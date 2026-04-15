BUILD_DIR = ./build
GEN_DIR= $(BUILD_DIR)/gen
SIM_DIR= $(BUILD_DIR)/sim

PRJ = bergamot
RTLEXPORTER = $(PRJ).exporter.CoreExporter
SIMEXPORTER = $(PRJ).exporter.CoreExporterSim

test:
	mill $(PRJ).test

prepare:
	@mkdir -p $(BUILD_DIR) $(GEN_DIR) $(SIM_DIR)

verilog: prepare
	mill $(PRJ).runMain $(RTLEXPORTER) --target-dir $(GEN_DIR)

verilogsim: prepare
	mill $(PRJ).runMain $(SIMEXPORTER) --target-dir $(SIM_DIR)

help:
	mill $(PRJ).runMain $(RTLEXPORTER) --help

clean:
	@rm -rf out
	@rm -rf $(BUILD_DIR)
	@echo "Done !"

.PHONY: test help clean prepare verilog verilogsim
