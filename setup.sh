#!/bin/bash

VIM_DIR=$(dirname `readlink -f $0`)

green_print()
{
    printf '\e[1;32m%s\e[0m\n' "$1"
}

red_print()
{
    printf '\e[1;31m%s\e[0m\n' "$1"
}

die()
{
	red_print "$1"
	exit 1
}

info()
{
	green_print "$1"
}

check_wlan()
{
	overtime=5
	target=www.baidu.com # sorry, baidu
	ret_code=`curl -I -s --connect-timeout $overtime $target -w %{http_code} | tail -n1`

	if [ "$ret_code" = "200" ];
	then
		return 0
	fi

	return 1
}

check_require()
{
	info "Checking requirements for vimrc ......"

	which curl || die "No curl installed"

	which ctags || die "No ctags installed!"
	which cscope || die "No cscope installed!"

	info "Check requirements for vimrc ok"
}

copy_vimrc()
{
	if [ -f $HOME/.vimrc ];
	then
		rm $HOME/.vimrc
	fi

    cp -f ${VIM_DIR}/vimrc $HOME/.vimrc
}

update_submodule()
{
	info "updating submodules ......"
	git submodule init
	git submodule update
	info "update submodules ok" 
}

install_vimrc()
{
	check_wlan
	if [ $? -eq 0 ];
	then
		echo "wlan"
		update_submodule
	fi

    test ! -f $HOME/.vimrc || rm -rf $HOME/.vimrc
    test ! -d $HOME/.vim || rm -rf $HOME/.vim

    cp -f ${VIM_DIR}/vimrc $HOME/.vimrc
    cp -rf ${VIM_DIR}/vim $HOME/.vim

    info "Install vimrc ok"
}

help()
{
	info "Usage: $0 -h/-i/-u"
	info "-h: help"
	info "-i: install vimrc"
	info "-u: update submodule"
}

while getopts ":hiu" opt;
do
	case $opt in
		h)
			help
			;;
		i)
			check_require
			install_vimrc
			;;
		u)
			update_submodule
			;;
		?)
			help
			;;
	esac
done
			


			
			
