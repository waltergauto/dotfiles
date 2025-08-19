# En RedHat base OS crear un custom.sh en /etc/profile.d/

# default bash profile config que da solus
# source /usr/share/defaults/etc/profile

# path al bindings de powerline para bash en solus
#source /usr/lib64/python2.7/site-packages/powerline/bindings/bash/powerline.sh

#alias ll='ls -la'
#alias la='ls -a'
alias tls="tmux list-sessions"
alias ta="tmux attach -t"
alias tks="tmux kill-session -t"
alias la="ls -A"


# get current branch in git repo (si no estoy usando powerline)
#function parse_git_branch() {
#	BRANCH=`git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p"`
#	if [ ! "${BRANCH}" == "" ]
#	then
#		echo " $BRANCH "
#	else
#		echo ""
#	fi
#}


# default prompt si no uso powerline
#PS1='\[\e[01;32m\]\u\[\e[m\]  \[\e[01;34m\]\W\[\e[m\] \[\e[01;32m\]`parse_git_branch`\[\e[01;37m\] '




# configuracion especifica para powerline (packages powerline powerline-fonts)
# Nota:
# 1) hay que configurar el archivo config.json del powerline y especificar
# en la parte de shell > theme: "default_leftonly" para que pueda ver los 
# branches de git
# 2) por defecto powerline muestra 3 directorios padres desde el working directory
# prefiero solo ver mi directory actual y eso se especifica en powerline config folder
# en fedora esta en /etc/xdg/powerline/themes/shell/__main__.py 
# en la opcion dir_limit_depth: 1
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi

export EDITOR=vim


### Support Git
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'


# Función avanzada para mostrar información de Git
git_prompt() {
    local git_status=""
    local branch=""

    # Verificar si estamos en un repositorio Git
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Obtener la rama actual
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

        # Verificar el estado del repositorio
        local status=$(git status --porcelain 2>/dev/null)
        local ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
        local behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)

        # Símbolos para el estado
        local symbols=""
        [[ -n $status ]] && symbols+="*"  # Archivos modificados
        [[ $ahead -gt 0 ]] && symbols+="↑"  # Commits adelante
        [[ $behind -gt 0 ]] && symbols+="↓"  # Commits atrás

        # Colorear según la rama
        if [[ $branch == "master" || $branch == "main" ]]; then
            git_status=" \033[91m$branch$symbols\033[0m "  # Rojo
        elif [[ $branch == "develop" || $branch == "dev" ]]; then
            git_status="\[\033[93m\]($branch$symbols)\[\033[0m\]"  # Amarillo
        else
            git_status="\[\033[92m\]($branch$symbols)\[\033[0m\]"  # Verde
        fi
    fi

    echo -e "$git_status"
}

# PS1 personalizado con información de Git
 61 export PS1='\[\033[48;2;0;95;135m\]\[\033[97m\] \H \[\033[0m\]\[\033[100m\]\[\033[97m\] \u \[\033[0m\] \[\033[96m\]\W\[\033[0m\]$(git_prompt) \[\033[97m\] \[\033[0m\]'                                                                 


