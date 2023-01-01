// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VMuxKey.h for the primary calling header

#ifndef VERILATED_VMUXKEY___024ROOT_H_
#define VERILATED_VMUXKEY___024ROOT_H_  // guard

#include "verilated_heavy.h"

//==========

class VMuxKey__Syms;
class VMuxKey_VerilatedVcd;


//----------

VL_MODULE(VMuxKey___024root) {
  public:

    // PORTS
    VL_IN8(a,0,0);
    VL_IN8(b,0,0);
    VL_IN8(s,0,0);
    VL_OUT8(y,0,0);

    // LOCAL SIGNALS
    CData/*0:0*/ top__DOT__i0__DOT__i0__DOT__lut_out;
    CData/*0:0*/ top__DOT__i0__DOT__i0__DOT__hit;
    VlUnpacked<CData/*1:0*/, 2> top__DOT__i0__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*0:0*/, 2> top__DOT__i0__DOT__i0__DOT__key_list;
    VlUnpacked<CData/*0:0*/, 2> top__DOT__i0__DOT__i0__DOT__data_list;

    // LOCAL VARIABLES
    CData/*3:0*/ top__DOT____Vcellinp__i0____pinNumber3;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;

    // INTERNAL VARIABLES
    VMuxKey__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(VMuxKey___024root);  ///< Copying not allowed
  public:
    VMuxKey___024root(const char* name);
    ~VMuxKey___024root();

    // INTERNAL METHODS
    void __Vconfigure(VMuxKey__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
