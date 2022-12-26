PKG_DIR=$(CURDIR)/install

all: build strip

build:
	./configure --prefix=$(PKG_DIR) --with-arch=rv32imcxgap9 --with-cmodel=medlow --enable-multilib
	$(MAKE) all install
	cp riscv.ld $(PKG_DIR)/riscv32-unknown-elf/lib

strip: build
	-find $(PKG_DIR)/libexec | xargs strip
	-find $(PKG_DIR)/bin | xargs strip

package_ubuntu: build
	cp -r $(CURDIR)/install $(CURDIR)/gap-gnu-toolchain-ubuntu
	cd $(CURDIR)
	tar cvaf gap-gnu-toolchain-ubuntu.tar.gz gap-gnu-toolchain-ubuntu
	-find $(PKG_DIR)/libexec | xargs strip
	-find $(PKG_DIR)/bin | xargs strip
	cp -r $(CURDIR)/install $(CURDIR)/gap-gnu-toolchain-ubuntu-stripped
	cd $(CURDIR)
	tar cvaf gap-gnu-toolchain-ubuntu-stripped.tar.gz gap-gnu-toolchain-ubuntu-stripped

checkout:
	git submodule update --init
