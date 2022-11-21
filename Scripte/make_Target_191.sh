#!/bin/bash
#Version 1.0.0
#!coding: utf-8
##########################################################################################################
#
##########################################################################################################
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic pop
# repo -> #!/usr/bin/env python3.5.2

#sudo update-alternatives --config python
#Es gibt 2 Auswahlmöglichkeiten für die Alternative python (welche /usr/bin/python bereitstellen).
#
#  Auswahl      Pfad              Priorität Status
#------------------------------------------------------------
#  0            /usr/bin/python3   2         automatischer Modus
#  1            /usr/bin/python2   1         manueller Modus
#  2            /usr/bin/python3   2         manueller Modus
#
#Drücken Sie die Eingabetaste, um die aktuelle Wahl[*] beizubehalten,
#oder geben Sie die Auswahlnummer ein:

##########################################################################################################
# Python Versionscheck und Warnung
##########################################################################################################

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv shell 3.8.10

version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
version=$(echo "${version//}")
IFS='.' read -ra ADDR <<< "$version"

echo "Python Version: $version"

##########################################################################################################
# Import
##########################################################################################################

#++++++++++++++++++++++++++++++++++#
# Ant+ mitbauen
AntPlusBuild=true
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
#++++++++++++++++++++++++++++++++++#
# Beenden nachdem alles aktualisiert wurde
checkBuildOnly=false
#++++++++++++++++++++++++++++++++++#
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
# Nur mal kurz aufraeumen
cleanOnly=false
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
# Synchen des Repos
repoSync=false
#++++++++++++++++++++++++++++++++++#

##########################################################################################################
# Definitionen
##########################################################################################################
#d=$(date +%Y-%m-%d-%H-%M)
buildDate=$(date +%Y%m%d)

RootPfad=$PWD
AndroidPath=lineage-19.1
RepoCmd=$RootPfad/bin/repo
CertPfad=$PWD
limitCpu=false
clearBuild=false
target=sunfish
cpuLmt=2
rebuild=false

#~ vendorFolder="android_vendor_google_sunfish"

appfolder="android_vendor_google_sunfish_proprietary_app"

maxArrCnt=0
patchfolder="packages"
scriptFolder="android_19_addon_scripts"
declare -A FilePatch
spoofing1=0
FilePatch[$spoofing1,0]="Signature Spoofing"
FilePatch[$spoofing1,1]="$RootPfad/LOS/$patchfolder/$scriptFolder/microG/signature_spoofing_patches/android_frameworks_base-S.patch"
FilePatch[$spoofing1,2]="$RootPfad/LOS/$AndroidPath/frameworks/base"

spoofing2=1
FilePatch[$spoofing2,0]="Signature Spoofing"
FilePatch[$spoofing2,1]="$RootPfad/LOS/$patchfolder/$scriptFolder/microG/signature_spoofing_patches/packages_modules_Permission-S.patch"
FilePatch[$spoofing2,2]="$RootPfad/LOS/$AndroidPath/packages/modules/Permission"

NtpServer=2
FilePatch[$NtpServer,0]="Ntp Server"
FilePatch[$NtpServer,1]="$RootPfad/LOS/$patchfolder/$scriptFolder/deGoogle/frameworks_base_core_res_res_values_config.patch"
FilePatch[$NtpServer,2]="$RootPfad/LOS/$AndroidPath/frameworks/base"

CapPort=3
FilePatch[$CapPort,0]="Captive Portal check"
FilePatch[$CapPort,1]="$RootPfad/LOS/$patchfolder/$scriptFolder/deGoogle/packages_modules_NetworkStack_res_values_config.patch"
FilePatch[$CapPort,2]="$RootPfad/LOS/$AndroidPath/packages/modules/NetworkStack"

if [ $AntPlusBuild = true ]
then
    AntPlus=4
    FilePatch[$AntPlus,0]="Ant+"
    FilePatch[$AntPlus,1]="$RootPfad/LOS/$patchfolder/$scriptFolder/Ant+/ant+AirplaneMode.patch"
    FilePatch[$AntPlus,2]="$RootPfad/LOS/$AndroidPath/frameworks/base"
fi

