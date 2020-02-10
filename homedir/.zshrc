# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh
# if you want to use this, change your non-ascii font to Droid Sans Mono for Awesome
# POWERLEVEL9K_MODE='awesome-patched'
export ZSH_THEME="powerlevel9k/powerlevel9k"
# export ZSH_THEME="agnoster"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
# https://github.com/bhilburn/powerlevel9k#customizing-prompt-segments
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir nvm vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time)
# colorcode test
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
POWERLEVEL9K_NVM_FOREGROUND='000'
POWERLEVEL9K_NVM_BACKGROUND='072'
POWERLEVEL9K_SHOW_CHANGESET=true
#export ZSH_THEME="random"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# disable colors in ls
# export DISABLE_LS_COLORS="true"

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colorize compleat dirpersist autojump git gulp history cp)

source $ZSH/oh-my-zsh.sh

source /usr/local/opt/nvm/nvm.sh --no-use

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use &> /dev/null
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Customize to your needs...
unsetopt correct

# run fortune on new terminal :)
# fortune
#
# ======================================
#								Functions
# ======================================
function set_title(){
  echo -ne "\033];$(hostname): $(pwd)\007"
}

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/seanhanford/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	history
	git
	dirhistory
	brew
	common-aliases
	node
  zsh-nvm
	z
	colorize
	iterm2
	ruby
	sudo
	zsh-navigation-tools
	zsh-syntax-highlighting
	zsh-autosuggestions
)

# Disabled the sourcing of oh-my-zsh to replace it with zplug
source $ZSH/oh-my-zsh.sh
## If you want to disable the sourcing of oh-my-zsh and replace it with zplug, uncomment the next 2-lines and the 1-line above this comment.
#export ZPLUG_HOME=/usr/local/opt/zplug
#source $ZPLUG_HOME/init.zsh

# Load custom dotfiles from oh-my-zsh custom folder
for file in ~/.oh-my-\zsh/custom/sourced/.* ; do
	source "$file"
done

# User configuration

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# SSH - Manage SSH with Keychain
if [ -x "$(command -V keychain)" ]; then
	eval `keychain --eval --quiet id_rsa`
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="cot ~/.zshrc"
alias ohmyzsh="cot ~/.oh-my-zsh"

## CANNOT DO WITHOUT THIS FUNCTION ##
# List directory files when cd'ing as in changing directory
function cd {
	builtin cd "$@" && ll
}

# Go up n levels:
# Usage .. [n]
function .. () {
	local arg=${1:-1};
	local dir=""
	while [ $arg -gt 0 ]; do
		dir="../$dir"
		arg=$(($arg - 1 ));
	done
	cd $dir #>&/dev/null
}

# Always work in a tmux session if tmux is installed
# https://github.com/chrishunt/dot-files/blob/master/.zshrc
#if which tmux 2>&1 > /dev/null; then
# if [ $TERM != "screen-256color" ] && [ $TERM != "screen" ]; then
#  tmux attach -t hack || tmux new -s hack; exit
# fi
#fi

fpath=(/usr/local/share/zsh-completions $fpath)

# Add Python 2.7 to the $PATH
# export PATH=/Users/seanhanford/Library/Python/2.7/bin:$PATH

# Add Python 3 to the $PATH
export PATH="/usr/local/Cellar/python/3.7.4_1/bin:$PATH"

## Add the coreutils tools to the $PATH
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
# export PATH="$PATH:$HOME/.composer/vendor/bin:$HOME/.composer/vendor/bin/drush"
# export PATH="$PATH:$HOME/.composer/vendor/bin"
# export PATH="/Users/seanhanford/Sites/webdaemon-blt/vendor/acquia/blt/bin:$PATH"
export PATH="$(composer config -g home)/vendor/bin:$PATH"
export PATH="$PATH:/usr/local/opt"
export PATH="/Users/seanhanford:$PATH"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/Users/seanhanford/vimrc:$PATH"
# export JAVA_HOME="/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_171.jdk/Contents/Home"

# Add the GO home path
export GOPATH=$HOME/go

# Set Spaceship ZSH as a prompt
  autoload -Uz promptinit
  promptinit
  prompt spaceship

## "pure" home page - https://github.com/sindresorhus/pure#getting-started
#autoload -Uz promptinit;
#promptinit
#prompt pure

#compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias composer="php /usr/local/bin/composer.phar"

# Load the shell integration script at login
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# include Z, yo
. ~/z.sh
export PATH="/usr/local/opt/nss/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

# ads autocomplete setup
ADS_AC_ZSH_SETUP_PATH=/Users/seanhanford/Library/Caches/ads-cli/autocomplete/zsh_setup && test -f $ADS_AC_ZSH_SETUP_PATH && source $ADS_AC_ZSH_SETUP_PATH;function blt() {
  if [[ ! -z ${AH_SITE_ENVIRONMENT} ]]; then
    PROJECT_ROOT="/var/www/html/${AH_SITE_GROUP}.${AH_SITE_ENVIRONMENT}"
  elif [ "`git rev-parse --show-cdup 2> /dev/null`" != "" ]; then
    PROJECT_ROOT=$(git rev-parse --show-cdup)
  else
    PROJECT_ROOT="."
  fi

  if [ -f "$PROJECT_ROOT/vendor/bin/blt" ]; then
    $PROJECT_ROOT/vendor/bin/blt "$@"

  # Check for local BLT.
  elif [ -f "./vendor/bin/blt" ]; then
    ./vendor/bin/blt "$@"

  else
    echo "You must run this command from within a BLT-generated project."
    return 1
  fi
}

# Adding in drush aliases and customizations originally added to the .bash_profile file
source ~/.git-prompt.sh
# export PATH="$PATH:/Applications/DevDesktop/tools"
# export PATH="$PATH:/Applications/DevDesktop/drush_9"

source ~/.zprofile

