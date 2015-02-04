#!/bin/bash

#--------------------------------------------
# 功能：重置版本号
# 使用说明：
# 			ipa-release [-w <project workspace>] [-p <project project>] [-s <project schemeName>] [-t <project target build path>] 
# 			example:/Users/cailu/bash/ipa-release.sh '/Users/cailu/Documents/project/iOS/MeileleMallHD(branches)/Dev/MeileleMallHD/MeileleMallHD-Info.plist' 'MeileleMallHD' '1.9.1'
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

while getopts :w:p:s:t:i:f: optname
  do
    case $optname in
	 	w)   
		workspace=$OPTARG
        ;;

        p)
		project=$OPTARG
		;;

    	s)
		schemeName=$OPTARG	
        ;;

        t)
		target_ios_build_path=$OPTARG	
        ;;

        f)
        configuration=$OPTARG   
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

#组合编译命令
build_cmd='/usr/local/bin/xctool'

if [ -d $workspace ]; then
	build_cmd=${build_cmd}' -workspace '${workspace}
fi

if [[ "${project}" != "" ]]; then
	build_cmd=${build_cmd}' -project '${project}
fi

if [[ "${target_ios_build_path}" == "" ]]; then
	target_ios_build_path="/Users/cailu/Documents/工作文档/版本库/${schemeName}/"
fi

if [[  "${configuration}" != "" ]]; then
    build_cmd="${build_cmd} -configuration ${configuration}"
fi

build_cmd=${build_cmd}' -destination generic/platform=iOS -scheme '${schemeName}' clean archive -archivePath '${target_ios_build_path}

#编译
echo "build_commond: ${build_cmd}"
$build_cmd || exit
