# Enable zsh profiler #
#######################
# zmodload zsh/zprof

# Path to your oh-my-zsh configuration.
export PATH="/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin:/Users/$USER/bin:/Users/wgallegos/.oh-my-zsh/bin:/Users/wgallegos/go/bin:~/bin/terraform:$PATH"
export ZSH=$HOME/.oh-my-zsh
export TERM="xterm-256color"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="sonicradish"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=15

# Uncomment following line if you want to disable colors in ls
 DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# all of our zsh files
typeset -U config_files
config_files=(~/.zsh.d/**/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
 source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -Uz compinit
compinit -D ~/Users/$USER/.zcompdump

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(battery     \
         git       \
         extract     \
         osx         \
         golang      \
         rbenv       \
         bgnotify    \
         copydir     \
         copybuffer  \
         copyfile    \
         cp          \
         docker      \
         docker-compose \
         # emoji     \
         # github    \
         golang      \
         # jira      \
         jsontools   \
         terraform   \
         branch      \
         kube-ps1    \
         kubectl     \
         # dotenv    \
         aws         
         # zsh-autosuggestions\
         # zsh-syntax-highlighting
)

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

[ -f $ZSH/plugins/kube-ps1/kube-ps1.zsh ] && source $ZSH/plugins/kube-ps1/kube-ps1.zsh

[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# zprof
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export KUBECONFIG=$HOME/.kube/config:$HOME/.kube/config-apptio-clusters
export PATH="${PATH}:${HOME}/.krew/bin"

source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1
alias k="kubectl"
alias kctx="kubectx"
alias kns="kubens"
complete -F __start_kubectl k
HIST_FORMAT="'%Y-%m-%d %T'$(echo -e '\t')"
alias history="fc -t "$HIST_FORMAT" -il 1"

#AWS logins
alias aws-login-engineering='docker run --rm -it -v ~/.aws:/root/.aws docker.apps.papt.to/engineering-tools/aws-azure-login:2.1.0 --profile engineering --no-prompt'
alias aws-login-fcp-prod='docker run --rm -it -v ~/.aws:/root/.aws docker.apps.papt.to/engineering-tools/aws-azure-login:2.1.0 --profile fcp-prod --no-prompt'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
