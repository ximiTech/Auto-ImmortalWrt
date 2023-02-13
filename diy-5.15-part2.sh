#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

########### 修改默认 IP ###########
# sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

########### 更改大雕源码（可选）###########
sed -i "s/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=5.15/g" target/linux/x86/Makefile

########### 维持xray-core的版本 ###########
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.7.2/g' feeds/passwall_packages/xray-core/Makefile
# sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/passwall_packages/xray-core/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=skip/g' feeds/passwall_packages/xray-core/Makefile

########### 维持xray-plugin的版本 ###########
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.7.2/g' feeds/passwall_packages/xray-plugin/Makefile
# sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/passwall_packages/xray-plugin/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=skip/g' feeds/passwall_packages/xray-plugin/Makefile

########### 替换immortal的内置的openclash版本 ###########
rm -rf feeds/luci/applications/luci-app-openclash
wget -P feeds/luci/applications https://github.com/ximiTech/intelligentclicker/raw/main/luci-app-openclash.zip
unzip -q -d feeds/luci/applications feeds/luci/applications/luci-app-openclash.zip
rm feeds/luci/applications/luci-app-openclash.zip
