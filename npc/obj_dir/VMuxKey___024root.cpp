// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VMuxKey.h for the primary calling header

#include "VMuxKey___024root.h"
#include "VMuxKey__Syms.h"

//==========

VL_INLINE_OPT void VMuxKey___024root___combo__TOP__1(VMuxKey___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMuxKey__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMuxKey___024root___combo__TOP__1\n"); );
    // Body
    vlSelf->top__DOT____Vcellinp__i0____pinNumber3 
        = (2U | (((IData)(vlSelf->a) << 2U) | (IData)(vlSelf->b)));
    vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list[0U] 
        = (3U & (IData)(vlSelf->top__DOT____Vcellinp__i0____pinNumber3));
    vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list[1U] 
        = (3U & ((IData)(vlSelf->top__DOT____Vcellinp__i0____pinNumber3) 
                 >> 2U));
    vlSelf->top__DOT__i0__DOT__i0__DOT__data_list[0U] 
        = (1U & vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
           [0U]);
    vlSelf->top__DOT__i0__DOT__i0__DOT__data_list[1U] 
        = (1U & vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
           [1U]);
    vlSelf->top__DOT__i0__DOT__i0__DOT__key_list[0U] 
        = (1U & (vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
                 [0U] >> 1U));
    vlSelf->top__DOT__i0__DOT__i0__DOT__key_list[1U] 
        = (1U & (vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
                 [1U] >> 1U));
    vlSelf->top__DOT__i0__DOT__i0__DOT__hit = ((IData)(vlSelf->s) 
                                               == vlSelf->top__DOT__i0__DOT__i0__DOT__key_list
                                               [0U]);
    vlSelf->top__DOT__i0__DOT__i0__DOT__hit = ((IData)(vlSelf->top__DOT__i0__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->s) 
                                                  == 
                                                  vlSelf->top__DOT__i0__DOT__i0__DOT__key_list
                                                  [1U]));
    vlSelf->top__DOT__i0__DOT__i0__DOT__lut_out = (
                                                   ((IData)(vlSelf->s) 
                                                    == 
                                                    vlSelf->top__DOT__i0__DOT__i0__DOT__key_list
                                                    [0U]) 
                                                   & vlSelf->top__DOT__i0__DOT__i0__DOT__data_list
                                                   [0U]);
    vlSelf->top__DOT__i0__DOT__i0__DOT__lut_out = ((IData)(vlSelf->top__DOT__i0__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->s) 
                                                       == 
                                                       vlSelf->top__DOT__i0__DOT__i0__DOT__key_list
                                                       [1U]) 
                                                      & vlSelf->top__DOT__i0__DOT__i0__DOT__data_list
                                                      [1U]));
    vlSelf->y = vlSelf->top__DOT__i0__DOT__i0__DOT__lut_out;
}

void VMuxKey___024root___eval(VMuxKey___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMuxKey__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMuxKey___024root___eval\n"); );
    // Body
    VMuxKey___024root___combo__TOP__1(vlSelf);
    vlSelf->__Vm_traceActivity[1U] = 1U;
}

QData VMuxKey___024root___change_request_1(VMuxKey___024root* vlSelf);

VL_INLINE_OPT QData VMuxKey___024root___change_request(VMuxKey___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMuxKey__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMuxKey___024root___change_request\n"); );
    // Body
    return (VMuxKey___024root___change_request_1(vlSelf));
}

VL_INLINE_OPT QData VMuxKey___024root___change_request_1(VMuxKey___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMuxKey__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMuxKey___024root___change_request_1\n"); );
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void VMuxKey___024root___eval_debug_assertions(VMuxKey___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMuxKey__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMuxKey___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->a & 0xfeU))) {
        Verilated::overWidthError("a");}
    if (VL_UNLIKELY((vlSelf->b & 0xfeU))) {
        Verilated::overWidthError("b");}
    if (VL_UNLIKELY((vlSelf->s & 0xfeU))) {
        Verilated::overWidthError("s");}
}
#endif  // VL_DEBUG
