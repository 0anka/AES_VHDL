GHDL = ghdl
STD = --std=02
IEEE = --ieee=synopsys
PKGDIR = pkg
CFG = CFG_AES_128
TIME= 500ns
all: run

analyze:
	cd pkg && $(GHDL) -a $(STD) Byte_sequences.vhd
	cd pkg && $(GHDL) -a $(STD) Subyte.vhd
	cd pkg && $(GHDL) -a $(STD) gf_mul.vhd
	cd pkg && $(GHDL) -a $(STD) keyexpansion.vhd
	cd pkg && $(GHDL) -a $(STD) mixcolumns.vhd
	cd pkg && $(GHDL) -a $(STD) shiftrows.vhd
	cd pkg && $(GHDL) -a $(STD) Add_roundkey.vhd

aes: analyze
	$(GHDL) -a $(STD) --workdir=$(PKGDIR) src/AES.vhd

tb: aes
	$(GHDL) -a $(STD) $(IEEE) --workdir=$(PKGDIR) testbench/test.vhd

run: tb
	$(GHDL) -r $(STD) $(IEEE) --workdir=$(PKGDIR) $(CFG) --stop-time=$(TIME)

wave: tb
	$(GHDL) -r $(STD) $(IEEE) --workdir=$(PKGDIR) $(CFG) --wave=wave.ghw --stop-time=$(TIME)

clean:
	rm -f $(PKGDIR)/*.cf
	rm -f $(PKGDIR)/*.o
	rm -f wave.ghw

