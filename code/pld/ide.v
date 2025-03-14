// Very simple IDE interface
// Malcolm Harrow December 2024
// MIT License

`default_nettype none

module ide (
    input [19:1] A,
    input IOSEL_n,
    input CPUCLK,
    input FC0,
    input FC1,
    input FC2,
    // assume 16 bit access only
    input UDS_n,
    input RW,
    input AS_n,
    // Assume CS1 is always low (active)
    // input CS1,
    // No CS3 connected on board ..
    // input CS3,
    // should really have a signal for AS_n ??
    
    inout DTACK_n,  // has to be inout for tri-state

    // assume 16bit access only
    output IDEBUF_n,
    output IDERD_n,
    output IDEWR_n,
    output VPA,
    output IDECS_n // have to add this here for tri-state to work
);

    
    wire CPU_SPACE = (FC0 && FC1 && FC2);
    
    // Below assumes CS0_n is low (active)
    assign IDECS_n = !(!CPU_SPACE && !IOSEL_n && (A[19:4] == 15'b1000000000000100));
    assign IDERD_n = !(RW && !AS_n && !UDS_n);
    assign IDEWR_n = !(!RW && !AS_n && !UDS_n);
    
    // assume 16bit access only .. this is used as CE_n on the 245 buffer chips
    assign IDEBUF_n = UDS_n;    

    assign VPA = CPU_SPACE && (!A[3] && A[2] && A[1]);

    assign DTACK_n = !IDECS_n ? 1'b0 : 1'bZ;  
   
endmodule

//PIN: CHIP "ide" ASSIGNED TO AN PLCC84
//PIN: RESET_n  : 1
//PIN: LDS      : 3
//PIN: UDS      : 4
//PIN: EXPSEL   : 5
//PIN: IOSEL    : 6
//PIN: VPA      : 8
//PIN: A_23     : 9
//PIN: A_22     : 10
//PIN: A_21     : 11
//PIN: A_20     : 12
//PIN: A_19     : 15
//PIN: A_18     : 16
//PIN: A_17     : 17
//PIN: A_16     : 18
//PIN: A_15     : 20
//PIN: A_14     : 21
//PIN: A_13     : 22
//PIN: A_12     : 24
//PIN: A_11     : 25
//PIN: A_10     : 27
//PIN: A_9      : 28
//PIN: A_8      : 29
//PIN: A_7      : 30
//PIN: A_6      : 31
//PIN: A_5      : 33
//PIN: A_4      : 34
//PIN: A_3      : 35
//PIN: A_2      : 36
//PIN: A_1      : 37
//PIN: MWE_n    : 39
//PIN: RAS1_n   : 40
//PIN: RAS0_n   : 41
//PIN: CAS1_n   : 44
//PIN: CAS3_n   : 45
//PIN: CAS2_n   : 46
//PIN: CAS0_n   : 48
//PIN: MA8      : 49
//PIN: MA9      : 50
//PIN: MA11     : 51
//PIN: MA7      : 52
//PIN: MA10     : 54
//PIN: MA6      : 55
//PIN: MA5      : 56
//PIN: MA4      : 57
//PIN: MA3      : 58
//PIN: MA2      : 60
//PIN: MA1      : 61
//PIN: MA0      : 63
//PIN: IDEWR_n  : 68
//PIN: IDERD_n  : 69
//PIN: RW       : 70
//PIN: IDEBUF   : 73
//PIN: CS0      : 74
//PIN: CS1      : 75
//PIN: DTACK    : 76
//PIN: IDECS_n  : 77
// above needed for tri state
//PIN: FC2      : 79
//PIN: FC1      : 80
//PIN: FC0      : 81

