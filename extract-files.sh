#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DEVICE=charge

rm -rf ../../../vendor/samsung/$DEVICE/*
mkdir -p ../../../vendor/samsung/$DEVICE/proprietary

if [ -f "$1" ]; then
	rm -rf tmp
	mkdir tmp
	unzip -q "$1" -d tmp
	if [ $? != 0 ]; then
		echo "$1 is not a valid zip file. Bye."
		rm -rf tmp
		exit 1
	fi
	echo "$1 successfully unzip'd. Copying files..."
	ZIP="true"
else
	unset ZIP
fi

DIRS="
bin
etc/wifi
lib/egl
lib/hw
media
vendor/firmware
vendor/lib/egl
vendor/lib/hw
"

for DIR in $DIRS; do
	mkdir -p ../../../vendor/samsung/$DEVICE/proprietary/$DIR
done

FILES="
vendor/firmware/nvram_net.txt

bin/pppd_runner
bin/rild
etc/cellcache.db
lib/libril.so
lib/libsec-ril40.so
lib/libsec-ril40-cdma.so
lib/libsecril-client.so

bin/gpsd
lib/hw/gps.s5pc110.so

bin/pvrsrvinit
lib/egl/libGLES_android.so
vendor/lib/egl/libEGL_POWERVR_SGX540_120.so
vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so
vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so
vendor/lib/libsrv_um.so
vendor/lib/libsrv_init.so
vendor/lib/libIMGegl.so
vendor/lib/libpvr2d.so
vendor/lib/libpvrANDROID_WSEGL.so
vendor/lib/libglslcompiler.so
vendor/lib/libPVRScopeServices.so
vendor/lib/libusc.so

bin/geomagneticd
bin/orientationd
lib/libsensor_yamaha_test.so
lib/hw/sensors.s5pc110.so

lib/hw/lights.s5pc110.so
vendor/lib/hw/gralloc.s5pc110.so

bin/BCM4329B1_002.002.023.0746.0818.hcd

bin/playlpm
bin/charging_mode
lib/libQmageDecoder.so
media/battery_charging_5.qmg
media/battery_charging_10.qmg
media/battery_charging_15.qmg
media/battery_charging_20.qmg
media/battery_charging_25.qmg
media/battery_charging_30.qmg
media/battery_charging_35.qmg
media/battery_charging_40.qmg
media/battery_charging_45.qmg
media/battery_charging_50.qmg
media/battery_charging_55.qmg
media/battery_charging_60.qmg
media/battery_charging_65.qmg
media/battery_charging_70.qmg
media/battery_charging_75.qmg
media/battery_charging_80.qmg
media/battery_charging_85.qmg
media/battery_charging_90.qmg
media/battery_charging_95.qmg
media/battery_charging_100.qmg
media/wc_battery_charging_5.qmg
media/wc_battery_charging_10.qmg
media/wc_battery_charging_15.qmg
media/wc_battery_charging_20.qmg
media/wc_battery_charging_25.qmg
media/wc_battery_charging_30.qmg
media/wc_battery_charging_35.qmg
media/wc_battery_charging_40.qmg
media/wc_battery_charging_45.qmg
media/wc_battery_charging_50.qmg
media/wc_battery_charging_55.qmg
media/wc_battery_charging_60.qmg
media/wc_battery_charging_65.qmg
media/wc_battery_charging_70.qmg
media/wc_battery_charging_75.qmg
media/wc_battery_charging_80.qmg
media/wc_battery_charging_85.qmg
media/wc_battery_charging_90.qmg
media/wc_battery_charging_95.qmg
media/wc_battery_charging_100.qmg
media/chargingwarning.qmg
media/chargingwarning_auth.qmg
"

for FILE in $FILES; do
	if [ "$ZIP" ]; then
		cp tmp/system/"$FILE" ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	else
		adb pull system/$FILE ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	fi
done
if [ "$ZIP" ]; then rm -rf tmp ; fi

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../vendor/samsung/$DEVICE/$DEVICE-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/samsung/__DEVICE__/extract-files.sh

#
# prelink
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:obj/lib/libsecrilclient.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40.so:obj/lib/libsec-ril40.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40-cdma.so:obj/lib/libsec-ril40-cdma.so

# gfx
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/pvrsrvinit:system/bin/pvrsrvinit \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLES_android.so:system/lib/egl/libGLES_android.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so:system/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so:system/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so:system/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/hw/gralloc.s5pc110.so:system/vendor/lib/hw/gralloc.s5pc110.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libglslcompiler.so:system/vendor/lib/libglslcompiler.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libIMGegl.so:system/vendor/lib/libIMGegl.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libpvr2d.so:system/vendor/lib/libpvr2d.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libpvrANDROID_WSEGL.so:system/vendor/lib/libpvrANDROID_WSEGL.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libPVRScopeServices.so:system/vendor/lib/libPVRScopeServices.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libsrv_init.so:system/vendor/lib/libsrv_init.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libsrv_um.so:system/vendor/lib/libsrv_um.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libusc.so:system/vendor/lib/libusc.so

#
# Wifi
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/vendor/firmware/nvram_net.txt:system/vendor/firmware/nvram_net.txt

#
# Sensors, Lights etc
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/geomagneticd:system/bin/geomagneticd \\
    vendor/samsung/__DEVICE__/proprietary/bin/orientationd:system/bin/orientationd \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/sensors.s5pc110.so:system/lib/hw/sensors.s5pc110.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsensor_yamaha_test.so:system/lib/libsensor_yamaha_test.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/lights.s5pc110.so:system/lib/hw/lights.s5pc110.so

#
# RIL
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/pppd_runner:system/bin/pppd_runner \\
    vendor/samsung/__DEVICE__/proprietary/bin/rild:system/bin/rild \\
    vendor/samsung/__DEVICE__/proprietary/etc/cellcache.db:system/etc/cellcache.db \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40.so:system/lib/libsec-ril40.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40-cdma.so:system/lib/libsec-ril40-cdma.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:system/lib/libsecril-client.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libril.so:system/lib/libril.so

#
# GPS
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/gpsd:system/bin/gpsd \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/gps.s5pc110.so:system/lib/hw/gps.s5pc110.so

#
# bluetooth
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/BCM4329B1_002.002.023.0746.0818.hcd:system/bin/BCM4329B1_002.002.023.0746.0818.hcd

#
# Files for battery charging screen
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/playlpm:system/bin/playlpm \\
    vendor/samsung/__DEVICE__/proprietary/bin/charging_mode:system/bin/charging_mode \\
    vendor/samsung/__DEVICE__/proprietary/lib/libQmageDecoder.so:system/lib/libQmageDecoder.so \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_5.qmg:system/media/battery_charging_5.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_10.qmg:system/media/battery_charging_10.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_15.qmg:system/media/battery_charging_15.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_20.qmg:system/media/battery_charging_20.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_25.qmg:system/media/battery_charging_25.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_30.qmg:system/media/battery_charging_30.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_35.qmg:system/media/battery_charging_35.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_40.qmg:system/media/battery_charging_40.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_45.qmg:system/media/battery_charging_45.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_50.qmg:system/media/battery_charging_50.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_55.qmg:system/media/battery_charging_55.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_60.qmg:system/media/battery_charging_60.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_65.qmg:system/media/battery_charging_65.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_70.qmg:system/media/battery_charging_70.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_75.qmg:system/media/battery_charging_75.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_80.qmg:system/media/battery_charging_80.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_85.qmg:system/media/battery_charging_85.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_90.qmg:system/media/battery_charging_90.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_95.qmg:system/media/battery_charging_95.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_100.qmg:system/media/battery_charging_100.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_5.qmg:system/media/wc_battery_charging_5.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_10.qmg:system/media/wc_battery_charging_10.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_15.qmg:system/media/wc_battery_charging_15.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_20.qmg:system/media/wc_battery_charging_20.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_25.qmg:system/media/wc_battery_charging_25.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_30.qmg:system/media/wc_battery_charging_30.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_35.qmg:system/media/wc_battery_charging_35.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_40.qmg:system/media/wc_battery_charging_40.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_45.qmg:system/media/wc_battery_charging_45.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_50.qmg:system/media/wc_battery_charging_50.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_55.qmg:system/media/wc_battery_charging_55.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_60.qmg:system/media/wc_battery_charging_60.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_65.qmg:system/media/wc_battery_charging_65.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_70.qmg:system/media/wc_battery_charging_70.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_75.qmg:system/media/wc_battery_charging_75.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_80.qmg:system/media/wc_battery_charging_80.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_85.qmg:system/media/wc_battery_charging_85.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_90.qmg:system/media/wc_battery_charging_90.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_95.qmg:system/media/wc_battery_charging_95.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/wc_battery_charging_100.qmg:system/media/wc_battery_charging_100.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/chargingwarning.qmg:system/media/chargingwarning.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/chargingwarning_auth.qmg:system/media/chargingwarning_auth.qmg


EOF

./setup-makefiles.sh
