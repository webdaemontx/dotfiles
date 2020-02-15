# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/homedir/oh-my-zsh
export ZSH_THEME="spaceship"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(colorize compleat dirpersist autojump git gulp history cp)

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
# Standard plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.dotfiles/oh-my-zsh/custom/plugins/
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

# Load custom dotfiles into oh-my-zsh custom folder
for file in $HOME/.dotfiles/homedir/oh\-my\-zsh/custom/sourced/.*; do
  mv $HOME/.dotfiles/homedir/oh\-my\-zsh/custom/sourced/$file $HOME/.dotfiles/oh\-my-\zsh/custom/sourced/$file
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
alias zshconfig="cot $HOME/.zshrc"
alias ohmyzsh="cot $HOME/dotfiles/oh-my-zsh"

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

# Add Python 3 to the $PATH
export PATH="/usr/local/Cellar/python/3.7.4_1/bin:$PATH"

## Add the coreutils tools to the $PATH
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
# export PATH="$PATH:$HOME/.composer/vendor/bin:$HOME/.composer/vendor/bin/drush"
# export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$(composer config -g home)/vendor/bin:$PATH"
export PATH="$PATH:/usr/local/opt"
export PATH="$HOME:$PATH"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="$HOME/vimrc:$PATH"

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
. $HOME/z.sh
export PATH="/usr/local/opt/nss/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

# ads autocomplete setup
ADS_AC_ZSH_SETUP_PATH=$HOME/Library/Caches/ads-cli/autocomplete/zsh_setup && test -f $ADS_AC_ZSH_SETUP_PATH && source $ADS_AC_ZSH_SETUP_PATH;function blt() {
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
# source $HOME/.git-prompt.sh
# export PATH="$PATH:/Applications/DevDesktop/tools"
# export PATH="$PATH:/Applications/DevDesktop/drush_9"

source $HOME/dotfiles/homedir/.zprofile

