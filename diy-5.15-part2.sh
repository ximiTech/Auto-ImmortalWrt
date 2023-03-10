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

# cd feeds/luci/applications
# git init
# git remote add -f origin https://github.com/vernesong/OpenClash.git
# git config core.sparsecheckout true
# echo "luci-app-openclash" >> .git/info/sparse-checkout
# git pull --depth 1 origin dev
# git branch --set-upstream-to=origin/dev
# git reset --hard 707d81813350bd5748de9391da55351f38df1f26
# sed -i 's/\r$//g' luci-app-openclash/root/etc/openclash/custom/openclash_custom_firewall_rules.sh
# sed -i 's/clashversion_check();/\/\/&/g' luci-app-openclash/luasrc/view/openclash/status.htm
# sed -i 's/ForceDnsMapping/force-dns-mapping/g' luci-app-openclash/root/usr/share/openclash/yml_change.sh
# sed -i 's/ParsePureIp/parse-pure-ip/g' luci-app-openclash/root/usr/share/openclash/yml_change.sh
# sed -i 's/0.45.84/0.68.86/g' luci-app-openclash/root/www/luci-static/resources/openclash/img/version.svg
# rm -rf .git/
# cd ../../..

# sed -i 's/\r$//g' feeds/luci/applications/luci-app-openclash/root/etc/openclash/custom/openclash_custom_firewall_rules.sh
# sed -i 's/clashversion_check();/\/\/&/g' feeds/luci/applications/luci-app-openclash/luasrc/view/openclash/status.htm
