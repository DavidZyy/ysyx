// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vwater_lignt.h for the primary calling header

#include "Vwater_lignt___024root.h"
#include "Vwater_lignt__Syms.h"

//==========


void Vwater_lignt___024root___ctor_var_reset(Vwater_lignt___024root* vlSelf);

Vwater_lignt___024root::Vwater_lignt___024root(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    Vwater_lignt___024root___ctor_var_reset(this);
}

void Vwater_lignt___024root::__Vconfigure(Vwater_lignt__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

Vwater_lignt___024root::~Vwater_lignt___024root() {
}

void Vwater_lignt___024root___eval_initial(Vwater_lignt___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vwater_lignt___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
}

void Vwater_lignt___024root___eval_settle(Vwater_lignt___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vwater_lignt___024root___eval_settle\n"); );
}

void Vwater_lignt___024root___final(Vwater_lignt___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vwater_lignt___024root___final\n"); );
}

void Vwater_lignt___024root___ctor_var_reset(Vwater_lignt___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vwater_lignt___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = VL_RAND_RESET_I(1);
    vlSelf->rst = VL_RAND_RESET_I(1);
    vlSelf->led = VL_RAND_RESET_I(16);
    vlSelf->top__DOT__light1__DOT__count = VL_RAND_RESET_I(32);
}
