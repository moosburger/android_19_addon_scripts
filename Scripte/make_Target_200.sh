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

#private static final Signature MICROG_FAKE_SIGNATURE = new Signature("308204433082032ba003020102020900c2e08746644a308d300d06092a864886f70d01010405003074310b3009060355040613025553311330110603550408130a43616c69666f726e6961311630140603550407130d4d6f756e7461696e205669657731143012060355040a130b476f6f676c6520496e632e3110300e060355040b1307416e64726f69643110300e06035504031307416e64726f6964301e170d3038303832313233313333345a170d3336303130373233313333345a3074310b3009060355040613025553311330110603550408130a43616c69666f726e6961311630140603550407130d4d6f756e7461696e205669657731143012060355040a130b476f6f676c6520496e632e3110300e060355040b1307416e64726f69643110300e06035504031307416e64726f696430820120300d06092a864886f70d01010105000382010d00308201080282010100ab562e00d83ba208ae0a966f124e29da11f2ab56d08f58e2cca91303e9b754d372f640a71b1dcb130967624e4656a7776a92193db2e5bfb724a91e77188b0e6a47a43b33d9609b77183145ccdf7b2e586674c9e1565b1f4c6a5955bff251a63dabf9c55c27222252e875e4f8154a645f897168c0b1bfc612eabf785769bb34aa7984dc7e2ea2764cae8307d8c17154d7ee5f64a51a44a602c249054157dc02cd5f5c0e55fbef8519fbe327f0b1511692c5a06f19d18385f5c4dbc2d6b93f68cc2979c70e18ab93866b3bd5db8999552a0e3b4c99df58fb918bedc182ba35e003c1b4b10dd244a8ee24fffd333872ab5221985edab0fc0d0b145b6aa192858e79020103a381d93081d6301d0603551d0e04160414c77d8cc2211756259a7fd382df6be398e4d786a53081a60603551d2304819e30819b8014c77d8cc2211756259a7fd382df6be398e4d786a5a178a4763074310b3009060355040613025553311330110603550408130a43616c69666f726e6961311630140603550407130d4d6f756e7461696e205669657731143012060355040a130b476f6f676c6520496e632e3110300e060355040b1307416e64726f69643110300e06035504031307416e64726f6964820900c2e08746644a308d300c0603551d13040530030101ff300d06092a864886f70d010104050003820101006dd252ceef85302c360aaace939bcff2cca904bb5d7a1661f8ae46b2994204d0ff4a68c7ed1a531ec4595a623ce60763b167297a7ae35712c407f208f0cb109429124d7b106219c084ca3eb3f9ad5fb871ef92269a8be28bf16d44c8d9a08e6cb2f005bb3fe2cb96447e868e731076ad45b33f6009ea19c161e62641aa99271dfd5228c5c587875ddb7f452758d661f6cc0cccb7352e424cc4365c523532f7325137593c4ae341f4db41edda0d0b1071a7c440f0fe9ea01cb627ca674369d084bd2fd911ff06cdbf2cfa10dc0f893ae35762919048c7efc64c7144178342f70581c9de573af55b390dd7fdb9418631895d5f759f30112687ff621410c069308a");

 #private static final Signature MICROG_REAL_SIGNATURE = new Signature("308202ed308201d5a003020102020426ffa009300d06092a864886f70d01010b05003027310b300906035504061302444531183016060355040a130f4e4f47415050532050726f6a656374301e170d3132313030363132303533325a170d3337303933303132303533325a3027310b300906035504061302444531183016060355040a130f4e4f47415050532050726f6a65637430820122300d06092a864886f70d01010105000382010f003082010a02820101009a8d2a5336b0eaaad89ce447828c7753b157459b79e3215dc962ca48f58c2cd7650df67d2dd7bda0880c682791f32b35c504e43e77b43c3e4e541f86e35a8293a54fb46e6b16af54d3a4eda458f1a7c8bc1b7479861ca7043337180e40079d9cdccb7e051ada9b6c88c9ec635541e2ebf0842521c3024c826f6fd6db6fd117c74e859d5af4db04448965ab5469b71ce719939a06ef30580f50febf96c474a7d265bb63f86a822ff7b643de6b76e966a18553c2858416cf3309dd24278374bdd82b4404ef6f7f122cec93859351fc6e5ea947e3ceb9d67374fe970e593e5cd05c905e1d24f5a5484f4aadef766e498adf64f7cf04bddd602ae8137b6eea40722d0203010001a321301f301d0603551d0e04160414110b7aa9ebc840b20399f69a431f4dba6ac42a64300d06092a864886f70d01010b0500038201010007c32ad893349cf86952fb5a49cfdc9b13f5e3c800aece77b2e7e0e9c83e34052f140f357ec7e6f4b432dc1ed542218a14835acd2df2deea7efd3fd5e8f1c34e1fb39ec6a427c6e6f4178b609b369040ac1f8844b789f3694dc640de06e44b247afed11637173f36f5886170fafd74954049858c6096308fc93c1bc4dd5685fa7a1f982a422f2a3b36baa8c9500474cf2af91c39cbec1bc898d10194d368aa5e91f1137ec115087c31962d8f76cd120d28c249cf76f4c70f5baa08c70a7234ce4123be080cee789477401965cfe537b924ef36747e8caca62dfefdd1a6288dcb1c4fd2aaa6131a7ad254e9742022cfd597d2ca5c660ce9e41ff537e5a4041e37");

