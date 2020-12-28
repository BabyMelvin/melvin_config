# !/bin/bash
# melvin_config.sh config vim、git

# set strict mode
set -euo pipefail

# bin to install, need absolute path
BIN_PATH=$HOME/.local
EXE_PATH=$BIN_PATH/${USER}_config

COLOR_RES='\E[0m'
INSTALL_VIM=

function help()
{
cat << EOF
        Usage: ./$0 -i vim
            -i -- install vim
            -h -- help
            -p -- prefix bin path, default bin path
EOF
}

function log_info()
{
    local COLOR_BLUE='\E[1;34m'
    if [ $# -lt 1 ];then 
        echo "Usage: $0 \"info to echo\""
        return
    fi

    echo -e "${COLOR_BLUE}<Info>:$1 ${COLOR_RES}"
}

function log_warn()
{
    local COLOR_YELLOW='\E[1;33m'
    if [ $# -lt 1 ];then 
        echo "Usage: $0 \"info to echo\""
        return
    fi

    echo -e "${COLOR_YELLOW}<Warn>:$1 ${COLOR_RES}"
}

function log_error()
{
    local COLOR_RED='\E[1;31m'
    if [ $# -lt 1 ];then 
        echo "Usage: $0 \"info to echo\""
        return
    fi

    echo -e "${COLOR_RED}<Error>:$1 ${COLOR_RES}"
}

function install_vim()
{
    [ -e $BIN_PATH/vim ] || mkdir $BIN_PATH/vim
    [ -e $BIN_PATH/vim/configure ] || git clone https://github.com/vim/vim.git $BIN_PATH/vim
    cd $BIN_PATH/vim/
    # need 2Python and python3
    ./configure --with-features=huge --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config --enable-rubyinterp --enable-luainterp --enable-perlinterp --enable-python3interp=yes --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu --enable-gui=gtk2 --enable-cscope --prefix=$BIN_PATH
    make
    make install
}

# the path to install
[ -e $BIN_PATH ] || mkdir $BIN_PATH
[ -e $EXE_PATH ] || mkdir $EXE_PATH

# copy all git to $HOME/.local
[ -e $BIN_PATH ] && cp -rf  * $EXE_PATH
[ -e $BIN_PATH/${USER}_config ] && cd $EXE_PATH

log_info "Current path:`pwd`"
if [ $BIN_PATH/${USER}_config != `pwd` ];then
   log_error "all should in the $BIN_PATH/${USER}_config path" 
   exit
fi

log_info "install vim"
[ -e $BIN_PATH/bin/vim ] || install_vim

source ~/.profile

cd $EXE_PATH
log_info "current dir: `pwd`"

# install bundle vim
[ -e  ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 

# create soft links
rm ~/.gitconfig && ln -s $BIN_PATH/${USER}_config/gitconfig ~/.gitconfig
rm ~/.vimrc && ln -s $BIN_PATH/${USER}_config/vimrc_pright ~/.vimrc
rm $HOME/.ycm_extra_conf.py && ln -s $BIN_PATH/${USER}_config/ycm_extra_conf ~/.ycm_extra_conf.py

# install vim plugin
vim -c "PluginInstall"
