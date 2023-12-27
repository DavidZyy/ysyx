
import "DPI-C" function void not_impl_exception();

module NotImplBB(
    input clock,
    input not_impl
);

always @(posedge clock) begin
    if(not_impl) begin
        not_impl_exception();
    end
end
 
endmodule //Not_impl