#++++++++++++++++++++++++++++++++++#
# Ant+ mitbauen
AntPlusBuild=false
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
repoSync=true
#++++++++++++++++++++++++++++++++++#

#++++++++++++++++++++++++++++++++++#
# RepoPick, wenn Gerrit nicht rechtzeitig gepusht wurde
repoPick=false
# der zu pickende Commit
gerritSecurityPatch=T_asb_2024-01
#++++++++++++++++++++++++++++++++++#

##########################################################################################################
# Definitionen
##########################################################################################################
#d=$(date +%Y-%m-%d-%H-%M)
buildDate=$(date +%Y%m%d)

RootPfad=$PWD
AndroidPath=lineage-20.0
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
scriptFolder="android_20_addon_scripts"
declare -A FilePatch
#spoofing1=0
#FilePatch[$spoofing1,0]="Signature Spoofing"
#FilePatch[$spoofing1,1]="$RootPfad/$patchfolder/$scriptFolder/microG/signature_spoofing_patches/android_frameworks_base-Android13.patch"
#FilePatch[$spoofing1,2]="$RootPfad/$AndroidPath/frameworks/base"

#spoofing2=1
#FilePatch[$spoofing2,0]="Signature Spoofing"
#FilePatch[$spoofing2,1]="$RootPfad/$patchfolder/$scriptFolder/microG/signature_spoofing_patches/packages_modules_Permission-Android13.patch"
#FilePatch[$spoofing2,2]="$RootPfad/$AndroidPath/packages/modules/Permission"

NtpServer=0
FilePatch[$NtpServer,0]="Ntp Server"
FilePatch[$NtpServer,1]="$RootPfad/$patchfolder/$scriptFolder/deGoogle/frameworks_base_core_res_res_values_config.patch"
FilePatch[$NtpServer,2]="$RootPfad/$AndroidPath/frameworks/base"

CapPort=1
FilePatch[$CapPort,0]="Captive Portal check"
FilePatch[$CapPort,1]="$RootPfad/$patchfolder/$scriptFolder/deGoogle/packages_modules_NetworkStack_res_values_config.patch"
FilePatch[$CapPort,2]="$RootPfad/$AndroidPath/packages/modules/NetworkStack"

SUPL=2
FilePatch[$SUPL,0]="SUPL No IMSI"
FilePatch[$SUPL,1]="$RootPfad/$patchfolder/$scriptFolder/deGoogle/SUPL_No_IMSI.patch"
FilePatch[$SUPL,2]="$RootPfad/$AndroidPath/frameworks/base"

# Nicht verwenden in LOS 19.1 führt zum Absturz der Einstellungen->App
#DisStat=5
#FilePatch[$DisStat,0]="Disable_usage_stats"
#FilePatch[$DisStat,1]="$RootPfad/$patchfolder/$scriptFolder/deGoogle/Disable_usage_stats.patch"
#FilePatch[$DisStat,2]="$RootPfad/$AndroidPath/frameworks/base"

lastCnt=$SUPL

