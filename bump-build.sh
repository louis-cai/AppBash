#!/bin/bash

#--------------------------------------------
# 功能：重置版本号
# 使用说明：
# 			bump-version <project directory> [-v <project version>] [-s <project schemeName>]
# 			example:/Users/cailu/bash/replace_info_plist.sh '/Users/cailu/Documents/project/iOS/MeileleMallHD(branches)/Dev/MeileleMallHD/MeileleMallHD-Info.plist' 'MeileleMallHD' '1.9.1'
# 参数说明: 
#			-v 版本号
#			-s scheme名称
#--------------------------------------------

if [ $# -lt 1 ];then
	echo "Error! Should enter the root directory of xcode project after the bump-version command."
	exit 2
fi

app_infoplist_path=$1

#取版本号
old_build=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${app_infoplist_path})
build=${old_build}

if [[ $2 == "" ]]; then
	build=$(expr $build + 1)
else
	build=$2
fi

if [[ "${build}" != "" ]]; then
	/usr/libexec/Plistbuddy -c "Set CFBundleVersion ${build}" "${app_infoplist_path}"
fi

new_build=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${app_infoplist_path})
echo "${new_build}" || exit