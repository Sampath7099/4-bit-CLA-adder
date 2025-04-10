module adder (
    input [3:0] A,        // 4-bit input A
    input [3:0] B,        // 4-bit input B
    output [3:0] Sum,
    output Cout           // Carry out
);

    wire [3:0] G, P, K;      // Generate and propagate signals
    wire [4:0] C;         // Carry signals (5 bits to include final carry out)

    assign C[0] = 1'b0;   // Initial carry-in is 0

    // Generate (G) and Propagate (P) signals
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

    // Final Carry Out
    assign Cout = C[4];

endmodule
