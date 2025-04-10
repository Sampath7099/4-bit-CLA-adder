.include TSMC_180nm.txt
.include project_dff.sp
.include project_adder.sp
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
.param width_P=3*LAMBDA
.param width_N=3*LAMBDA
.param widthP=4*LAMBDA  
.param widthN=3*LAMBDA
Vdd	vdd	gnd	'SUPPLY'


VA1 A_1 gnd pulse 0 1.8 3ns 10ps 10ps 20ns 40ns
VA2 A_2 gnd 0
VA3 A_3 gnd 0
VA4 A_4 gnd pulse 0 1.8 3ns 10ps 10ps 20ns 40ns


VB1 B_1 gnd pulse 0 1.8 3ns 10ps 10ps 20ns 40ns
VB2 B_2 gnd pulse 0 1.8 3ns 10ps 10ps 20ns 40ns
VB3 B_3 gnd pulse 0 1.8 3ns 10ps 10ps 20ns 40ns
VB4 B_4 gnd pulse 0 1.8 3ns 10ps 10ps 20ns 40ns


Vclk clk gnd pulse 1.8 0 0ns 10ps 10ps 5ns 10ns 

X_ddf_A1 A1 A_1 clk clk_not vdd gnd dff
X_ddf_A2 A2 A_2 clk clk_not vdd gnd dff
X_ddf_A3 A3 A_3 clk clk_not vdd gnd dff
X_ddf_A4 A4 A_4 clk clk_not vdd gnd dff

X_ddf_B1 B1 B_1 clk clk_not vdd gnd dff
X_ddf_B2 B2 B_2 clk clk_not vdd gnd dff
X_ddf_B3 B3 B_3 clk clk_not vdd gnd dff
X_ddf_B4 B4 B_4 clk clk_not vdd gnd dff

Xinv n10 A1 vdd gnd min_inverter

X_adder A1 A2 A3 A4 B1 B2 B3 B4 S_1 S_2 S_3 S_4 C_out adder

X_ddf_S1 S1 S_1 clk clk_not vdd gnd dff
X_ddf_S2 S2 S_2 clk clk_not vdd gnd dff
X_ddf_S3 S3 S_3 clk clk_not vdd gnd dff
X_ddf_S4 S4 S_4 clk clk_not vdd gnd dff
X_ddf_C Cout C_out clk clk_not vdd gnd dff

Xinv_1 n1 S1 vdd gnd min_inverter
Xinv_2 n2 S2 vdd gnd min_inverter
Xinv_3 n3 S3 vdd gnd min_inverter
Xinv_4 n4 S4 vdd gnd min_inverter
Xinv_5 n5 Cout vdd gnd min_inverter









.tran 1e-2n 40n 0n
.measure tran tpd_rise
+ TRIG v(A1) VAL='SUPPLY/2' RISE=1
+ TARG v(S_4) VAL='SUPPLY/2' RISE=1
.measure tran tpd_fall
+ TRIG v(A1) VAL='SUPPLY/2' FALL=1
+ TARG v(S_4) VAL='SUPPLY/2' FALL=1
.measure tran total_prop_delay param='(tpd_rise+tpd_fall)/2'
.control


run
set hcopypscolor = 1 *White background for saving plots
set color0=white ** color0 is used to set the background of the plot (manual sec:17.7))
set color1=black ** color1 is used to set the grid color of the plot (manual sec:17.7))
set curplottitle= Sampath_2023102033


plot v(Cout)+12 v(S4)+10 v(S3)+8 v(S2)+6 v(S1)+4 v(A_1)+2 v(clk)



.endc