maxArrCnt=$((${#FilePatch[@]}/3-1))

# Pfade zum resetten der Patches
            patchUndo=("vendor/lineage"
            "packages/apps/PermissionController"
            "frameworks/base"
            "packages/modules/NetworkStack"
            "packages/modules/Permission"
)

# Generell wohl besser alle Änderungen von mir als patch beim build einzuspielen, damit könnten Kernel updates einfacher werden
##########################################################################################################
#
#
#
#
##########################################################################################################
# Start Functionblock
##########################################################################################################
#
#
#
#
##########################################################################################################

##########################################################################################################
# FunktionsName limitUsedCpu
# details               weitere Apps
##########################################################################################################
function limitUsedCpu {
    xmessage -buttons "Nein":0,"Ja":1 -default "Nein" -nearmouse "Anzahl der Prozessoren begrenzen?"
    if [ $? = 1 ]
    then
        limitCpu=true
    fi
}

##########################################################################################################
# FunktionsName cleanBuild
# details               weitere Apps
##########################################################################################################
function cleanBuild {
    xmessage -buttons "Nein":0,"Ja":1 -default "Nein" -nearmouse "Den Build Ordner vorher loeschen?"
    if [ $? = 1 ]
    then
        clearBuild=true
    fi
}

##########################################################################################################
# FunktionsName Exit
# details               Beenden
##########################################################################################################
function quit {
    echo  "$1 bei Zeile $2 schlug fehl"
    exit
}

##########################################################################################################
# FunktionsName  securityPatchDate
# details               der PatchStand auf der Platte
##########################################################################################################
function securityPatchDate {
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Patch Datum +++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    #grep "PLATFORM_SECURITY_PATCH := " ./build/core/version_defaults.mk
    LOCAL=$(grep -Eoi "PLATFORM_SECURITY_PATCH := .*" ./build/core/version_defaults.mk | sed  s@'PLATFORM_SECURITY_PATCH := '@''@)
    echo -  Security Patch Level lokal  : $LOCAL
    echo
}

##########################################################################################################
# FunktionsName  newPatchesAvailable
# details               gibts einen neueren PatchStand
##########################################################################################################
function newPatchesAvailable {
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Security Patches ++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    LOCAL=$(grep -Eoi "PLATFORM_SECURITY_PATCH := .*" ./build/core/version_defaults.mk | sed  s@'PLATFORM_SECURITY_PATCH := '@''@)
    echo - Security Patch Level lokal  : $LOCAL

    REMOTE=$(curl -sS https://github.com/LineageOS/android_build/blob/$AndroidPath/core/version_defaults.mk | grep -Eoi 'PLATFORM_SECURITY_PATCH</span> := [0-9]{4}-[0-9]{2}-[0-9]{2}' | sed  s@'PLATFORM_SECURITY_PATCH</span> := '@''@)
    echo - Security Patch Level remote: $REMOTE

    # wenn laenge = 0 keine verbindung zum server
    if [ ${#REMOTE} = 0 ]
    then
        echo - Keine Verbindung zum Server
        exit
    fi
    if [ ${#LOCAL} = 0 ]
    then
        echo - Kein Repo gefunden, manuell synchen!
        exit
    fi
}

##########################################################################################################
# FunktionsName  whatToBuild
# details               wie und was bauen
##########################################################################################################
function whatToBuild {

    retVal=0
    strLoc="${LOCAL//-/}"
    strRem="${REMOTE//-/}"

    if (( $strLoc >= $strRem )); then
        xmessage -buttons "Trotzdem bauen":0,"Beenden":1,"CleanPatches":2  -default "Beenden"-nearmouse "Keine neuen Patches vorhanden"
        retVal=$?
        rebuild=true
    elif  (( $strLoc < $strRem )); then
        xmessage -buttons "Build!":0,"Beenden":1,"CleanPatches":2 -default "Beenden" -nearmouse "Neue Patches vorhanden"
        retVal=$?
    fi

    if [ $retVal = 2 ]
    then
        #echo - Patches zurueck
        cleanOnly=true
    fi
    if [ $retVal = 1 ]
    then
        echo - Beenden
        exit
    fi
}

##########################################################################################################
# FunktionsName prepCache
# details               Cache loeschen und vorbereiten
##########################################################################################################
function prepCache {
    #echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Cleanup Cache +++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ccache -C

    if [ $clearBuild = true ] && [ -d "$RootPfad/LOS/$AndroidPath/out" ]
    then
        echo - make Clean
        make clean

        if [ -f $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock ]
        then
            rm $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock
        fi
    fi

    # Cache Einstellungen
    export USE_CCACHE=1
    export CCACHE_EXEC=/usr/bin/ccache
    ccache -M 75G
    ccache -o compression=true
}

##########################################################################################################
# FunktionsName restoreBuildEnv
# details               die geaenderten Scripte wiederherstellen
##########################################################################################################
function restoreBuildEnv {

    echo
    echo - Anzahl Prozessoren
    # Die Buildumgebung wieder zurueck
    replaceWith="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j\$(grep \"\^processor\" /proc/cpuinfo | wc -l) \"\$@\""
    #searchString="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j4 \"\$@\""
    searchString="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j$cpuLmt \"\$@\""
    echo $searchString
    sed -i -e "s:${searchString}:${replaceWith}:g" $RootPfad/LOS/$AndroidPath/vendor/lineage/build/envsetup.sh
    #auslesen
    grep -Eoi "mk_timer schedtool -B -n 10 -e ionice .*" $RootPfad/LOS/$AndroidPath/vendor/lineage/build/envsetup.sh
    echo
}

##########################################################################################################
# FunktionsName applyGitPatches
# details               git patches anwenden
##########################################################################################################
function applyGitPatches {

    echo - apply Git Patches

    for ((i=0;i<=$maxArrCnt;i++))
    do
        echo
        echo - "${FilePatch[$i,0]}"
        cve="${FilePatch[$i,1]}"
        cd "${FilePatch[$i,2]}"
        echo $cve

        #echo - git --stat $cve
        git apply --stat $cve --whitespace=nowarn --ignore-space-change --ignore-whitespace

        #echo - git --check
        # suppress error
        exec 3>&2
        exec 2> /dev/null
        git apply --check $cve --whitespace=nowarn --ignore-space-change --ignore-whitespace
        gitError=$?

        # restore stderr
        exec 2>&3

        if [ $gitError != 1 ]
        then
            git apply $cve  --whitespace=nowarn --ignore-space-change --ignore-whitespace
        fi
    done
}

##########################################################################################################
# FunktionsName removeGitPatches
# details               git patches wieder entfernen
##########################################################################################################
function removeGitPatches {

    echo
    echo - remove Git Patches

    # Remove previous changes of vendor/lineage and frameworks/base (if they exist)
    # TODO: maybe reset everything using https://source.android.com/setup/develop/repo#forall
    for path in ${patchUndo[@]}; do
        echo $RootPfad/LOS/$AndroidPath/$path
        if [ -d "$RootPfad/LOS/$AndroidPath/$path" ]; then
            cd "$RootPfad/LOS/$AndroidPath/$path"
            git reset -q --hard
            git clean -q -fd
            cd "$SRC_DIR/$branch_dir"
            echo - done
        else
            echo - not found
        fi
    done
}

##########################################################################################################
#
#
#
#
##########################################################################################################
# End Functionblock
##########################################################################################################
#
#
#
#
##########################################################################################################

##########################################################################################################
# Wechsel ins Buildverzeichnis
##########################################################################################################
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ In das Buildverzeichnis +++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

cd $RootPfad/LOS/$AndroidPath
pwd

# gibts neue security patches
newPatchesAvailable

echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ Build Optionen ++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "-  Anzahl Patches: $(($maxArrCnt + 1))"
echo "- Ant+ integriert: $AntPlusBuild"
echo "-Check Build Only: $checkBuildOnly"
echo "-  Nur aufrauumen: $cleanOnly"
echo "-    Repo synchen: $repoSync"
#echo "-       Repo Pick: $repoPick"
#echo

# was bauen
whatToBuild

# Nur aufraeumen
if [ $cleanOnly = true ]
then
    removeGitPatches
    restoreBuildEnv
    echo
        if [ -f $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock ]
        then
            rm $RootPfad/LOS/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock
        fi
    exit
fi

# fuer welches Target bauen wir
#getTarget
# Prozessoren begrenzen
limitUsedCpu
# BuildOrdner loeschen
cleanBuild
#Zusammenfassung
#showFeature

##########################################################################################################
# Repo init und sync
##########################################################################################################
echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ Init Repo +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
$RepoCmd init -u https://github.com/LineageOS/android.git -b $AndroidPath

if [ $? -ne 0 ]
then
    quit "repo Init" "$LINENO"
fi

if [ $repoSync = true ]
then
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Sync Repo +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo -c --force-remove-dirty --force-sync --verbose
    $RepoCmd sync -c --force-remove-dirty --force-sync --verbose
    echo

    if [ $? -ne 0 ]
    then
        quit "repo sync" "$LINENO"
    fi
fi

# Environment aufetzen
cd $RootPfad/LOS/$AndroidPath
source build/envsetup.sh

##########################################################################################################
# Android Security Patch Level auslesen
##########################################################################################################
securityPatchDate

if (( $strLoc <= $strRem )) && (( $rebuild = false ))
then
    #echo - Security Patch Level lokal  : $LOCAL
    echo - Security Patch Level remote: $REMOTE
    echo "Keine neuen Patches gefunden" "$LINENO"
    exit
fi

##########################################################################################################
# Target bauen
##########################################################################################################
while :
do
    exitWhile=true
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Den Code fuer $target +++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #syncht den Code fuer sunfish
    breakfast $target
    echo
    if [ $? -ne 0 ]
    then
        quit "breakfast $target" "$LINENO"
    fi

##########################################################################################################
# Cache
##########################################################################################################
    prepCache

##########################################################################################################
# Build auf x Cpu Cores begrenzen
##########################################################################################################
    if [ $limitCpu = true ]
    then
        searchString="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j\$(grep \"\^processor\" /proc/cpuinfo | wc -l) \"\$@\""
        #replaceWith="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j4 \"\$@\""
        replaceWith="mk_timer schedtool -B -n 10 -e ionice -n 7 make -C \$T -j$cpuLmt \"\$@\""
        sed -i -e "s:${searchString}:${replaceWith}:g" $RootPfad/LOS/$AndroidPath/vendor/lineage/build/envsetup.sh
    fi

##########################################################################################################
# meine git Repos synchen
##########################################################################################################
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ sync git repo +++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    #Backup aktuellen Pfad
    lstPath=$PWD

    echo - vendor/partner_gms synchen
    cd $RootPfad/LOS/$AndroidPath/vendor/partner_gms
    echo $PWD
    git config --get remote.origin.url
    git pull

    #zurueck in den Pfad
    cd $lstPath

##########################################################################################################
# Files austauschen, patchen, hinzufuegen
##########################################################################################################
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ in das LOS Verzeichnis kopieren +++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    if [ $AntPlusBuild = true ]
    then
        echo - external/ant-wireless kopieren
        rm -rf external/ant-wireless
        cp -r $RootPfad/LOS/$patchfolder/$scriptFolder/Ant+/android_external_ant-wireless/ ./external/ant-wireless/
        rm -rf external/ant-wireless/.git
        echo - done
        echo
    fi

    echo - vendor/lineage/overlay erstellen
    mkdir -p "$RootPfad/LOS/$AndroidPath/vendor/lineage/overlay/microg/frameworks/base/core/res/res/values/"
    # Override device-specific settings for the location providers
    cp $RootPfad/LOS/$patchfolder/$scriptFolder/microG/signature_spoofing_patches/frameworks_base_config.xml "$RootPfad/LOS/$AndroidPath/vendor/lineage/overlay/microg/frameworks/base/core/res/res/values/config.xml"
    sed -i "1s;^;\n# Set up microg overlay\nPRODUCT_PACKAGE_OVERLAYS += vendor/lineage/overlay/microg\n\n;" "$RootPfad/LOS/$AndroidPath/vendor/lineage/config/common.mk"
    echo - done
    echo

    echo - Google Kamera kopieren
    rm -rf ./vendor/google/sunfish/proprietary/product/app/GoogleCamera/GoogleCamera.apk
    cp -r $RootPfad/LOS/$patchfolder/$appfolder/GoogleCamera/Gcam_8.3.252_V2.0c_MWP.apk ./vendor/google/sunfish/proprietary/product/app/GoogleCamera/GoogleCamera.apk
    echo - done
    echo

    echo - vendor/lineage/bootanimation kopieren
    rm -rf ./vendor/lineage/bootanimation/bootanimation.tar
    rm -rf ./vendor/lineage/bootanimation/desc.txt
    cp -r $RootPfad/LOS/$patchfolder/$scriptFolder/BootAnimation/bootanimationRing/bootanimation.tar ./vendor/lineage/bootanimation/bootanimation.tar
    cp -r $RootPfad/LOS/$patchfolder/$scriptFolder/BootAnimation/bootanimationRing/desc.txt ./vendor/lineage/bootanimation/desc.txt
    echo - done

    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Dateien austauschen, patchen, hinzufuegen +++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    ########################################################
    # nach dem synch patchen
    ########################################################
    applyGitPatches

    #zurueck in den Pfad
    cd $lstPath

##########################################################################################################
#
##########################################################################################################
# Build
##########################################################################################################
#
##########################################################################################################
    croot
    export LC_ALL=C

    # microG support
    export WITH_GMS=true

    # Ant-wireless_ant_native
    if [ $AntPlusBuild = true ]
    then
        export BOARD_ANT_WIRELESS_DEVICE='"qualcomm-smd"'
    fi
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Starte signierten Build fuer $target ++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    breakfast $target
    if [ $checkBuildOnly = true ]
    then
        exit
    fi

    mka target-files-package otatools
    if [ $? -ne 0 ]
    then
        echo - otatools $target schlug fehl
        break
    fi
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ APK +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo
    croot
    python ./build/tools/releasetools/sign_target_files_apks -o -d $CertPfad/.android-certs $OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $RootPfad/$target-files-signed.zip
    sign_target_files_apks -o -d $CertPfad/.android-certs $OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $RootPfad/$target-files-signed.zip
    if [ $? -ne 0 ]
    then
        echo - $target APK signieren schlug fehl
        break
    fi
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ OTA +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo
    python ./build/tools/releasetools/ota_from_target_files -k $CertPfad/.android-certs/releasekey --block --backup=true $RootPfad/$target-files-signed.zip $RootPfad/$target-ota-update.zip
    ota_from_target_files -k $CertPfad/.android-certs/releasekey --block --backup=true $RootPfad/$target-files-signed.zip $RootPfad/$target-ota-update.zip
    if [ $? -ne 0 ]
    then
        echo - $target OTA signieren schlug fehl
        break
    fi
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Ende signierter Build +++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo
##########################################################################################################
# Exit aus der while
##########################################################################################################
    if [ $exitWhile = true ]
    then
        break
    fi
done

##########################################################################################################
# Android Security Patch Level auslesen
##########################################################################################################
securityPatchDate

##########################################################################################################
# Build verschieben
##########################################################################################################
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ verschiebe Build ++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
if [ -f $RootPfad/$target-files-signed.zip ]
then
    rm $RootPfad/$target-files-signed.zip
fi

# Kopieren und umbenennen
if [ -f $RootPfad/$target-ota-update.zip ]
then
    echo "verschiebe $RootPfad/$target-ota-update.zip ==> $RootPfad/$AndroidPath-$buildDate-UNOFFICIAL-$target-signed.zip"
    mv $RootPfad/$target-ota-update.zip $RootPfad/$AndroidPath-$buildDate-UNOFFICIAL-$target-signed.zip
fi

if [ -f $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip ]
then
    echo "verschiebe $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip ==> $RootPfad/$AndroidPath-*-UNOFFICIAL-$target.zip"
    mv $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip $RootPfad
    echo "verschiebe $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip.md5sum ==> $RootPfad/$AndroidPath-*-UNOFFICIAL-$target.zip.md5sum"
    mv $OUT/$AndroidPath-*-UNOFFICIAL-$target.zip.md5sum $RootPfad
fi

echo $OUT/boot.img
if [ -f $OUT/boot.img ]
then
    echo "verschiebe $OUT/boot.img ==> $RootPfad/$AndroidPath-$buildDate-UNOFFICIAL-boot-$target.img"
    mv $OUT/boot.img $RootPfad/$AndroidPath-$buildDate-UNOFFICIAL-boot-$target.img
fi

##########################################################################################################
# aufraeumen
##########################################################################################################
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ aufraeumen ++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
restoreBuildEnv
removeGitPatches

##########################################################################################################
