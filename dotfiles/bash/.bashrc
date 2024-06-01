#!/bin/bash
iatest=$(expr index "$-" i)

#####################################
#                                   #
#   Sourcing System Configuration   #
#                                   #
#####################################

# Sourcing system bashrc file
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# enabling bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion

elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

######################################
#                                    #
#  Modifying Bash Interactive Shell  #
#                                    #
######################################

# disabling the bell sound
if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi

# completion settings
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

shopt -s checkwinsize
shopt -s histappend

######################################
#                                    #
#               Exports              #
#                                    #
######################################
export HISTCONTROL=erasedups:ignoredups:ignorespace
export HISTFILESIZE=10000
export HISTSIZE=500

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;37;41:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.m4a=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.oga=01;36:*.opus=01;36:*.spx=01;36:*.xspf=01;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:"

######################################
#                                    #
#         Important Aliases          #
#                                    #
######################################
alias cp='cp -i'
alias mv='mv -i'
alias cls='clear'
alias rm='trash'
alias py='python3 -qB'
alias mkdir='mkdir -p'
alias ls='ls -ah --group-directories-first --color=always'

######################################
#                                    #
#           Useful Aliases           #
#                                    #
######################################
alias mktar='tar -cvf'
alias untar='tar -xvf'
alias mkgz='tar -cvzf'
alias ungz='tar -xvzf'
alias mount-info='df -hT'
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

######################################
#                                    #
#          Directory Aliases         #
#                                    #
######################################
alias env="cd $HOME/environment/"
alias dot="cd $HOME/environment/dotfiles/"
alias dev="cd $HOME/environment/programming/"
alias ppo="cd $HOME/environment/programming/python/"
alias jpo="cd $HOME/environment/programming/javascript/"
alias spo="cd $HOME/environment/programming/scratch/"

######################################
#                                    #
#          Useful Functions          #
#                                    #
######################################
extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
      *.tar.xz) tar xvJf $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*) echo "unknown archive file '$archive'" ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

######################################
#                                    #
#       Terminal Prompt and TTY      #
#                                    #
######################################

# only enable starship if the current session is not in a tty
if [[ $(tty | grep ".*/pts/.*") ]]; then
  eval "$(starship init bash)"

else
  # if the current session is in a tty then apply the catppuccin theme
  printf %b '\e]P0303446'
  printf %b '\e]P8626880'
  printf %b '\e]P7C6D0F5'
  printf %b '\e]PFA5ADCE'
  printf %b '\e]P1E78284'
  printf %b '\e]P9E78284'
  printf %b '\e]P2A6D189'
  printf %b '\e]PAA6D189'
  printf %b '\e]P3E5C890'
  printf %b '\e]PBE5C890'
  printf %b '\e]P48CAAEE'
  printf %b '\e]PC8CAAEE'
  printf %b '\e]P5F4B8E4'
  printf %b '\e]PDF4B8E4'
  printf %b '\e]P681C8BE'
  printf %b '\e]PE81C8BE'
  clear 
fi

export PATH
