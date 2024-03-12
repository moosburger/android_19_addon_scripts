#!/bin/bash
#Version 1.0.0
#!coding: utf-8
##########################################################################################################
#
##########################################################################################################

subject='/C=GE/ST=Bavaria/L=Moosburg/O=Android/OU=Android/CN=Android/emailAddress=moosburger@freenet.de'
mkdir /home/dejhgp07/Daten/LOS/.android-certs
for cert in bluetooth cyngn-app media networkstack platform releasekey sdk_sandbox shared testcert testkey verity; do \
    /home/dejhgp07/Daten/LOS/lineage-20.0//development/tools/make_key /home/dejhgp07/Daten/LOS/.android-certs/$cert "$subject"; \
done

#LineageOS 19.1 and above will also require APEXes be re-signed. Each APEX file is signed with two keys: one for the mini file system image within an APEX and the other for the entire APEX. In this case, only SHA256_RSA4096 keys are allowed, default is SHA256_RSA2048.
#So you need to make a copy of ./development/tools/make_key file and edit to use SHA256_RSA4096.

cp /home/dejhgp07/Daten/LOS/lineage-20.0//development/tools/make_key /home/dejhgp07/Daten/LOS/.android-certs/
sed -i 's|2048|4096|g' /home/dejhgp07/Daten/LOS/.android-certs/make_key
