GCC=/bin/bash
GCMD=./run.sh

run:
	make make_init
	$(GCC) $(GCMD)

install:
	make make_init
	$(GCC) ./install.sh

check:
	make make_init
	$(GCC) ./run.sh

fetch:
	make make_init
	$(GCC) ./fetch.sh

update:
	make make_init
	$(GCC) ./fetch.sh

remove:
	make make_init
	$(GCC) ./uninstall.sh

whitelist:
	make make_init
	$(GCC) ./whitelist.sh

clean:
	make make_init
	$(GCC) ./clean.sh

download:
	make make_init
	$(GCC) ./download.sh

make_init:
	chmod +x ./*.sh
