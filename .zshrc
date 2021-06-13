# ##########################################################################
# EXPORT
# ##########################################################################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
#
# Use neo-vim as default text editor
#export EDITOR='nvim'
#
# Add GO to path
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
#
# Set name of the theme to load
#ZSH_THEME="awesomepanda"
ZSH_THEME="robbyrussell"
#
# Disable auto title window
DISABLE_AUTO_TITLE="true"
#
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# ##########################################################################
# ALIAS
# ##########################################################################

alias b='buku --suggest'
alias df='df -h'
#alias dus='du -hs'
#alias l='ls -CF'
#alias la='ls -a'
#alias ll='ls -l'
#alias ls='ls -h'
#alias vim='nvim'
alias vi=vim

# ##########################################################################
# FUNCTIONS
# ##########################################################################

# colors, a lot of colors!
function clicolors() {
    i=1
    for color in {000..255}; do;
        c=$c"$FG[$color]$color✔$reset_color  ";
        if [ `expr $i % 8` -eq 0 ]; then
            c=$c"\n"
        fi
        i=`expr $i + 1`
    done;
    echo $c | sed 's/%//g' | sed 's/{//g' | sed 's/}//g' | sed '$s/..$//';
    c=''
}

# Open a remote session specially useful for windows servers
function roco() {
  mkdir -p /tmp/windows_share
  host $1 | grep 10.201 >& /dev/null
  if [[ $? -eq 0 ]]; then
    echo "dmz" > /dev/stderr
    pass=$(ssh -o StrictHostKeyChecking=no monitorizacion@lep1maa1 sudo docker exec awx_task "/opt/CARKaim/sdk/clipasswordsdk GetPassword -p AppDescs.AppID=app_lep1maa1 -p Query=\"Safe=WindowsServerLocalAdminDMZ;Folder=Root;Object=$1-ROCO\" -o Password" | tr -d '\n')
  else
    pass=$(ssh -o StrictHostKeyChecking=no monitorizacion@lep1maa1 sudo docker exec awx_task "/opt/CARKaim/sdk/clipasswordsdk GetPassword -p AppDescs.AppID=app_lep1maa1 -p Query=\"Safe=WindowsServerLocalAdminLAN;Folder=Root;Object=$1-ROCO\" -o Password" | tr -d '\n')
  fi
  echo "${pass}"
  xfreerdp /v:$1 /u:roco /p:"${pass}" /drive:tmp,/tmp/windows_share
  
}

function connect () {
  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -J lep1maa1 cyberark@$1
}

############################################################################
# Go Enviromental Variables
# ##########################################################################

export GO111MODULE=on

############################################################################
# Rust Enviromental Variables
############################################################################
#

#export ~/.local/bin/rust-analyzer

# Always work in a tmux session if tmux is installed
#if which tmux 2>&1 >/dev/null; then
#  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
#    tmux attach -t hack || tmux new -s mgnt; exit
#  fi
#fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
