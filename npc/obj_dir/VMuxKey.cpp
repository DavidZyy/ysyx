// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VMuxKey.h"
#include "VMuxKey__Syms.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

VMuxKey::VMuxKey(VerilatedContext* _vcontextp__, const char* _vcname__)
    : vlSymsp{new VMuxKey__Syms(_vcontextp__, _vcname__, this)}
    , a{vlSymsp->TOP.a}
    , b{vlSymsp->TOP.b}
    , s{vlSymsp->TOP.s}
    , y{vlSymsp->TOP.y}
    , rootp{&(vlSymsp->TOP)}
{
}

VMuxKey::VMuxKey(const char* _vcname__)
    : VMuxKey(nullptr, _vcname__)
{
}

//============================================================
// Destructor

VMuxKey::~VMuxKey() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void VMuxKey___024root___eval_initial(VMuxKey___024root* vlSelf);
void VMuxKey___024root___eval_settle(VMuxKey___024root* vlSelf);
void VMuxKey___024root___eval(VMuxKey___024root* vlSelf);
QData VMuxKey___024root___change_request(VMuxKey___024root* vlSelf);
#ifdef VL_DEBUG
void VMuxKey___024root___eval_debug_assertions(VMuxKey___024root* vlSelf);
#endif  // VL_DEBUG
void VMuxKey___024root___final(VMuxKey___024root* vlSelf);

static void _eval_initial_loop(VMuxKey__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    VMuxKey___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        VMuxKey___024root___eval_settle(&(vlSymsp->TOP));
        VMuxKey___024root___eval(&(vlSymsp->TOP));
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = VMuxKey___024root___change_request(&(vlSymsp->TOP));
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/home/zhuyangyang/project/ysyx-workbench/npc/vsrc/top.v", 1, "",
                "Verilated model didn't DC converge\n"
                "- See https://verilator.org/warn/DIDNOTCONVERGE");
        } else {
            __Vchange = VMuxKey___024root___change_request(&(vlSymsp->TOP));
        }
    } while (VL_UNLIKELY(__Vchange));
}

void VMuxKey::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VMuxKey::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VMuxKey___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        VMuxKey___024root___eval(&(vlSymsp->TOP));
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = VMuxKey___024root___change_request(&(vlSymsp->TOP));
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/home/zhuyangyang/project/ysyx-workbench/npc/vsrc/top.v", 1, "",
                "Verilated model didn't converge\n"
                "- See https://verilator.org/warn/DIDNOTCONVERGE");
        } else {
            __Vchange = VMuxKey___024root___change_request(&(vlSymsp->TOP));
        }
    } while (VL_UNLIKELY(__Vchange));
}

//============================================================
// Invoke final blocks

void VMuxKey::final() {
    VMuxKey___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Utilities

VerilatedContext* VMuxKey::contextp() const {
    return vlSymsp->_vm_contextp__;
}

const char* VMuxKey::name() const {
    return vlSymsp->name();
}

//============================================================
// Trace configuration

void VMuxKey___024root__traceInitTop(VMuxKey___024root* vlSelf, VerilatedVcd* tracep);

static void traceInit(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    VMuxKey___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VMuxKey___024root*>(voidSelf);
    VMuxKey__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->module(vlSymsp->name());
    tracep->scopeEscape(' ');
    VMuxKey___024root__traceInitTop(vlSelf, tracep);
    tracep->scopeEscape('.');
}

void VMuxKey___024root__traceRegister(VMuxKey___024root* vlSelf, VerilatedVcd* tracep);

void VMuxKey::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addInitCb(&traceInit, &(vlSymsp->TOP));
    VMuxKey___024root__traceRegister(&(vlSymsp->TOP), tfp->spTrace());
}
