library verilog;
use verilog.vl_types.all;
entity ram_test is
    port(
        clk             : in     vl_logic;
        nreset          : in     vl_logic;
        info_en         : in     vl_logic;
        para_en         : in     vl_logic;
        indata_GPBCON3  : in     vl_logic;
        indata_GPBCON4  : in     vl_logic;
        indata_GPBCON5  : in     vl_logic;
        indata_GPBCON6  : in     vl_logic;
        indata_GPBCON7  : in     vl_logic;
        indata_GPBCON8  : in     vl_logic;
        indata_GPBCON9  : in     vl_logic;
        indata_GPBCON10 : in     vl_logic;
        indata_GPCCON0  : in     vl_logic;
        indata_GPCCON5  : in     vl_logic;
        indata_GPCCON6  : in     vl_logic;
        indata_GPCCON7  : in     vl_logic;
        indata_GPECON1  : in     vl_logic;
        indata_GPECON7  : in     vl_logic;
        indata_GPECON8  : in     vl_logic;
        indata_GPECON9  : in     vl_logic;
        indata_GPECON10 : in     vl_logic;
        indata_GPGCON1  : in     vl_logic;
        indata_GPGCON3  : in     vl_logic;
        indata_GPGCON6  : in     vl_logic;
        indata_GPGCON8  : in     vl_logic;
        indata_GPGCON11 : in     vl_logic;
        indata_GPHCON5_clk: in     vl_logic;
        indata_GPJCON0  : in     vl_logic;
        indata_GPJCON1  : in     vl_logic;
        indata_GPJCON2  : in     vl_logic;
        indata_GPJCON3  : in     vl_logic;
        indata_GPJCON4  : in     vl_logic;
        indata_GPJCON7  : in     vl_logic;
        indata_GPJCON8  : in     vl_logic;
        voltage_out     : out    vl_logic;
        voltage_out_part1: out    vl_logic;
        voltage_out_part2: out    vl_logic
    );
end ram_test;
