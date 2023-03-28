load_venv
---------

A helper package to setup and load a virtualenv called "venv" next to the install directory in the workspace.

Any package that wants to rely on the virtualenv must depend on this package to ensure the correct python environment is used to build the workspace:

```
  <depend>load_venv</depend>
```

Additionally, it might include the following lines in its package.xml to automatically add packages from a `requirements.txt` to the virtualenv when it is first generated:

```
  <export>
    <load_venv requirements="${prefix}/requirements.txt" />
  </export>
```
