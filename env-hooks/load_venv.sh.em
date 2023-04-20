VENV=`realpath -m @(CMAKE_INSTALL_PREFIX)/../venv`
ALL_REQUIREMENTS="$VENV/load_venv_pkgs.txt"

if [ ! -d "$VENV" ]; then
  virtualenv --system-site-packages "$VENV" >/dev/null
  . $VENV/bin/activate
  # first off, avoid pip warning about outdated pip version
  pip install -U pip >/dev/null
  (
  # basic requirements for a ROS workspace
  cat <<EOF
empy
rospkg
EOF
  # extract all required packages from dependencies
  rospack plugins --attrib=requirements load_venv | cut -d' ' -f2- | xargs cat
  ) | sort -u > "$ALL_REQUIREMENTS"
  pip install -U -r "$ALL_REQUIREMENTS" >/dev/null
else
  . $VENV/bin/activate
fi
