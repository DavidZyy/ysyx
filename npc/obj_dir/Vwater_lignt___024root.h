// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vwater_lignt.h for the primary calling header

#ifndef VERILATED_VWATER_LIGNT___024ROOT_H_
#define VERILATED_VWATER_LIGNT___024ROOT_H_  // guard

#include "verilated_heavy.h"

//==========

class Vwater_lignt__Syms;
class Vwater_lignt_VerilatedVcd;


//----------

VL_MODULE(Vwater_lignt___024root) {
  public:

    // PORTS
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_OUT16(led,15,0);

    // LOCAL SIGNALS
    IData/*31:0*/ top__DOT__light1__DOT__count;

    // LOCAL VARIABLES
    CData/*0:0*/ __Vclklast__TOP__clk;

    // INTERNAL VARIABLES
    Vwater_lignt__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vwater_lignt___024root);  ///< Copying not allowed
  public:
    Vwater_lignt___024root(const char* name);
    ~Vwater_lignt___024root();

    // INTERNAL METHODS
    void __Vconfigure(Vwater_lignt__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
