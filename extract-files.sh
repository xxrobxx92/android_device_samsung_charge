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
		exit 1
	fi
	echo "$1 successfully unzip'd. Copying files..."
	ZIP="true"
else
	unset ZIP
fi

DIRS="
bin
cameradata
etc/wifi
firmware/SA
firmware/SG
lib/egl
lib/hw
media
"

for DIR in $DIRS; do
	mkdir -p ../../../vendor/samsung/$DEVICE/proprietary/$DIR
done

FILES="
etc/wifi/nvram_net.txt
etc/wifi/nvram_mfg.txt
etc/wifi/bcm4329_aps.bin
etc/wifi/bcm4329_mfg.bin
etc/wifi/bcm4329_sta.bin

bin/tvoutserver
cameradata/datapattern_420sp.yuv
cameradata/datapattern_front_420sp.yuv
firmware/SA/RS_M5LS.bin
firmware/SG/RS_M5LS.bin
lib/libActionShot.so
lib/libcamera.so
lib/libarccamera.so
lib/libcamera_client.so
lib/libcamerafirmwarejni.so
lib/libcameraservice.so
lib/libCaMotion.so
lib/libcaps.so
lib/libddc.so
lib/libedid.so
lib/libfactorytestcamerajni.so
lib/libfimc.so
lib/libPanoraMax1.so
lib/libPlusMe.so
lib/libs3cjpeg.so
lib/libseccamera.so
lib/libseccameraadaptor.so
lib/libsecjpegencoder.so
lib/libtvout.so
lib/lib_tvoutengine.so
lib/libtvoutfimc.so
lib/libtvouthdmi.so
lib/libtvoutservice.so

bin/pppd_runner
bin/rild
etc/cellcache.db
lib/libnetutils.so
lib/libril.so
lib/libsec-ril40.so
lib/libsec-ril40-cdma.so
lib/libsecril-client.so

bin/gpsd
lib/hw/gps.s5pc110.so

bin/pvrsrvinit
lib/egl/libEGL_POWERVR_SGX540_120.so
lib/egl/libGLES_android.so
lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so
lib/egl/libGLESv2_POWERVR_SGX540_120.so
lib/libsrv_um.so
lib/libsrv_init.so
lib/libIMGegl.so
lib/libpvr2d.so
lib/libpvrANDROID_WSEGL.so
lib/libglslcompiler.so
lib/libPVRScopeServices.so
lib/libusc.so

bin/geomagneticd
bin/orientationd
lib/libsensorservice.so
lib/libsensor_yamaha_test.so
lib/hw/sensors.default.so

lib/hw/copybit.s5pc110.so
lib/hw/lights.s5pc110.so
lib/hw/gralloc.s5pc110.so

lib/libs263domxoc.so
lib/libs263eomxoc.so
lib/libs264domxoc.so
lib/libs264eomxoc.so
lib/libsaacdomxoc.so
lib/libsaaceomxoc.so
lib/libsac3domxoc.so
lib/libsamrdomxoc.so
lib/libsamreomxoc.so
lib/libsdiv3domxoc.so
lib/libsflacdomxoc.so
lib/libsmp3domxoc.so
lib/libsmp4vdomxoc.so
lib/libsvc1domxoc.so
lib/libswmadomxoc.so
lib/libswmv7domxoc.so
lib/libswmv8domxoc.so
lib/libstagefrighthw.so
lib/libSecOMXCore.so
lib/hw/overlay.s5pc110.so

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
    vendor/samsung/__DEVICE__/proprietary/lib/libcamera.so:obj/lib/libcamera.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:obj/lib/libsecrilclient.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40.so:obj/lib/libsec-ril40.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40-cdma.so:obj/lib/libsec-ril40-cdma.so

#
# Wifi
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/nvram_net.txt:system/etc/wifi/nvram_net.txt \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/nvram_mfg.txt:system/etc/wifi/nvram_mfg.txt \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_aps.bin:system/etc/wifi/bcm4329_aps.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_mfg.bin:system/etc/wifi/bcm4329_mfg.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/bcm4329_sta.bin:system/etc/wifi/bcm4329_sta.bin

#
# Display (3D)
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/pvrsrvinit:system/bin/pvrsrvinit \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libEGL_POWERVR_SGX540_120.so:system/lib/egl/libEGL_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLES_android.so:system/lib/egl/libGLES_android.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so:system/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLESv2_POWERVR_SGX540_120.so:system/lib/egl/libGLESv2_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsrv_um.so:system/lib/libsrv_um.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsrv_init.so:system/lib/libsrv_init.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libIMGegl.so:system/lib/libIMGegl.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libpvr2d.so:system/lib/libpvr2d.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libpvrANDROID_WSEGL.so:system/lib/libpvrANDROID_WSEGL.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libglslcompiler.so:system/lib/libglslcompiler.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libPVRScopeServices.so:system/lib/libPVRScopeServices.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libusc.so:system/lib/libusc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/gralloc.s5pc110.so:system/lib/hw/gralloc.s5pc110.so

