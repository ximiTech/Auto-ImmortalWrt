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

########### 替换immortal的内置的smartdns版本 ###########
cd feeds/packages/net
rm -rf smartdns/
svn co https://github.com/coolsnowwolf/packages/trunk/net/smartdns smartdns/
rm -rf smartdns/.svn/
# sed -i 's/1.2022.38/1.2023.41/g' smartdns/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=0947a8dcabdd48f7cabd05a336a3eb7d4510f605/g' smartdns/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=skip/g' smartdns/Makefile
cd ../../..

cd feeds/luci/applications

########### 替换immortal的内置的openclash版本 ###########
rm -rf luci-app-openclash/
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull --depth 1 origin dev
git branch --set-upstream-to=origin/dev
git reset --hard 4564a7fe49657c08266f786d1c1421839b6797a1
sed -i 's/clashversion_check();/\/\/&/g' luci-app-openclash/luasrc/view/openclash/status.htm
rm -rf .git/
rm -rf .github/

########### 替换immortal的内置的passwall版本 ###########
rm -rf luci-app-passwall/
svn co https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall luci-app-passwall/
rm -rf luci-app-passwall/.svn/

########### 替换immortal的内置的unblockneteasemusic版本 ###########
rm -rf luci-app-unblockneteasemusic/
git clone -b js https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git luci-app-unblockneteasemusic
rm -rf luci-app-unblockneteasemusic/.git/
rm -rf luci-app-unblockneteasemusic/.github/

cd ../../..

# sed -i 's/\r$//g' luci-app-openclash/root/etc/openclash/custom/openclash_custom_firewall_rules.sh
# sed -i 's/clashversion_check();/\/\/&/g' luci-app-openclash/luasrc/view/openclash/status.htm
# sed -i 's/ForceDnsMapping/force-dns-mapping/g' luci-app-openclash/root/usr/share/openclash/yml_change.sh
# sed -i 's/ParsePureIp/parse-pure-ip/g' luci-app-openclash/root/usr/share/openclash/yml_change.sh
# sed -i 's/0.45.84/0.68.86/g' luci-app-openclash/root/www/luci-static/resources/openclash/img/version.svg

# wget -P feeds/luci/applications https://github.com/ximiTech/intelligentclicker/raw/main/luci-app-openclash.zip
# unzip -q -d feeds/luci/applications feeds/luci/applications/luci-app-openclash.zip
# rm feeds/luci/applications/luci-app-openclash.zip

# sed -i 's/\r$//g' feeds/luci/applications/luci-app-openclash/root/etc/openclash/custom/openclash_custom_firewall_rules.sh
# sed -i 's/clashversion_check();/\/\/&/g' feeds/luci/applications/luci-app-openclash/luasrc/view/openclash/status.htm
