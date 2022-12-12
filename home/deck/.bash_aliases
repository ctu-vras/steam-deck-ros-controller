alias ros="conda activate ros_env"

alias cdd="cd .."
alias cddd="cd ../.."
alias cdddd="cd ../../.."
alias cddddd="cd ../../../.."

alias ll="ls -la"

alias space="du -sh"

alias ctu="ROS_MASTER_URI=http://ctu-robot:11311"
alias husky="ROS_MASTER_URI=http://husky-robot:11311"
alias spot2="ROS_MASTER_URI=http://spot-2:11311"
alias spot3="ROS_MASTER_URI=http://spot-3:11311"

alias grepws="grep --exclude-dir='cmake-build*' --exclude-dir=build --exclude-dir=devel --exclude-dir=.idea --exclude-dir=.git"

function path()
{
	echo "$1" | tr ":" "\n"
}

function vimexec()
{
	touch "$1"
	chmod +x "$1"
	vim "$@"
}

function mkdircd()
{
	mkdir -p "$1"
	cd "$1"
}

function pings()
{
  host="$1"
  text="$host"
  if [[ $# -gt 1 ]]; then
    text="$2"
  fi
  ping "$host" | sed -u "s/^.*seq=\([0-9]\+\) .* time=/$(hostname) => $text seq=\\1 time=/"
}

function remove_matching_paths()
{
  VAR="$1"
  pattern="$2"
  echo ${!VAR} | awk -v RS=: -v ORS=: "/${pattern}/ {next} {print}" | sed 's/:*$//'
}

function clean_ros_from_env()
{
  for VAR in PATH LD_LIBRARY_PATH CMAKE_PREFIX_PATH PYTHONPATH ROS_PACKAGE_PATH; do
    for pattern in "\/opt\/ros\/" "\/media\/data\/subt" "\/media\/data\/ros"; do
      eval ${VAR}="$(remove_matching_paths ${VAR} "${pattern}")"
    done
    # remove duplicate entries
    eval ${VAR}="$(printf %s "${!VAR}" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')"
    export ${VAR}
  done
}

