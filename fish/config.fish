# fish global
set -U fish_greeting ""

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init - | source
pyenv virtualenv-init - | source

# zoxide
zoxide init fish | source

# fzf
fzf --fish | source
set fzf_preview_dir_cmd eza --all --color=always

# oh my posh
oh-my-posh init fish --config ~/.config/oh-my-posh/everforest.omp.json | source 

# PATH var
fish_add_path $HOME/.local/bin/

if status is-interactive
   alias ls "eza"
   alias ll "eza -l" 
   alias lla "ll -a"
   alias cd "z"
end
