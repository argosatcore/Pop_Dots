#░█▀▄░█▀█░█▀▀░█░█░░░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
#░█▀▄░█▀█░▀▀█░█▀█░░░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█
#░▀▀░░▀░▀░▀▀▀░▀░▀░░░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀


# ------Make a new directory and cd into it immediately:
	mkcd() {
		mkdir "$1"
		cd "$1"
	}


# ------Create quick notes on random topics:
 	jot() {
 		touch ~/Desktop/Notes/"$1"
		nvim ~/Desktop/Notes/"$1"
 	}


# ------Browse and open notes quickly:
	fjot() {
		cd ~/Desktop/Notes/
		note="$(fdfind -t f -H | fzf --reverse --preview="head -$LINES {}" --bind="space:toggle-preview" --preview-window=wrap:hidden)"
			if [ -n "$note" ]; then	
			nvim "$note"
			fi
		cd
	}


# ------Use fzf as a file opener:
	fo() {
		file="$(fdfind -t f -H | fzf --reverse --preview="head -$LINES {}" --bind="space:toggle-preview" --preview-window=wrap:hidden)"
		if [ -n "$file" ]; then
			mimetype="$(xdg-mime query filetype $file)"
			default="$(xdg-mime query default $mimetype)"
		    		if [[ "$default" == "nvim.desktop" ]]; then
		        		nvim "$file"
		    		else
		        		&>/dev/null xdg-open "$file" & disown; exit
		    		fi
		fi
	}


# ------Use fzf to move between directories:
	fd() {
		cd "$(fdfind -t d -H | fzf --cycle --reverse --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=wrap:hidden)" && clear
	}


# ------Give Apt fuzzy-like package management abilities:
	debcrawler() {
		sudo apt update && sudo apt install $(apt-cache pkgnames | fzf --multi --cycle --reverse --preview "apt-cache show {1}" --preview-window=:57%:wrap:hidden --bind=space:toggle-preview)
	}


# -----Fuzzy find packages with Apt:
	lookapt() {
		apt-cache pkgnames | fzf --multi --cycle --reverse --preview "apt-cache show {1}" --preview-window=:99%:wrap:hidden --bind=space:toggle-preview
	}


# ------Clean system:
	debclean() {
		sudo apt clean
		sudo apt autoclean
		sudo apt autoremove --purge 
	}


# ------Wayland's color picker:
	waypick() {
		grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:-
	}


# ------Update Deb_Dots:
	debgit() {
		git add -u
		git commit -m "$1"
		git push -u
	}
