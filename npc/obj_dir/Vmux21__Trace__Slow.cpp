// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vmux21__Syms.h"


void Vmux21___024root__traceInitSub0(Vmux21___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vmux21___024root__traceInitTop(Vmux21___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vmux21__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vmux21___024root__traceInitSub0(vlSelf, tracep);
    }
}

void Vmux21___024root__traceInitSub0(Vmux21___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vmux21__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+1,"a", false,-1);
        tracep->declBit(c+2,"b", false,-1);
        tracep->declBit(c+3,"s", false,-1);
        tracep->declBit(c+4,"y", false,-1);
        tracep->declBit(c+1,"mux21 a", false,-1);
        tracep->declBit(c+2,"mux21 b", false,-1);
        tracep->declBit(c+3,"mux21 s", false,-1);
        tracep->declBit(c+4,"mux21 y", false,-1);
    }
}

void Vmux21___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) VL_ATTR_COLD;
void Vmux21___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep);
void Vmux21___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/);

void Vmux21___024root__traceRegister(Vmux21___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vmux21__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        tracep->addFullCb(&Vmux21___024root__traceFullTop0, vlSelf);
        tracep->addChgCb(&Vmux21___024root__traceChgTop0, vlSelf);
        tracep->addCleanupCb(&Vmux21___024root__traceCleanup, vlSelf);
    }
}

void Vmux21___024root__traceFullSub0(Vmux21___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vmux21___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) {
    Vmux21___024root* const __restrict vlSelf = static_cast<Vmux21___024root*>(voidSelf);
    Vmux21__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vmux21___024root__traceFullSub0((&vlSymsp->TOP), tracep);
    }
}

void Vmux21___024root__traceFullSub0(Vmux21___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vmux21__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullBit(oldp+1,(vlSelf->a));
        tracep->fullBit(oldp+2,(vlSelf->b));
        tracep->fullBit(oldp+3,(vlSelf->s));
        tracep->fullBit(oldp+4,(vlSelf->y));
    }
}
