# katherine's bash settings


##########
# Colors #
##########

# Define colors to use later
export COLOR_NULL='\033[0m' # No Color
export COLOR_BLACK='\033[0;30m'
export COLOR_RED='\033[0;31m'
export COLOR_GREEN='\033[0;32m'
export COLOR_YELLOW='\033[0;33m'
export COLOR_BLUE='\033[0;34m'
export COLOR_PINK='\033[0;35m'
export COLOR_CYAN='\033[0;36m'
export COLOR_WHITE='\033[0;37m'

# List these colors
alias listcolors="set | egrep 'COLOR_\w*'"

# Enable command line colors (BSD and OS X)
export CLICOLOR=1

# Define colors for ls on BSD and OS X. Tool to modify: geoff.greer.fm/lscolors/
export LSCOLORS='gxfxcxdxbxegedabagacad'

# Define colors for ls on Linux. Tool to modify: geoff.greer.fm/lscolors/
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

# Color grep matches (NOTE: GREP_OPTIONS soon to be deprecated)
alias grep='grep --color=auto'


##########
# Prompt #
##########

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
export PS1="\[${COLOR_GREEN}\]\u@\h:\w\$(__git_ps1 ' [%s]') > \[${COLOR_NULL}\]"


#################
# Auto complete #
#################

# Use `bind` instead of using a separate ~/.inputrc file. See:
# http://www.gnu.org/software/bash/manual/html_node/Readline-Init-File.html
bind 'set completion-ignore-case on'

# Show ambiguities without ringing bell
bind 'set show-all-if-ambiguous on'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


##################
# Simple aliases #
##################

# To use the brewed vim (vi goes to the system vim, which is older and
# causing a SEGV fault due to something with Syntastic and autocmds)
alias vi='vim'

# Moving up directories
alias ..='cd ..'
alias ...='cd .. ; cd ..'
alias ....='cd .. ; cd .. ; cd ..'

# Prompt before overwrite
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Fancy listing
alias ll='ls -hl'
alias la='ls -a'
alias lla='ls -lah'

# Case insensitive searching
alias g='grep -i'
alias f='find . -iname'


#############
# Fun stuff #
#############

# Most used commands, modified from
# http://lifehacker.com/274317/turbocharge-your-terminal
alias profileme="history | tr -s ' ' | cut -d ' ' -f 3 | sort | uniq -c | sort -nr | head -20"

# Biggest disk usage
alias ducks='du -cks * | sort -rn | head -10'


############################
# Python virtualenvwrapper #
############################

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh


########
# Path #
########

export PATH="~/bin:$PATH"


########
# Java #
########

if which jenv > /dev/null; then eval "$(jenv init -)"; fi


########
# Ruby #
########

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
