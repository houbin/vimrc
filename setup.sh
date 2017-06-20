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

compile_vim_with_lua()
{
    wget 
        

}

check_require()
{
	info "Checking requirements for vimrc ......"

	which curl || die "No curl installed"

	which ctags || die "No ctags installed!"
	which cscope || die "No cscope installed!"

    vim_version=$(vim --version | head -n 1 | awk '{print $5}' | cut -c 1,3)
    if [ ${vim_version} -lt 74 ];
    then
        die "You vim version is less than 7.4. Please update your vim"
    fi

    vim --version | grep "+lua" || die "Vim without lua, need +lua \
yum install lua lua-devel \n\
wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz \n\
tar -xzf LuaJIT-2.0.4.tar.gz \n\
cd LuaJIT-2.0.4 \n\
make && make install \n\
wget https://github.com/vim/vim/archive/v7.4.tar.gz \n\
tar -xzf v7.4.tar.gz \n\
./configure --prefix=/usr --with-features=huge --with-luajit --enable-luainterp=yes --enable-fail-if-missing \n\
make && make install"

	info "Check requirements for vimrc ok"
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

backup_vimrc()
{
	cd $VIM_DIR/../
	tar -czf vimrc.tar.gz vimrc/
}

help()
{
	info "Usage: $0 -h/-i/-u"
	info "-h: help"
	info "-i: install vimrc"
	info "-u: update submodule"
	info "-b: backup vimrc"
}

while getopts ":hiub" opt;
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
		b)
			backup_vimrc
			;;
		?)
			help
			;;
	esac
done
			


			
			
