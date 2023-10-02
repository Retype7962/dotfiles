#! /bin/bash

if [ ! "`pwd`" == "$HOME/Git/dotfiles" ]; then
    echo "You must be in the root of dotfiles" && exit 1
fi

git_dir="$HOME/Git/dotfiles/"

function link_files 
{
    [ -z "${1}" ] && echo 'link_files : $1 argument is 0 length' && exit 1
    mkdir -p "${1}"
    for file in `ls "$dir"`
    do
        ln -sf "$git_dir$dir$file" "${1}${file}"
    done
}

function find_librewolf_dir
{
    if [ ! -z "`ls -d $HOME/.librewolf/*.default-default/ 2>/dev/null`" ]
    then
        echo "Librewolf config in default Linux directory" >&2
        echo "`ls -d $HOME/.librewolf/*.default-default/`"
    elif [ ! -z "`ls -d $HOME/Library/Application\ Support/librewolf/Profiles/*.default-default/ 2>/dev/null`" ]
    then
        echo "Librewolf config in default MacOS directory" >&2
        echo "`ls -d $HOME/Library/Application\ Support/librewolf/Profiles/*.default-default/`"
    else
        echo "Librewolf config not found, this will not succeed" >&2
    fi
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
            link_files "`find_librewolf_dir`"
            mkdir -p "$HOME/.librewolf"
            ln -sf "$git_dir${dir}override/librewolf.overrides.cfg" "$HOME/.librewolf/librewolf.overrides.cfg"
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
