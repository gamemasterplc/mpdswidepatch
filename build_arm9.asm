.nds

.create "arm9.bin", 0x2000000

.org 0x2000000
.incbin "arm9_header.bin"
.incbin "arm9_decompressed.bin"
arm9_compressed_end:

.org 0x2000B7C
.dw arm9_compressed_end

.close