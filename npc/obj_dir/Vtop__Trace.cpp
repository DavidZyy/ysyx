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
        if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
            tracep->chgQData(oldp+0,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[0]),64);
            tracep->chgQData(oldp+2,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[1]),64);
            tracep->chgQData(oldp+4,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[2]),64);
            tracep->chgQData(oldp+6,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[3]),64);
            tracep->chgQData(oldp+8,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[4]),64);
        }
        tracep->chgBit(oldp+10,(vlSelf->clk));
        tracep->chgBit(oldp+11,(vlSelf->rst));
        tracep->chgIData(oldp+12,(vlSelf->inst),32);
        tracep->chgQData(oldp+13,(vlSelf->pc),64);
        tracep->chgCData(oldp+15,((0x1fU & (vlSelf->inst 
                                            >> 7U))),5);
        tracep->chgCData(oldp+16,((0x1fU & (vlSelf->inst 
                                            >> 0xfU))),5);
        tracep->chgCData(oldp+17,((0x1fU & (vlSelf->inst 
                                            >> 0x14U))),5);
        tracep->chgQData(oldp+18,(((- (QData)((IData)(
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
        tracep->chgBit(oldp+20,((0x13U == (0x7fU & vlSelf->inst))));
        tracep->chgBit(oldp+21,((IData)((0x13U == (0x707fU 
                                                   & vlSelf->inst)))));
        tracep->chgQData(oldp+22,(((- (QData)((IData)(
                                                      (0x13U 
                                                       == 
                                                       (0x707fU 
                                                        & vlSelf->inst))))) 
                                   & (((4U >= (7U & 
                                               (vlSelf->inst 
                                                >> 0xfU)))
                                        ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                       [(7U & (vlSelf->inst 
                                               >> 0xfU))]
                                        : 0ULL) + (
                                                   (0x13U 
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
                                                     : 0ULL))))),64);
        tracep->chgQData(oldp+24,(((4U >= (7U & (vlSelf->inst 
                                                 >> 0xfU)))
                                    ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                   [(7U & (vlSelf->inst 
                                           >> 0xfU))]
                                    : 0ULL)),64);
        tracep->chgQData(oldp+26,(((4U >= (7U & (vlSelf->inst 
                                                 >> 0x14U)))
                                    ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                   [(7U & (vlSelf->inst 
                                           >> 0x14U))]
                                    : 0ULL)),64);
        tracep->chgQData(oldp+28,(((0x13U == (0x7fU 
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
                                    : ((4U >= (7U & 
                                               (vlSelf->inst 
                                                >> 0x14U)))
                                        ? vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                       [(7U & (vlSelf->inst 
                                               >> 0x14U))]
                                        : 0ULL))),64);
        tracep->chgBit(oldp+30,((0x73U == (0x7fU & vlSelf->inst))));
        tracep->chgBit(oldp+31,((0U == (7U & (vlSelf->inst 
                                              >> 0xcU)))));
        tracep->chgBit(oldp+32,((1U == (vlSelf->inst 
                                        >> 0x14U))));
        tracep->chgBit(oldp+33,(((IData)((0x73U == 
                                          (0x707fU 
                                           & vlSelf->inst))) 
                                 & (1U == (vlSelf->inst 
                                           >> 0x14U)))));
        tracep->chgQData(oldp+34,((((- (QData)((IData)(
                                                       (vlSelf->inst 
                                                        >> 0x1fU)))) 
                                    << 0xcU) | (QData)((IData)(
                                                               (vlSelf->inst 
                                                                >> 0x14U))))),64);
        tracep->chgQData(oldp+36,((((4U >= (7U & (vlSelf->inst 
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
                                                 [(7U 
                                                   & (vlSelf->inst 
                                                      >> 0x14U))]
                                                  : 0ULL)))),64);
        tracep->chgQData(oldp+38,((4ULL + vlSelf->pc)),64);
    }
}

void Vtop___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    Vtop___024root* const __restrict vlSelf = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
        vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    }
}
