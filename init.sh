#!/bin/bash

################ 1. init config ################ 
ZIP_FILE="init-master.zip"
UNZIP_FOLDER=`basename "${ZIP_FILE}" ".zip"`
ONLINE_FILE="https://codeload.github.com/neagle2009/init/zip/master"

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
INSTALL=`installCmd`

function installZsh() {
    ${INSTALL} zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    test -f /bin/zsh && chsh -s /bin/zsh
    cp -r "${UNZIP_FOLDER}/init_file/zshrc" $HOME/.zshrc
}

function getOnlinFile() {
    test -f "${ONLINE_FILE}" ||  wget -O "${ZIP_FILE}" -c "${ONLINE_FILE}"
    if [ ! -f "${ZIP_FILE}" ] ;then
        echo "not found file ${ZIP_FILE}"
        exit
    fi
    unzip "${ZIP_FILE}"
}

function installConfigFile() {

    #1. dircolor config
    colorFile="$HMOE/.dircolors"
    if [ ! -f "${colorFile}" ] ;then
        cat ${UNZIP_FOLDER}/init_file/dir_colors >> ${colorFile}
    fi

    #2. install public bin
    hideBinDir="$HOME/.bin"
    if [ ! -d "${hideBinDir}" ] ;then
        mkdir "${hideBinDir}"
    fi

    #3. install vim config
    cat ${UNZIP_FOLDER}/init_file/vimrc/vimrc > $HOME/.vimrc
    vimdir="$HOME/.vim"
    if [ ! -d "$vimdir" ] ;then
        mkdir "${vimdir}"
    fi
    cp -r "${UNZIP_FOLDER}/init_file/vimrc/plugin" "${vimdir}/plugin"
}

function cleanTrash() {
    rm -rf "${UNZIP_FOLDER}"
    rm "${ZIP_FILE}"
}

function downloadCdargs() {
    $INTALL cdargs &> /dev/null
    type cdargs &> /dev/null || (
        mv "${UNZIP_FOLDER}/init_file/cdargs-bash.sh" "$HOME/.bin/cdargs-bash.sh" 
    )
}

function installVundle() {
    vimrcfile="$HOME/.vimrc"
    vimrc=`cat ${vimrcfile}`
    bundleVimrc=`cat ${UNZIP_FOLDER}/init_file/vundle.vimrc`
    bundleVim="$HOME/.vim/bundle/Vundle.vim"
    grep -q 'call vundle#begin()' ~/.vimrc || (echo "${bundleVimrc}${vimrc}" > $vimrcfile)
    test -e $bundleVim || git clone https://github.com/VundleVim/Vundle.vim.git $bundleVim
    #vim +PluginInstall +qall
    #vim +PluginInstall ctrlp.vim +qall
    #vim +PluginInstall ctags.vim +qall
}

################ 2. setting ################ 

getOnlinFile
installConfigFile
installZsh
downloadCdargs
installVundle
#cleanTrash
