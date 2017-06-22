该vim配置是自己从头开始配置的vim，不求最好，但求适合自己，从头打磨
参考大神孟圣智的vim配置 [coolceph vim](https://github.com/coolceph/vimrc)

# Requirements
1. vim 7.4+, vim需要支持lua, 可以通过 vim --version | grep lua 来检查是否支持lua.
2. ctags

# Install

``` shell
git clone https://github.com/houbin/vimrc.git
cd vimrc
./setup.sh -i
```

无网络环境的话，可以再有网络的地方执行如下步骤

``` shell
./setup.sh -u
./setup.sh -b
```
这样就可以在上层目录生成vimrc.tar.gz文件, 该文件可以拷贝到无网络环境使用

# Plugin

1. [Vundle](https://github.com/VundleVim/Vundle.vim)
2. [neocomplete](https://github.com/Shougo/neocomplete.vim)
3. [nerdtree](https://github.com/scrooloose/nerdtree)
4. [tagbar](https://github.com/majutsushi/tagbar)




