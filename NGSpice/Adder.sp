.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
.param width_P=3*LAMBDA
.param width_N=3*LAMBDA
.param widthP=4*LAMBDA  
.param widthN=3*LAMBDA



.subckt inv y x vdd gnd

.param width_P={11*LAMBDA}
.param width_N={3*LAMBDA}
M1      y       x       gnd     gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2      y       x       vdd     vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
.ends inv


.subckt multiplexer S S_not X1 X0 Y
.param width_N={6*LAMBDA}
M1      Y       S       X1     gnd  CMOSN   W={width_N}   L={LAMBDA}  
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2      Y       S_not   X0     gnd  CMOSN   W={width_N}   L={LAMBDA}  
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends multiplexer

.subckt adder A1 A2 A3 A4 B1 B2 B3 B4 S1 S2 S3 S4 C4
*----------------------------------------------------------------*
*structure for propogate and generate signals*
x_A1 A_not1 A1 vdd gnd inv
x_A2 A_not2 A2 vdd gnd inv
x_A3 A_not3 A3 vdd gnd inv
x_A4 A_not4 A4 vdd gnd inv

x_B1 B_not1 B1 vdd gnd inv
x_B2 B_not2 B2 vdd gnd inv
x_B3 B_not3 B3 vdd gnd inv
x_B4 B_not4 B4 vdd gnd inv

X_MUX_K2 A2 A_not2 gnd B_not2 K_2 multiplexer 
X_MUX_K3 A3 A_not3 gnd B_not3 K_3 multiplexer 
X_MUX_K4 A4 A_not4 gnd B_not4 K_4 multiplexer 

X_MUX_G1 A1 A_not1 B_not1 vdd G_1 multiplexer 
X_MUX_G2 A2 A_not2 B_not2 vdd G_2 multiplexer 
X_MUX_G3 A3 A_not3 B_not3 vdd G_3 multiplexer 
X_MUX_G4 A4 A_not4 B_not4 vdd G_4 multiplexer 
*-----------------------one singular structure in magic*
X_MUX_P2 A2 A_not2 B_not2 B2 P_2 multiplexer 
X_MUX_P3 A3 A_not3 B_not3 B3 P_3 multiplexer 
X_MUX_P4 A4 A_not4 B_not4 B4 P_4 multiplexer

X_MUX_P_1 A1 A_not1 B1 B_not1 P_not1 multiplexer 
X_MUX_P_2 A2 A_not2 B2 B_not2 P_not_2 multiplexer 
X_MUX_P_3 A3 A_not3 B3 B_not3 P_not_3 multiplexer 
X_MUX_P_4 A4 A_not4 B4 B_not4 P_not_4 multiplexer

x__2 P_not2 P_2 vdd gnd inv
x__3 P_not3 P_3 vdd gnd inv
x__4 P_not4 P_4 vdd gnd inv

x_S_not2 P2 P_not_2 vdd gnd inv
x_S_not3 P3 P_not_3 vdd gnd inv
x_S_not4 P4 P_not_4 vdd gnd inv
*-------------------------*



*----------------------------------------------------------------*
*structure for carry look ahead

*C1 generation 1.35617e-10 *
M1      C1       G_1       gnd     gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M2      C1       G_1       vdd     vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
*C2 generation 1.69429e-10*
M3      C2      G_2      vdd   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M4      node2       K_2     vdd     vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M5      C2       G_1   node2   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}

M6      C2      G_2       node1      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M7      node1   K_2     gnd     gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M8      node1    G_1    gnd      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
*C3 generation 2.40186e-10*
M9      C3      G_3      vdd   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M10      node3   K_3       vdd     vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M11      C3      G_2   node3   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M12     node4   G_1    vdd   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M13     node5   K_2     node4     vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M14      C3     K_3   node5   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}

