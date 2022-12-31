// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vwater_lignt.h"
#include "Vwater_lignt__Syms.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

Vwater_lignt::Vwater_lignt(VerilatedContext* _vcontextp__, const char* _vcname__)
    : vlSymsp{new Vwater_lignt__Syms(_vcontextp__, _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , rst{vlSymsp->TOP.rst}
    , led{vlSymsp->TOP.led}
    , rootp{&(vlSymsp->TOP)}
{
}

Vwater_lignt::Vwater_lignt(const char* _vcname__)
    : Vwater_lignt(nullptr, _vcname__)
{
}

//============================================================
// Destructor

Vwater_lignt::~Vwater_lignt() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void Vwater_lignt___024root___eval_initial(Vwater_lignt___024root* vlSelf);
void Vwater_lignt___024root___eval_settle(Vwater_lignt___024root* vlSelf);
void Vwater_lignt___024root___eval(Vwater_lignt___024root* vlSelf);
QData Vwater_lignt___024root___change_request(Vwater_lignt___024root* vlSelf);
#ifdef VL_DEBUG
void Vwater_lignt___024root___eval_debug_assertions(Vwater_lignt___024root* vlSelf);
#endif  // VL_DEBUG
void Vwater_lignt___024root___final(Vwater_lignt___024root* vlSelf);

static void _eval_initial_loop(Vwater_lignt__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    Vwater_lignt___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        Vwater_lignt___024root___eval_settle(&(vlSymsp->TOP));
        Vwater_lignt___024root___eval(&(vlSymsp->TOP));
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = Vwater_lignt___024root___change_request(&(vlSymsp->TOP));
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/home/zhuyangyang/project/ysyx-workbench/npc/vsrc/top.v", 1, "",
                "Verilated model didn't DC converge\n"
                "- See https://verilator.org/warn/DIDNOTCONVERGE");
        } else {
            __Vchange = Vwater_lignt___024root___change_request(&(vlSymsp->TOP));
        }
    } while (VL_UNLIKELY(__Vchange));
}

void Vwater_lignt::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vwater_lignt::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vwater_lignt___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        Vwater_lignt___024root___eval(&(vlSymsp->TOP));
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = Vwater_lignt___024root___change_request(&(vlSymsp->TOP));
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/home/zhuyangyang/project/ysyx-workbench/npc/vsrc/top.v", 1, "",
                "Verilated model didn't converge\n"
                "- See https://verilator.org/warn/DIDNOTCONVERGE");
        } else {
            __Vchange = Vwater_lignt___024root___change_request(&(vlSymsp->TOP));
        }
    } while (VL_UNLIKELY(__Vchange));
}

//============================================================
// Invoke final blocks

void Vwater_lignt::final() {
    Vwater_lignt___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Utilities

VerilatedContext* Vwater_lignt::contextp() const {
    return vlSymsp->_vm_contextp__;
}

const char* Vwater_lignt::name() const {
    return vlSymsp->name();
}

//============================================================
// Trace configuration

void Vwater_lignt___024root__traceInitTop(Vwater_lignt___024root* vlSelf, VerilatedVcd* tracep);

static void traceInit(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vwater_lignt___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vwater_lignt___024root*>(voidSelf);
    Vwater_lignt__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->module(vlSymsp->name());
    tracep->scopeEscape(' ');
    Vwater_lignt___024root__traceInitTop(vlSelf, tracep);
    tracep->scopeEscape('.');
}

void Vwater_lignt___024root__traceRegister(Vwater_lignt___024root* vlSelf, VerilatedVcd* tracep);

void Vwater_lignt::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addInitCb(&traceInit, &(vlSymsp->TOP));
    Vwater_lignt___024root__traceRegister(&(vlSymsp->TOP), tfp->spTrace());
}
