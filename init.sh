#!/bin/bash

################ 1. init config ################ 
ZIP_FILE="init-master.zip"
UNZIP_FOLDER=`basename "${ZIP_FILE}" ".zip"`
ONLINE_FILE="https://codeload.github.com/neagle2009/init/zip/master"
INIT_PATH="$HOME/.init"

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

function installZsh() {
    ${INSTALL} -y zsh
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
    colorFile="$HOME/.dircolors"
    if [ ! -f "${colorFile}" ] ;then
        cat ${UNZIP_FOLDER}/init_file/dir_colors >> ${colorFile}
    fi

    #2. install public bin
    hideBinDir="$HOME/.bin"
    if [ ! -d "${hideBinDir}" ] ;then
        mkdir "${hideBinDir}"
    fi

    #3. init
    if [ ! -d "${INIT_PATH}" ] ;then
        mkdir $INIT_PATH
    fi

    #3. install vim config
    cat ${UNZIP_FOLDER}/init_file/vimrc/vimrc > $HOME/.vimrc
    vimdir="$HOME/.vim"
    if [ ! -d "$vimdir" ] ;then
        mkdir "${vimdir}"
    fi
    cp -r "${UNZIP_FOLDER}/init_file/vimrc/plugin" "${vimdir}/plugin"

    cat "${UNZIP_FOLDER}/init_file/bashrc_public" >> $HOME/.bashrc
}

function cleanTrash() {
    rm -rf "${UNZIP_FOLDER}"
    rm "${ZIP_FILE}"
}

function installCdargs() {
    $INTALL -y cdargs &> /dev/null
    type cdargs &> /dev/null || (
        mv "${UNZIP_FOLDER}/init_file/cdargs-bash.sh" "${INIT_PATH}/cdargs-bash.sh" 
        sourceFile "${INIT_PATH}/cdargs-bash.sh"
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

function installGit() {
    $INSTALL -y git

    if [ "${SHELL}"=="/bin/bash" ]; then
        wget -O "${INIT_PATH}/.git-completion.bash" 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'
        sourceFile "${INIT_PATH}/.git-completion.bash" 

        wget -O "${INIT_PATH}/.git-prompt.sh" 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh'
        sourceFile "${INIT_PATH}/.git-prompt.sh"
    
        echo 'export GIT_PS1_SHOWDIRTYSTATE=1' >> ~/.bashrc
        echo 'export PS1=\'\n \[\e[0;36m\]\u@\h(10.94.96.105)\[\e[0;30;1m\]:\[\e[0;33m\]\w $(__git_ps1) \[\e[0;30;1m\] \D{%Y-%m-%d %H:%M:%S} \[\e[0m\] \n[\e[0    ;31m\]!\!\[\e[0;37;1m\]\$\[\e[0m] \' >> ~/.bashrc
    else

    fi
}

################ 2. setting ################ 

getOnlinFile
installConfigFile
#installZsh
installCdargs
installVundle
installGit
#cleanTrash
