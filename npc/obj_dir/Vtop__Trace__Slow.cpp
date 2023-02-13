// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


void Vtop___024root__traceInitSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vtop___024root__traceInitTop(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vtop___024root__traceInitSub0(vlSelf, tracep);
    }
}

void Vtop___024root__traceInitSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+69,"clk", false,-1);
        tracep->declBit(c+70,"rst", false,-1);
        tracep->declBus(c+71,"inst", false,-1, 31,0);
        tracep->declQuad(c+72,"pc", false,-1, 63,0);
        tracep->declBit(c+69,"top clk", false,-1);
        tracep->declBit(c+70,"top rst", false,-1);
        tracep->declBus(c+71,"top inst", false,-1, 31,0);
        tracep->declQuad(c+72,"top pc", false,-1, 63,0);
        tracep->declBus(c+92,"top rd", false,-1, 4,0);
        tracep->declBus(c+93,"top rs1", false,-1, 4,0);
        tracep->declBus(c+94,"top rs2", false,-1, 4,0);
        tracep->declQuad(c+74,"top imm", false,-1, 63,0);
        tracep->declBit(c+76,"top need_imm", false,-1);
        tracep->declBit(c+77,"top alu_add", false,-1);
        tracep->declQuad(c+78,"top wdata", false,-1, 63,0);
        tracep->declBit(c+95,"top wen", false,-1);
        tracep->declQuad(c+1,"top rdata_1", false,-1, 63,0);
        tracep->declQuad(c+3,"top rdata_2", false,-1, 63,0);
        tracep->declQuad(c+80,"top operator_2", false,-1, 63,0);
        tracep->declQuad(c+78,"top result", false,-1, 63,0);
        tracep->declQuad(c+96,"top current_pc", false,-1, 63,0);
        tracep->declBus(c+71,"top u_decoder inst", false,-1, 31,0);
        tracep->declBus(c+92,"top u_decoder rd", false,-1, 4,0);
        tracep->declBus(c+93,"top u_decoder rs1", false,-1, 4,0);
        tracep->declBus(c+94,"top u_decoder rs2", false,-1, 4,0);
        tracep->declQuad(c+74,"top u_decoder imm", false,-1, 63,0);
        tracep->declBit(c+76,"top u_decoder need_imm", false,-1);
        tracep->declBit(c+77,"top u_decoder alu_add", false,-1);
        tracep->declBit(c+76,"top u_decoder op_imm", false,-1);
        tracep->declBit(c+82,"top u_decoder op_system", false,-1);
        tracep->declBit(c+83,"top u_decoder funct3_000", false,-1);
        tracep->declBit(c+84,"top u_decoder funct12_000000000001", false,-1);
        tracep->declBit(c+77,"top u_decoder addi", false,-1);
        tracep->declBit(c+85,"top u_decoder ebreak", false,-1);
        tracep->declBit(c+76,"top u_decoder I_type", false,-1);
        tracep->declQuad(c+86,"top u_decoder I_imm", false,-1, 63,0);
        tracep->declBus(c+98,"top u_RegisterFile ADDR_WIDTH", false,-1, 31,0);
        tracep->declBus(c+99,"top u_RegisterFile DATA_WIDTH", false,-1, 31,0);
        tracep->declBit(c+69,"top u_RegisterFile clk", false,-1);
        tracep->declQuad(c+78,"top u_RegisterFile wdata", false,-1, 63,0);
        tracep->declBus(c+100,"top u_RegisterFile rd", false,-1, 31,0);
        tracep->declBit(c+95,"top u_RegisterFile wen", false,-1);
        tracep->declBus(c+101,"top u_RegisterFile rs1", false,-1, 31,0);
        tracep->declBus(c+102,"top u_RegisterFile rs2", false,-1, 31,0);
        tracep->declQuad(c+1,"top u_RegisterFile rdata_1", false,-1, 63,0);
        tracep->declQuad(c+3,"top u_RegisterFile rdata_2", false,-1, 63,0);
        {int i; for (i=0; i<32; i++) {
                tracep->declQuad(c+5+i*2,"top u_RegisterFile rf", true,(i+0), 63,0);}}
        tracep->declQuad(c+1,"top u_Alu operator_1", false,-1, 63,0);
        tracep->declQuad(c+80,"top u_Alu operator_2", false,-1, 63,0);
        tracep->declBit(c+77,"top u_Alu alu_add", false,-1);
        tracep->declQuad(c+78,"top u_Alu result", false,-1, 63,0);
        tracep->declQuad(c+88,"top u_Alu add_result", false,-1, 63,0);
        tracep->declBit(c+69,"top u_PC clk", false,-1);
        tracep->declBit(c+70,"top u_PC rst", false,-1);
        tracep->declQuad(c+72,"top u_PC current_pc", false,-1, 63,0);
        tracep->declQuad(c+90,"top u_PC next_pc", false,-1, 63,0);
        tracep->declBus(c+99,"top u_PC Pc_Reg WIDTH", false,-1, 31,0);
        tracep->declQuad(c+103,"top u_PC Pc_Reg RESET_VAL", false,-1, 63,0);
        tracep->declBit(c+69,"top u_PC Pc_Reg clk", false,-1);
        tracep->declBit(c+70,"top u_PC Pc_Reg rst", false,-1);
        tracep->declQuad(c+90,"top u_PC Pc_Reg din", false,-1, 63,0);
        tracep->declBit(c+95,"top u_PC Pc_Reg wen", false,-1);
        tracep->declQuad(c+72,"top u_PC Pc_Reg dout", false,-1, 63,0);
    }
}

