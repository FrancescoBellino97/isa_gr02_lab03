library verilog;
use verilog.vl_types.all;
entity Risc_V is
    port(
        Clk             : in     vl_logic;
        reset           : in     vl_logic;
        Code_instruction: in     vl_logic_vector(31 downto 0);
        Data_from_memory: in     vl_logic_vector(31 downto 0);
        Address_instruction: out    vl_logic_vector(31 downto 0);
        Address_data    : out    vl_logic_vector(31 downto 0);
        Data_write      : out    vl_logic_vector(31 downto 0);
        Wr_MEM_cntrl    : out    vl_logic
    );
end Risc_V;
