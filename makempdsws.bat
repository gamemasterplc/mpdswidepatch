ndstool -x mpds.nds -9 arm9.bin -7 arm7.bin -y9 y9.bin -y7 y7.bin -d data -y overlay -t banner.bin -h header.bin
blz -d .\overlay\overlay*.bin
makearm9 -x arm9.bin arm9_decompressed.bin arm9_header.bin
blz -d arm9_decompressed.bin
xcopy "custom_files" "data\data" /S /E /Y
armips mpdsws.asm
blz -eo arm9_decompressed.bin
armips build_arm9.asm
blz -eo .\overlay\overlay*.bin
pushd %CD%
copy fixy9.exe .\overlay\
copy y9.bin .\overlay\
cd .\overlay
SET "i=0"
:fixy9loop
set "Value=000%i%
fixy9.exe y9.bin "overlay_%Value:~-4%.bin"
set /A i+=1
if not %i% == 108 goto fixy9loop
popd
copy .\overlay\y9.bin y9.bin
ndstool -c "Mario Party DS Widescreen.nds" -9 arm9.bin -7 arm7.bin -y9 y9.bin -y7 y7.bin -d data -y overlay -t banner.bin -h header.bin
rmdir /s /q overlay
rmdir /s /q data
del *.bin
exit