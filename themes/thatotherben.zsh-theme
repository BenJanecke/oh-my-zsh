# THOB - created from Steve Eley's cat waxing.
# Initially hacked from the Dallas theme. Thanks, Dallas Reedy.
#
# This theme assumes you do most of your oh-my-zsh'ed "colorful" work at a single machine,
# and eschews the standard space-consuming user and hostname info.  Instead, only the
# things that vary in my own workflow are shown:
#
# * The time (not the date)
# * The RVM version and gemset (omitting the 'ruby' name if it's MRI)
# * The current directory
# * The Git branch and its 'dirty' state
#
# Colors are at the top so you can mess with those separately if you like.
# For the most part I stuck with Dallas's.

THOB_BRACKET_COLOR="%{$fg[white]%}"
THOB_TIME_COLOR="%{$fg[yellow]%}"
THOB_RVM_COLOR="%{$fg[magenta]%}"
THOB_DIR_COLOR="%{$fg[cyan]%}"
THOB_GIT_BRANCH_COLOR="%{$fg[green]%}"
THOB_GIT_CLEAN_COLOR="%{$fg[green]%}"
THOB_GIT_DIRTY_COLOR="%{$fg[red]%}"

# These Git variables are used by the oh-my-zsh git_prompt_info helper:
ZSH_THEME_GIT_PROMPT_PREFIX="$THOB_BRACKET_COLOR:$THOB_GIT_BRANCH_COLOR"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $THOB_GIT_CLEAN_COLOR✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" $THOB_GIT_DIRTY_COLOR✗"

# Our elements:
if [ -e ~/.rvm/bin/rvm-prompt ]; then
  THOB_RVM_="$THOB_BRACKET_COLOR"["$THOB_RVM_COLOR\${\$(~/.rvm/bin/rvm-prompt i v g)#ruby-}$THOB_BRACKET_COLOR"]"%{$reset_color%}"
else
  if which rbenv &> /dev/null; then
    THOB_RVM_="$THOB_BRACKET_COLOR"["$THOB_RVM_COLOR\${\$(rbenv version | sed -e 's/ (set.*$//' -e 's/^ruby-//')}$THOB_BRACKET_COLOR"]"%{$reset_color%}"
  fi
fi
THOB_DIR_="$THOB_DIR_COLOR%~\$(git_prompt_info) "
THOB_PROMPT="$THOB_BRACKET_COLOR$ "

virtualenv_path="$VIRTUAL_ENV"
if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
  THOB_VENV_="(`basename $virtualenv_path`)"
fi

user=`whoami`
if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
  THOB_CONTEXT_="$user@%m"
fi


# Put it all together!
PROMPT="$THOB_VENV_$THOB_CONTEXT_$THOB_RVM_$THOB_DIR_$THOB_PROMPT%{$reset_color%}"
