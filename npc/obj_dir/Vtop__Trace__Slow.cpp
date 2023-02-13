// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


void Vtop___024root__traceInitSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vtop___024root__traceInitTop(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vtop___024root__traceInitSub0(vlSelf, tracep);
    }
}

void Vtop___024root__traceInitSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+11,"clk", false,-1);
        tracep->declBit(c+12,"rst", false,-1);
        tracep->declBus(c+13,"inst", false,-1, 31,0);
        tracep->declQuad(c+14,"pc", false,-1, 63,0);
        tracep->declBit(c+11,"top clk", false,-1);
        tracep->declBit(c+12,"top rst", false,-1);
        tracep->declBus(c+13,"top inst", false,-1, 31,0);
        tracep->declQuad(c+14,"top pc", false,-1, 63,0);
        tracep->declBus(c+16,"top rd", false,-1, 4,0);
        tracep->declBus(c+17,"top rs1", false,-1, 4,0);
        tracep->declBus(c+18,"top rs2", false,-1, 4,0);
        tracep->declQuad(c+19,"top imm", false,-1, 63,0);
        tracep->declBit(c+21,"top need_imm", false,-1);
        tracep->declBit(c+22,"top alu_add", false,-1);
        tracep->declQuad(c+23,"top wdata", false,-1, 63,0);
        tracep->declBit(c+41,"top wen", false,-1);
        tracep->declQuad(c+25,"top rdata_1", false,-1, 63,0);
        tracep->declQuad(c+27,"top rdata_2", false,-1, 63,0);
        tracep->declQuad(c+29,"top operator_2", false,-1, 63,0);
        tracep->declQuad(c+23,"top result", false,-1, 63,0);
        tracep->declQuad(c+42,"top current_pc", false,-1, 63,0);
        tracep->declBus(c+13,"top u_decoder inst", false,-1, 31,0);
        tracep->declBus(c+16,"top u_decoder rd", false,-1, 4,0);
        tracep->declBus(c+17,"top u_decoder rs1", false,-1, 4,0);
        tracep->declBus(c+18,"top u_decoder rs2", false,-1, 4,0);
        tracep->declQuad(c+19,"top u_decoder imm", false,-1, 63,0);
        tracep->declBit(c+21,"top u_decoder need_imm", false,-1);
        tracep->declBit(c+22,"top u_decoder alu_add", false,-1);
        tracep->declBit(c+21,"top u_decoder op_imm", false,-1);
        tracep->declBit(c+31,"top u_decoder op_system", false,-1);
        tracep->declBit(c+32,"top u_decoder funct3_000", false,-1);
        tracep->declBit(c+33,"top u_decoder funct12_000000000001", false,-1);
        tracep->declBit(c+22,"top u_decoder addi", false,-1);
        tracep->declBit(c+34,"top u_decoder ebreak", false,-1);
        tracep->declBit(c+21,"top u_decoder I_type", false,-1);
        tracep->declQuad(c+35,"top u_decoder I_imm", false,-1, 63,0);
        tracep->declBus(c+44,"top u_RegisterFile ADDR_WIDTH", false,-1, 31,0);
        tracep->declBus(c+45,"top u_RegisterFile DATA_WIDTH", false,-1, 31,0);
        tracep->declBit(c+11,"top u_RegisterFile clk", false,-1);
        tracep->declQuad(c+23,"top u_RegisterFile wdata", false,-1, 63,0);
        tracep->declBus(c+16,"top u_RegisterFile rd", false,-1, 4,0);
        tracep->declBit(c+41,"top u_RegisterFile wen", false,-1);
        tracep->declBus(c+17,"top u_RegisterFile rs1", false,-1, 4,0);
        tracep->declBus(c+18,"top u_RegisterFile rs2", false,-1, 4,0);
        tracep->declQuad(c+25,"top u_RegisterFile rdata_1", false,-1, 63,0);
        tracep->declQuad(c+27,"top u_RegisterFile rdata_2", false,-1, 63,0);
        {int i; for (i=0; i<5; i++) {
                tracep->declQuad(c+1+i*2,"top u_RegisterFile rf", true,(i+0), 63,0);}}
        tracep->declQuad(c+25,"top u_Alu operator_1", false,-1, 63,0);
        tracep->declQuad(c+29,"top u_Alu operator_2", false,-1, 63,0);
        tracep->declBit(c+22,"top u_Alu alu_add", false,-1);
        tracep->declQuad(c+23,"top u_Alu result", false,-1, 63,0);
        tracep->declQuad(c+37,"top u_Alu add_result", false,-1, 63,0);
        tracep->declBit(c+11,"top u_PC clk", false,-1);
        tracep->declBit(c+12,"top u_PC rst", false,-1);
        tracep->declQuad(c+14,"top u_PC current_pc", false,-1, 63,0);
        tracep->declQuad(c+39,"top u_PC next_pc", false,-1, 63,0);
        tracep->declBus(c+45,"top u_PC Pc_Reg WIDTH", false,-1, 31,0);
        tracep->declQuad(c+46,"top u_PC Pc_Reg RESET_VAL", false,-1, 63,0);
        tracep->declBit(c+11,"top u_PC Pc_Reg clk", false,-1);
        tracep->declBit(c+12,"top u_PC Pc_Reg rst", false,-1);
        tracep->declQuad(c+39,"top u_PC Pc_Reg din", false,-1, 63,0);
        tracep->declBit(c+41,"top u_PC Pc_Reg wen", false,-1);
        tracep->declQuad(c+14,"top u_PC Pc_Reg dout", false,-1, 63,0);
    }
}

