// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vmux21.h for the primary calling header

#ifndef VERILATED_VMUX21___024ROOT_H_
#define VERILATED_VMUX21___024ROOT_H_  // guard

#include "verilated_heavy.h"

//==========

class Vmux21__Syms;
class Vmux21_VerilatedVcd;


//----------

VL_MODULE(Vmux21___024root) {
  public:

    // PORTS
    VL_OUT8(out,0,0);
    VL_IN8(key,0,0);
    VL_IN8(default_out,0,0);
    VL_IN8(lut,3,0);
    VL_IN8(a,0,0);
    VL_IN8(b,0,0);
    VL_IN8(s,0,0);
    VL_OUT8(y,0,0);

    // LOCAL SIGNALS
    CData/*0:0*/ MuxKeyWithDefault__DOT__i0__DOT__lut_out;
    CData/*0:0*/ MuxKeyWithDefault__DOT__i0__DOT__hit;
    CData/*0:0*/ top__DOT__i0__DOT__i0__DOT__lut_out;
    CData/*0:0*/ top__DOT__i0__DOT__i0__DOT__hit;
    VlUnpacked<CData/*1:0*/, 2> MuxKeyWithDefault__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*0:0*/, 2> MuxKeyWithDefault__DOT__i0__DOT__key_list;
    VlUnpacked<CData/*0:0*/, 2> MuxKeyWithDefault__DOT__i0__DOT__data_list;
    VlUnpacked<CData/*1:0*/, 2> top__DOT__i0__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*0:0*/, 2> top__DOT__i0__DOT__i0__DOT__key_list;
    VlUnpacked<CData/*0:0*/, 2> top__DOT__i0__DOT__i0__DOT__data_list;

    // LOCAL VARIABLES
    CData/*3:0*/ top__DOT____Vcellinp__i0____pinNumber3;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;

    // INTERNAL VARIABLES
    Vmux21__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vmux21___024root);  ///< Copying not allowed
  public:
    Vmux21___024root(const char* name);
    ~Vmux21___024root();

    // INTERNAL METHODS
    void __Vconfigure(Vmux21__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
