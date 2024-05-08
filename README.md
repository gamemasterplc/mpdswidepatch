Mario Party DS Widescreen Patch
===============
This patch implements widescreen for Mario Party DS with help from a custom MelonDS Build.

Custom MelonDS Build
-------------
[Windows Build](https://www.dropbox.com/scl/fi/rj8aky1sbzgfyija50jdm/melondsws.zip?rlkey=yp05jho8f64whk4br495gdt60&dl=1)

[Source Code](https://github.com/gamemasterplc/melonds/)

Build Requirements
-------------
Building these sources requires:

* An installation of Windows 10 or Windows 11.
* Mario Party DS ROM

Building the Source
-------------
Place a copy of the Mario Party DS ROM (US version) in the root directory, name it "mpds.nds", and run "makempdsws.bat" to build.

Running
-------------
The output of building will be named "mpdsws.nds" and will be significantly smaller than the input ROM. It can be run directly with the custom MelonDS build. DS Download Play is compatible with a DS firmware modified to bypass signature checks running on other consoles.
