#!/bin/zsh

echo zsh user configs loaded.

alias dev='cd ~/dev'
alias desktop='cd ~/Desktop'
alias _tools='cd ~/dev/_tools'
alias portfolio='cd ~/dev/PIERREPORTAL/portfolio/client'
alias gs='git status'
alias gpf='git push --force-with-lease'
alias gp1='git push --set-upstream origin master'
# alias ide='tmux split-window -v & tmux split-window -h'
source ~/.zsh_user_config/tmux/ide


export GITHUB_GRAPH_API=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
# NodeJS helpers
#
function node-at-port {
	readonly port=${1:?"You must give a port"}
	lsof -i tcp:"$1" | grep LISTEN | awk '{print $2}'
}

function kill-node-at-port {
	readonly port=${1:?"You must give a port"}
	local node_ps=$(node-at-port $1)
	echo killing ${node_ps}...
	kill -9 ${node_ps}
}

function serve-80 {
	python2 -m SimpleHTTPServer 80
}

function localhost {
	readonly port=${1:?"You must give a port"}
	open http://localhost:$port
}

function tunnelPort {
	readonly port=${1:?"You must give a port"}
	local href=$(lt --port $port)&
	echo $href
	qrencode -s 1 -m 1 -t ANSI -o - "${href}"
}

alias lh='localhost'

source ~/dev/_tools/hostshare/hostshare.sh

