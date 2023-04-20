VENV=`realpath -m @(CMAKE_INSTALL_PREFIX)/../venv`

if [ ! -d "$VENV" ]; then
  virtualenv --system-site-packages "$VENV" >/dev/null
  . $VENV/bin/activate
  pip install empy rospkg >/dev/null
  rospack plugins --attrib=requirements load_venv | cut -d' ' -f2- | xargs -I% pip install -r "%" >/dev/null
else
  . $VENV/bin/activate
fi