void Vtop___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) VL_ATTR_COLD;
void Vtop___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep);
void Vtop___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/);

void Vtop___024root__traceRegister(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        tracep->addFullCb(&Vtop___024root__traceFullTop0, vlSelf);
        tracep->addChgCb(&Vtop___024root__traceChgTop0, vlSelf);
        tracep->addCleanupCb(&Vtop___024root__traceCleanup, vlSelf);
    }
}

void Vtop___024root__traceFullSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vtop___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) {
    Vtop___024root* const __restrict vlSelf = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vtop___024root__traceFullSub0((&vlSymsp->TOP), tracep);
    }
}

void Vtop___024root__traceFullSub0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullQData(oldp+1,(vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                  [vlSelf->top__DOT__rs1]),64);
        tracep->fullQData(oldp+3,(vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                  [vlSelf->top__DOT__rs2]),64);
        tracep->fullQData(oldp+5,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[0]),64);
        tracep->fullQData(oldp+7,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[1]),64);
        tracep->fullQData(oldp+9,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[2]),64);
        tracep->fullQData(oldp+11,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[3]),64);
        tracep->fullQData(oldp+13,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[4]),64);
        tracep->fullQData(oldp+15,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[5]),64);
        tracep->fullQData(oldp+17,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[6]),64);
        tracep->fullQData(oldp+19,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[7]),64);
        tracep->fullQData(oldp+21,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[8]),64);
        tracep->fullQData(oldp+23,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[9]),64);
        tracep->fullQData(oldp+25,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[10]),64);
        tracep->fullQData(oldp+27,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[11]),64);
        tracep->fullQData(oldp+29,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[12]),64);
        tracep->fullQData(oldp+31,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[13]),64);
        tracep->fullQData(oldp+33,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[14]),64);
        tracep->fullQData(oldp+35,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[15]),64);
        tracep->fullQData(oldp+37,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[16]),64);
        tracep->fullQData(oldp+39,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[17]),64);
        tracep->fullQData(oldp+41,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[18]),64);
        tracep->fullQData(oldp+43,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[19]),64);
        tracep->fullQData(oldp+45,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[20]),64);
        tracep->fullQData(oldp+47,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[21]),64);
        tracep->fullQData(oldp+49,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[22]),64);
        tracep->fullQData(oldp+51,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[23]),64);
        tracep->fullQData(oldp+53,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[24]),64);
        tracep->fullQData(oldp+55,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[25]),64);
        tracep->fullQData(oldp+57,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[26]),64);
        tracep->fullQData(oldp+59,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[27]),64);
        tracep->fullQData(oldp+61,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[28]),64);
        tracep->fullQData(oldp+63,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[29]),64);
        tracep->fullQData(oldp+65,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[30]),64);
        tracep->fullQData(oldp+67,(vlSelf->top__DOT__u_RegisterFile__DOT__rf[31]),64);
        tracep->fullBit(oldp+69,(vlSelf->clk));
        tracep->fullBit(oldp+70,(vlSelf->rst));
        tracep->fullIData(oldp+71,(vlSelf->inst),32);
        tracep->fullQData(oldp+72,(vlSelf->pc),64);
        tracep->fullQData(oldp+74,(((- (QData)((IData)(
                                                       (0x13U 
                                                        == 
                                                        (0x7fU 
                                                         & vlSelf->inst))))) 
                                    & (((- (QData)((IData)(
                                                           (vlSelf->inst 
                                                            >> 0x1fU)))) 
                                        << 0xcU) | (QData)((IData)(
                                                                   (vlSelf->inst 
                                                                    >> 0x14U)))))),64);
        tracep->fullBit(oldp+76,((0x13U == (0x7fU & vlSelf->inst))));
        tracep->fullBit(oldp+77,((IData)((0x13U == 
                                          (0x707fU 
                                           & vlSelf->inst)))));
        tracep->fullQData(oldp+78,(((- (QData)((IData)(
                                                       (0x13U 
                                                        == 
                                                        (0x707fU 
                                                         & vlSelf->inst))))) 
                                    & (vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                       [vlSelf->top__DOT__rs1] 
                                       + ((0x13U == 
                                           (0x7fU & vlSelf->inst))
                                           ? ((- (QData)((IData)(
                                                                 (0x13U 
                                                                  == 
                                                                  (0x7fU 
                                                                   & vlSelf->inst))))) 
                                              & (((- (QData)((IData)(
                                                                     (vlSelf->inst 
                                                                      >> 0x1fU)))) 
                                                  << 0xcU) 
                                                 | (QData)((IData)(
                                                                   (vlSelf->inst 
                                                                    >> 0x14U)))))
                                           : vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                          [vlSelf->top__DOT__rs2])))),64);
        tracep->fullQData(oldp+80,(((0x13U == (0x7fU 
                                               & vlSelf->inst))
                                     ? ((- (QData)((IData)(
                                                           (0x13U 
                                                            == 
                                                            (0x7fU 
                                                             & vlSelf->inst))))) 
                                        & (((- (QData)((IData)(
                                                               (vlSelf->inst 
                                                                >> 0x1fU)))) 
                                            << 0xcU) 
                                           | (QData)((IData)(
                                                             (vlSelf->inst 
                                                              >> 0x14U)))))
                                     : vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                    [vlSelf->top__DOT__rs2])),64);
        tracep->fullBit(oldp+82,((0x73U == (0x7fU & vlSelf->inst))));
        tracep->fullBit(oldp+83,((0U == (7U & (vlSelf->inst 
                                               >> 0xcU)))));
        tracep->fullBit(oldp+84,((1U == (vlSelf->inst 
                                         >> 0x14U))));
        tracep->fullBit(oldp+85,(((IData)((0x73U == 
                                           (0x707fU 
                                            & vlSelf->inst))) 
                                  & (1U == (vlSelf->inst 
                                            >> 0x14U)))));
        tracep->fullQData(oldp+86,((((- (QData)((IData)(
                                                        (vlSelf->inst 
                                                         >> 0x1fU)))) 
                                     << 0xcU) | (QData)((IData)(
                                                                (vlSelf->inst 
                                                                 >> 0x14U))))),64);
        tracep->fullQData(oldp+88,((vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                    [vlSelf->top__DOT__rs1] 
                                    + ((0x13U == (0x7fU 
                                                  & vlSelf->inst))
                                        ? ((- (QData)((IData)(
                                                              (0x13U 
                                                               == 
                                                               (0x7fU 
                                                                & vlSelf->inst))))) 
                                           & (((- (QData)((IData)(
                                                                  (vlSelf->inst 
                                                                   >> 0x1fU)))) 
                                               << 0xcU) 
                                              | (QData)((IData)(
                                                                (vlSelf->inst 
                                                                 >> 0x14U)))))
                                        : vlSelf->top__DOT__u_RegisterFile__DOT__rf
                                       [vlSelf->top__DOT__rs2]))),64);
        tracep->fullQData(oldp+90,((4ULL + vlSelf->pc)),64);
        tracep->fullCData(oldp+92,(vlSelf->top__DOT__rd),5);
        tracep->fullCData(oldp+93,(vlSelf->top__DOT__rs1),5);
        tracep->fullCData(oldp+94,(vlSelf->top__DOT__rs2),5);
        tracep->fullBit(oldp+95,(1U));
        tracep->fullQData(oldp+96,(vlSelf->top__DOT__current_pc),64);
        tracep->fullIData(oldp+98,(0x20U),32);
        tracep->fullIData(oldp+99,(0x40U),32);
        tracep->fullIData(oldp+100,(vlSelf->top__DOT__rd),32);
        tracep->fullIData(oldp+101,(vlSelf->top__DOT__rs1),32);
        tracep->fullIData(oldp+102,(vlSelf->top__DOT__rs2),32);
        tracep->fullQData(oldp+103,(0x80000000ULL),64);
    }
}
