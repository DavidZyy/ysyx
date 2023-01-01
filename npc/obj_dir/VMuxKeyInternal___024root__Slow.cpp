// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VMuxKeyInternal.h for the primary calling header

#include "VMuxKeyInternal___024root.h"
#include "VMuxKeyInternal__Syms.h"

//==========


void VMuxKeyInternal___024root___ctor_var_reset(VMuxKeyInternal___024root* vlSelf);

VMuxKeyInternal___024root::VMuxKeyInternal___024root(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    VMuxKeyInternal___024root___ctor_var_reset(this);
}

void VMuxKeyInternal___024root::__Vconfigure(VMuxKeyInternal__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

VMuxKeyInternal___024root::~VMuxKeyInternal___024root() {
}

void VMuxKeyInternal___024root___eval_initial(VMuxKeyInternal___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMuxKeyInternal__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMuxKeyInternal___024root___eval_initial\n"); );
}

void VMuxKeyInternal___024root___combo__TOP__1(VMuxKeyInternal___024root* vlSelf);

void VMuxKeyInternal___024root___eval_settle(VMuxKeyInternal___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMuxKeyInternal__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMuxKeyInternal___024root___eval_settle\n"); );
    // Body
    VMuxKeyInternal___024root___combo__TOP__1(vlSelf);
    vlSelf->__Vm_traceActivity[1U] = 1U;
    vlSelf->__Vm_traceActivity[0U] = 1U;
}

void VMuxKeyInternal___024root___final(VMuxKeyInternal___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMuxKeyInternal__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMuxKeyInternal___024root___final\n"); );
}

void VMuxKeyInternal___024root___ctor_var_reset(VMuxKeyInternal___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMuxKeyInternal__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMuxKeyInternal___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->a = VL_RAND_RESET_I(1);
    vlSelf->b = VL_RAND_RESET_I(1);
    vlSelf->s = VL_RAND_RESET_I(1);
    vlSelf->y = VL_RAND_RESET_I(1);
    vlSelf->top__DOT____Vcellinp__i0____pinNumber3 = VL_RAND_RESET_I(4);
    for (int __Vi0=0; __Vi0<2; ++__Vi0) {
        vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list[__Vi0] = VL_RAND_RESET_I(2);
    }
    for (int __Vi0=0; __Vi0<2; ++__Vi0) {
        vlSelf->top__DOT__i0__DOT__i0__DOT__key_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    for (int __Vi0=0; __Vi0<2; ++__Vi0) {
        vlSelf->top__DOT__i0__DOT__i0__DOT__data_list[__Vi0] = VL_RAND_RESET_I(1);
    }
    vlSelf->top__DOT__i0__DOT__i0__DOT__lut_out = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__i0__DOT__i0__DOT__hit = VL_RAND_RESET_I(1);
    for (int __Vi0=0; __Vi0<2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = VL_RAND_RESET_I(1);
    }
}
