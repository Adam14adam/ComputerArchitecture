import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

@cocotb.test()
async def test_add_instruction(dut):
    """Test ADD instruction: opcode=0000, rd=0001, rs1=0010, rs2=0011"""
    
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Reset
    dut.reset.value = 1
    dut.instruction.value = 0x0123  # ADD r1, r2, r3
    await ClockCycles(dut.clk, 2)
    dut.reset.value = 0
    
    # FETCH state - should load instruction and increment PC
    await RisingEdge(dut.clk)
    assert dut.if_load.value == 1, "FETCH: if_load should be 1"
    assert dut.pc_up.value == 1, "FETCH: pc_up should be 1"
    assert dut.rf_w_en.value == 0, "FETCH: rf_w_en should be 0"
    
    # EXECUTE state - should enable ALU and register file
    await RisingEdge(dut.clk)
    assert dut.alu_sel.value == 0, "EXECUTE: alu_sel should be 000 (ADD)"
    assert dut.rf_out1_en.value == 1, "EXECUTE: rf_out1_en should be 1"
    assert dut.rf_out2_en.value == 1, "EXECUTE: rf_out2_en should be 1"
    assert dut.rf_w_en.value == 1, "EXECUTE: rf_w_en should be 1"
    assert dut.if_load.value == 0, "EXECUTE: if_load should be 0"
    
    cocotb.log.info("ADD instruction test passed!")
