# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./regfile.sv"
vlog "./register.sv"
vlog "./D_FF.sv"
vlog "./decoder.sv"
vlog "./mux64.sv"
vlog "./alu.sv"
vlog "./adderSubtractor.sv"
vlog "./bitslice.sv"
vlog "./testZero.sv"
vlog "./Datapath.sv"
vlog "./math.sv"
vlog "./datamem.sv"
vlog "./instructmem.sv"
vlog "./controlSignal.sv"
vlog "./flagUpdate.sv"
vlog "./pipelineBuffer.sv"
vlog "./forwardingUnit.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work Datapath_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do Datapath_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
