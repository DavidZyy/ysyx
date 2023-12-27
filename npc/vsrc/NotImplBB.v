
import "DPI-C" function void not_impl_exception();

module NotImplBB(
    input clock,
    input valid
);

always @(posedge clock) begin
    if(valid) begin
        not_impl_exception();
    end
end
 
endmodule //Not_impl

