/* used in this file */
import "DPI-C" function void exit_code();

module EbreakBB (
    input      is_ebreak
);

always @(*) begin
    if(is_ebreak) begin
        exit_code();
    end
end
    
endmodule //moduleName