if [ $AntPlusBuild = true ]
then
    AntPlus1=$lastCnt + 1
    FilePatch[$AntPlus1,0]="Ant+"
    FilePatch[$AntPlus1,1]="$RootPfad/$patchfolder/$scriptFolder/Ant+/ant+AirplaneMode.patch"
    FilePatch[$AntPlus1,2]="$RootPfad/$AndroidPath/frameworks/base"

    AntPlus2= AntPlus1 + 1
    FilePatch[$AntPlus2,0]="Ant+"
    FilePatch[$AntPlus2,1]="$RootPfad/$patchfolder/$scriptFolder/Ant+/device_mk.patch"
    FilePatch[$AntPlus2,2]="$RootPfad/$AndroidPath/device/google/sunfish"

fi

maxArrCnt=$((${#FilePatch[@]}/3-1))

# Pfade zum resetten der Patches
            patchUndo=("vendor/lineage"
            "frameworks/base"
            "packages/modules/NetworkStack"
            "device/google/sunfish"
            "kernel/google/msm-4.14"
)
            #"packages/modules/Permission"

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

    if [ ${#REMOTE} = 0 ]
    then
        REMOTE=$(curl -sS https://github.com/LineageOS/android_build/blob/$AndroidPath/core/version_defaults.mk | grep -Eoi 'PLATFORM_SECURITY_PATCH := [0-9]{4}-[0-9]{2}-[0-9]{2}' | sed  s@'PLATFORM_SECURITY_PATCH := '@''@)
    fi


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

    if [ $clearBuild = true ] && [ -d "$RootPfad/$AndroidPath/out" ]
    then
        echo - make Clean
        make clean

#        if [ -f $RootPfad/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock ]
  #      then
   #         rm $RootPfad/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock
     #   fi
    fi

    # Cache Einstellungen
    export USE_CCACHE=1
    export CCACHE_EXEC=/usr/bin/ccache
    ccache -M 100G
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
    sed -i -e "s:${searchString}:${replaceWith}:g" $RootPfad/$AndroidPath/vendor/lineage/build/envsetup.sh
    #auslesen
    grep -Eoi "mk_timer schedtool -B -n 10 -e ionice .*" $RootPfad/$AndroidPath/vendor/lineage/build/envsetup.sh
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

        echo - git apply --stat $cve
        git apply --stat $cve --whitespace=nowarn --ignore-space-change --ignore-whitespace

        #echo - git apply --check $cve --whitespace=nowarn --ignore-space-change --ignore-whitespace
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
        echo $RootPfad/$AndroidPath/$path
        if [ -d "$RootPfad/$AndroidPath/$path" ]; then
            cd "$RootPfad/$AndroidPath/$path"
            git reset -q --hard
            git clean -q -fd
            cd "$SRC_DIR/$branch_dir"
            echo - done
        else
            echo - not found
        fi
    done

    cd $RootPfad/$AndroidPath
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

cd $RootPfad/$AndroidPath
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
echo "-   Nur aufraumen: $cleanOnly"
echo "-    Repo synchen: $repoSync"
echo "-       Repo Pick: $repoPick"
echo

# was bauen
whatToBuild

restoreBuildEnv
removeGitPatches

# Nur aufraeumen
if [ $cleanOnly = true ]
then
    echo
        if [ -f $RootPfad/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock ]
        then
            rm $RootPfad/$AndroidPath/.repo/projects/external/chromium-webview.git/shallow.lock
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
git lfs install

echo
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ Init Repo +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
pwd
echo - $RepoCmd init -u https://github.com/LineageOS/android.git -b $AndroidPath
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
    echo $RepoCmd sync -c --force-remove-dirty --force-sync --verbose
    $RepoCmd sync -c --force-remove-dirty --force-sync --verbose
    echo

    if [ $? -ne 0 ]
    then
        quit "repo sync" "$LINENO"
    fi
fi

# Environment aufetzen
cd $RootPfad/$AndroidPath
source build/envsetup.sh

if [ $repoPick = true ]
then
    echo
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++ Repo Cherry Pick ++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo - repoPick
    #repopick_topic $gerritSecurityPatch
    repopick -t $gerritSecurityPatch

    if [ $? -ne 0 ]
    then
        quit "repopick" "$LINENO"
    fi
fi

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
        sed -i -e "s:${searchString}:${replaceWith}:g" $RootPfad/$AndroidPath/vendor/lineage/build/envsetup.sh
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
    cd $RootPfad/$AndroidPath/vendor/partner_gms
    echo $PWD
    git config --get remote.origin.url
    git pull

    #zurueck in den Pfad
    cd $lstPath


#https://github.com/LineageOS/android_kernel_google_msm-4.14.git -b lineage-20
#https://github.com/LineageOS/android_device_google_sunfish.git -b lineage-20

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
        cp -r $RootPfad/$patchfolder/$scriptFolder/Ant+/android_external_ant-wireless/ ./external/ant-wireless/
        rm -rf external/ant-wireless/.git
        echo - done
        echo
    fi

    echo - vendor/lineage/overlay erstellen
    mkdir -p "$RootPfad/$AndroidPath/vendor/lineage/overlay/microg/frameworks/base/core/res/res/values/"
    # Override device-specific settings for the location providers
    cp $RootPfad/$patchfolder/$scriptFolder/microG/signature_spoofing_patches/frameworks_base_config.xml "$RootPfad/$AndroidPath/vendor/lineage/overlay/microg/frameworks/base/core/res/res/values/config.xml"
    sed -i "1s;^;\n# Set up microg overlay\nPRODUCT_PACKAGE_OVERLAYS += vendor/lineage/overlay/microg\n\n;" "$RootPfad/$AndroidPath/vendor/lineage/config/common.mk"
    echo - done
    echo

    echo - Google Kamera kopieren
    if [ ! -d "$RootPfad/$AndroidPath/vendor/google/sunfish/proprietary/product/app/GoogleCamera" ]; then
        mkdir -p "$RootPfad/$AndroidPath/vendor/google/sunfish/proprietary/product/app/GoogleCamera"
    fi
    rm -rf ./vendor/google/sunfish/proprietary/product/app/GoogleCamera/GoogleCamera.apk
    # cp -r $RootPfad/$patchfolder/$appfolder/GoogleCamera/Gcam_8.3.252_V2.0c_MWP.apk $RootPfad/$AndroidPath/vendor/google/sunfish/proprietary/product/app/GoogleCamera/GoogleCamera.apk
    cp -r $RootPfad/$patchfolder/$appfolder/GoogleCamera/Gcam_8.4.300_V2_Final_MWP_Cloned.apk $RootPfad/$AndroidPath/vendor/google/sunfish/proprietary/product/app/GoogleCamera/GoogleCamera.apk
    echo - done
    echo

    echo - vendor/lineage/bootanimation kopieren
    rm -rf ./vendor/lineage/bootanimation/bootanimation.tar
    rm -rf ./vendor/lineage/bootanimation/desc.txt
    cp -r $RootPfad/$patchfolder/$scriptFolder/BootAnimation/bootanimationRing/bootanimation.tar ./vendor/lineage/bootanimation/bootanimation.tar
    cp -r $RootPfad/$patchfolder/$scriptFolder/BootAnimation/bootanimationRing/desc.txt ./vendor/lineage/bootanimation/desc.txt
    echo - done
    echo

    echo - Volume Steps patchen
    rm -rf ./device/google/sunfish/device.mk
    cp -r $RootPfad/$patchfolder/$scriptFolder/VolumeSteps/device.mk ./device/google/sunfish/device.mk
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
        [ ! -d $RootPfad/$AndroidPath/out/target/product/$target/system/etc/permissions ] &&  mkdir -p $RootPfad/$AndroidPath/out/target/product/$target/system/etc/permissions
        cp $RootPfad/$AndroidPath/external/ant-wireless/antradio-library/com.dsi.ant.antradio_library.xml $RootPfad/$AndroidPath/out/target/product/$target/system/etc/permissions/com.dsi.ant.antradio_library.xml
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
    #python ./build/tools/releasetools/sign_target_files_apks -o -d $CertPfad/.android-certs $OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $RootPfad/$target-files-signed.zip
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
    #python ./build/tools/releasetools/ota_from_target_files -k $CertPfad/.android-certs/releasekey --block --backup=true $RootPfad/$target-files-signed.zip $RootPfad/$target-ota-update.zip
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

echo
##########################################################################################################
# aufraeumen
##########################################################################################################
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++ aufraeumen ++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
restoreBuildEnv
#removeGitPatches

##########################################################################################################
