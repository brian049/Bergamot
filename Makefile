BUILD_DIR = ./build
GEN_DIR= $(BUILD_DIR)/gen
SIM_DIR= $(BUILD_DIR)/sim

PRJ = bergamot
SVFILE = BergamotCore
RTLEXPORTER = $(PRJ).exporter.CoreExporter
SIMEXPORTER = $(PRJ).exporter.CoreExporterSim

test:
	mill -i $(PRJ).test

prepare:
	@mkdir -p $(GEN_DIR) $(SIM_DIR)

verilog: prepare
	$(call git_commit, "generate verilog")
	mkdir -p $(BUILD_DIR)
	mill -i $(PRJ).runMain $(RTLEXPORTER) --target-dir $(GEN_DIR)

verilogsim: prepare
	$(call git_commit, "generate verilog")
	mkdir -p $(BUILD_DIR)
	mill -i $(PRJ).runMain $(SIMEXPORTER) --target-dir $(SIM_DIR)

help:
	mill -i $(PRJ).runMain $(EXPORTER) --help

clean:
	@rm -rf out 
	@rm -rf $(GEN_DIR)/*
	@rm -f $(SYN_DIR)/*
	@echo "Done !"

.PHONY: test help clean prepare verilog

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	mill demo.test

-include ../Makefile
