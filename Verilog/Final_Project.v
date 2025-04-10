module final (
    input [3:0] A,        
    input [3:0] B,        
    input clk,            
    output S0, S1, S2, S3,
    output Cout           
);
    wire [3:0] A1;
    wire [3:0] B1;
    wire [3:0] S;
    wire C_out;

    dff F1 (A[0], clk, A1[0], A1_not);
    dff F2 (A[1], clk, A1[1], A2_not);
    dff F3 (A[2], clk, A1[2], A3_not);
    dff F4 (A[3], clk, A1[3], A4_not);
    
    dff F5 (B[0], clk, B1[0], B1_not);
    dff F6 (B[1], clk, B1[1], B2_not);
    dff F7 (B[2], clk, B1[2], B3_not);
    dff F8 (B[3], clk, B1[3], B4_not);
    
    adder Add (A1, B1, S, C_out);

    dff F9  (S[0], clk, S0, Sum0_not);
    dff F10 (S[1], clk, S1, Sum1_not);
    dff F11 (S[2], clk, S2, Sum2_not);
    dff F12 (S[3], clk, S3, Sum3_not);
    
    dff F13 (C_out, clk, Cout, Cout_not);
    
endmodule



module adder (
    input [3:0] A,        // 4-bit input A
    input [3:0] B,        // 4-bit input B
    output [3:0] Sum,
    output Cout           // Carry out
);

    wire [3:0] G, P, K;      
    wire [4:0] C;         
    assign C[0] = 1'b0;   
    nand G0 (G[0], A[0], B[0]);
    nand G1 (G[1], A[1], B[1]);
    nand G2 (G[2], A[2], B[2]);
    nand G3 (G[3], A[3], B[3]);

    nor K0 (K[0], A[0], B[0]);
    nor K1 (K[1], A[1], B[1]);
    nor K2 (K[2], A[2], B[2]);
    nor K3 (K[3], A[3], B[3]);

    xor P0 (P[0], A[0], B[0]);
    xor P1 (P[1], A[1], B[1]);
    xor P2 (P[2], A[2], B[2]);
    xor P3 (P[3], A[3], B[3]);

    assign C[1] = ~(G[0]); 
    assign C[2] = ~(G[1] & (G[0] | K[1]));
    assign C[3] = ~(G[2] & (G[1] | K[2]) & (G[0] | K[1] | K[2]));
    assign C[4] = ~(G[3] & (G[2] | K[3]) & ((G[1] & (K[1] | G[0]) )| K[3] | K[2]));
    
        

    xor S0 (Sum[0], P[0], C[0]);
    xor S1 (Sum[1], P[1], C[1]);
    xor S2 (Sum[2], P[2], C[2]);
    xor S3 (Sum[3], P[3], C[3]);
    assign Cout = C[4];

endmodule






module dff (input D, clk, output Q, Q_not );

    wire A1;        
    wire A2; 
    wire clk_not;

    not I2 (clk_not,clk);     

    latch L1 (D,clk_not,A1,A2);
    latch L2 (A1,clk,Q,Q_not);

endmodule

module latch (input D, clk, output Q, Q_not );

    wire D_not;        
    wire S, R;      
    not I1 (D_not,D);
    nand N1 (S, D, clk);
    nand N2 (R, D_not, clk);

    nand N3 (Q, S, Q_not);
    nand N4 (Q_not, R, Q);

endmodule
