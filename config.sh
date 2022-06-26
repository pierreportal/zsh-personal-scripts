#!/bin/zsh

echo zsh user configs loaded.

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

function share-localhost {
	readonly port=${1:?"You must give a port"}
	if [[ "$(which qrencode)" = "qrencode not found" ]]; then
		echo "You need to install a dependency (qrencode) for hostshare to work. Please run 'brew install qrencode'\nDo you want to install it now? (Y/n)"
		read
		case $REPLY in
			[Yy] ) brew install qrencode;;
			[Nn] ) echo "Quit Hostshare.";;
			* ) echo "Invalid input. please type 'y' for yes or 'n' for no";;
		esac
	else
		echo "true"
	fi

	local ip=$(ifconfig | grep netmask | grep broadcast | awk '{print $2}')
	clear
	echo "\n\n\n
@@@  @@@   @@@@@@    @@@@@@   @@@@@@@   @@@@@@   @@@  @@@   @@@@@@   @@@@@@@   @@@@@@@@
@@@  @@@  @@@@@@@@  @@@@@@@   @@@@@@@  @@@@@@@   @@@  @@@  @@@@@@@@  @@@@@@@@  @@@@@@@@
@@!  @@@  @@!  @@@  !@@         @@!    !@@       @@!  @@@  @@!  @@@  @@!  @@@  @@!     
!@!  @!@  !@!  @!@  !@!         !@!    !@!       !@!  @!@  !@!  @!@  !@!  @!@  !@!     
@!@!@!@!  @!@  !@!  !!@@!!      @!!    !!@@!!    @!@!@!@!  @!@!@!@!  @!@!!@!   @!!!:!  
!!!@!!!!  !@!  !!!   !!@!!!     !!!     !!@!!!   !!!@!!!!  !!!@!!!!  !!@!@!    !!!!!:  
!!:  !!!  !!:  !!!       !:!    !!:         !:!  !!:  !!!  !!:  !!!  !!: :!!   !!:     
:!:  !:!  :!:  !:!      !:!     :!:        !:!   :!:  !:!  :!:  !:!  :!:  !:!  :!:     
::   :::  ::::: ::  :::: ::      ::    :::: ::   ::   :::  ::   :::  ::   :::   :: ::::
 :   : :   : :  :   :: : :       :     :: : :     :   : :   :   : :   :   : :  : :: :: 
 \n\n
----------------------- Serving @ http://$ip:$port 👾 -----------------------
 \n\n"
 	qrencode -s 1 -m 1 -t ANSI -o - "http://${ip}:${port}"
	echo "\n\nThanks for using Hostshare!\n\n"

}

