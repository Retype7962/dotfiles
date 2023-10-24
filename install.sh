#! /bin/bash

git_dir="$HOME/Git/dotfiles/"

if [ ! "`pwd`/" == "$git_dir" ]
then
    echo "You must be in the root folder of the dotfiles repository" && exit 1
fi

function link_files 
{
    [ -z "${1}" ] && echo 'link_files : $1 argument is 0 length' && exit 1
    mkdir -p "${1}"
    for file in `ls "$dir"`
    do
        #echo "linking $git_dir$dir$file to ${1}${file}"
        ln -sf "$git_dir$dir$file" "${1}${file}"
    done
}

for dir in `ls -d */`
do    
    case "$dir" in
	    git/)
	        ;;

        kitty/)
            link_files "$HOME/.config/kitty/"
            echo "successfuly linked ${dir%/}"
            ;;

        librewolf/)
            link_files "$HOME/.librewolf/"
            echo "successfuly linked ${dir%/}"
            ;;
        
        nvim/)
            link_files "$HOME/.config/nvim/" 
            echo "successfuly linked ${dir%/}"
            ;;

        zsh/)
            link_files "$HOME/."
            echo "successfuly linked ${dir%/}"
            ;;

        *)
            echo "Something went wrong in the switch case"
            exit 1
            ;;

        esac
done