void Vtop___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) VL_ATTR_COLD;
void Vtop___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep);
void Vtop___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/);

void Vtop___024root__traceRegister(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        tracep->addFullCb(&Vtop___024root__traceFullTop0, vlSelf);
        tracep->addChgCb(&Vtop___024root__traceChgTop0, vlSelf);
        tracep->addCleanupCb(&Vtop___024root__traceCleanup, vlSelf);
    }
}

void Vtop___024root__traceFullSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vtop___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) {
    Vtop___024root* const __restrict vlSelf = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vtop___024root__traceFullSub0((&vlSymsp->TOP), tracep);
    }
}

void Vtop___024root__traceFullSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullQData(oldp+1,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[0]),64);
        tracep->fullQData(oldp+3,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[1]),64);
        tracep->fullQData(oldp+5,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[2]),64);
        tracep->fullQData(oldp+7,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[3]),64);
        tracep->fullQData(oldp+9,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[4]),64);
        tracep->fullBit(oldp+11,(vlSelf->clk));
        tracep->fullBit(oldp+12,(vlSelf->rst));
        tracep->fullIData(oldp+13,(vlSelf->inst),32);
        tracep->fullQData(oldp+14,(vlSelf->pc),64);
        tracep->fullCData(oldp+16,((0x1fU & (vlSelf->inst 
                                             >> 7U))),5);
        tracep->fullCData(oldp+17,((0x1fU & (vlSelf->inst 
                                             >> 0xfU))),5);
        tracep->fullCData(oldp+18,((0x1fU & (vlSelf->inst 
                                             >> 0x14U))),5);
        tracep->fullQData(oldp+19,(((- (QData)((IData)(
                                                       (0x13U 
                                                        == 
                                                        (0x7fU 
                                                         & vlSelf->inst))))) 
                                    & (((- (QData)((IData)(
                                                           (vlSelf->inst 
                                                            >> 0x1fU)))) 
                                        << 0xcU) | (QData)((IData)(
                                                                   (vlSelf->inst 
                                                                    >> 0x14U)))))),64);
        tracep->fullBit(oldp+21,((0x13U == (0x7fU & vlSelf->inst))));
        tracep->fullBit(oldp+22,((IData)((0x13U == 
                                          (0x707fU 
                                           & vlSelf->inst)))));
        tracep->fullQData(oldp+23,(((- (QData)((IData)(
                                                       (0x13U 
                                                        == 
                                                        (0x707fU 
                                                         & vlSelf->inst))))) 
                                    & (((4U >= (7U 
                                                & (vlSelf->inst 
                                                   >> 0xfU)))
                                         ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                        [(7U & (vlSelf->inst 
                                                >> 0xfU))]
                                         : 0ULL) + 
                                       ((0x13U == (0x7fU 
                                                   & vlSelf->inst))
                                         ? ((- (QData)((IData)(
                                                               (0x13U 
                                                                == 
                                                                (0x7fU 
                                                                 & vlSelf->inst))))) 
                                            & (((- (QData)((IData)(
                                                                   (vlSelf->inst 
                                                                    >> 0x1fU)))) 
                                                << 0xcU) 
                                               | (QData)((IData)(
                                                                 (vlSelf->inst 
                                                                  >> 0x14U)))))
                                         : ((4U >= 
                                             (7U & 
                                              (vlSelf->inst 
                                               >> 0x14U)))
                                             ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                            [(7U & 
                                              (vlSelf->inst 
                                               >> 0x14U))]
                                             : 0ULL))))),64);
        tracep->fullQData(oldp+25,(((4U >= (7U & (vlSelf->inst 
                                                  >> 0xfU)))
                                     ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                    [(7U & (vlSelf->inst 
                                            >> 0xfU))]
                                     : 0ULL)),64);
        tracep->fullQData(oldp+27,(((4U >= (7U & (vlSelf->inst 
                                                  >> 0x14U)))
                                     ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                    [(7U & (vlSelf->inst 
                                            >> 0x14U))]
                                     : 0ULL)),64);
        tracep->fullQData(oldp+29,(((0x13U == (0x7fU 
                                               & vlSelf->inst))
                                     ? ((- (QData)((IData)(
                                                           (0x13U 
                                                            == 
                                                            (0x7fU 
                                                             & vlSelf->inst))))) 
                                        & (((- (QData)((IData)(
                                                               (vlSelf->inst 
                                                                >> 0x1fU)))) 
                                            << 0xcU) 
                                           | (QData)((IData)(
                                                             (vlSelf->inst 
                                                              >> 0x14U)))))
                                     : ((4U >= (7U 
                                                & (vlSelf->inst 
                                                   >> 0x14U)))
                                         ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                        [(7U & (vlSelf->inst 
                                                >> 0x14U))]
                                         : 0ULL))),64);
        tracep->fullBit(oldp+31,((0x73U == (0x7fU & vlSelf->inst))));
        tracep->fullBit(oldp+32,((0U == (7U & (vlSelf->inst 
                                               >> 0xcU)))));
        tracep->fullBit(oldp+33,((1U == (vlSelf->inst 
                                         >> 0x14U))));
        tracep->fullBit(oldp+34,(((IData)((0x73U == 
                                           (0x707fU 
                                            & vlSelf->inst))) 
                                  & (1U == (vlSelf->inst 
                                            >> 0x14U)))));
        tracep->fullQData(oldp+35,((((- (QData)((IData)(
                                                        (vlSelf->inst 
                                                         >> 0x1fU)))) 
                                     << 0xcU) | (QData)((IData)(
                                                                (vlSelf->inst 
                                                                 >> 0x14U))))),64);
        tracep->fullQData(oldp+37,((((4U >= (7U & (vlSelf->inst 
                                                   >> 0xfU)))
                                      ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                     [(7U & (vlSelf->inst 
                                             >> 0xfU))]
                                      : 0ULL) + ((0x13U 
                                                  == 
                                                  (0x7fU 
                                                   & vlSelf->inst))
                                                  ? 
                                                 ((- (QData)((IData)(
                                                                     (0x13U 
                                                                      == 
                                                                      (0x7fU 
                                                                       & vlSelf->inst))))) 
                                                  & (((- (QData)((IData)(
                                                                         (vlSelf->inst 
                                                                          >> 0x1fU)))) 
                                                      << 0xcU) 
                                                     | (QData)((IData)(
                                                                       (vlSelf->inst 
                                                                        >> 0x14U)))))
                                                  : 
                                                 ((4U 
                                                   >= 
                                                   (7U 
                                                    & (vlSelf->inst 
                                                       >> 0x14U)))
                                                   ? 
                                                  vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                                  [
                                                  (7U 
                                                   & (vlSelf->inst 
                                                      >> 0x14U))]
                                                   : 0ULL)))),64);
        tracep->fullQData(oldp+39,((4ULL + vlSelf->pc)),64);
        tracep->fullBit(oldp+41,(1U));
        tracep->fullQData(oldp+42,(vlSelf->top__DOT__current_pc),64);
        tracep->fullIData(oldp+44,(5U),32);
        tracep->fullIData(oldp+45,(0x40U),32);
        tracep->fullQData(oldp+46,(0x80000000ULL),64);
    }
}
