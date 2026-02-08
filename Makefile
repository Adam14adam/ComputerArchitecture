SIM = icarus
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(PWD)/src/controller.sv
TOPLEVEL = controller
MODULE = test_controller

include $(shell cocotb-config --makefiles)/Makefile.sim
