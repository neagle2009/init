# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/neagle/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-completions
)

autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

##################### neagle2009
#alias
alias ..='cd ../'
alias ...='cd ../../'
alias diff='diff -u'
alias ll='ls -lhtr'
alias mv="mv -i"
alias cp="cp -i"

if [ -f "/home/neagle/code/myself/private/proxy.sites.blocklist" ]; then
	alias proxyblocklist="cat /home/neagle/code/myself/private/proxy.sites.blocklist| xargs | tr ' ' ';'"
fi

# wsl chinese display utf8 code
export GIT_PS1_SHOWDIRTYSTATE=1
#no dumps history
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

zstyle ':completion:*' rehash true

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

function addToPATH() {
	case ":$PATH:" in
		*":$1:"*) :;; # already there
		*) PATH="$1:$PATH";; # or PATH="$PATH:$1"
	esac
}

## add path
needInPath=("$HOME/bin" "$HOME/go/bin")
for p in ${needInPath[@]}
do
    if [ -d $p ] ;then
		addToPATH "$p"
    fi
done

## include file
sourceList=("$HOME/.bin/cdargs-bash.sh")
for s in ${sourceList[@]}
do
    if [ -f $s ] ;then
        source $s
    fi  
done

function psg() {
    ps -ef | grep "$@"
}

function mgrep() {
    path=${3:-$PWD}
    if [ -n "$2" ]; then
        word="$1"
        inc="$2"
        shift
        shift
        sudo grep --color -n -w "${word}" --include="${inc}" -r "$path"
    else
        word="$1"
        shift
        sudo grep --color -n -w "${word}" -r "$path"
    fi
}

function bak() {
    if [ -f "$1" ]; then
        cp "$1" ${1}.bak.`date +"%Y%m%d%H%M%S"`
    elif [ -d "$1" ]; then
        cp -r "$1" ${1}.bak.`date +"%Y%m%d%H%M%S"`
    else
        echo "sorry, only support file and dir"
    fi
}

