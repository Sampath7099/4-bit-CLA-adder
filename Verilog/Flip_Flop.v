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
