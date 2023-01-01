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
        tracep->declBit(c+10,"a", false,-1);
        tracep->declBit(c+11,"b", false,-1);
        tracep->declBit(c+12,"s", false,-1);
        tracep->declBit(c+13,"y", false,-1);
        tracep->declBit(c+10,"top a", false,-1);
        tracep->declBit(c+11,"top b", false,-1);
        tracep->declBit(c+12,"top s", false,-1);
        tracep->declBit(c+13,"top y", false,-1);
        tracep->declBus(c+14,"top i0 NR_KEY", false,-1, 31,0);
        tracep->declBus(c+15,"top i0 KEY_LEN", false,-1, 31,0);
        tracep->declBus(c+15,"top i0 DATA_LEN", false,-1, 31,0);
        tracep->declBus(c+13,"top i0 out", false,-1, 0,0);
        tracep->declBus(c+12,"top i0 key", false,-1, 0,0);
        tracep->declBus(c+1,"top i0 lut", false,-1, 3,0);
        tracep->declBus(c+14,"top i0 i0 NR_KEY", false,-1, 31,0);
        tracep->declBus(c+15,"top i0 i0 KEY_LEN", false,-1, 31,0);
        tracep->declBus(c+15,"top i0 i0 DATA_LEN", false,-1, 31,0);
        tracep->declBus(c+16,"top i0 i0 HAS_DEFAULT", false,-1, 31,0);
        tracep->declBus(c+13,"top i0 i0 out", false,-1, 0,0);
        tracep->declBus(c+12,"top i0 i0 key", false,-1, 0,0);
        tracep->declBus(c+17,"top i0 i0 default_out", false,-1, 0,0);
        tracep->declBus(c+1,"top i0 i0 lut", false,-1, 3,0);
        tracep->declBus(c+14,"top i0 i0 PAIR_LEN", false,-1, 31,0);
        {int i; for (i=0; i<2; i++) {
                tracep->declBus(c+2+i*1,"top i0 i0 pair_list", true,(i+0), 1,0);}}
        {int i; for (i=0; i<2; i++) {
                tracep->declBus(c+4+i*1,"top i0 i0 key_list", true,(i+0), 0,0);}}
        {int i; for (i=0; i<2; i++) {
                tracep->declBus(c+6+i*1,"top i0 i0 data_list", true,(i+0), 0,0);}}
        tracep->declBus(c+8,"top i0 i0 lut_out", false,-1, 0,0);
        tracep->declBit(c+9,"top i0 i0 hit", false,-1);
        tracep->declBus(c+18,"top i0 i0 i", false,-1, 31,0);
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
        tracep->fullCData(oldp+1,(vlSelf->top__DOT____Vcellinp__i0____pinNumber3),4);
        tracep->fullCData(oldp+2,(vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list[0]),2);
        tracep->fullCData(oldp+3,(vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list[1]),2);
        tracep->fullBit(oldp+4,(vlSelf->top__DOT__i0__DOT__i0__DOT__key_list[0]));
        tracep->fullBit(oldp+5,(vlSelf->top__DOT__i0__DOT__i0__DOT__key_list[1]));
        tracep->fullBit(oldp+6,(vlSelf->top__DOT__i0__DOT__i0__DOT__data_list[0]));
        tracep->fullBit(oldp+7,(vlSelf->top__DOT__i0__DOT__i0__DOT__data_list[1]));
        tracep->fullBit(oldp+8,(vlSelf->top__DOT__i0__DOT__i0__DOT__lut_out));
        tracep->fullBit(oldp+9,(vlSelf->top__DOT__i0__DOT__i0__DOT__hit));
        tracep->fullBit(oldp+10,(vlSelf->a));
        tracep->fullBit(oldp+11,(vlSelf->b));
        tracep->fullBit(oldp+12,(vlSelf->s));
        tracep->fullBit(oldp+13,(vlSelf->y));
        tracep->fullIData(oldp+14,(2U),32);
        tracep->fullIData(oldp+15,(1U),32);
        tracep->fullIData(oldp+16,(0U),32);
        tracep->fullBit(oldp+17,(0U));
        tracep->fullIData(oldp+18,(2U),32);
    }
}