M15      C3      G_3       node6      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M16      node6   K_3     node7     gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M17      node6    G_2    node7      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M18      node7    G_1    gnd      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M19      node7    K_2     gnd     gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M20      node7    K_3    gnd      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
*-----------------------------------------*
*C4 generation 1.54362e-10*
M21      C4      G_4      vdd   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M22      node8   K_4     vdd     vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M23      C4      G_3   node8   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M24     node9   G_2    vdd   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M25     node10  K_2    vdd     vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M26     node9     G_1   node10   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M27     node11   K_3     node9     vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}
M28      C4     K_4   node11   vdd  CMOSP   W={widthP}   L={2*LAMBDA}
+ AS={5*widthP*LAMBDA} PS={10*LAMBDA+2*widthP} AD={5*widthP*LAMBDA} PD={10*LAMBDA+2*widthP}

M29      C4      G_4       node12   gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M30      node12   K_4     node13     gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M31      node12    G_3    node13      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M32      node13    G_2    node14      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M33      node14    K_2    gnd   gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M34      node14    G_1    gnd      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M35      node13    K_3    gnd   gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN}
M36      node13    K_4    gnd      gnd  CMOSN   W={widthN}   L={2*LAMBDA}
+ AS={5*widthN*LAMBDA} PS={10*LAMBDA+2*widthN} AD={5*widthN*LAMBDA} PD={10*LAMBDA+2*widthN} 
*----------------------------------------------------------------*
*structure for sum block
x_C1 C_not1 C1 vdd gnd inv
x_C2 C_not2 C2 vdd gnd inv
x_C3 C_not3 C3 vdd gnd inv

X_MUX_S_2 P2 P_not2 C_not1 C1 sum2 multiplexer 
X_MUX_S_3 P3 P_not3 C_not2 C2 sum3 multiplexer 
X_MUX_S_4 P4 P_not4 C_not3 C3 sum4 multiplexer

*S1 1.23134e-10
x_S1 S1 P_not1 vdd gnd inv
*S2 2.48059e-10
x_S2 S_2 sum2 vdd gnd inv
x_S_2 S2 s_2 vdd gnd inv
*S3 2.92128e-10
x_S3 S_3 sum3 vdd gnd inv
x_S_3 S3 s_3 vdd gnd inv
*S4 3.61127e-10
x_S4 S_4 sum4 vdd gnd inv
x_S_4 S4 s_4 vdd gnd inv


*----------------------------------------------------------------*
.ends adder

// input bits
//VA1 A_1 gnd pulse 0 1.8 4.98210ns 100ps 100ps 10ns 20ns
//VA2 A_2 gnd 0
//VA3 A_3 gnd 0
//VA4 A_4 gnd pulse 0 1.8 2.5ns 100ps 100ps 10ns 20ns


//VB1 B_1 gnd pulse 0 1.8 2.5ns 100ps 100ps 10ns 20ns
//VB2 B_2 gnd pulse 0 1.8 2.5ns 100ps 100ps 10ns 20ns
//VB3 B_3 gnd pulse 0 1.8 2.5ns 100ps 100ps 10ns 20ns
//VB4 B_4 gnd pulse 0 1.8 2.5ns 100ps 100ps 10ns 20ns

//X_adder A_1 A_2 A_3 A_4 B_1 B_2 B_3 B_4 S_1 S_2 S_3 S_4 C_out adder
//Xinv_1 n1 S_1 vdd gnd min_inverter
//Xinv_2 n2 S_2 vdd gnd min_inverter
//Xinv_3 n3 S_3 vdd gnd min_inverter
//Xinv_4 n4 S_4 vdd gnd min_inverter
//Xinv_5 n5 C_out vdd gnd min_inverter

//.tran 1e-2n 20n 0n
//.measure tran tpd_rise
//+ TRIG v(A1) VAL='SUPPLY/2' RISE=1
//+ TARG v(S4) VAL='SUPPLY/2' RISE=1
//.measure tran tpd_fall
//+ TRIG v(A1) VAL='SUPPLY/2' FALL=1
//+ TARG v(S4) VAL='SUPPLY/2' FALL=1
//.measure tran total_prop_delay param='(tpd_rise+tpd_fall)/2'
//.control
//run
//set hcopypscolor = 1 *White background for saving plots
//set color0=white ** color0 is used to set the background of the plot (manual sec:17.7))
//set color1=black ** color1 is used to set the grid color of the plot (manual sec:17.7))
//set curplottitle= Sampath_2023102033

//plot v(cout) v(S4) v(S3) v(S2) v(S1) v(A1) 




.endc
