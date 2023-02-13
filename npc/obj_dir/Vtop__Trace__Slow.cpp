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
        tracep->declBit(c+1,"clk", false,-1);
        tracep->declBit(c+2,"rst", false,-1);
        tracep->declBus(c+3,"inst", false,-1, 31,0);
        tracep->declQuad(c+4,"pc", false,-1, 63,0);
        tracep->declBit(c+1,"top clk", false,-1);
        tracep->declBit(c+2,"top rst", false,-1);
        tracep->declBus(c+3,"top inst", false,-1, 31,0);
        tracep->declQuad(c+4,"top pc", false,-1, 63,0);
        tracep->declBus(c+16,"top rd", false,-1, 4,0);
        tracep->declBus(c+17,"top rs1", false,-1, 4,0);
        tracep->declBus(c+18,"top rs2", false,-1, 4,0);
        tracep->declQuad(c+6,"top imm", false,-1, 63,0);
        tracep->declBus(c+3,"top u_decoder inst", false,-1, 31,0);
        tracep->declBus(c+16,"top u_decoder rd", false,-1, 4,0);
        tracep->declBus(c+17,"top u_decoder rs1", false,-1, 4,0);
        tracep->declBus(c+18,"top u_decoder rs2", false,-1, 4,0);
        tracep->declQuad(c+6,"top u_decoder imm", false,-1, 63,0);
        tracep->declBit(c+8,"top u_decoder op_imm", false,-1);
        tracep->declBit(c+9,"top u_decoder op_system", false,-1);
        tracep->declBit(c+10,"top u_decoder funct3_000", false,-1);
        tracep->declBit(c+11,"top u_decoder funct12_000000000001", false,-1);
        tracep->declBit(c+12,"top u_decoder addi", false,-1);
        tracep->declBit(c+13,"top u_decoder ebreak", false,-1);
        tracep->declBit(c+8,"top u_decoder I_type", false,-1);
        tracep->declQuad(c+14,"top u_decoder I_imm", false,-1, 63,0);
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
        tracep->fullBit(oldp+1,(vlSelf->clk));
        tracep->fullBit(oldp+2,(vlSelf->rst));
        tracep->fullIData(oldp+3,(vlSelf->inst),32);
        tracep->fullQData(oldp+4,(vlSelf->pc),64);
        tracep->fullQData(oldp+6,(((- (QData)((IData)(
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
        tracep->fullBit(oldp+8,((0x13U == (0x7fU & vlSelf->inst))));
        tracep->fullBit(oldp+9,((0x73U == (0x7fU & vlSelf->inst))));
        tracep->fullBit(oldp+10,((0U == (7U & (vlSelf->inst 
                                               >> 0xcU)))));
        tracep->fullBit(oldp+11,((1U == (vlSelf->inst 
                                         >> 0x14U))));
        tracep->fullBit(oldp+12,((IData)((0x13U == 
                                          (0x707fU 
                                           & vlSelf->inst)))));
        tracep->fullBit(oldp+13,(((IData)((0x73U == 
                                           (0x707fU 
                                            & vlSelf->inst))) 
                                  & (1U == (vlSelf->inst 
                                            >> 0x14U)))));
        tracep->fullQData(oldp+14,((((- (QData)((IData)(
                                                        (vlSelf->inst 
                                                         >> 0x1fU)))) 
                                     << 0xcU) | (QData)((IData)(
                                                                (vlSelf->inst 
                                                                 >> 0x14U))))),64);
        tracep->fullCData(oldp+16,(vlSelf->top__DOT__rd),5);
        tracep->fullCData(oldp+17,(vlSelf->top__DOT__rs1),5);
        tracep->fullCData(oldp+18,(vlSelf->top__DOT__rs2),5);
    }
}
