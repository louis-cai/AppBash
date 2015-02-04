#!/bin/bash

#--------------------------------------------
# 功能：重置版本号
# 使用说明：
# 			ipa-package [-p <project project>] [-s <project schemeName>] [-t <project target build path>] 
# 			example:ipa-package.sh -i '/Users/cailu/Documents/project/iOS/MeileleMallHD(branches)/Dev/MeileleMallHD/MeileleMallHD-Info.plist' -s 'MeileleMallHD'  -t '/Users/cailu/Documents/工作文档/版本库/MeileleMallHD/MeileleMallHD' -p '/Users/cailu/Documents/工作文档/版本库/MeileleMallHD/'
# 参数说明: 
#			-w workspace
#			-p project
#			-s schemeName
#			-t archive文件的地址
#
# 作者：Louis
# 创建时间：2015年01月13日
#--------------------------------------------

if [ $# -lt 1 ];then
	echo "Error! Should enter the root directory of xcode project after the replace_info_plist command."
	exit 2
fi

while getopts :v:o: optname
  do
    case $optname in
        v)
		target_ios_app_path=$OPTARG
		;;

		o)
		ipa_publish_path=$OPTARG
		;;

        "?")
        echo "Error! Unknown option $OPTARG"
		exit 2
        ;;

        ":")
        echo "Error! No argument value for option $OPTARG"
		exit 2
        ;;

      	*)
      	# Should not occur
        echo "Error! Unknown error while processing options"
		exit 2
        ;;
    esac
  done

if [ -d $target_ios_app_path ] ; then
	pack_cmd="xcrun -sdk iphoneos PackageApplication -v ${target_ios_app_path} -o  ${ipa_publish_path}"
	echo "package_commond: ${pack_cmd}"
	$pack_cmd || exit
fi