export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Load all .zsh files from ~/.zsh directory
if [ -d ~/.zsh ]; then
    for file in ~/.zsh/*.zsh; do
        [ -r "$file" ] && source "$file"
    done
    unset file
fi

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
