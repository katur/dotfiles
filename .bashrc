# Colors ----------------------------------------------------------------
# Define colors to use later
export COLOR_NULL='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'

# List above colors
alias listcolors="set | egrep 'COLOR_\w*'"

# Enable command line colors (BSD and OS X)
export CLICOLOR=1

# Define colors for ls (BSD and OS X). Tool to modify: geoff.greer.fm/lscolors/
export LSCOLORS='gxfxcxdxbxegedabagacad'

# Define colors for ls (Linux). Tool to modify: geoff.greer.fm/lscolors/
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'


# Prompt -----------------------------------------------------------------
export PS1="\[${COLOR_GREEN}\]\u@\h:\w\$ > \[${COLOR_NULL}\]"
