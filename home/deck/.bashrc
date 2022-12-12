#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/deck/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/deck/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/deck/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/deck/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/deck/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/deck/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

. /home/deck/.bash_aliases

[ -z "$XAUTHORITY" ] && export XAUTHORITY=$(cat /proc/$(cat /home/deck/.steampid)/environ | xargs --null --max-args=1 echo | grep XAUTHORITY | tail -c+12)
