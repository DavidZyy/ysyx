// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


void Vtop___024root__traceChgSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep);

void Vtop___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep) {
    Vtop___024root* const __restrict vlSelf = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    {
        Vtop___024root__traceChgSub0((&vlSymsp->TOP), tracep);
    }
}

void Vtop___024root__traceChgSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode + 1);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->chgBit(oldp+0,(vlSelf->clk));
        tracep->chgBit(oldp+1,(vlSelf->rst));
        tracep->chgIData(oldp+2,(vlSelf->inst),32);
        tracep->chgQData(oldp+3,(vlSelf->pc),64);
        tracep->chgQData(oldp+5,(((- (QData)((IData)(
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
        tracep->chgBit(oldp+7,((0x13U == (0x7fU & vlSelf->inst))));
        tracep->chgBit(oldp+8,((0x73U == (0x7fU & vlSelf->inst))));
        tracep->chgBit(oldp+9,((0U == (7U & (vlSelf->inst 
                                             >> 0xcU)))));
        tracep->chgBit(oldp+10,((1U == (vlSelf->inst 
                                        >> 0x14U))));
        tracep->chgBit(oldp+11,((IData)((0x13U == (0x707fU 
                                                   & vlSelf->inst)))));
        tracep->chgBit(oldp+12,(((IData)((0x73U == 
                                          (0x707fU 
                                           & vlSelf->inst))) 
                                 & (1U == (vlSelf->inst 
                                           >> 0x14U)))));
        tracep->chgQData(oldp+13,((((- (QData)((IData)(
                                                       (vlSelf->inst 
                                                        >> 0x1fU)))) 
                                    << 0xcU) | (QData)((IData)(
                                                               (vlSelf->inst 
                                                                >> 0x14U))))),64);
    }
}

void Vtop___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VlUnpacked<CData/*0:0*/, 1> __Vm_traceActivity;
    Vtop___024root* const __restrict vlSelf = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        __Vm_traceActivity[0U] = 0U;
    }
}
