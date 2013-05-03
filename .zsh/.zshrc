## Viライクキーバインド設定
bindkey -v

## PROMPT
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
# 右プロンプトに入力がきたら消す(コピペしやすいようにコマンド実行後は右プロンプトを消す)
setopt transient_rprompt

## Completion configuration
autoload -U compinit
compinit

## check
# コマンドのスペルチェックをする
#setopt correct
# コマンドライン全てのスペルチェックをする
#setopt correct_all

## Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# 重複を記録しない
setopt hist_ignore_all_dups
# 共有複数プロセスで history を共有
# setopt share_history
# 余分なスペースを削除して記録する
setopt hist_reduce_blanks
# history コマンドを記録しない
setopt hist_no_store
# インクリメンタルに追加
setopt inc_append_history

## color
autoload colors
colors

case ${UID} in
0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*)
    #
    # Color
    #
    DEFAULT=$'%{\e[1;0m%}'
    RESET="%{${reset_color}%}"
    GREEN="%{${fg[green]}%}"
    BLUE="%{${fg[blue]}%}"
    RED="%{${fg[red]}%}"
    CYAN="%{${fg[cyan]}%}"
    WHITE="%{${fg[white]}%}"

    #
    # Prompt
    #
    PROMPT='%{$fg_bold[blue]%}${USER}@%m ${RESET}${WHITE}$ ${RESET}'
    RPROMPT='${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)% ${WHITE}]${RESET}'

    #
    # Vi入力モードでPROMPTの色を変える
    # http://memo.officebrook.net/20090226.html
    function zle-line-init zle-keymap-select {
        case $KEYMAP in
            vicmd)
                PROMPT="%{$fg_bold[cyan]%}${USER}@%m ${RESET}${WHITE}$ ${RESET}"
                ;;
            main|viins)
                PROMPT="%{$fg_bold[blue]%}${USER}@%m ${RESET}${WHITE}$ ${RESET}"
                ;;
        esac
        zle reset-prompt
    }
    zle -N zle-line-init
    zle -N zle-keymap-select

    # Show git branch when you are in git repository
    # http://d.hatena.ne.jp/mollifier/20100906/p1

    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git svn hg bzr
    zstyle ':vcs_info:*' formats '(%s)-[%b]'
    zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
    zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
    zstyle ':vcs_info:bzr:*' use-simple true

    autoload -Uz is-at-least
    if is-at-least 4.3.10; then
        # この check-for-changes が今回の設定するところ
        zstyle ':vcs_info:git:*' check-for-changes true
        zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
        zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
        zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
        zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
    fi

    function _update_vcs_info_msg() {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        psvar[2]=$(_git_not_pushed)
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
    add-zsh-hook precmd _update_vcs_info_msg

    # show status of git pushed to HEAD in prompt
    function _git_not_pushed()
    {
        if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
            head="$(git rev-parse HEAD)"
            for x in $(git rev-parse --remotes)
            do
                if [ "$head" = "$x" ]; then
                    return 0
                fi
            done
            echo "|?"
        fi
        return 0
    }

    # display Ruby version
    # function rbenv_version() {
    #     echo -n "${$(rbenv version)%% *}"
    # }
    # RPROMPT='[$(rbenv_version)]'

    # Show branch name in Zsh's right prompt
    # https://gist.github.com/3136632
    autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

    setopt prompt_subst

    function rprompt-git-current-branch {
        local name st color gitdir action
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
            return
        fi
        name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
        if [[ -z $name ]]; then
            return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
            color=%F{green}
        elif [[ -n `echo "$st" | grep "^no changes added"` ]]; then
            color=%F{yellow}
        elif [[ -n `echo "$st" | grep "^# Changes to be committed"` ]]; then
            color=%B%F{red}
        else
            color=%F{red}
        fi

        echo "$color$name$action%f%b "
    }
    RPROMPT='[`rprompt-git-current-branch`%~]'

    ;;
esac

## cd -[tab] を押すと過去に移動したディレクトリ一覧を表示
setopt auto_pushd

## 補完候補リストを詰めて表示
setopt list_packed

## 補完一覧でファイル種別表示
setopt list_types

## 補完候補が複数ある時に、一覧表示する
setopt auto_list

## 色付きで補完する
zstyle ':completion:*' list-colors di=34 fi=0

## 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する(コマンドが省略されていたらcdとみなす)
setopt auto_cd

## ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_ignore_dups

## 上書きリダイレクトの禁止
setopt no_clobber

## = 以降でも補完できるようにする
setopt magic_equal_subst

## カッコの対応などを自動的に補完する
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

## 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

## 最後の / を自動的に削除しない
setopt noautoremoveslash

## beepを鳴らさないようにする
setopt nolistbeep

## sudo も補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

## 補完の時に大文字小文字を区別しない(但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## terminal configuration
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color

    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character

    stty erase
    ;;

cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad

    export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
    zstyle ':completion:*' list-colors \
        'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;

kterm*|xterm*)
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

    zstyle ':completion:*' list-colors \
        'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

fpath=($ZDOTDIR/functions/Completion ${fpath})

setopt complete_aliases # aliased ls needs if file/dir completions work

## alias設定
[ -f $ZDOTDIR/.zshrc.alias ] && source $ZDOTDIR/.zshrc.alias

## 共通設定
[ -f $ZDOTDIR/.zshrc.common ] && source $ZDOTDIR/.zshrc.common

## OS固有設定
case "${OSTYPE}" in
# Mac(Unix)
darwin*)
    # ここに設定
    [ -f $ZDOTDIR/.zshrc.osx ] && source $ZDOTDIR/.zshrc.osx
    ;;
# Linux
linux*)
    # ここに設定
    [ -f $ZDOTDIR/.zshrc.linux ] && source $ZDOTDIR/.zshrc.linux
    ;;
esac
