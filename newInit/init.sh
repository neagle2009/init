#!/bin/bash

################ 1. init config ################ 
ZIP_FILE="init-master.zip"
UNZIP_FOLDER=`basename "${ZIP_FILE}" ".zip"`
ONLINE_FILE="https://codeload.github.com/neagle2009/init/zip/master"
INIT_PATH="$HOME/.init"
TEMP_DIR=$(mktemp -d)
CURRNET_DIR=$(pwd)

function installCmd() {
    list='/usr/bin/apt /usr/bin/yum'
    for i in $list
    do 
        if [ -f "${i}" ] ;then 
            echo "sudo ${i} install"
            return
        fi
    done
}
function sourceFile() {
    if [ -f $1 ] ;then
        echo "source $1" >> $HOME/.bashrc
    fi
}

INSTALL=`installCmd`

function installBase() {
    ${INSTALL} -y vim git net-tools wget curl telnet rsync scp dos2unix ctags unzip unrar cmake m4 gcc ntpdate gcc-c++ autoconf automake patch openssl-devel
}

function installZsh() {
    ${INSTALL} -y zsh
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh &> /dev/null 
	if [ $? -eq 0 ]; then
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	else
		sh ${CURRENT_DIR}/init_files/new_init/zsh_install.sh
	fi

    test -f /bin/zsh && chsh -s /bin/zsh
    cp -r "${CURRENT_DIR}/new_init/zshrc" $HOME/.zshrc
	git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
	if [ ! -e "$HOME/fonts" ]; then
		(cd $HOME && git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh)
	fi

	#ZSH--agnoster主题乱码问题 ** wsl install fonts in windows , then set windows terminal fonts
	#https://blog.csdn.net/Jonder_wu/article/details/100529721
}

function installGoAndConfigGolang() {
	if [ -f /usr/bin/go ]; then
		go env -w GO111MODULE="on"
		go env -w GOPROXY="https://goproxy.io,direct"
	fi

}

function installAndConfigGit() {
	if [ ! "$GIT_PS1_SHOWDIRTYSTATE"] ;then
		echo 'export GIT_PS1_SHOWDIRTYSTATE=1' >> ~/.zshrc
	fi
}

function initVim() {
# install supertab https://www.vim.org/scripts/script.php?script_id=1643
# git: https://github.com/ervandew/supertab
# wget -c 'https://www.vim.org/scripts/download_script.php?src_id=21752' -O supertab.vmb	
#1. Download supertab.vmb to any directory.
#2. Open the file in vim ($ vim supertab.vmb).
#3. Source the file (:so %).

# vim-go
#1. git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
#2. open vim , then :GoInstallBinaries
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#git clone https://github.com/fatih/vim-go.git ~/.vim/plugged/vim-go

}
