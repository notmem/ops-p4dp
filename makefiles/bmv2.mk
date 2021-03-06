BMV2_PD_DIR = $(BUILD_DIR)/bmv2_pd/

BMV2_PD_ENV := 'P4_PATH=$(P4_INPUT)' 'P4_PREFIX=$(P4_PREFIX)'

$(BMV2_PD_DIR):
	@echo $(BUILD_DIR)
	@echo $(BMV2_PD_DIR)
	mkdir -p $(BMV2_PD_DIR)

bmv2-pd: $(P4_INPUT) | $(BMV2_PD_DIR)
	@echo $(BUILD_DIR)
	$(MAKE) -C $(SUBMODULE_P4C_BM)/pd_mk/ $(BMV2_PD_ENV) includedir=/bmv2_pd/include libdir=/bmv2_pd/lib datadir=/bmv2_pd/share
	$(MAKE) -C $(SUBMODULE_P4C_BM)/pd_mk/ $(BMV2_PD_ENV) includedir=/bmv2_pd/include libdir=/bmv2_pd/lib datadir=/bmv2_pd/share 'DESTDIR=$(BUILD_DIR)' install

BMV2_PD_INC := $(BUILD_DIR)/bmv2_pd/include/p4_pd/
BMV2_PD_INC += $(BUILD_DIR)/bmv2_pd/include/pdfixed/

BMV2_PD_LIB_DIR := $(BUILD_DIR)/bmv2_pd/lib/

BMV2_EXE := $(TARGET_ROOT)/$(P4_NAME)_bmv2

BMV2_THRIFT_PY_DIR = $(BUILD_DIR)/bmv2_pd/share/gen-py/

$(BMV2_EXE):
	$(MAKE) -C $(SUBMODULE_BM)
	cp -a $(SUBMODULE_BM)/targets/simple_switch/simple_switch $(BMV2_EXE)

BMV2_P4C_MAIN := $(SUBMODULE_P4C_BM)/p4c_bm/__main__.py

BMV2_JSON := $(TARGET_ROOT)/$(P4_NAME)_bmv2.json

$(BMV2_JSON): $(P4_INPUT)
	$(BMV2_P4C_MAIN) --json $@ $<

bmv2 :$(BMV2_EXE) $(BMV2_JSON)

bmv2-clean:
	$(MAKE) -C $(SUBMODULE_BM) clean
	$(MAKE) -C $(SUBMODULE_P4C_BM)/pd_mk/ $(BMV2_PD_ENV) clean
	rm -f $(BMV2_EXE) $(BMV2_JSON)

.PHONY: bmv2-pd bmv2-pd-sane bmv2-clean bmv2 $(BMV2_EXE)