#
# Sensors, Lights etc
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/geomagneticd:system/bin/geomagneticd \\
    vendor/samsung/__DEVICE__/proprietary/bin/orientationd:system/bin/orientationd \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsensor_yamaha_test.so:system/lib/libsensor_yamaha_test.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsensorservice.so:system/lib/libsensorservice.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/copybit.s5pc110.so:system/lib/hw/copybit.s5pc110.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/lights.s5pc110.so:system/lib/hw/lights.s5pc110.so

#
# OMX
#
#PRODUCT_COPY_FILES += \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libstagefrighthw.so:system/lib/libstagefrighthw.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libSecOMXCore.so:system/lib/libSecOMXCore.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/hw/overlay.s5pc110.so:system/lib/hw/overlay.s5pc110.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libs263domxoc.so:system/lib/libs263domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libs263eomxoc.so:system/lib/libs263eomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libs264domxoc.so:system/lib/libs264domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libs264eomxoc.so:system/lib/libs264eomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsaacdomxoc.so:system/lib/libsaacdomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsaaceomxoc.so:system/lib/libsaaceomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsac3domxoc.so:system/lib/libsac3domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsamrdomxoc.so:system/lib/libsamrdomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsamreomxoc.so:system/lib/libsamreomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsdiv3domxoc.so:system/lib/libsdiv3domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsflacdomxoc.so:system/lib/libsflacdomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsmp3domxoc.so:system/lib/libsmp3domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsmp4vdomxoc.so:system/lib/libsmp4vdomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libsvc1domxoc.so:system/lib/libsvc1domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libswmadomxoc.so:system/lib/libswmadomxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libswmv7domxoc.so:system/lib/libswmv7domxoc.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libswmv8domxoc.so:system/lib/libswmv8domxoc.so

#
# Camera
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/tvoutserver:system/bin/tvoutserver \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_420sp.yuv:system/cameradata/datapattern_420sp.yuv \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_front_420sp.yuv:system/cameradata/datapattern_front_420sp.yuv \\
    vendor/samsung/__DEVICE__/proprietary/firmware/SA/RS_M5LS.bin:system/firmware/SA/RS_M5LS.bin \\
    vendor/samsung/__DEVICE__/proprietary/firmware/SG/RS_M5LS.bin:system/firmware/SG/RS_M5LS.bin \\
    vendor/samsung/__DEVICE__/proprietary/lib/libActionShot.so:system/lib/libActionShot.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamera.so:system/lib/libcamera.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libarccamera.so:system/lib/libarccamera.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamera_client.so:system/lib/libcamera_client.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamerafirmwarejni.so:system/lib/libcamerafirmwarejni.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcameraservice.so:system/lib/libcameraservice.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libCaMotion.so:system/lib/libCaMotion.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcaps.so:system/lib/libcaps.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libddc.so:system/lib/libddc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libedid.so:system/lib/libedid.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libfactorytestcamerajni.so:system/lib/libfactorytestcamerajni.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libfimc.so:system/lib/libfimc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libPanoraMax1.so:system/lib/libPanoraMax1.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libPlusMe.so:system/lib/libPlusMe.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libs3cjpeg.so:system/lib/libs3cjpeg.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libseccamera.so:system/lib/libseccamera.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libseccameraadaptor.so:system/lib/libseccameraadaptor.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecjpegencoder.so:system/lib/libsecjpegencoder.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libtvout.so:system/lib/libtvout.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/lib_tvoutengine.so:system/lib/lib_tvoutengine.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libtvoutfimc.so:system/lib/libtvoutfimc.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libtvouthdmi.so:system/lib/libtvouthdmi.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libtvoutservice.so:system/lib/libtvoutservice.so

#
# RIL
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/pppd_runner:system/bin/pppd_runner \\
    vendor/samsung/__DEVICE__/proprietary/bin/rild:system/bin/rild \\
    vendor/samsung/__DEVICE__/proprietary/etc/cellcache.db:system/etc/cellcache.db \\
    vendor/samsung/__DEVICE__/proprietary/lib/libnetutils.so:system/lib/libnetutils.so \\
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
# Vold (sdcard)
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/vold:system/bin/vold \\
    vendor/samsung/__DEVICE__/proprietary/etc/vold.conf:system/etc/vold.conf \\
    vendor/samsung/__DEVICE__/proprietary/etc/vold.fstab:system/etc/vold.fstab

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
