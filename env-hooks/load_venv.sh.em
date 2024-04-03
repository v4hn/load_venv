VENV=`realpath -m @(CMAKE_INSTALL_PREFIX)/../venv`
ALL_REQUIREMENTS="$VENV/load_venv_pkgs.txt"
LOG="$VENV/load_venv_install.log"

if [ ! -d "$VENV" ]; then
  virtualenv --system-site-packages "$VENV" >/dev/null
  . $VENV/bin/activate
  # first off, avoid pip warning about outdated pip version
  if ! pip install -U pip >"$LOG" 2>&1; then
    cat "$LOG" >&2
    exit 1
  fi
  (
  # basic requirements for a ROS workspace
  cat <<EOF
empy==3.3.4
rospkg
EOF
  # extract all required packages from dependencies
  # extra echo to handle files without trailing newline
  rospack plugins --attrib=requirements load_venv |
    cut -d' ' -f2- |
    xargs -I% sh -c "cat %; echo"
  ) | sort -u > "$ALL_REQUIREMENTS"
  if ! pip install -U -r "$ALL_REQUIREMENTS" >"$LOG" 2>&1; then
    cat "$LOG" >&2
    echo "load_venv failed to install all pip dependencies. You may modify '$VENV' manually and eventually make sure 'pip install -r $ALL_REQUIREMENTS' succeeds before going on." >&2
    exit 1
  fi
else
  . $VENV/bin/activate
fi
