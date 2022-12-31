// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vwater_lignt__Syms.h"


void Vwater_lignt___024root__traceInitSub0(Vwater_lignt___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vwater_lignt___024root__traceInitTop(Vwater_lignt___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vwater_lignt___024root__traceInitSub0(vlSelf, tracep);
    }
}

void Vwater_lignt___024root__traceInitSub0(Vwater_lignt___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+1,"clk", false,-1);
        tracep->declBit(c+2,"rst", false,-1);
        tracep->declBus(c+3,"led", false,-1, 15,0);
        tracep->declBit(c+1,"top clk", false,-1);
        tracep->declBit(c+2,"top rst", false,-1);
        tracep->declBus(c+3,"top led", false,-1, 15,0);
        tracep->declBit(c+1,"top light1 clk", false,-1);
        tracep->declBit(c+2,"top light1 rst", false,-1);
        tracep->declBus(c+3,"top light1 led", false,-1, 15,0);
        tracep->declBus(c+4,"top light1 count", false,-1, 31,0);
    }
}

void Vwater_lignt___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) VL_ATTR_COLD;
void Vwater_lignt___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep);
void Vwater_lignt___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/);

void Vwater_lignt___024root__traceRegister(Vwater_lignt___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        tracep->addFullCb(&Vwater_lignt___024root__traceFullTop0, vlSelf);
        tracep->addChgCb(&Vwater_lignt___024root__traceChgTop0, vlSelf);
        tracep->addCleanupCb(&Vwater_lignt___024root__traceCleanup, vlSelf);
    }
}

void Vwater_lignt___024root__traceFullSub0(Vwater_lignt___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vwater_lignt___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) {
    Vwater_lignt___024root* const __restrict vlSelf = static_cast<Vwater_lignt___024root*>(voidSelf);
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vwater_lignt___024root__traceFullSub0((&vlSymsp->TOP), tracep);
    }
}

void Vwater_lignt___024root__traceFullSub0(Vwater_lignt___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullBit(oldp+1,(vlSelf->clk));
        tracep->fullBit(oldp+2,(vlSelf->rst));
        tracep->fullSData(oldp+3,(vlSelf->led),16);
        tracep->fullIData(oldp+4,(vlSelf->top__DOT__light1__DOT__count),32);
    }
}
