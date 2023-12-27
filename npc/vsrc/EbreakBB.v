
/* used in this file */
import "DPI-C" function void exit_code();

module EbreakBB (
    input      clock,
    input      valid
);

always @(posedge clock) begin
    if(valid) begin
        exit_code();
    end
end
    
endmodule //moduleName

