circuit Top :
  module pc :
    input clock : Clock
    input reset : UInt<1>
    input io_addr : UInt<32>
    output io_pc_out : UInt<32>
    output io_pc_out4 : UInt<32>

    reg reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg) @[pc.scala 12:22]
    node _T = add(reg, UInt<3>("h4")) @[pc.scala 15:21]
    node _T_1 = tail(_T, 1) @[pc.scala 15:21]
    io_pc_out <= reg @[pc.scala 14:14]
    io_pc_out4 <= _T_1 @[pc.scala 15:15]
    reg <= mux(reset, UInt<32>("h0"), io_addr) @[pc.scala 12:22 pc.scala 12:22 pc.scala 13:8]

  module alucontrol :
    input clock : Clock
    input reset : UInt<1>
    input io_alu : UInt<3>
    input io_f3 : UInt<3>
    input io_f7 : UInt<1>
    output io_alucontrolout : UInt<5>

    node _T = eq(io_alu, UInt<1>("h1")) @[ALU_CONTROL.scala 14:16]
    node hi = bits(io_alu, 2, 1) @[ALU_CONTROL.scala 15:37]
    node _T_1 = cat(hi, io_f3) @[Cat.scala 30:58]
    node _T_2 = eq(io_alu, UInt<1>("h0")) @[ALU_CONTROL.scala 16:22]
    node hi_hi = bits(io_alu, 1, 1) @[ALU_CONTROL.scala 17:37]
    node hi_1 = cat(hi_hi, io_f7) @[Cat.scala 30:58]
    node _T_3 = cat(hi_1, io_f3) @[Cat.scala 30:58]
    node _T_4 = eq(io_alu, UInt<2>("h2")) @[ALU_CONTROL.scala 18:22]
    node hi_2 = bits(io_alu, 1, 0) @[ALU_CONTROL.scala 19:37]
    node _T_5 = cat(hi_2, io_f3) @[Cat.scala 30:58]
    node _T_6 = eq(io_alu, UInt<3>("h5")) @[ALU_CONTROL.scala 20:22]
    node _T_7 = mux(UInt<1>("h0"), UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 72:12]
    node _T_8 = eq(io_alu, UInt<2>("h3")) @[ALU_CONTROL.scala 22:22]
    node _T_9 = mux(UInt<1>("h1"), UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 72:12]
    node _T_10 = eq(io_alu, UInt<3>("h6")) @[ALU_CONTROL.scala 24:22]
    node _T_11 = mux(UInt<1>("h0"), UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 72:12]
    node _GEN_0 = mux(_T_10, _T_11, UInt<1>("h0")) @[ALU_CONTROL.scala 24:34 ALU_CONTROL.scala 25:25 ALU_CONTROL.scala 13:21]
    node _GEN_1 = mux(_T_8, _T_9, _GEN_0) @[ALU_CONTROL.scala 22:34 ALU_CONTROL.scala 23:25]
    node _GEN_2 = mux(_T_6, _T_7, _GEN_1) @[ALU_CONTROL.scala 20:34 ALU_CONTROL.scala 21:25]
    node _GEN_3 = mux(_T_4, _T_5, _GEN_2) @[ALU_CONTROL.scala 18:34 ALU_CONTROL.scala 19:25]
    node _GEN_4 = mux(_T_2, _T_3, _GEN_3) @[ALU_CONTROL.scala 16:34 ALU_CONTROL.scala 17:25]
    node _GEN_5 = mux(_T, _T_1, _GEN_4) @[ALU_CONTROL.scala 14:28 ALU_CONTROL.scala 15:25]
    io_alucontrolout <= _GEN_5

  module ALU :
    input clock : Clock
    input reset : UInt<1>
    input io_in_A : UInt<32>
    input io_in_B : UInt<32>
    input io_alu_Op : UInt<5>
    output io_out : UInt<32>

    node _T = eq(UInt<1>("h0"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_1 = add(io_in_A, io_in_B) @[alu.scala 18:29]
    node _T_2 = tail(_T_1, 1) @[alu.scala 18:29]
    node _T_3 = eq(UInt<4>("h8"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_4 = sub(io_in_A, io_in_B) @[alu.scala 20:29]
    node _T_5 = tail(_T_4, 1) @[alu.scala 20:29]
    node _T_6 = eq(UInt<3>("h4"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_7 = xor(io_in_A, io_in_B) @[alu.scala 22:30]
    node _T_8 = eq(UInt<3>("h6"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_9 = or(io_in_A, io_in_B) @[alu.scala 24:28]
    node _T_10 = eq(UInt<3>("h7"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_11 = and(io_in_A, io_in_B) @[alu.scala 26:29]
    node _T_12 = eq(UInt<5>("h1f"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_13 = eq(UInt<1>("h1"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_14 = bits(io_in_B, 4, 0) @[alu.scala 30:37]
    node _T_15 = dshl(io_in_A, _T_14) @[alu.scala 30:28]
    node _T_16 = eq(UInt<3>("h5"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_17 = bits(io_in_B, 4, 0) @[alu.scala 32:37]
    node _T_18 = dshr(io_in_A, _T_17) @[alu.scala 32:28]
    node _T_19 = eq(UInt<2>("h2"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_20 = lt(io_in_A, io_in_B) @[alu.scala 34:26]
    node _GEN_0 = mux(_T_20, UInt<1>("h1"), UInt<1>("h0")) @[alu.scala 34:36 alu.scala 35:23 alu.scala 37:23]
    node _GEN_1 = mux(_T_19, _GEN_0, UInt<1>("h0")) @[Conditional.scala 39:67 alu.scala 14:11]
    node _GEN_2 = mux(_T_16, _T_18, _GEN_1) @[Conditional.scala 39:67 alu.scala 32:19]
    node _GEN_3 = mux(_T_13, _T_15, _GEN_2) @[Conditional.scala 39:67 alu.scala 30:19]
    node _GEN_4 = mux(_T_12, io_in_A, _GEN_3) @[Conditional.scala 39:67 alu.scala 28:19]
    node _GEN_5 = mux(_T_10, _T_11, _GEN_4) @[Conditional.scala 39:67 alu.scala 26:19]
    node _GEN_6 = mux(_T_8, _T_9, _GEN_5) @[Conditional.scala 39:67 alu.scala 24:19]
    node _GEN_7 = mux(_T_6, _T_7, _GEN_6) @[Conditional.scala 39:67 alu.scala 22:20]
    node _GEN_8 = mux(_T_3, _T_5, _GEN_7) @[Conditional.scala 39:67 alu.scala 20:19]
    node _GEN_9 = mux(_T, _T_2, _GEN_8) @[Conditional.scala 40:58 alu.scala 18:19]
    io_out <= bits(_GEN_9, 31, 0)

  module controller :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<7>
    output io_memwrite : UInt<1>
    output io_branch : UInt<1>
    output io_memread : UInt<1>
    output io_regwrite : UInt<1>
    output io_memtoreg : UInt<1>
    output io_aluop : UInt<3>
    output io_opA : UInt<4>
    output io_opB : UInt<2>
    output io_extendsel : UInt<4>
    output io_nextpcsel : UInt<4>

    node _T = eq(UInt<5>("h13"), io_in) @[Conditional.scala 37:30]
    node _T_1 = eq(UInt<6>("h33"), io_in) @[Conditional.scala 37:30]
    node _T_2 = eq(UInt<6>("h23"), io_in) @[Conditional.scala 37:30]
    node _T_3 = eq(UInt<2>("h3"), io_in) @[Conditional.scala 37:30]
    node _T_4 = eq(UInt<7>("h63"), io_in) @[Conditional.scala 37:30]
    node _T_5 = eq(UInt<7>("h6f"), io_in) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<7>("h67"), io_in) @[Conditional.scala 37:30]
    node _T_7 = eq(UInt<6>("h37"), io_in) @[Conditional.scala 37:30]
    node _GEN_0 = mux(_T_7, UInt<1>("h0"), UInt<1>("h0")) @[Conditional.scala 39:67 controller.scala 118:26 controller.scala 20:18]
    node _GEN_1 = mux(_T_7, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 39:67 controller.scala 121:26 controller.scala 23:17]
    node _GEN_2 = mux(_T_7, UInt<3>("h6"), UInt<1>("h0")) @[Conditional.scala 39:67 controller.scala 123:22 controller.scala 25:13]
    node _GEN_3 = mux(_T_7, UInt<2>("h3"), UInt<1>("h0")) @[Conditional.scala 39:67 controller.scala 124:21 controller.scala 26:12]
    node _GEN_4 = mux(_T_7, UInt<2>("h2"), UInt<1>("h0")) @[Conditional.scala 39:67 controller.scala 126:27 controller.scala 28:18]
    node _GEN_5 = mux(_T_6, UInt<1>("h0"), _GEN_0) @[Conditional.scala 39:67 controller.scala 106:26]
    node _GEN_6 = mux(_T_6, UInt<1>("h1"), _GEN_1) @[Conditional.scala 39:67 controller.scala 109:26]
    node _GEN_7 = mux(_T_6, UInt<2>("h3"), _GEN_2) @[Conditional.scala 39:67 controller.scala 111:22]
    node _GEN_8 = mux(_T_6, UInt<2>("h2"), _GEN_3) @[Conditional.scala 39:67 controller.scala 112:21]
    node _GEN_9 = mux(_T_6, UInt<1>("h0"), _GEN_1) @[Conditional.scala 39:67 controller.scala 113:21]
    node _GEN_10 = mux(_T_6, UInt<1>("h0"), _GEN_4) @[Conditional.scala 39:67 controller.scala 114:27]
    node _GEN_11 = mux(_T_6, UInt<2>("h3"), _GEN_0) @[Conditional.scala 39:67 controller.scala 115:27]
    node _GEN_12 = mux(_T_5, UInt<1>("h0"), _GEN_5) @[Conditional.scala 39:67 controller.scala 94:26]
    node _GEN_13 = mux(_T_5, UInt<1>("h1"), _GEN_6) @[Conditional.scala 39:67 controller.scala 97:26]
    node _GEN_14 = mux(_T_5, UInt<2>("h3"), _GEN_7) @[Conditional.scala 39:67 controller.scala 99:22]
    node _GEN_15 = mux(_T_5, UInt<2>("h2"), _GEN_8) @[Conditional.scala 39:67 controller.scala 100:21]
    node _GEN_16 = mux(_T_5, UInt<1>("h0"), _GEN_9) @[Conditional.scala 39:67 controller.scala 101:21]
    node _GEN_17 = mux(_T_5, UInt<1>("h0"), _GEN_10) @[Conditional.scala 39:67 controller.scala 102:27]
    node _GEN_18 = mux(_T_5, UInt<2>("h2"), _GEN_11) @[Conditional.scala 39:67 controller.scala 103:27]
    node _GEN_19 = mux(_T_4, UInt<1>("h0"), _GEN_12) @[Conditional.scala 39:67 controller.scala 82:26]
    node _GEN_20 = mux(_T_4, UInt<1>("h1"), _GEN_12) @[Conditional.scala 39:67 controller.scala 83:23]
    node _GEN_21 = mux(_T_4, UInt<1>("h0"), _GEN_13) @[Conditional.scala 39:67 controller.scala 85:26]
    node _GEN_22 = mux(_T_4, UInt<2>("h2"), _GEN_14) @[Conditional.scala 39:67 controller.scala 87:22]
    node _GEN_23 = mux(_T_4, UInt<1>("h0"), _GEN_15) @[Conditional.scala 39:67 controller.scala 88:21]
    node _GEN_24 = mux(_T_4, UInt<1>("h0"), _GEN_16) @[Conditional.scala 39:67 controller.scala 89:21]
    node _GEN_25 = mux(_T_4, UInt<1>("h0"), _GEN_17) @[Conditional.scala 39:67 controller.scala 90:27]
    node _GEN_26 = mux(_T_4, UInt<1>("h1"), _GEN_18) @[Conditional.scala 39:67 controller.scala 91:27]
    node _GEN_27 = mux(_T_3, UInt<1>("h0"), _GEN_19) @[Conditional.scala 39:67 controller.scala 70:26]
    node _GEN_28 = mux(_T_3, UInt<1>("h0"), _GEN_20) @[Conditional.scala 39:67 controller.scala 71:22]
    node _GEN_29 = mux(_T_3, UInt<1>("h1"), _GEN_19) @[Conditional.scala 39:67 controller.scala 72:23]
    node _GEN_30 = mux(_T_3, UInt<1>("h1"), _GEN_21) @[Conditional.scala 39:67 controller.scala 73:25]
    node _GEN_31 = mux(_T_3, UInt<2>("h3"), _GEN_22) @[Conditional.scala 39:67 controller.scala 75:21]
    node _GEN_32 = mux(_T_3, UInt<1>("h0"), _GEN_23) @[Conditional.scala 39:67 controller.scala 76:20]
    node _GEN_33 = mux(_T_3, UInt<1>("h1"), _GEN_24) @[Conditional.scala 39:67 controller.scala 77:20]
    node _GEN_34 = mux(_T_3, UInt<1>("h0"), _GEN_25) @[Conditional.scala 39:67 controller.scala 78:26]
    node _GEN_35 = mux(_T_3, UInt<1>("h0"), _GEN_26) @[Conditional.scala 39:67 controller.scala 79:26]
    node _GEN_36 = mux(_T_2, UInt<1>("h1"), _GEN_27) @[Conditional.scala 39:67 controller.scala 58:25]
    node _GEN_37 = mux(_T_2, UInt<1>("h0"), _GEN_28) @[Conditional.scala 39:67 controller.scala 59:22]
    node _GEN_38 = mux(_T_2, UInt<1>("h0"), _GEN_29) @[Conditional.scala 39:67 controller.scala 60:23]
    node _GEN_39 = mux(_T_2, UInt<1>("h0"), _GEN_30) @[Conditional.scala 39:67 controller.scala 61:25]
    node _GEN_40 = mux(_T_2, UInt<3>("h5"), _GEN_31) @[Conditional.scala 39:67 controller.scala 63:21]
    node _GEN_41 = mux(_T_2, UInt<1>("h0"), _GEN_32) @[Conditional.scala 39:67 controller.scala 64:20]
    node _GEN_42 = mux(_T_2, UInt<1>("h1"), _GEN_33) @[Conditional.scala 39:67 controller.scala 65:20]
    node _GEN_43 = mux(_T_2, UInt<2>("h2"), _GEN_34) @[Conditional.scala 39:67 controller.scala 66:26]
    node _GEN_44 = mux(_T_2, UInt<1>("h0"), _GEN_35) @[Conditional.scala 39:67 controller.scala 67:26]
    node _GEN_45 = mux(_T_1, UInt<1>("h0"), _GEN_36) @[Conditional.scala 39:67 controller.scala 45:26]
    node _GEN_46 = mux(_T_1, UInt<1>("h0"), _GEN_37) @[Conditional.scala 39:67 controller.scala 46:23]
    node _GEN_47 = mux(_T_1, UInt<1>("h0"), _GEN_38) @[Conditional.scala 39:67 controller.scala 47:24]
    node _GEN_48 = mux(_T_1, UInt<1>("h1"), _GEN_39) @[Conditional.scala 39:67 controller.scala 48:26]
    node _GEN_49 = mux(_T_1, UInt<1>("h0"), _GEN_40) @[Conditional.scala 39:67 controller.scala 50:22]
    node _GEN_50 = mux(_T_1, UInt<1>("h0"), _GEN_41) @[Conditional.scala 39:67 controller.scala 51:21]
    node _GEN_51 = mux(_T_1, UInt<1>("h0"), _GEN_42) @[Conditional.scala 39:67 controller.scala 52:21]
    node _GEN_52 = mux(_T_1, UInt<1>("h0"), _GEN_43) @[Conditional.scala 39:67 controller.scala 53:27]
    node _GEN_53 = mux(_T_1, UInt<1>("h0"), _GEN_44) @[Conditional.scala 39:67 controller.scala 54:27]
    node _GEN_54 = mux(_T, UInt<1>("h0"), _GEN_45) @[Conditional.scala 40:58 controller.scala 32:27]
    node _GEN_55 = mux(_T, UInt<1>("h0"), _GEN_46) @[Conditional.scala 40:58 controller.scala 33:23]
    node _GEN_56 = mux(_T, UInt<1>("h0"), _GEN_47) @[Conditional.scala 40:58 controller.scala 34:24]
    node _GEN_57 = mux(_T, UInt<1>("h1"), _GEN_48) @[Conditional.scala 40:58 controller.scala 35:26]
    node _GEN_58 = mux(_T, UInt<1>("h1"), _GEN_49) @[Conditional.scala 40:58 controller.scala 37:22]
    node _GEN_59 = mux(_T, UInt<1>("h0"), _GEN_50) @[Conditional.scala 40:58 controller.scala 38:21]
    node _GEN_60 = mux(_T, UInt<1>("h1"), _GEN_51) @[Conditional.scala 40:58 controller.scala 39:21]
    node _GEN_61 = mux(_T, UInt<1>("h0"), _GEN_52) @[Conditional.scala 40:58 controller.scala 40:27]
    node _GEN_62 = mux(_T, UInt<1>("h0"), _GEN_53) @[Conditional.scala 40:58 controller.scala 41:27]
    io_memwrite <= _GEN_54
    io_branch <= _GEN_55
    io_memread <= _GEN_56
    io_regwrite <= _GEN_57
    io_memtoreg <= _GEN_56
    io_aluop <= _GEN_58
    io_opA <= _GEN_59
    io_opB <= _GEN_60
    io_extendsel <= _GEN_61
    io_nextpcsel <= _GEN_62

  module imem :
    input clock : Clock
    input reset : UInt<1>
    input io_address : UInt<32>
    output io_readdata : UInt<32>

    mem memory : @[imem.scala 13:19]
      data-type => UInt<32>
      depth => 32
      read-latency => 0
      write-latency => 1
      reader => MPORT
      read-under-write => undefined
    node _T = bits(io_address, 4, 0) @[imem.scala 14:25]
    io_readdata <= memory.MPORT.data @[imem.scala 14:17]
    memory.MPORT.addr <= _T @[imem.scala 14:25]
    memory.MPORT.en <= UInt<1>("h1") @[imem.scala 14:25]
    memory.MPORT.clk <= clock @[imem.scala 14:25]

  module immediate :
    input clock : Clock
    input reset : UInt<1>
    input io_instr : UInt<32>
    output io_iimmd_se : SInt<32>
    output io_simmd_se : SInt<32>
    output io_sbimmd_se : SInt<32>
    output io_uimmd_se : SInt<32>
    output io_ujimmd_se : SInt<32>
    input io_pc : UInt<32>

    node opcodes = bits(io_instr, 6, 0) @[immediate.scala 16:26]
    node _T = bits(io_instr, 31, 31) @[immediate.scala 23:39]
    node _T_1 = bits(_T, 0, 0) @[Bitwise.scala 72:15]
    node hi = mux(_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 72:12]
    node lo = bits(io_instr, 31, 20) @[immediate.scala 23:53]
    node _T_2 = cat(hi, lo) @[Cat.scala 30:58]
    node _T_3 = asSInt(_T_2) @[immediate.scala 23:63]
    node _T_4 = bits(io_instr, 31, 31) @[immediate.scala 25:39]
    node _T_5 = bits(_T_4, 0, 0) @[Bitwise.scala 72:15]
    node hi_hi = mux(_T_5, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 72:12]
    node hi_lo = bits(io_instr, 31, 25) @[immediate.scala 25:53]
    node lo_1 = bits(io_instr, 11, 7) @[immediate.scala 25:69]
    node hi_1 = cat(hi_hi, hi_lo) @[Cat.scala 30:58]
    node _T_6 = cat(hi_1, lo_1) @[Cat.scala 30:58]
    node _T_7 = asSInt(_T_6) @[immediate.scala 25:78]
    node _T_8 = bits(io_instr, 31, 31) @[immediate.scala 27:40]
    node _T_9 = bits(_T_8, 0, 0) @[Bitwise.scala 72:15]
    node hi_hi_hi = mux(_T_9, UInt<19>("h7ffff"), UInt<19>("h0")) @[Bitwise.scala 72:12]
    node hi_hi_lo = bits(io_instr, 31, 31) @[immediate.scala 27:54]
    node hi_lo_1 = bits(io_instr, 7, 7) @[immediate.scala 27:67]
    node lo_hi_hi = bits(io_instr, 30, 25) @[immediate.scala 27:79]
    node lo_hi_lo = bits(io_instr, 11, 8) @[immediate.scala 27:95]
    node lo_hi = cat(lo_hi_hi, lo_hi_lo) @[Cat.scala 30:58]
    node lo_2 = cat(lo_hi, UInt<1>("h0")) @[Cat.scala 30:58]
    node hi_hi_1 = cat(hi_hi_hi, hi_hi_lo) @[Cat.scala 30:58]
    node hi_2 = cat(hi_hi_1, hi_lo_1) @[Cat.scala 30:58]
    node _T_10 = cat(hi_2, lo_2) @[Cat.scala 30:58]
    node _T_11 = add(_T_10, io_pc) @[immediate.scala 27:111]
    node _T_12 = tail(_T_11, 1) @[immediate.scala 27:111]
    node _T_13 = asSInt(_T_12) @[immediate.scala 27:120]
    node _T_14 = bits(io_instr, 31, 31) @[immediate.scala 29:40]
    node _T_15 = bits(_T_14, 0, 0) @[Bitwise.scala 72:15]
    node hi_3 = mux(_T_15, UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 72:12]
    node lo_3 = bits(io_instr, 31, 12) @[immediate.scala 29:54]
    node _T_16 = cat(hi_3, lo_3) @[Cat.scala 30:58]
    node _T_17 = shl(_T_16, 12) @[immediate.scala 29:63]
    node _T_18 = asSInt(_T_17) @[immediate.scala 29:69]
    node _T_19 = bits(io_instr, 31, 31) @[immediate.scala 31:40]
    node _T_20 = bits(_T_19, 0, 0) @[Bitwise.scala 72:15]
    node hi_hi_hi_1 = mux(_T_20, UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 72:12]
    node hi_hi_lo_1 = bits(io_instr, 31, 31) @[immediate.scala 31:54]
    node hi_lo_2 = bits(io_instr, 19, 12) @[immediate.scala 31:67]
    node lo_hi_hi_1 = bits(io_instr, 20, 20) @[immediate.scala 31:83]
    node lo_hi_lo_1 = bits(io_instr, 31, 21) @[immediate.scala 31:96]
    node lo_hi_1 = cat(lo_hi_hi_1, lo_hi_lo_1) @[Cat.scala 30:58]
    node lo_4 = cat(lo_hi_1, UInt<1>("h0")) @[Cat.scala 30:58]
    node hi_hi_2 = cat(hi_hi_hi_1, hi_hi_lo_1) @[Cat.scala 30:58]
    node hi_4 = cat(hi_hi_2, hi_lo_2) @[Cat.scala 30:58]
    node _T_21 = cat(hi_4, lo_4) @[Cat.scala 30:58]
    node _T_22 = add(_T_21, io_pc) @[immediate.scala 31:112]
    node _T_23 = tail(_T_22, 1) @[immediate.scala 31:112]
    node _T_24 = asSInt(_T_23) @[immediate.scala 31:120]
    io_iimmd_se <= _T_3 @[immediate.scala 23:16]
    io_simmd_se <= _T_7 @[immediate.scala 25:16]
    io_sbimmd_se <= _T_13 @[immediate.scala 27:17]
    io_uimmd_se <= asSInt(bits(_T_18, 31, 0)) @[immediate.scala 29:16]
    io_ujimmd_se <= asSInt(bits(_T_24, 31, 0)) @[immediate.scala 31:17]

  module JALR :
    input clock : Clock
    input reset : UInt<1>
    input io_addr : UInt<32>
    input io_pc : UInt<32>
    output io_out : UInt<32>

    node _T = add(io_pc, io_addr) @[JALR.scala 12:22]
    node _T_1 = tail(_T, 1) @[JALR.scala 12:22]
    node _T_2 = and(_T_1, UInt<28>("hfffffff")) @[JALR.scala 12:33]
    io_out <= _T_2 @[JALR.scala 12:12]

  module register :
    input clock : Clock
    input reset : UInt<1>
    input io_regwrite : UInt<1>
    input io_writereg : UInt<5>
    input io_rs1 : UInt<5>
    input io_rs2 : UInt<5>
    input io_writedata : SInt<32>
    output io_rd1 : SInt<32>
    output io_rd2 : SInt<32>

    reg register_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_0) @[register.scala 15:27]
    reg register_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_1) @[register.scala 15:27]
    reg register_2 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_2) @[register.scala 15:27]
    reg register_3 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_3) @[register.scala 15:27]
    reg register_4 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_4) @[register.scala 15:27]
    reg register_5 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_5) @[register.scala 15:27]
    reg register_6 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_6) @[register.scala 15:27]
    reg register_7 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_7) @[register.scala 15:27]
    reg register_8 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_8) @[register.scala 15:27]
    reg register_9 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_9) @[register.scala 15:27]
    reg register_10 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_10) @[register.scala 15:27]
    reg register_11 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_11) @[register.scala 15:27]
    reg register_12 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_12) @[register.scala 15:27]
    reg register_13 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_13) @[register.scala 15:27]
    reg register_14 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_14) @[register.scala 15:27]
    reg register_15 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_15) @[register.scala 15:27]
    reg register_16 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_16) @[register.scala 15:27]
    reg register_17 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_17) @[register.scala 15:27]
    reg register_18 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_18) @[register.scala 15:27]
    reg register_19 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_19) @[register.scala 15:27]
    reg register_20 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_20) @[register.scala 15:27]
    reg register_21 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_21) @[register.scala 15:27]
    reg register_22 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_22) @[register.scala 15:27]
    reg register_23 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_23) @[register.scala 15:27]
    reg register_24 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_24) @[register.scala 15:27]
    reg register_25 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_25) @[register.scala 15:27]
    reg register_26 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_26) @[register.scala 15:27]
    reg register_27 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_27) @[register.scala 15:27]
    reg register_28 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_28) @[register.scala 15:27]
    reg register_29 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_29) @[register.scala 15:27]
    reg register_30 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_30) @[register.scala 15:27]
    reg register_31 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_31) @[register.scala 15:27]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_rs1), register_0) @[register.scala 17:12 register.scala 17:12]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_rs1), register_1, _GEN_0) @[register.scala 17:12 register.scala 17:12]
    node _GEN_2 = mux(eq(UInt<2>("h2"), io_rs1), register_2, _GEN_1) @[register.scala 17:12 register.scala 17:12]
    node _GEN_3 = mux(eq(UInt<2>("h3"), io_rs1), register_3, _GEN_2) @[register.scala 17:12 register.scala 17:12]
    node _GEN_4 = mux(eq(UInt<3>("h4"), io_rs1), register_4, _GEN_3) @[register.scala 17:12 register.scala 17:12]
    node _GEN_5 = mux(eq(UInt<3>("h5"), io_rs1), register_5, _GEN_4) @[register.scala 17:12 register.scala 17:12]
    node _GEN_6 = mux(eq(UInt<3>("h6"), io_rs1), register_6, _GEN_5) @[register.scala 17:12 register.scala 17:12]
    node _GEN_7 = mux(eq(UInt<3>("h7"), io_rs1), register_7, _GEN_6) @[register.scala 17:12 register.scala 17:12]
    node _GEN_8 = mux(eq(UInt<4>("h8"), io_rs1), register_8, _GEN_7) @[register.scala 17:12 register.scala 17:12]
    node _GEN_9 = mux(eq(UInt<4>("h9"), io_rs1), register_9, _GEN_8) @[register.scala 17:12 register.scala 17:12]
    node _GEN_10 = mux(eq(UInt<4>("ha"), io_rs1), register_10, _GEN_9) @[register.scala 17:12 register.scala 17:12]
    node _GEN_11 = mux(eq(UInt<4>("hb"), io_rs1), register_11, _GEN_10) @[register.scala 17:12 register.scala 17:12]
    node _GEN_12 = mux(eq(UInt<4>("hc"), io_rs1), register_12, _GEN_11) @[register.scala 17:12 register.scala 17:12]
    node _GEN_13 = mux(eq(UInt<4>("hd"), io_rs1), register_13, _GEN_12) @[register.scala 17:12 register.scala 17:12]
    node _GEN_14 = mux(eq(UInt<4>("he"), io_rs1), register_14, _GEN_13) @[register.scala 17:12 register.scala 17:12]
    node _GEN_15 = mux(eq(UInt<4>("hf"), io_rs1), register_15, _GEN_14) @[register.scala 17:12 register.scala 17:12]
    node _GEN_16 = mux(eq(UInt<5>("h10"), io_rs1), register_16, _GEN_15) @[register.scala 17:12 register.scala 17:12]
    node _GEN_17 = mux(eq(UInt<5>("h11"), io_rs1), register_17, _GEN_16) @[register.scala 17:12 register.scala 17:12]
    node _GEN_18 = mux(eq(UInt<5>("h12"), io_rs1), register_18, _GEN_17) @[register.scala 17:12 register.scala 17:12]
    node _GEN_19 = mux(eq(UInt<5>("h13"), io_rs1), register_19, _GEN_18) @[register.scala 17:12 register.scala 17:12]
    node _GEN_20 = mux(eq(UInt<5>("h14"), io_rs1), register_20, _GEN_19) @[register.scala 17:12 register.scala 17:12]
    node _GEN_21 = mux(eq(UInt<5>("h15"), io_rs1), register_21, _GEN_20) @[register.scala 17:12 register.scala 17:12]
    node _GEN_22 = mux(eq(UInt<5>("h16"), io_rs1), register_22, _GEN_21) @[register.scala 17:12 register.scala 17:12]
    node _GEN_23 = mux(eq(UInt<5>("h17"), io_rs1), register_23, _GEN_22) @[register.scala 17:12 register.scala 17:12]
    node _GEN_24 = mux(eq(UInt<5>("h18"), io_rs1), register_24, _GEN_23) @[register.scala 17:12 register.scala 17:12]
    node _GEN_25 = mux(eq(UInt<5>("h19"), io_rs1), register_25, _GEN_24) @[register.scala 17:12 register.scala 17:12]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), io_rs1), register_26, _GEN_25) @[register.scala 17:12 register.scala 17:12]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), io_rs1), register_27, _GEN_26) @[register.scala 17:12 register.scala 17:12]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), io_rs1), register_28, _GEN_27) @[register.scala 17:12 register.scala 17:12]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), io_rs1), register_29, _GEN_28) @[register.scala 17:12 register.scala 17:12]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), io_rs1), register_30, _GEN_29) @[register.scala 17:12 register.scala 17:12]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), io_rs1), register_31, _GEN_30) @[register.scala 17:12 register.scala 17:12]
    node _GEN_32 = validif(eq(UInt<1>("h0"), io_rs2), register_0) @[register.scala 18:12 register.scala 18:12]
    node _GEN_33 = mux(eq(UInt<1>("h1"), io_rs2), register_1, _GEN_32) @[register.scala 18:12 register.scala 18:12]
    node _GEN_34 = mux(eq(UInt<2>("h2"), io_rs2), register_2, _GEN_33) @[register.scala 18:12 register.scala 18:12]
    node _GEN_35 = mux(eq(UInt<2>("h3"), io_rs2), register_3, _GEN_34) @[register.scala 18:12 register.scala 18:12]
    node _GEN_36 = mux(eq(UInt<3>("h4"), io_rs2), register_4, _GEN_35) @[register.scala 18:12 register.scala 18:12]
    node _GEN_37 = mux(eq(UInt<3>("h5"), io_rs2), register_5, _GEN_36) @[register.scala 18:12 register.scala 18:12]
    node _GEN_38 = mux(eq(UInt<3>("h6"), io_rs2), register_6, _GEN_37) @[register.scala 18:12 register.scala 18:12]
    node _GEN_39 = mux(eq(UInt<3>("h7"), io_rs2), register_7, _GEN_38) @[register.scala 18:12 register.scala 18:12]
    node _GEN_40 = mux(eq(UInt<4>("h8"), io_rs2), register_8, _GEN_39) @[register.scala 18:12 register.scala 18:12]
    node _GEN_41 = mux(eq(UInt<4>("h9"), io_rs2), register_9, _GEN_40) @[register.scala 18:12 register.scala 18:12]
    node _GEN_42 = mux(eq(UInt<4>("ha"), io_rs2), register_10, _GEN_41) @[register.scala 18:12 register.scala 18:12]
    node _GEN_43 = mux(eq(UInt<4>("hb"), io_rs2), register_11, _GEN_42) @[register.scala 18:12 register.scala 18:12]
    node _GEN_44 = mux(eq(UInt<4>("hc"), io_rs2), register_12, _GEN_43) @[register.scala 18:12 register.scala 18:12]
    node _GEN_45 = mux(eq(UInt<4>("hd"), io_rs2), register_13, _GEN_44) @[register.scala 18:12 register.scala 18:12]
    node _GEN_46 = mux(eq(UInt<4>("he"), io_rs2), register_14, _GEN_45) @[register.scala 18:12 register.scala 18:12]
    node _GEN_47 = mux(eq(UInt<4>("hf"), io_rs2), register_15, _GEN_46) @[register.scala 18:12 register.scala 18:12]
    node _GEN_48 = mux(eq(UInt<5>("h10"), io_rs2), register_16, _GEN_47) @[register.scala 18:12 register.scala 18:12]
    node _GEN_49 = mux(eq(UInt<5>("h11"), io_rs2), register_17, _GEN_48) @[register.scala 18:12 register.scala 18:12]
    node _GEN_50 = mux(eq(UInt<5>("h12"), io_rs2), register_18, _GEN_49) @[register.scala 18:12 register.scala 18:12]
    node _GEN_51 = mux(eq(UInt<5>("h13"), io_rs2), register_19, _GEN_50) @[register.scala 18:12 register.scala 18:12]
    node _GEN_52 = mux(eq(UInt<5>("h14"), io_rs2), register_20, _GEN_51) @[register.scala 18:12 register.scala 18:12]
    node _GEN_53 = mux(eq(UInt<5>("h15"), io_rs2), register_21, _GEN_52) @[register.scala 18:12 register.scala 18:12]
    node _GEN_54 = mux(eq(UInt<5>("h16"), io_rs2), register_22, _GEN_53) @[register.scala 18:12 register.scala 18:12]
    node _GEN_55 = mux(eq(UInt<5>("h17"), io_rs2), register_23, _GEN_54) @[register.scala 18:12 register.scala 18:12]
    node _GEN_56 = mux(eq(UInt<5>("h18"), io_rs2), register_24, _GEN_55) @[register.scala 18:12 register.scala 18:12]
    node _GEN_57 = mux(eq(UInt<5>("h19"), io_rs2), register_25, _GEN_56) @[register.scala 18:12 register.scala 18:12]
    node _GEN_58 = mux(eq(UInt<5>("h1a"), io_rs2), register_26, _GEN_57) @[register.scala 18:12 register.scala 18:12]
    node _GEN_59 = mux(eq(UInt<5>("h1b"), io_rs2), register_27, _GEN_58) @[register.scala 18:12 register.scala 18:12]
    node _GEN_60 = mux(eq(UInt<5>("h1c"), io_rs2), register_28, _GEN_59) @[register.scala 18:12 register.scala 18:12]
    node _GEN_61 = mux(eq(UInt<5>("h1d"), io_rs2), register_29, _GEN_60) @[register.scala 18:12 register.scala 18:12]
    node _GEN_62 = mux(eq(UInt<5>("h1e"), io_rs2), register_30, _GEN_61) @[register.scala 18:12 register.scala 18:12]
    node _GEN_63 = mux(eq(UInt<5>("h1f"), io_rs2), register_31, _GEN_62) @[register.scala 18:12 register.scala 18:12]
    node _T = eq(io_regwrite, UInt<1>("h1")) @[register.scala 19:22]
    node _T_1 = eq(io_writereg, UInt<1>("h0")) @[register.scala 20:26]
    node _register_io_writereg = pad(asSInt(UInt<1>("h0")), 32) @[register.scala 21:35 register.scala 21:35]
    node _GEN_64 = mux(eq(UInt<1>("h0"), io_writereg), _register_io_writereg, asSInt(UInt<1>("h0"))) @[register.scala 21:35 register.scala 21:35 register.scala 16:16]
    node _GEN_65 = mux(eq(UInt<1>("h1"), io_writereg), _register_io_writereg, register_1) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_66 = mux(eq(UInt<2>("h2"), io_writereg), _register_io_writereg, register_2) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_67 = mux(eq(UInt<2>("h3"), io_writereg), _register_io_writereg, register_3) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_68 = mux(eq(UInt<3>("h4"), io_writereg), _register_io_writereg, register_4) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_69 = mux(eq(UInt<3>("h5"), io_writereg), _register_io_writereg, register_5) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_70 = mux(eq(UInt<3>("h6"), io_writereg), _register_io_writereg, register_6) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_71 = mux(eq(UInt<3>("h7"), io_writereg), _register_io_writereg, register_7) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_72 = mux(eq(UInt<4>("h8"), io_writereg), _register_io_writereg, register_8) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_73 = mux(eq(UInt<4>("h9"), io_writereg), _register_io_writereg, register_9) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_74 = mux(eq(UInt<4>("ha"), io_writereg), _register_io_writereg, register_10) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_75 = mux(eq(UInt<4>("hb"), io_writereg), _register_io_writereg, register_11) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_76 = mux(eq(UInt<4>("hc"), io_writereg), _register_io_writereg, register_12) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_77 = mux(eq(UInt<4>("hd"), io_writereg), _register_io_writereg, register_13) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_78 = mux(eq(UInt<4>("he"), io_writereg), _register_io_writereg, register_14) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_79 = mux(eq(UInt<4>("hf"), io_writereg), _register_io_writereg, register_15) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_80 = mux(eq(UInt<5>("h10"), io_writereg), _register_io_writereg, register_16) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_81 = mux(eq(UInt<5>("h11"), io_writereg), _register_io_writereg, register_17) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_82 = mux(eq(UInt<5>("h12"), io_writereg), _register_io_writereg, register_18) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_83 = mux(eq(UInt<5>("h13"), io_writereg), _register_io_writereg, register_19) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_84 = mux(eq(UInt<5>("h14"), io_writereg), _register_io_writereg, register_20) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_85 = mux(eq(UInt<5>("h15"), io_writereg), _register_io_writereg, register_21) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_86 = mux(eq(UInt<5>("h16"), io_writereg), _register_io_writereg, register_22) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_87 = mux(eq(UInt<5>("h17"), io_writereg), _register_io_writereg, register_23) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_88 = mux(eq(UInt<5>("h18"), io_writereg), _register_io_writereg, register_24) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_89 = mux(eq(UInt<5>("h19"), io_writereg), _register_io_writereg, register_25) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_90 = mux(eq(UInt<5>("h1a"), io_writereg), _register_io_writereg, register_26) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_91 = mux(eq(UInt<5>("h1b"), io_writereg), _register_io_writereg, register_27) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_92 = mux(eq(UInt<5>("h1c"), io_writereg), _register_io_writereg, register_28) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_93 = mux(eq(UInt<5>("h1d"), io_writereg), _register_io_writereg, register_29) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_94 = mux(eq(UInt<5>("h1e"), io_writereg), _register_io_writereg, register_30) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _GEN_95 = mux(eq(UInt<5>("h1f"), io_writereg), _register_io_writereg, register_31) @[register.scala 21:35 register.scala 21:35 register.scala 15:27]
    node _register_io_writereg_0 = io_writedata @[register.scala 23:35 register.scala 23:35]
    node _GEN_96 = mux(eq(UInt<1>("h0"), io_writereg), _register_io_writereg_0, asSInt(UInt<1>("h0"))) @[register.scala 23:35 register.scala 23:35 register.scala 16:16]
    node _GEN_97 = mux(eq(UInt<1>("h1"), io_writereg), _register_io_writereg_0, register_1) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_98 = mux(eq(UInt<2>("h2"), io_writereg), _register_io_writereg_0, register_2) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_99 = mux(eq(UInt<2>("h3"), io_writereg), _register_io_writereg_0, register_3) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_100 = mux(eq(UInt<3>("h4"), io_writereg), _register_io_writereg_0, register_4) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_101 = mux(eq(UInt<3>("h5"), io_writereg), _register_io_writereg_0, register_5) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_102 = mux(eq(UInt<3>("h6"), io_writereg), _register_io_writereg_0, register_6) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_103 = mux(eq(UInt<3>("h7"), io_writereg), _register_io_writereg_0, register_7) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_104 = mux(eq(UInt<4>("h8"), io_writereg), _register_io_writereg_0, register_8) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_105 = mux(eq(UInt<4>("h9"), io_writereg), _register_io_writereg_0, register_9) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_106 = mux(eq(UInt<4>("ha"), io_writereg), _register_io_writereg_0, register_10) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_107 = mux(eq(UInt<4>("hb"), io_writereg), _register_io_writereg_0, register_11) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_108 = mux(eq(UInt<4>("hc"), io_writereg), _register_io_writereg_0, register_12) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_109 = mux(eq(UInt<4>("hd"), io_writereg), _register_io_writereg_0, register_13) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_110 = mux(eq(UInt<4>("he"), io_writereg), _register_io_writereg_0, register_14) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_111 = mux(eq(UInt<4>("hf"), io_writereg), _register_io_writereg_0, register_15) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_112 = mux(eq(UInt<5>("h10"), io_writereg), _register_io_writereg_0, register_16) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_113 = mux(eq(UInt<5>("h11"), io_writereg), _register_io_writereg_0, register_17) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_114 = mux(eq(UInt<5>("h12"), io_writereg), _register_io_writereg_0, register_18) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_115 = mux(eq(UInt<5>("h13"), io_writereg), _register_io_writereg_0, register_19) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_116 = mux(eq(UInt<5>("h14"), io_writereg), _register_io_writereg_0, register_20) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_117 = mux(eq(UInt<5>("h15"), io_writereg), _register_io_writereg_0, register_21) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_118 = mux(eq(UInt<5>("h16"), io_writereg), _register_io_writereg_0, register_22) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_119 = mux(eq(UInt<5>("h17"), io_writereg), _register_io_writereg_0, register_23) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_120 = mux(eq(UInt<5>("h18"), io_writereg), _register_io_writereg_0, register_24) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_121 = mux(eq(UInt<5>("h19"), io_writereg), _register_io_writereg_0, register_25) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_122 = mux(eq(UInt<5>("h1a"), io_writereg), _register_io_writereg_0, register_26) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_123 = mux(eq(UInt<5>("h1b"), io_writereg), _register_io_writereg_0, register_27) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_124 = mux(eq(UInt<5>("h1c"), io_writereg), _register_io_writereg_0, register_28) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_125 = mux(eq(UInt<5>("h1d"), io_writereg), _register_io_writereg_0, register_29) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_126 = mux(eq(UInt<5>("h1e"), io_writereg), _register_io_writereg_0, register_30) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_127 = mux(eq(UInt<5>("h1f"), io_writereg), _register_io_writereg_0, register_31) @[register.scala 23:35 register.scala 23:35 register.scala 15:27]
    node _GEN_128 = mux(_T_1, _GEN_64, _GEN_96) @[register.scala 20:41]
    node _GEN_129 = mux(_T_1, _GEN_65, _GEN_97) @[register.scala 20:41]
    node _GEN_130 = mux(_T_1, _GEN_66, _GEN_98) @[register.scala 20:41]
    node _GEN_131 = mux(_T_1, _GEN_67, _GEN_99) @[register.scala 20:41]
    node _GEN_132 = mux(_T_1, _GEN_68, _GEN_100) @[register.scala 20:41]
    node _GEN_133 = mux(_T_1, _GEN_69, _GEN_101) @[register.scala 20:41]
    node _GEN_134 = mux(_T_1, _GEN_70, _GEN_102) @[register.scala 20:41]
    node _GEN_135 = mux(_T_1, _GEN_71, _GEN_103) @[register.scala 20:41]
    node _GEN_136 = mux(_T_1, _GEN_72, _GEN_104) @[register.scala 20:41]
    node _GEN_137 = mux(_T_1, _GEN_73, _GEN_105) @[register.scala 20:41]
    node _GEN_138 = mux(_T_1, _GEN_74, _GEN_106) @[register.scala 20:41]
    node _GEN_139 = mux(_T_1, _GEN_75, _GEN_107) @[register.scala 20:41]
    node _GEN_140 = mux(_T_1, _GEN_76, _GEN_108) @[register.scala 20:41]
    node _GEN_141 = mux(_T_1, _GEN_77, _GEN_109) @[register.scala 20:41]
    node _GEN_142 = mux(_T_1, _GEN_78, _GEN_110) @[register.scala 20:41]
    node _GEN_143 = mux(_T_1, _GEN_79, _GEN_111) @[register.scala 20:41]
    node _GEN_144 = mux(_T_1, _GEN_80, _GEN_112) @[register.scala 20:41]
    node _GEN_145 = mux(_T_1, _GEN_81, _GEN_113) @[register.scala 20:41]
    node _GEN_146 = mux(_T_1, _GEN_82, _GEN_114) @[register.scala 20:41]
    node _GEN_147 = mux(_T_1, _GEN_83, _GEN_115) @[register.scala 20:41]
    node _GEN_148 = mux(_T_1, _GEN_84, _GEN_116) @[register.scala 20:41]
    node _GEN_149 = mux(_T_1, _GEN_85, _GEN_117) @[register.scala 20:41]
    node _GEN_150 = mux(_T_1, _GEN_86, _GEN_118) @[register.scala 20:41]
    node _GEN_151 = mux(_T_1, _GEN_87, _GEN_119) @[register.scala 20:41]
    node _GEN_152 = mux(_T_1, _GEN_88, _GEN_120) @[register.scala 20:41]
    node _GEN_153 = mux(_T_1, _GEN_89, _GEN_121) @[register.scala 20:41]
    node _GEN_154 = mux(_T_1, _GEN_90, _GEN_122) @[register.scala 20:41]
    node _GEN_155 = mux(_T_1, _GEN_91, _GEN_123) @[register.scala 20:41]
    node _GEN_156 = mux(_T_1, _GEN_92, _GEN_124) @[register.scala 20:41]
    node _GEN_157 = mux(_T_1, _GEN_93, _GEN_125) @[register.scala 20:41]
    node _GEN_158 = mux(_T_1, _GEN_94, _GEN_126) @[register.scala 20:41]
    node _GEN_159 = mux(_T_1, _GEN_95, _GEN_127) @[register.scala 20:41]
    node _GEN_160 = mux(_T, _GEN_128, asSInt(UInt<1>("h0"))) @[register.scala 19:30 register.scala 16:16]
    node _GEN_161 = mux(_T, _GEN_129, register_1) @[register.scala 19:30 register.scala 15:27]
    node _GEN_162 = mux(_T, _GEN_130, register_2) @[register.scala 19:30 register.scala 15:27]
    node _GEN_163 = mux(_T, _GEN_131, register_3) @[register.scala 19:30 register.scala 15:27]
    node _GEN_164 = mux(_T, _GEN_132, register_4) @[register.scala 19:30 register.scala 15:27]
    node _GEN_165 = mux(_T, _GEN_133, register_5) @[register.scala 19:30 register.scala 15:27]
    node _GEN_166 = mux(_T, _GEN_134, register_6) @[register.scala 19:30 register.scala 15:27]
    node _GEN_167 = mux(_T, _GEN_135, register_7) @[register.scala 19:30 register.scala 15:27]
    node _GEN_168 = mux(_T, _GEN_136, register_8) @[register.scala 19:30 register.scala 15:27]
    node _GEN_169 = mux(_T, _GEN_137, register_9) @[register.scala 19:30 register.scala 15:27]
    node _GEN_170 = mux(_T, _GEN_138, register_10) @[register.scala 19:30 register.scala 15:27]
    node _GEN_171 = mux(_T, _GEN_139, register_11) @[register.scala 19:30 register.scala 15:27]
    node _GEN_172 = mux(_T, _GEN_140, register_12) @[register.scala 19:30 register.scala 15:27]
    node _GEN_173 = mux(_T, _GEN_141, register_13) @[register.scala 19:30 register.scala 15:27]
    node _GEN_174 = mux(_T, _GEN_142, register_14) @[register.scala 19:30 register.scala 15:27]
    node _GEN_175 = mux(_T, _GEN_143, register_15) @[register.scala 19:30 register.scala 15:27]
    node _GEN_176 = mux(_T, _GEN_144, register_16) @[register.scala 19:30 register.scala 15:27]
    node _GEN_177 = mux(_T, _GEN_145, register_17) @[register.scala 19:30 register.scala 15:27]
    node _GEN_178 = mux(_T, _GEN_146, register_18) @[register.scala 19:30 register.scala 15:27]
    node _GEN_179 = mux(_T, _GEN_147, register_19) @[register.scala 19:30 register.scala 15:27]
    node _GEN_180 = mux(_T, _GEN_148, register_20) @[register.scala 19:30 register.scala 15:27]
    node _GEN_181 = mux(_T, _GEN_149, register_21) @[register.scala 19:30 register.scala 15:27]
    node _GEN_182 = mux(_T, _GEN_150, register_22) @[register.scala 19:30 register.scala 15:27]
    node _GEN_183 = mux(_T, _GEN_151, register_23) @[register.scala 19:30 register.scala 15:27]
    node _GEN_184 = mux(_T, _GEN_152, register_24) @[register.scala 19:30 register.scala 15:27]
    node _GEN_185 = mux(_T, _GEN_153, register_25) @[register.scala 19:30 register.scala 15:27]
    node _GEN_186 = mux(_T, _GEN_154, register_26) @[register.scala 19:30 register.scala 15:27]
    node _GEN_187 = mux(_T, _GEN_155, register_27) @[register.scala 19:30 register.scala 15:27]
    node _GEN_188 = mux(_T, _GEN_156, register_28) @[register.scala 19:30 register.scala 15:27]
    node _GEN_189 = mux(_T, _GEN_157, register_29) @[register.scala 19:30 register.scala 15:27]
    node _GEN_190 = mux(_T, _GEN_158, register_30) @[register.scala 19:30 register.scala 15:27]
    node _GEN_191 = mux(_T, _GEN_159, register_31) @[register.scala 19:30 register.scala 15:27]
    node _WIRE_0 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_1 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_2 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_3 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_4 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_5 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_6 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_7 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_8 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_9 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_10 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_11 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_12 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_13 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_14 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_15 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_16 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_17 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_18 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_19 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_20 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_21 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_22 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_23 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_24 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_25 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_26 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_27 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_28 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_29 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_30 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _WIRE_31 = asSInt(UInt<32>("h0")) @[register.scala 15:35 register.scala 15:35]
    node _register_io_rs1 = _GEN_31 @[register.scala 17:12]
    node _register_io_rs2 = _GEN_63 @[register.scala 18:12]
    io_rd1 <= _register_io_rs1 @[register.scala 17:12]
    io_rd2 <= _register_io_rs2 @[register.scala 18:12]
    register_0 <= mux(reset, _WIRE_0, _GEN_160) @[register.scala 15:27 register.scala 15:27]
    register_1 <= mux(reset, _WIRE_1, _GEN_161) @[register.scala 15:27 register.scala 15:27]
    register_2 <= mux(reset, _WIRE_2, _GEN_162) @[register.scala 15:27 register.scala 15:27]
    register_3 <= mux(reset, _WIRE_3, _GEN_163) @[register.scala 15:27 register.scala 15:27]
    register_4 <= mux(reset, _WIRE_4, _GEN_164) @[register.scala 15:27 register.scala 15:27]
    register_5 <= mux(reset, _WIRE_5, _GEN_165) @[register.scala 15:27 register.scala 15:27]
    register_6 <= mux(reset, _WIRE_6, _GEN_166) @[register.scala 15:27 register.scala 15:27]
    register_7 <= mux(reset, _WIRE_7, _GEN_167) @[register.scala 15:27 register.scala 15:27]
    register_8 <= mux(reset, _WIRE_8, _GEN_168) @[register.scala 15:27 register.scala 15:27]
    register_9 <= mux(reset, _WIRE_9, _GEN_169) @[register.scala 15:27 register.scala 15:27]
    register_10 <= mux(reset, _WIRE_10, _GEN_170) @[register.scala 15:27 register.scala 15:27]
    register_11 <= mux(reset, _WIRE_11, _GEN_171) @[register.scala 15:27 register.scala 15:27]
    register_12 <= mux(reset, _WIRE_12, _GEN_172) @[register.scala 15:27 register.scala 15:27]
    register_13 <= mux(reset, _WIRE_13, _GEN_173) @[register.scala 15:27 register.scala 15:27]
    register_14 <= mux(reset, _WIRE_14, _GEN_174) @[register.scala 15:27 register.scala 15:27]
    register_15 <= mux(reset, _WIRE_15, _GEN_175) @[register.scala 15:27 register.scala 15:27]
    register_16 <= mux(reset, _WIRE_16, _GEN_176) @[register.scala 15:27 register.scala 15:27]
    register_17 <= mux(reset, _WIRE_17, _GEN_177) @[register.scala 15:27 register.scala 15:27]
    register_18 <= mux(reset, _WIRE_18, _GEN_178) @[register.scala 15:27 register.scala 15:27]
    register_19 <= mux(reset, _WIRE_19, _GEN_179) @[register.scala 15:27 register.scala 15:27]
    register_20 <= mux(reset, _WIRE_20, _GEN_180) @[register.scala 15:27 register.scala 15:27]
    register_21 <= mux(reset, _WIRE_21, _GEN_181) @[register.scala 15:27 register.scala 15:27]
    register_22 <= mux(reset, _WIRE_22, _GEN_182) @[register.scala 15:27 register.scala 15:27]
    register_23 <= mux(reset, _WIRE_23, _GEN_183) @[register.scala 15:27 register.scala 15:27]
    register_24 <= mux(reset, _WIRE_24, _GEN_184) @[register.scala 15:27 register.scala 15:27]
    register_25 <= mux(reset, _WIRE_25, _GEN_185) @[register.scala 15:27 register.scala 15:27]
    register_26 <= mux(reset, _WIRE_26, _GEN_186) @[register.scala 15:27 register.scala 15:27]
    register_27 <= mux(reset, _WIRE_27, _GEN_187) @[register.scala 15:27 register.scala 15:27]
    register_28 <= mux(reset, _WIRE_28, _GEN_188) @[register.scala 15:27 register.scala 15:27]
    register_29 <= mux(reset, _WIRE_29, _GEN_189) @[register.scala 15:27 register.scala 15:27]
    register_30 <= mux(reset, _WIRE_30, _GEN_190) @[register.scala 15:27 register.scala 15:27]
    register_31 <= mux(reset, _WIRE_31, _GEN_191) @[register.scala 15:27 register.scala 15:27]

  module memory :
    input clock : Clock
    input reset : UInt<1>
    input io_w_enable : UInt<1>
    input io_r_enable : UInt<1>
    input io_addr : UInt<8>
    input io_data : UInt<32>
    output io_output : UInt<32>

    mem mem : @[smem.scala 14:18]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => MPORT_1
      writer => MPORT
      read-under-write => undefined
    node _T = eq(io_w_enable, UInt<1>("h1")) @[smem.scala 15:23]
    node _T_1 = eq(io_r_enable, UInt<1>("h1")) @[smem.scala 18:28]
    node _GEN_0 = validif(_T_1, io_addr) @[smem.scala 18:36 smem.scala 19:28]
    node _GEN_1 = validif(_T_1, clock) @[smem.scala 18:36 smem.scala 19:28]
    node _GEN_2 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[smem.scala 18:36 smem.scala 19:28 smem.scala 14:18]
    node _GEN_3 = mux(_T_1, mem.MPORT_1.data, UInt<1>("h0")) @[smem.scala 18:36 smem.scala 19:18 smem.scala 21:18]
    node _GEN_4 = validif(_T, io_addr) @[smem.scala 15:31]
    node _GEN_5 = validif(_T, clock) @[smem.scala 15:31]
    node _GEN_6 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[smem.scala 15:31 smem.scala 14:18]
    node _GEN_7 = validif(_T, UInt<1>("h1")) @[smem.scala 15:31]
    node _GEN_8 = validif(_T, io_data) @[smem.scala 15:31]
    node _GEN_9 = mux(_T, UInt<1>("h0"), _GEN_3) @[smem.scala 15:31 smem.scala 17:18]
    node _GEN_10 = validif(eq(_T, UInt<1>("h0")), _GEN_0) @[smem.scala 15:31]
    node _GEN_11 = validif(eq(_T, UInt<1>("h0")), _GEN_1) @[smem.scala 15:31]
    node _GEN_12 = mux(_T, UInt<1>("h0"), _GEN_2) @[smem.scala 15:31 smem.scala 14:18]
    io_output <= _GEN_9
    mem.MPORT_1.addr <= _GEN_10
    mem.MPORT_1.en <= _GEN_12
    mem.MPORT_1.clk <= _GEN_11
    mem.MPORT.addr <= _GEN_4
    mem.MPORT.en <= _GEN_6
    mem.MPORT.clk <= _GEN_5
    mem.MPORT.data <= _GEN_8
    mem.MPORT.mask <= _GEN_7

  module IF_ID_Reg :
    input clock : Clock
    input reset : UInt<1>
    input io_pc_in : UInt<32>
    output io_pc_out : UInt<32>
    input io_pc_in4 : UInt<32>
    output io_pc_out4 : UInt<32>
    input io_instr_in : UInt<32>
    output io_instr_out : UInt<32>

    reg pcreg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pcreg) @[if_id_pipe.scala 16:28]
    reg pc4reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc4reg) @[if_id_pipe.scala 17:29]
    reg instrreg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instrreg) @[if_id_pipe.scala 18:30]
    io_pc_out <= pcreg @[if_id_pipe.scala 21:19]
    io_pc_out4 <= pc4reg @[if_id_pipe.scala 23:20]
    io_instr_out <= instrreg @[if_id_pipe.scala 25:22]
    pcreg <= mux(reset, UInt<32>("h0"), io_pc_in) @[if_id_pipe.scala 16:28 if_id_pipe.scala 16:28 if_id_pipe.scala 20:15]
    pc4reg <= mux(reset, UInt<32>("h0"), io_pc_in4) @[if_id_pipe.scala 17:29 if_id_pipe.scala 17:29 if_id_pipe.scala 22:16]
    instrreg <= mux(reset, UInt<32>("h0"), io_instr_in) @[if_id_pipe.scala 18:30 if_id_pipe.scala 18:30 if_id_pipe.scala 24:18]

  module ID_EX_Reg :
    input clock : Clock
    input reset : UInt<1>
    input io_pc_in : UInt<32>
    output io_pc_out : UInt<32>
    input io_pc_in4 : UInt<32>
    output io_pc_out4 : UInt<32>
    input io_branch_in : UInt<1>
    output io_branch_out : UInt<1>
    input io_regwrite_in : UInt<1>
    output io_regwrite_out : UInt<1>
    input io_f3_in : UInt<3>
    output io_f3_out : UInt<3>
    input io_f7_in : UInt<1>
    output io_f7_out : UInt<1>
    input io_opA_in : UInt<4>
    output io_opA_out : UInt<4>
    input io_opB_in : UInt<2>
    output io_opB_out : UInt<2>
    input io_nextpcsel_in : UInt<4>
    output io_nextpcsel_out : UInt<4>
    input io_memtoreg_in : UInt<1>
    output io_memtoreg_out : UInt<1>
    input io_aluop_in : UInt<3>
    output io_aluop_out : UInt<3>
    input io_memwrite_in : UInt<1>
    output io_memwrite_out : UInt<1>
    input io_memread_in : UInt<1>
    output io_memread_out : UInt<1>
    input io_immd_in : SInt<32>
    output io_immd_out : SInt<32>
    input io_rs1_in : UInt<5>
    output io_rs1_out : UInt<5>
    input io_rs2_in : UInt<5>
    output io_rs2_out : UInt<5>
    input io_rd1_in : SInt<32>
    output io_rd1_out : SInt<32>
    input io_rd2_in : SInt<32>
    output io_rd2_out : SInt<32>
    input io_writereg_in : UInt<5>
    output io_writereg_out : UInt<5>

    reg pcreg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pcreg) @[id_ex_pipe.scala 78:24]
    reg pc4reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc4reg) @[id_ex_pipe.scala 79:25]
    reg f3reg : UInt<3>, clock with :
      reset => (UInt<1>("h0"), f3reg) @[id_ex_pipe.scala 82:24]
    reg f7reg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), f7reg) @[id_ex_pipe.scala 83:24]
    reg branchreg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), branchreg) @[id_ex_pipe.scala 86:28]
    reg regwritereg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regwritereg) @[id_ex_pipe.scala 87:30]
    reg opAreg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), opAreg) @[id_ex_pipe.scala 88:25]
    reg opBreg : UInt<2>, clock with :
      reset => (UInt<1>("h0"), opBreg) @[id_ex_pipe.scala 89:25]
    reg nextpcselreg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), nextpcselreg) @[id_ex_pipe.scala 90:31]
    reg memtoregreg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memtoregreg) @[id_ex_pipe.scala 91:30]
    reg aluopreg : UInt<3>, clock with :
      reset => (UInt<1>("h0"), aluopreg) @[id_ex_pipe.scala 92:27]
    reg memwritereg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memwritereg) @[id_ex_pipe.scala 93:30]
    reg memreadreg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memreadreg) @[id_ex_pipe.scala 94:29]
    reg immdreg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), immdreg) @[id_ex_pipe.scala 95:26]
    reg rs1reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs1reg) @[id_ex_pipe.scala 96:25]
    reg rs2reg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs2reg) @[id_ex_pipe.scala 97:25]
    reg writeregreg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), writeregreg) @[id_ex_pipe.scala 98:30]
    reg rd1reg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rd1reg) @[id_ex_pipe.scala 99:25]
    reg rd2reg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rd2reg) @[id_ex_pipe.scala 100:25]
    io_pc_out <= pcreg @[id_ex_pipe.scala 104:14]
    io_pc_out4 <= pc4reg @[id_ex_pipe.scala 107:16]
    io_branch_out <= branchreg @[id_ex_pipe.scala 129:19]
    io_regwrite_out <= regwritereg @[id_ex_pipe.scala 132:21]
    io_f3_out <= f3reg @[id_ex_pipe.scala 117:15]
    io_f7_out <= f7reg @[id_ex_pipe.scala 120:15]
    io_opA_out <= opAreg @[id_ex_pipe.scala 135:16]
    io_opB_out <= opBreg @[id_ex_pipe.scala 138:16]
    io_nextpcsel_out <= nextpcselreg @[id_ex_pipe.scala 141:22]
    io_memtoreg_out <= memtoregreg @[id_ex_pipe.scala 144:21]
    io_aluop_out <= aluopreg @[id_ex_pipe.scala 147:18]
    io_memwrite_out <= memwritereg @[id_ex_pipe.scala 150:21]
    io_memread_out <= memreadreg @[id_ex_pipe.scala 153:20]
    io_immd_out <= immdreg @[id_ex_pipe.scala 156:17]
    io_rs1_out <= rs1reg @[id_ex_pipe.scala 159:16]
    io_rs2_out <= rs2reg @[id_ex_pipe.scala 162:16]
    io_rd1_out <= rd1reg @[id_ex_pipe.scala 168:16]
    io_rd2_out <= rd2reg @[id_ex_pipe.scala 171:16]
    io_writereg_out <= writeregreg @[id_ex_pipe.scala 165:21]
    pcreg <= mux(reset, UInt<32>("h0"), io_pc_in) @[id_ex_pipe.scala 78:24 id_ex_pipe.scala 78:24 id_ex_pipe.scala 103:10]
    pc4reg <= mux(reset, UInt<32>("h0"), io_pc_in4) @[id_ex_pipe.scala 79:25 id_ex_pipe.scala 79:25 id_ex_pipe.scala 106:12]
    f3reg <= mux(reset, UInt<3>("h0"), io_f3_in) @[id_ex_pipe.scala 82:24 id_ex_pipe.scala 82:24 id_ex_pipe.scala 116:11]
    f7reg <= mux(reset, UInt<1>("h0"), io_f7_in) @[id_ex_pipe.scala 83:24 id_ex_pipe.scala 83:24 id_ex_pipe.scala 119:11]
    branchreg <= mux(reset, UInt<1>("h0"), io_branch_in) @[id_ex_pipe.scala 86:28 id_ex_pipe.scala 86:28 id_ex_pipe.scala 128:15]
    regwritereg <= mux(reset, UInt<1>("h0"), io_regwrite_in) @[id_ex_pipe.scala 87:30 id_ex_pipe.scala 87:30 id_ex_pipe.scala 131:17]
    opAreg <= mux(reset, UInt<4>("h0"), io_opA_in) @[id_ex_pipe.scala 88:25 id_ex_pipe.scala 88:25 id_ex_pipe.scala 134:12]
    opBreg <= mux(reset, UInt<2>("h0"), io_opB_in) @[id_ex_pipe.scala 89:25 id_ex_pipe.scala 89:25 id_ex_pipe.scala 137:12]
    nextpcselreg <= mux(reset, UInt<4>("h0"), io_nextpcsel_in) @[id_ex_pipe.scala 90:31 id_ex_pipe.scala 90:31 id_ex_pipe.scala 140:18]
    memtoregreg <= mux(reset, UInt<1>("h0"), io_memtoreg_in) @[id_ex_pipe.scala 91:30 id_ex_pipe.scala 91:30 id_ex_pipe.scala 143:17]
    aluopreg <= mux(reset, UInt<3>("h0"), io_aluop_in) @[id_ex_pipe.scala 92:27 id_ex_pipe.scala 92:27 id_ex_pipe.scala 146:14]
    memwritereg <= mux(reset, UInt<1>("h0"), io_memwrite_in) @[id_ex_pipe.scala 93:30 id_ex_pipe.scala 93:30 id_ex_pipe.scala 149:17]
    memreadreg <= mux(reset, UInt<1>("h0"), io_memread_in) @[id_ex_pipe.scala 94:29 id_ex_pipe.scala 94:29 id_ex_pipe.scala 152:16]
    immdreg <= mux(reset, asSInt(UInt<32>("h0")), io_immd_in) @[id_ex_pipe.scala 95:26 id_ex_pipe.scala 95:26 id_ex_pipe.scala 155:13]
    rs1reg <= mux(reset, UInt<5>("h0"), io_rs1_in) @[id_ex_pipe.scala 96:25 id_ex_pipe.scala 96:25 id_ex_pipe.scala 158:12]
    rs2reg <= mux(reset, UInt<5>("h0"), io_rs2_in) @[id_ex_pipe.scala 97:25 id_ex_pipe.scala 97:25 id_ex_pipe.scala 161:12]
    writeregreg <= mux(reset, UInt<5>("h0"), io_writereg_in) @[id_ex_pipe.scala 98:30 id_ex_pipe.scala 98:30 id_ex_pipe.scala 164:17]
    rd1reg <= mux(reset, asSInt(UInt<32>("h0")), io_rd1_in) @[id_ex_pipe.scala 99:25 id_ex_pipe.scala 99:25 id_ex_pipe.scala 167:12]
    rd2reg <= mux(reset, asSInt(UInt<32>("h0")), io_rd2_in) @[id_ex_pipe.scala 100:25 id_ex_pipe.scala 100:25 id_ex_pipe.scala 170:12]

  module EX_MEM_Reg :
    input clock : Clock
    input reset : UInt<1>
    input io_stdata_in : SInt<32>
    output io_stdata_out : SInt<32>
    input io_alu_in : UInt<32>
    output io_alu_out : UInt<32>
    input io_rd_in : UInt<5>
    output io_rd_out : UInt<5>
    input io_memwrite_in : UInt<1>
    input io_memread_in : UInt<1>
    input io_regwrite_in : UInt<1>
    input io_memtoreg_in : UInt<1>
    output io_memwrite_out : UInt<1>
    output io_memread_out : UInt<1>
    output io_regwrite_out : UInt<1>
    output io_memtoreg_out : UInt<1>

    reg stdatareg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), stdatareg) @[ex_mem_pipe.scala 30:32]
    reg memwritereg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memwritereg) @[ex_mem_pipe.scala 31:34]
    reg memreadreg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memreadreg) @[ex_mem_pipe.scala 32:33]
    reg regwritereg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regwritereg) @[ex_mem_pipe.scala 33:34]
    reg memtoregreg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memtoregreg) @[ex_mem_pipe.scala 34:34]
    reg alureg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), alureg) @[ex_mem_pipe.scala 35:29]
    reg rdreg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdreg) @[ex_mem_pipe.scala 36:28]
    io_stdata_out <= stdatareg @[ex_mem_pipe.scala 39:23]
    io_alu_out <= alureg @[ex_mem_pipe.scala 42:20]
    io_rd_out <= rdreg @[ex_mem_pipe.scala 45:19]
    io_memwrite_out <= memwritereg @[ex_mem_pipe.scala 48:25]
    io_memread_out <= memreadreg @[ex_mem_pipe.scala 51:24]
    io_regwrite_out <= regwritereg @[ex_mem_pipe.scala 54:25]
    io_memtoreg_out <= memtoregreg @[ex_mem_pipe.scala 57:25]
    stdatareg <= mux(reset, asSInt(UInt<32>("h0")), io_stdata_in) @[ex_mem_pipe.scala 30:32 ex_mem_pipe.scala 30:32 ex_mem_pipe.scala 38:19]
    memwritereg <= mux(reset, UInt<1>("h0"), io_memwrite_in) @[ex_mem_pipe.scala 31:34 ex_mem_pipe.scala 31:34 ex_mem_pipe.scala 47:21]
    memreadreg <= mux(reset, UInt<1>("h0"), io_memread_in) @[ex_mem_pipe.scala 32:33 ex_mem_pipe.scala 32:33 ex_mem_pipe.scala 50:20]
    regwritereg <= mux(reset, UInt<1>("h0"), io_regwrite_in) @[ex_mem_pipe.scala 33:34 ex_mem_pipe.scala 33:34 ex_mem_pipe.scala 53:21]
    memtoregreg <= mux(reset, UInt<1>("h0"), io_memtoreg_in) @[ex_mem_pipe.scala 34:34 ex_mem_pipe.scala 34:34 ex_mem_pipe.scala 56:21]
    alureg <= mux(reset, UInt<32>("h0"), io_alu_in) @[ex_mem_pipe.scala 35:29 ex_mem_pipe.scala 35:29 ex_mem_pipe.scala 41:16]
    rdreg <= mux(reset, UInt<5>("h0"), io_rd_in) @[ex_mem_pipe.scala 36:28 ex_mem_pipe.scala 36:28 ex_mem_pipe.scala 44:15]

  module MEM_WB_Reg :
    input clock : Clock
    input reset : UInt<1>
    input io_alu_in : UInt<32>
    output io_alu_out : UInt<32>
    input io_rd_in : UInt<5>
    output io_rd_out : UInt<5>
    input io_dataout_in : UInt<32>
    output io_dataout_out : UInt<32>
    input io_memread_in : UInt<1>
    output io_memread_out : UInt<1>
    input io_regwrite_in : UInt<1>
    output io_regwrite_out : UInt<1>
    input io_memwrite_in : UInt<1>
    output io_memwrite_out : UInt<1>
    input io_memtoreg_in : UInt<1>
    output io_memtoreg_out : UInt<1>

    reg dataoutreg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), dataoutreg) @[mem_wb_pipe.scala 30:33]
    reg alureg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), alureg) @[mem_wb_pipe.scala 31:25]
    reg rdreg : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdreg) @[mem_wb_pipe.scala 32:24]
    reg regwritereg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regwritereg) @[mem_wb_pipe.scala 33:30]
    reg memtoregreg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memtoregreg) @[mem_wb_pipe.scala 34:30]
    reg memreadreg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memreadreg) @[mem_wb_pipe.scala 35:29]
    reg memwritereg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memwritereg) @[mem_wb_pipe.scala 36:30]
    io_alu_out <= alureg @[mem_wb_pipe.scala 43:20]
    io_rd_out <= rdreg @[mem_wb_pipe.scala 46:19]
    io_dataout_out <= dataoutreg @[mem_wb_pipe.scala 40:24]
    io_memread_out <= memreadreg @[mem_wb_pipe.scala 55:20]
    io_regwrite_out <= regwritereg @[mem_wb_pipe.scala 49:25]
    io_memwrite_out <= memwritereg @[mem_wb_pipe.scala 58:21]
    io_memtoreg_out <= memtoregreg @[mem_wb_pipe.scala 52:25]
    dataoutreg <= mux(reset, UInt<32>("h0"), io_dataout_in) @[mem_wb_pipe.scala 30:33 mem_wb_pipe.scala 30:33 mem_wb_pipe.scala 39:20]
    alureg <= mux(reset, UInt<32>("h0"), io_alu_in) @[mem_wb_pipe.scala 31:25 mem_wb_pipe.scala 31:25 mem_wb_pipe.scala 42:16]
    rdreg <= mux(reset, UInt<5>("h0"), io_rd_in) @[mem_wb_pipe.scala 32:24 mem_wb_pipe.scala 32:24 mem_wb_pipe.scala 45:15]
    regwritereg <= mux(reset, UInt<1>("h0"), io_regwrite_in) @[mem_wb_pipe.scala 33:30 mem_wb_pipe.scala 33:30 mem_wb_pipe.scala 48:21]
    memtoregreg <= mux(reset, UInt<1>("h0"), io_memtoreg_in) @[mem_wb_pipe.scala 34:30 mem_wb_pipe.scala 34:30 mem_wb_pipe.scala 51:21]
    memreadreg <= mux(reset, UInt<1>("h0"), io_memread_in) @[mem_wb_pipe.scala 35:29 mem_wb_pipe.scala 35:29 mem_wb_pipe.scala 54:16]
    memwritereg <= mux(reset, UInt<1>("h0"), io_memwrite_in) @[mem_wb_pipe.scala 36:30 mem_wb_pipe.scala 36:30 mem_wb_pipe.scala 57:17]

  module ForwardUnit :
    input clock : Clock
    input reset : UInt<1>
    input io_EX_MEM_rd : UInt<5>
    input io_ID_EX_rs1 : UInt<5>
    input io_ID_EX_rs2 : UInt<5>
    input io_EX_MEM_regwrite : UInt<1>
    input io_MEM_WB_rd : UInt<5>
    input io_MEM_WB_regwrite : UInt<1>
    output io_forward_A : UInt<2>
    output io_forward_B : UInt<2>

    node _T = eq(io_EX_MEM_regwrite, UInt<1>("h1")) @[Forward.scala 21:29]
    node _T_1 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[Forward.scala 21:53]
    node _T_2 = and(_T, _T_1) @[Forward.scala 21:37]
    node _T_3 = eq(io_EX_MEM_rd, io_ID_EX_rs1) @[Forward.scala 21:84]
    node _T_4 = and(_T_2, _T_3) @[Forward.scala 21:68]
    node _T_5 = eq(io_EX_MEM_rd, io_ID_EX_rs2) @[Forward.scala 21:119]
    node _T_6 = and(_T_4, _T_5) @[Forward.scala 21:102]
    node _T_7 = eq(io_EX_MEM_regwrite, UInt<1>("h1")) @[Forward.scala 24:36]
    node _T_8 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[Forward.scala 24:60]
    node _T_9 = and(_T_7, _T_8) @[Forward.scala 24:44]
    node _T_10 = eq(io_EX_MEM_rd, io_ID_EX_rs2) @[Forward.scala 24:92]
    node _T_11 = and(_T_9, _T_10) @[Forward.scala 24:75]
    node _T_12 = eq(io_EX_MEM_regwrite, UInt<1>("h1")) @[Forward.scala 26:36]
    node _T_13 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[Forward.scala 26:60]
    node _T_14 = and(_T_12, _T_13) @[Forward.scala 26:44]
    node _T_15 = eq(io_EX_MEM_rd, io_ID_EX_rs1) @[Forward.scala 26:92]
    node _T_16 = and(_T_14, _T_15) @[Forward.scala 26:75]
    node _GEN_0 = mux(_T_16, UInt<1>("h1"), UInt<1>("h0")) @[Forward.scala 26:111 Forward.scala 27:30 Forward.scala 16:18]
    node _GEN_1 = mux(_T_11, UInt<1>("h1"), UInt<1>("h0")) @[Forward.scala 24:111 Forward.scala 25:30 Forward.scala 17:18]
    node _GEN_2 = mux(_T_11, UInt<1>("h0"), _GEN_0) @[Forward.scala 24:111 Forward.scala 16:18]
    node _GEN_3 = mux(_T_6, UInt<1>("h1"), _GEN_2) @[Forward.scala 21:138 Forward.scala 22:22]
    node _GEN_4 = mux(_T_6, UInt<1>("h1"), _GEN_1) @[Forward.scala 21:138 Forward.scala 23:30]
    node _T_17 = eq(io_MEM_WB_regwrite, UInt<1>("h1")) @[Forward.scala 31:32]
    node _T_18 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[Forward.scala 31:56]
    node _T_19 = and(_T_17, _T_18) @[Forward.scala 31:40]
    node _T_20 = eq(io_EX_MEM_regwrite, UInt<1>("h1")) @[Forward.scala 31:96]
    node _T_21 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[Forward.scala 31:125]
    node _T_22 = and(_T_20, _T_21) @[Forward.scala 31:108]
    node _T_23 = eq(io_EX_MEM_rd, io_ID_EX_rs1) @[Forward.scala 32:22]
    node _T_24 = and(_T_22, _T_23) @[Forward.scala 31:141]
    node _T_25 = eq(io_EX_MEM_rd, io_ID_EX_rs2) @[Forward.scala 32:57]
    node _T_26 = and(_T_24, _T_25) @[Forward.scala 32:40]
    node _T_27 = not(_T_26) @[Forward.scala 31:74]
    node _T_28 = and(_T_19, _T_27) @[Forward.scala 31:71]
    node _T_29 = eq(io_MEM_WB_rd, io_ID_EX_rs1) @[Forward.scala 32:92]
    node _T_30 = and(_T_28, _T_29) @[Forward.scala 32:76]
    node _T_31 = eq(io_MEM_WB_rd, io_ID_EX_rs2) @[Forward.scala 33:22]
    node _T_32 = and(_T_30, _T_31) @[Forward.scala 32:110]
    node _T_33 = eq(io_MEM_WB_regwrite, UInt<1>("h1")) @[Forward.scala 36:40]
    node _T_34 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[Forward.scala 36:64]
    node _T_35 = and(_T_33, _T_34) @[Forward.scala 36:48]
    node _T_36 = eq(io_EX_MEM_regwrite, UInt<1>("h1")) @[Forward.scala 36:104]
    node _T_37 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[Forward.scala 36:130]
    node _T_38 = and(_T_36, _T_37) @[Forward.scala 36:113]
    node _T_39 = eq(io_EX_MEM_rd, io_ID_EX_rs2) @[Forward.scala 37:19]
    node _T_40 = and(_T_38, _T_39) @[Forward.scala 36:146]
    node _T_41 = not(_T_40) @[Forward.scala 36:82]
    node _T_42 = and(_T_35, _T_41) @[Forward.scala 36:79]
    node _T_43 = eq(io_MEM_WB_rd, io_ID_EX_rs2) @[Forward.scala 37:55]
    node _T_44 = and(_T_42, _T_43) @[Forward.scala 37:38]
    node _T_45 = eq(io_MEM_WB_regwrite, UInt<1>("h1")) @[Forward.scala 39:40]
    node _T_46 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[Forward.scala 39:64]
    node _T_47 = and(_T_45, _T_46) @[Forward.scala 39:48]
    node _T_48 = eq(io_EX_MEM_regwrite, UInt<1>("h1")) @[Forward.scala 39:104]
    node _T_49 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[Forward.scala 39:129]
    node _T_50 = and(_T_48, _T_49) @[Forward.scala 39:112]
    node _T_51 = eq(io_EX_MEM_rd, io_ID_EX_rs2) @[Forward.scala 40:19]
    node _T_52 = and(_T_50, _T_51) @[Forward.scala 39:145]
    node _T_53 = not(_T_52) @[Forward.scala 39:82]
    node _T_54 = and(_T_47, _T_53) @[Forward.scala 39:79]
    node _T_55 = eq(io_MEM_WB_rd, io_ID_EX_rs1) @[Forward.scala 40:57]
    node _T_56 = and(_T_54, _T_55) @[Forward.scala 40:39]
    node _GEN_5 = mux(_T_56, UInt<2>("h2"), _GEN_3) @[Forward.scala 40:76 Forward.scala 41:30]
    node _GEN_6 = mux(_T_44, UInt<2>("h2"), _GEN_4) @[Forward.scala 37:74 Forward.scala 38:30]
    node _GEN_7 = mux(_T_44, _GEN_3, _GEN_5) @[Forward.scala 37:74]
    node _GEN_8 = mux(_T_32, UInt<2>("h2"), _GEN_7) @[Forward.scala 33:41 Forward.scala 34:30]
    node _GEN_9 = mux(_T_32, UInt<2>("h2"), _GEN_6) @[Forward.scala 33:41 Forward.scala 35:30]
    io_forward_A <= _GEN_8
    io_forward_B <= _GEN_9

  module HazardDetection :
    input clock : Clock
    input reset : UInt<1>
    input io_IF_ID_instr : UInt<32>
    input io_ID_EX_memread : UInt<1>
    input io_ID_EX_rd : UInt<5>
    input io_pc_in : UInt<32>
    input io_current_pc_in : UInt<32>
    output io_instr_forward : UInt<1>
    output io_pc_forward : UInt<1>
    output io_ctrl_forward : UInt<1>
    output io_instr_out : UInt<32>
    output io_pc_out : UInt<32>
    output io_current_pc_out : UInt<32>

    node rs1_sel = bits(io_IF_ID_instr, 19, 15) @[hazard.scala 18:31]
    node rs2_sel = bits(io_IF_ID_instr, 24, 20) @[hazard.scala 19:31]
    node _T = eq(io_ID_EX_memread, UInt<1>("h1")) @[hazard.scala 20:25]
    node _T_1 = eq(io_ID_EX_rd, rs1_sel) @[hazard.scala 20:50]
    node _T_2 = eq(io_ID_EX_rd, rs2_sel) @[hazard.scala 20:79]
    node _T_3 = or(_T_1, _T_2) @[hazard.scala 20:63]
    node _T_4 = and(_T, _T_3) @[hazard.scala 20:33]
    node _GEN_0 = mux(_T_4, UInt<1>("h1"), UInt<1>("h0")) @[hazard.scala 20:94 hazard.scala 21:24 hazard.scala 29:22]
    node _GEN_1 = mux(_T_4, io_IF_ID_instr, io_IF_ID_instr) @[hazard.scala 20:94 hazard.scala 24:20 hazard.scala 32:18]
    node _GEN_2 = mux(_T_4, io_pc_in, io_pc_in) @[hazard.scala 20:94 hazard.scala 25:17 hazard.scala 33:15]
    node _GEN_3 = mux(_T_4, io_current_pc_in, io_current_pc_in) @[hazard.scala 20:94 hazard.scala 26:25 hazard.scala 34:23]
    io_instr_forward <= _GEN_0
    io_pc_forward <= _GEN_0
    io_ctrl_forward <= _GEN_0
    io_instr_out <= _GEN_1
    io_pc_out <= _GEN_2
    io_current_pc_out <= _GEN_3

  module BranchLogic :
    input clock : Clock
    input reset : UInt<1>
    input io_in_rs1 : SInt<32>
    input io_in_rs2 : SInt<32>
    input io_in_func3 : UInt<3>
    output io_output : UInt<1>

    node _T = eq(io_in_func3, UInt<1>("h0")) @[branchlogic.scala 14:20]
    node _T_1 = eq(io_in_rs1, io_in_rs2) @[branchlogic.scala 16:20]
    node _GEN_0 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[branchlogic.scala 16:35 branchlogic.scala 17:17 branchlogic.scala 19:17]
    node _T_2 = eq(io_in_func3, UInt<1>("h1")) @[branchlogic.scala 21:27]
    node _T_3 = neq(io_in_rs1, io_in_rs2) @[branchlogic.scala 23:20]
    node _GEN_1 = mux(_T_3, UInt<1>("h1"), UInt<1>("h0")) @[branchlogic.scala 23:35 branchlogic.scala 24:17 branchlogic.scala 26:17]
    node _T_4 = eq(io_in_func3, UInt<3>("h4")) @[branchlogic.scala 28:27]
    node _T_5 = lt(io_in_rs1, io_in_rs2) @[branchlogic.scala 30:20]
    node _GEN_2 = mux(_T_5, UInt<1>("h1"), UInt<1>("h0")) @[branchlogic.scala 30:33 branchlogic.scala 31:17 branchlogic.scala 33:17]
    node _T_6 = eq(io_in_func3, UInt<3>("h5")) @[branchlogic.scala 35:27]
    node _T_7 = geq(io_in_rs1, io_in_rs2) @[branchlogic.scala 37:20]
    node _GEN_3 = mux(_T_7, UInt<1>("h1"), UInt<1>("h0")) @[branchlogic.scala 37:34 branchlogic.scala 38:17 branchlogic.scala 40:17]
    node _T_8 = eq(io_in_func3, UInt<3>("h6")) @[branchlogic.scala 42:27]
    node _T_9 = asUInt(io_in_rs1) @[branchlogic.scala 44:20]
    node _T_10 = asUInt(io_in_rs2) @[branchlogic.scala 44:39]
    node _T_11 = lt(_T_9, _T_10) @[branchlogic.scala 44:27]
    node _GEN_4 = mux(_T_11, UInt<1>("h1"), UInt<1>("h0")) @[branchlogic.scala 44:47 branchlogic.scala 45:17 branchlogic.scala 47:17]
    node _T_12 = eq(io_in_func3, UInt<3>("h7")) @[branchlogic.scala 49:27]
    node _T_13 = asUInt(io_in_rs1) @[branchlogic.scala 51:20]
    node _T_14 = asUInt(io_in_rs2) @[branchlogic.scala 51:40]
    node _T_15 = geq(_T_13, _T_14) @[branchlogic.scala 51:27]
    node _GEN_5 = mux(_T_15, UInt<1>("h1"), UInt<1>("h0")) @[branchlogic.scala 51:48 branchlogic.scala 52:17 branchlogic.scala 54:17]
    node _GEN_6 = mux(_T_12, _GEN_5, UInt<1>("h0")) @[branchlogic.scala 49:41 branchlogic.scala 57:15]
    node _GEN_7 = mux(_T_8, _GEN_4, _GEN_6) @[branchlogic.scala 42:41]
    node _GEN_8 = mux(_T_6, _GEN_3, _GEN_7) @[branchlogic.scala 35:41]
    node _GEN_9 = mux(_T_4, _GEN_2, _GEN_8) @[branchlogic.scala 28:41]
    node _GEN_10 = mux(_T_2, _GEN_1, _GEN_9) @[branchlogic.scala 21:41]
    node _GEN_11 = mux(_T, _GEN_0, _GEN_10) @[branchlogic.scala 14:34]
    io_output <= _GEN_11

  module BranchForward :
    input clock : Clock
    input reset : UInt<1>
    input io_ID_EX_rd : UInt<5>
    input io_ID_EX_memread : UInt<1>
    input io_EX_MEM_rd : UInt<5>
    input io_EX_MEM_memread : UInt<1>
    input io_MEM_WB_rd : UInt<5>
    input io_MEM_WB_memread : UInt<1>
    input io_rs1_sel : UInt<5>
    input io_rs2_sel : UInt<5>
    input io_ctrl_branch : UInt<1>
    output io_forward_rs1 : UInt<4>
    output io_forward_rs2 : UInt<4>

    node _T = eq(io_ctrl_branch, UInt<1>("h1")) @[branchforward.scala 21:21]
    node _T_1 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 23:20]
    node _T_2 = neq(io_ID_EX_memread, UInt<1>("h1")) @[branchforward.scala 23:55]
    node _T_3 = and(_T_1, _T_2) @[branchforward.scala 23:35]
    node _T_4 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 23:79]
    node _T_5 = and(_T_3, _T_4) @[branchforward.scala 23:63]
    node _T_6 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 23:111]
    node _T_7 = and(_T_5, _T_6) @[branchforward.scala 23:95]
    node _T_8 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 26:27]
    node _T_9 = neq(io_ID_EX_memread, UInt<1>("h1")) @[branchforward.scala 26:62]
    node _T_10 = and(_T_8, _T_9) @[branchforward.scala 26:42]
    node _T_11 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 26:86]
    node _T_12 = and(_T_10, _T_11) @[branchforward.scala 26:70]
    node _T_13 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 28:27]
    node _T_14 = neq(io_ID_EX_memread, UInt<1>("h1")) @[branchforward.scala 28:62]
    node _T_15 = and(_T_13, _T_14) @[branchforward.scala 28:42]
    node _T_16 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 28:86]
    node _T_17 = and(_T_15, _T_16) @[branchforward.scala 28:70]
    node _GEN_0 = mux(_T_17, UInt<1>("h1"), UInt<1>("h0")) @[branchforward.scala 28:103 branchforward.scala 29:20 branchforward.scala 20:20]
    node _GEN_1 = mux(_T_12, UInt<1>("h1"), UInt<1>("h0")) @[branchforward.scala 26:103 branchforward.scala 27:20 branchforward.scala 19:20]
    node _GEN_2 = mux(_T_12, UInt<1>("h0"), _GEN_0) @[branchforward.scala 26:103 branchforward.scala 20:20]
    node _GEN_3 = mux(_T_7, UInt<1>("h1"), _GEN_1) @[branchforward.scala 23:128 branchforward.scala 24:20]
    node _GEN_4 = mux(_T_7, UInt<1>("h1"), _GEN_2) @[branchforward.scala 23:128 branchforward.scala 25:20]
    node _T_18 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 33:21]
    node _T_19 = neq(io_EX_MEM_memread, UInt<1>("h1")) @[branchforward.scala 33:57]
    node _T_20 = and(_T_18, _T_19) @[branchforward.scala 33:36]
    node _T_21 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 34:20]
    node _T_22 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 34:52]
    node _T_23 = and(_T_21, _T_22) @[branchforward.scala 34:36]
    node _T_24 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 34:84]
    node _T_25 = and(_T_23, _T_24) @[branchforward.scala 34:68]
    node _T_26 = not(_T_25) @[branchforward.scala 34:5]
    node _T_27 = and(_T_20, _T_26) @[branchforward.scala 33:65]
    node _T_28 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 35:19]
    node _T_29 = and(_T_27, _T_28) @[branchforward.scala 34:101]
    node _T_30 = eq(io_EX_MEM_rd, io_rs2_sel) @[branchforward.scala 35:52]
    node _T_31 = and(_T_29, _T_30) @[branchforward.scala 35:35]
    node _T_32 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 40:28]
    node _T_33 = neq(io_EX_MEM_memread, UInt<1>("h1")) @[branchforward.scala 40:64]
    node _T_34 = and(_T_32, _T_33) @[branchforward.scala 40:43]
    node _T_35 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 41:20]
    node _T_36 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 41:52]
    node _T_37 = and(_T_35, _T_36) @[branchforward.scala 41:36]
    node _T_38 = not(_T_37) @[branchforward.scala 41:5]
    node _T_39 = and(_T_34, _T_38) @[branchforward.scala 40:72]
    node _T_40 = eq(io_EX_MEM_rd, io_rs2_sel) @[branchforward.scala 42:19]
    node _T_41 = and(_T_39, _T_40) @[branchforward.scala 41:69]
    node _T_42 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 46:28]
    node _T_43 = neq(io_EX_MEM_memread, UInt<1>("h1")) @[branchforward.scala 46:64]
    node _T_44 = and(_T_42, _T_43) @[branchforward.scala 46:43]
    node _T_45 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 47:20]
    node _T_46 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 47:52]
    node _T_47 = and(_T_45, _T_46) @[branchforward.scala 47:36]
    node _T_48 = not(_T_47) @[branchforward.scala 47:5]
    node _T_49 = and(_T_44, _T_48) @[branchforward.scala 46:72]
    node _T_50 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 48:19]
    node _T_51 = and(_T_49, _T_50) @[branchforward.scala 47:69]
    node _T_52 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 52:28]
    node _T_53 = eq(io_EX_MEM_memread, UInt<1>("h1")) @[branchforward.scala 52:64]
    node _T_54 = and(_T_52, _T_53) @[branchforward.scala 52:43]
    node _T_55 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 53:20]
    node _T_56 = eq(io_ID_EX_memread, io_rs1_sel) @[branchforward.scala 53:57]
    node _T_57 = and(_T_55, _T_56) @[branchforward.scala 53:36]
    node _T_58 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 53:89]
    node _T_59 = and(_T_57, _T_58) @[branchforward.scala 53:73]
    node _T_60 = not(_T_59) @[branchforward.scala 53:5]
    node _T_61 = and(_T_54, _T_60) @[branchforward.scala 52:72]
    node _T_62 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 54:19]
    node _T_63 = and(_T_61, _T_62) @[branchforward.scala 53:106]
    node _T_64 = eq(io_EX_MEM_rd, io_rs2_sel) @[branchforward.scala 54:52]
    node _T_65 = and(_T_63, _T_64) @[branchforward.scala 54:35]
    node _T_66 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 59:28]
    node _T_67 = eq(io_EX_MEM_memread, UInt<1>("h1")) @[branchforward.scala 59:64]
    node _T_68 = and(_T_66, _T_67) @[branchforward.scala 59:43]
    node _T_69 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 60:20]
    node _T_70 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 60:52]
    node _T_71 = and(_T_69, _T_70) @[branchforward.scala 60:36]
    node _T_72 = not(_T_71) @[branchforward.scala 60:5]
    node _T_73 = and(_T_68, _T_72) @[branchforward.scala 59:72]
    node _T_74 = eq(io_EX_MEM_rd, io_rs2_sel) @[branchforward.scala 61:19]
    node _T_75 = and(_T_73, _T_74) @[branchforward.scala 60:69]
    node _T_76 = eq(io_ctrl_branch, UInt<1>("h1")) @[branchforward.scala 65:30]
    node _T_77 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 65:54]
    node _T_78 = and(_T_76, _T_77) @[branchforward.scala 65:38]
    node _T_79 = eq(io_EX_MEM_memread, UInt<1>("h1")) @[branchforward.scala 65:90]
    node _T_80 = and(_T_78, _T_79) @[branchforward.scala 65:69]
    node _T_81 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 66:20]
    node _T_82 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 66:52]
    node _T_83 = and(_T_81, _T_82) @[branchforward.scala 66:36]
    node _T_84 = not(_T_83) @[branchforward.scala 66:5]
    node _T_85 = and(_T_80, _T_84) @[branchforward.scala 65:98]
    node _T_86 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 67:19]
    node _T_87 = and(_T_85, _T_86) @[branchforward.scala 66:69]
    node _GEN_5 = mux(_T_87, UInt<3>("h4"), _GEN_3) @[branchforward.scala 67:36 branchforward.scala 69:20]
    node _GEN_6 = mux(_T_75, UInt<3>("h4"), _GEN_4) @[branchforward.scala 61:36 branchforward.scala 63:20]
    node _GEN_7 = mux(_T_75, _GEN_3, _GEN_5) @[branchforward.scala 61:36]
    node _GEN_8 = mux(_T_65, UInt<3>("h4"), _GEN_7) @[branchforward.scala 54:69 branchforward.scala 56:20]
    node _GEN_9 = mux(_T_65, UInt<3>("h4"), _GEN_6) @[branchforward.scala 54:69 branchforward.scala 57:20]
    node _GEN_10 = mux(_T_51, UInt<2>("h2"), _GEN_8) @[branchforward.scala 48:36 branchforward.scala 50:20]
    node _GEN_11 = mux(_T_51, _GEN_4, _GEN_9) @[branchforward.scala 48:36]
    node _GEN_12 = mux(_T_41, UInt<2>("h2"), _GEN_11) @[branchforward.scala 42:36 branchforward.scala 44:20]
    node _GEN_13 = mux(_T_41, _GEN_3, _GEN_10) @[branchforward.scala 42:36]
    node _GEN_14 = mux(_T_31, UInt<2>("h2"), _GEN_13) @[branchforward.scala 35:69 branchforward.scala 37:20]
    node _GEN_15 = mux(_T_31, UInt<2>("h2"), _GEN_12) @[branchforward.scala 35:69 branchforward.scala 38:20]
    node _T_88 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[branchforward.scala 74:21]
    node _T_89 = neq(io_MEM_WB_memread, UInt<1>("h1")) @[branchforward.scala 74:57]
    node _T_90 = and(_T_88, _T_89) @[branchforward.scala 74:36]
    node _T_91 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 76:20]
    node _T_92 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 76:52]
    node _T_93 = and(_T_91, _T_92) @[branchforward.scala 76:36]
    node _T_94 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 76:84]
    node _T_95 = and(_T_93, _T_94) @[branchforward.scala 76:68]
    node _T_96 = not(_T_95) @[branchforward.scala 76:5]
    node _T_97 = and(_T_90, _T_96) @[branchforward.scala 74:65]
    node _T_98 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 78:21]
    node _T_99 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 78:54]
    node _T_100 = and(_T_98, _T_99) @[branchforward.scala 78:37]
    node _T_101 = eq(io_EX_MEM_rd, io_rs2_sel) @[branchforward.scala 78:87]
    node _T_102 = and(_T_100, _T_101) @[branchforward.scala 78:70]
    node _T_103 = not(_T_102) @[branchforward.scala 78:5]
    node _T_104 = and(_T_97, _T_103) @[branchforward.scala 76:101]
    node _T_105 = eq(io_MEM_WB_rd, io_rs1_sel) @[branchforward.scala 79:19]
    node _T_106 = and(_T_104, _T_105) @[branchforward.scala 78:104]
    node _T_107 = eq(io_MEM_WB_rd, io_rs2_sel) @[branchforward.scala 79:52]
    node _T_108 = and(_T_106, _T_107) @[branchforward.scala 79:35]
    node _T_109 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[branchforward.scala 85:28]
    node _T_110 = neq(io_MEM_WB_rd, UInt<1>("h1")) @[branchforward.scala 85:59]
    node _T_111 = and(_T_109, _T_110) @[branchforward.scala 85:43]
    node _T_112 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 87:22]
    node _T_113 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 87:54]
    node _T_114 = and(_T_112, _T_113) @[branchforward.scala 87:38]
    node _T_115 = not(_T_114) @[branchforward.scala 87:7]
    node _T_116 = and(_T_111, _T_115) @[branchforward.scala 85:67]
    node _T_117 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 89:23]
    node _T_118 = eq(io_EX_MEM_rd, io_rs2_sel) @[branchforward.scala 89:56]
    node _T_119 = and(_T_117, _T_118) @[branchforward.scala 89:39]
    node _T_120 = not(_T_119) @[branchforward.scala 89:7]
    node _T_121 = and(_T_116, _T_120) @[branchforward.scala 87:71]
    node _T_122 = eq(io_MEM_WB_rd, io_rs2_sel) @[branchforward.scala 90:21]
    node _T_123 = and(_T_121, _T_122) @[branchforward.scala 89:73]
    node _T_124 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[branchforward.scala 95:28]
    node _T_125 = neq(io_MEM_WB_memread, UInt<1>("h1")) @[branchforward.scala 95:64]
    node _T_126 = and(_T_124, _T_125) @[branchforward.scala 95:43]
    node _T_127 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 97:22]
    node _T_128 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 97:54]
    node _T_129 = and(_T_127, _T_128) @[branchforward.scala 97:38]
    node _T_130 = not(_T_129) @[branchforward.scala 97:7]
    node _T_131 = and(_T_126, _T_130) @[branchforward.scala 95:72]
    node _T_132 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 99:23]
    node _T_133 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 99:56]
    node _T_134 = and(_T_132, _T_133) @[branchforward.scala 99:39]
    node _T_135 = not(_T_134) @[branchforward.scala 99:7]
    node _T_136 = and(_T_131, _T_135) @[branchforward.scala 97:71]
    node _T_137 = eq(io_MEM_WB_rd, io_rs1_sel) @[branchforward.scala 100:21]
    node _T_138 = and(_T_136, _T_137) @[branchforward.scala 99:73]
    node _T_139 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[branchforward.scala 104:30]
    node _T_140 = eq(io_MEM_WB_memread, UInt<1>("h1")) @[branchforward.scala 104:66]
    node _T_141 = and(_T_139, _T_140) @[branchforward.scala 104:45]
    node _T_142 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 106:20]
    node _T_143 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 106:52]
    node _T_144 = and(_T_142, _T_143) @[branchforward.scala 106:36]
    node _T_145 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 106:84]
    node _T_146 = and(_T_144, _T_145) @[branchforward.scala 106:68]
    node _T_147 = not(_T_146) @[branchforward.scala 106:5]
    node _T_148 = and(_T_141, _T_147) @[branchforward.scala 104:74]
    node _T_149 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 108:21]
    node _T_150 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 108:54]
    node _T_151 = and(_T_149, _T_150) @[branchforward.scala 108:37]
    node _T_152 = eq(io_EX_MEM_rd, io_rs2_sel) @[branchforward.scala 108:87]
    node _T_153 = and(_T_151, _T_152) @[branchforward.scala 108:70]
    node _T_154 = not(_T_153) @[branchforward.scala 108:5]
    node _T_155 = and(_T_148, _T_154) @[branchforward.scala 106:101]
    node _T_156 = eq(io_MEM_WB_rd, io_rs1_sel) @[branchforward.scala 109:19]
    node _T_157 = and(_T_155, _T_156) @[branchforward.scala 108:104]
    node _T_158 = eq(io_MEM_WB_rd, io_rs2_sel) @[branchforward.scala 109:52]
    node _T_159 = and(_T_157, _T_158) @[branchforward.scala 109:35]
    node _T_160 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[branchforward.scala 115:28]
    node _T_161 = eq(io_MEM_WB_memread, UInt<1>("h1")) @[branchforward.scala 115:64]
    node _T_162 = and(_T_160, _T_161) @[branchforward.scala 115:43]
    node _T_163 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 117:22]
    node _T_164 = eq(io_ID_EX_rd, io_rs2_sel) @[branchforward.scala 117:54]
    node _T_165 = and(_T_163, _T_164) @[branchforward.scala 117:38]
    node _T_166 = not(_T_165) @[branchforward.scala 117:7]
    node _T_167 = and(_T_162, _T_166) @[branchforward.scala 115:72]
    node _T_168 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 119:23]
    node _T_169 = eq(io_EX_MEM_rd, io_rs2_sel) @[branchforward.scala 119:56]
    node _T_170 = and(_T_168, _T_169) @[branchforward.scala 119:39]
    node _T_171 = not(_T_170) @[branchforward.scala 119:7]
    node _T_172 = and(_T_167, _T_171) @[branchforward.scala 117:71]
    node _T_173 = eq(io_MEM_WB_rd, io_rs2_sel) @[branchforward.scala 120:21]
    node _T_174 = and(_T_172, _T_173) @[branchforward.scala 119:73]
    node _T_175 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[branchforward.scala 125:28]
    node _T_176 = eq(io_MEM_WB_memread, UInt<1>("h1")) @[branchforward.scala 125:64]
    node _T_177 = and(_T_175, _T_176) @[branchforward.scala 125:43]
    node _T_178 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 127:22]
    node _T_179 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 127:54]
    node _T_180 = and(_T_178, _T_179) @[branchforward.scala 127:38]
    node _T_181 = not(_T_180) @[branchforward.scala 127:7]
    node _T_182 = and(_T_177, _T_181) @[branchforward.scala 125:72]
    node _T_183 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 129:23]
    node _T_184 = eq(io_EX_MEM_memread, io_rs1_sel) @[branchforward.scala 129:61]
    node _T_185 = and(_T_183, _T_184) @[branchforward.scala 129:39]
    node _T_186 = not(_T_185) @[branchforward.scala 129:7]
    node _T_187 = and(_T_182, _T_186) @[branchforward.scala 127:71]
    node _T_188 = eq(io_MEM_WB_rd, io_rs1_sel) @[branchforward.scala 130:21]
    node _T_189 = and(_T_187, _T_188) @[branchforward.scala 129:77]
    node _GEN_16 = mux(_T_189, UInt<3>("h5"), _GEN_14) @[branchforward.scala 130:38 branchforward.scala 132:22]
    node _GEN_17 = mux(_T_174, UInt<3>("h5"), _GEN_15) @[branchforward.scala 120:38 branchforward.scala 122:22]
    node _GEN_18 = mux(_T_174, _GEN_14, _GEN_16) @[branchforward.scala 120:38]
    node _GEN_19 = mux(_T_159, UInt<3>("h5"), _GEN_18) @[branchforward.scala 109:69 branchforward.scala 111:20]
    node _GEN_20 = mux(_T_159, UInt<3>("h5"), _GEN_17) @[branchforward.scala 109:69 branchforward.scala 112:20]
    node _GEN_21 = mux(_T_138, UInt<2>("h3"), _GEN_19) @[branchforward.scala 100:38 branchforward.scala 102:22]
    node _GEN_22 = mux(_T_138, _GEN_15, _GEN_20) @[branchforward.scala 100:38]
    node _GEN_23 = mux(_T_123, UInt<2>("h3"), _GEN_22) @[branchforward.scala 90:38 branchforward.scala 92:22]
    node _GEN_24 = mux(_T_123, _GEN_14, _GEN_21) @[branchforward.scala 90:38]
    node _GEN_25 = mux(_T_108, UInt<2>("h3"), _GEN_24) @[branchforward.scala 79:69 branchforward.scala 81:20]
    node _GEN_26 = mux(_T_108, UInt<2>("h3"), _GEN_23) @[branchforward.scala 79:69 branchforward.scala 82:20]
    node _T_190 = eq(io_ctrl_branch, UInt<1>("h0")) @[branchforward.scala 137:26]
    node _T_191 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 139:26]
    node _T_192 = neq(io_ID_EX_memread, UInt<1>("h1")) @[branchforward.scala 139:61]
    node _T_193 = and(_T_191, _T_192) @[branchforward.scala 139:41]
    node _T_194 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 139:85]
    node _T_195 = and(_T_193, _T_194) @[branchforward.scala 139:69]
    node _GEN_27 = mux(_T_195, UInt<3>("h6"), UInt<1>("h0")) @[branchforward.scala 139:109 branchforward.scala 140:26 branchforward.scala 19:20]
    node _T_196 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 144:27]
    node _T_197 = neq(io_EX_MEM_memread, UInt<1>("h1")) @[branchforward.scala 144:63]
    node _T_198 = and(_T_196, _T_197) @[branchforward.scala 144:42]
    node _T_199 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 145:26]
    node _T_200 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 145:58]
    node _T_201 = and(_T_199, _T_200) @[branchforward.scala 145:42]
    node _T_202 = not(_T_201) @[branchforward.scala 145:11]
    node _T_203 = and(_T_198, _T_202) @[branchforward.scala 144:71]
    node _T_204 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 146:25]
    node _T_205 = and(_T_203, _T_204) @[branchforward.scala 145:75]
    node _T_206 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 151:34]
    node _T_207 = eq(io_EX_MEM_memread, UInt<1>("h1")) @[branchforward.scala 151:70]
    node _T_208 = and(_T_206, _T_207) @[branchforward.scala 151:49]
    node _T_209 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 152:28]
    node _T_210 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 152:60]
    node _T_211 = and(_T_209, _T_210) @[branchforward.scala 152:44]
    node _T_212 = not(_T_211) @[branchforward.scala 152:13]
    node _T_213 = and(_T_208, _T_212) @[branchforward.scala 151:78]
    node _T_214 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 153:27]
    node _T_215 = and(_T_213, _T_214) @[branchforward.scala 152:77]
    node _GEN_28 = mux(_T_215, UInt<4>("h9"), _GEN_27) @[branchforward.scala 153:44 branchforward.scala 155:28]
    node _GEN_29 = mux(_T_205, UInt<3>("h7"), _GEN_28) @[branchforward.scala 146:42 branchforward.scala 148:26]
    node _T_216 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[branchforward.scala 161:27]
    node _T_217 = neq(io_MEM_WB_memread, UInt<1>("h1")) @[branchforward.scala 161:63]
    node _T_218 = and(_T_216, _T_217) @[branchforward.scala 161:42]
    node _T_219 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 163:26]
    node _T_220 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 163:58]
    node _T_221 = and(_T_219, _T_220) @[branchforward.scala 163:42]
    node _T_222 = not(_T_221) @[branchforward.scala 163:11]
    node _T_223 = and(_T_218, _T_222) @[branchforward.scala 161:71]
    node _T_224 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 165:27]
    node _T_225 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 165:60]
    node _T_226 = and(_T_224, _T_225) @[branchforward.scala 165:43]
    node _T_227 = not(_T_226) @[branchforward.scala 165:11]
    node _T_228 = and(_T_223, _T_227) @[branchforward.scala 163:75]
    node _T_229 = eq(io_MEM_WB_rd, io_rs1_sel) @[branchforward.scala 166:25]
    node _T_230 = and(_T_228, _T_229) @[branchforward.scala 165:77]
    node _T_231 = neq(io_MEM_WB_rd, UInt<1>("h0")) @[branchforward.scala 171:35]
    node _T_232 = eq(io_MEM_WB_memread, UInt<1>("h1")) @[branchforward.scala 171:71]
    node _T_233 = and(_T_231, _T_232) @[branchforward.scala 171:50]
    node _T_234 = neq(io_ID_EX_rd, UInt<1>("h0")) @[branchforward.scala 173:26]
    node _T_235 = eq(io_ID_EX_rd, io_rs1_sel) @[branchforward.scala 173:58]
    node _T_236 = and(_T_234, _T_235) @[branchforward.scala 173:42]
    node _T_237 = not(_T_236) @[branchforward.scala 173:11]
    node _T_238 = and(_T_233, _T_237) @[branchforward.scala 171:79]
    node _T_239 = neq(io_EX_MEM_rd, UInt<1>("h0")) @[branchforward.scala 175:27]
    node _T_240 = eq(io_EX_MEM_rd, io_rs1_sel) @[branchforward.scala 175:60]
    node _T_241 = and(_T_239, _T_240) @[branchforward.scala 175:43]
    node _T_242 = not(_T_241) @[branchforward.scala 175:11]
    node _T_243 = and(_T_238, _T_242) @[branchforward.scala 173:75]
    node _T_244 = eq(io_MEM_WB_rd, io_rs1_sel) @[branchforward.scala 176:25]
    node _T_245 = and(_T_243, _T_244) @[branchforward.scala 175:77]
    node _GEN_30 = mux(_T_245, UInt<4>("ha"), _GEN_29) @[branchforward.scala 176:42 branchforward.scala 178:26]
    node _GEN_31 = mux(_T_230, UInt<4>("h8"), _GEN_30) @[branchforward.scala 166:42 branchforward.scala 168:26]
    node _GEN_32 = mux(_T_190, _GEN_31, UInt<1>("h0")) @[branchforward.scala 137:35 branchforward.scala 19:20]
    node _GEN_33 = mux(_T, _GEN_25, _GEN_32) @[branchforward.scala 21:30]
    node _GEN_34 = mux(_T, _GEN_26, UInt<1>("h0")) @[branchforward.scala 21:30 branchforward.scala 20:20]
    io_forward_rs1 <= _GEN_33
    io_forward_rs2 <= _GEN_34

  module StructuralDetector :
    input clock : Clock
    input reset : UInt<1>
    input io_rs1_sel : UInt<5>
    input io_rs2_sel : UInt<5>
    input io_MEM_WB_regwrite : UInt<1>
    input io_MEM_WB_rd : UInt<5>
    output io_fwd_rs1 : UInt<1>
    output io_fwd_rs2 : UInt<1>

    node _T = eq(io_MEM_WB_regwrite, UInt<1>("h1")) @[structural.scala 15:27]
    node _T_1 = eq(io_MEM_WB_rd, io_rs1_sel) @[structural.scala 15:52]
    node _T_2 = and(_T, _T_1) @[structural.scala 15:35]
    node _GEN_0 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[structural.scala 15:68 structural.scala 16:16 structural.scala 18:16]
    node _T_3 = eq(io_MEM_WB_regwrite, UInt<1>("h1")) @[structural.scala 20:27]
    node _T_4 = eq(io_MEM_WB_rd, io_rs2_sel) @[structural.scala 20:51]
    node _T_5 = and(_T_3, _T_4) @[structural.scala 20:35]
    node _GEN_1 = mux(_T_5, UInt<1>("h1"), UInt<1>("h0")) @[structural.scala 20:67 structural.scala 21:16 structural.scala 23:16]
    io_fwd_rs1 <= _GEN_0
    io_fwd_rs2 <= _GEN_1

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io_address : UInt<32>

    inst pc_module of pc @[toppipe.scala 9:27]
    inst aluctrl_module of alucontrol @[toppipe.scala 10:32]
    inst alu_module of ALU @[toppipe.scala 11:28]
    inst control_module of controller @[toppipe.scala 12:32]
    inst imem_module of imem @[toppipe.scala 13:29]
    inst immediate_module of immediate @[toppipe.scala 14:34]
    inst jalr_module of JALR @[toppipe.scala 15:29]
    inst register_module of register @[toppipe.scala 16:33]
    inst smem_module of memory @[toppipe.scala 17:29]
    inst if_id_module of IF_ID_Reg @[toppipe.scala 21:28]
    inst id_ex_module of ID_EX_Reg @[toppipe.scala 22:29]
    inst ex_mem_module of EX_MEM_Reg @[toppipe.scala 23:30]
    inst mem_wb_moodule of MEM_WB_Reg @[toppipe.scala 24:30]
    inst forward_module of ForwardUnit @[toppipe.scala 26:34]
    inst hazard_module of HazardDetection @[toppipe.scala 27:35]
    inst branchlogic_module of BranchLogic @[toppipe.scala 28:39]
    inst branchforward_module of BranchForward @[toppipe.scala 29:41]
    inst stractural_module of StructuralDetector @[toppipe.scala 30:38]
    node _T = bits(pc_module.io_pc_out, 11, 2) @[toppipe.scala 43:48]
    node _T_1 = bits(if_id_module.io_instr_out, 6, 0) @[toppipe.scala 51:52]
    node _T_2 = bits(if_id_module.io_instr_out, 19, 15) @[toppipe.scala 55:54]
    node _T_3 = bits(if_id_module.io_instr_out, 24, 20) @[toppipe.scala 56:54]
    node _T_4 = bits(if_id_module.io_instr_out, 19, 15) @[toppipe.scala 68:62]
    node _T_5 = bits(if_id_module.io_instr_out, 24, 20) @[toppipe.scala 69:62]
    node _T_6 = eq(stractural_module.io_fwd_rs1, UInt<1>("h1")) @[toppipe.scala 75:39]
    node _GEN_0 = mux(_T_6, register_module.io_writedata, register_module.io_rd1) @[toppipe.scala 75:48 toppipe.scala 76:28 toppipe.scala 78:28]
    node _T_7 = eq(stractural_module.io_fwd_rs2, UInt<1>("h1")) @[toppipe.scala 81:39]
    node _GEN_1 = mux(_T_7, register_module.io_writedata, register_module.io_rd2) @[toppipe.scala 81:48 toppipe.scala 82:28 toppipe.scala 84:28]
    node _T_8 = eq(hazard_module.io_ctrl_forward, UInt<1>("h1")) @[toppipe.scala 88:40]
    node _GEN_2 = mux(_T_8, UInt<1>("h0"), control_module.io_memwrite) @[toppipe.scala 88:52 toppipe.scala 89:37 toppipe.scala 100:37]
    node _GEN_3 = mux(_T_8, UInt<1>("h0"), control_module.io_memread) @[toppipe.scala 88:52 toppipe.scala 90:36 toppipe.scala 101:36]
    node _GEN_4 = mux(_T_8, UInt<1>("h0"), control_module.io_branch) @[toppipe.scala 88:52 toppipe.scala 91:35 toppipe.scala 102:36]
    node _GEN_5 = mux(_T_8, UInt<1>("h0"), control_module.io_regwrite) @[toppipe.scala 88:52 toppipe.scala 92:37 toppipe.scala 103:37]
    node _GEN_6 = mux(_T_8, UInt<1>("h0"), control_module.io_memtoreg) @[toppipe.scala 88:52 toppipe.scala 93:37 toppipe.scala 104:37]
    node _GEN_7 = mux(_T_8, UInt<1>("h0"), control_module.io_aluop) @[toppipe.scala 88:52 toppipe.scala 94:34 toppipe.scala 105:34]
    node _GEN_8 = mux(_T_8, UInt<1>("h0"), control_module.io_opA) @[toppipe.scala 88:52 toppipe.scala 95:32 toppipe.scala 106:32]
    node _GEN_9 = mux(_T_8, UInt<1>("h0"), control_module.io_opB) @[toppipe.scala 88:52 toppipe.scala 96:32 toppipe.scala 107:32]
    node _GEN_10 = mux(_T_8, UInt<1>("h0"), control_module.io_nextpcsel) @[toppipe.scala 88:52 toppipe.scala 97:38 toppipe.scala 108:38]
    node _T_9 = bits(if_id_module.io_instr_out, 19, 15) @[toppipe.scala 118:65]
    node _T_10 = bits(if_id_module.io_instr_out, 24, 20) @[toppipe.scala 119:65]
    node _T_11 = bits(if_id_module.io_instr_out, 14, 12) @[toppipe.scala 125:64]
    node _T_12 = asUInt(immediate_module.io_iimmd_se) @[toppipe.scala 132:55]
    node _T_13 = asUInt(register_module.io_rd1) @[toppipe.scala 133:47]
    node _T_14 = eq(branchforward_module.io_forward_rs1, UInt<1>("h0")) @[toppipe.scala 138:46]
    node _T_15 = asUInt(register_module.io_rd1) @[toppipe.scala 141:55]
    node _T_16 = eq(branchforward_module.io_forward_rs1, UInt<1>("h1")) @[toppipe.scala 143:53]
    node _T_17 = asSInt(alu_module.io_out) @[toppipe.scala 145:59]
    node _T_18 = asUInt(register_module.io_rd1) @[toppipe.scala 146:55]
    node _T_19 = eq(branchforward_module.io_forward_rs1, UInt<2>("h2")) @[toppipe.scala 148:53]
    node _T_20 = asSInt(ex_mem_module.io_alu_out) @[toppipe.scala 150:66]
    node _T_21 = asUInt(register_module.io_rd1) @[toppipe.scala 151:55]
    node _T_22 = eq(branchforward_module.io_forward_rs1, UInt<2>("h3")) @[toppipe.scala 153:53]
    node _T_23 = asUInt(register_module.io_rd1) @[toppipe.scala 156:55]
    node _T_24 = eq(branchforward_module.io_forward_rs1, UInt<3>("h4")) @[toppipe.scala 158:53]
    node _T_25 = asSInt(smem_module.io_output) @[toppipe.scala 160:63]
    node _T_26 = asUInt(register_module.io_rd1) @[toppipe.scala 161:55]
    node _T_27 = eq(branchforward_module.io_forward_rs1, UInt<3>("h5")) @[toppipe.scala 163:53]
    node _T_28 = asUInt(register_module.io_rd1) @[toppipe.scala 166:55]
    node _T_29 = eq(branchforward_module.io_forward_rs1, UInt<3>("h6")) @[toppipe.scala 168:52]
    node _T_30 = eq(branchforward_module.io_forward_rs1, UInt<3>("h7")) @[toppipe.scala 173:53]
    node _T_31 = eq(branchforward_module.io_forward_rs1, UInt<4>("h8")) @[toppipe.scala 178:53]
    node _T_32 = asUInt(register_module.io_writedata) @[toppipe.scala 180:61]
    node _T_33 = eq(branchforward_module.io_forward_rs1, UInt<4>("h9")) @[toppipe.scala 183:53]
    node _T_34 = eq(branchforward_module.io_forward_rs1, UInt<4>("ha")) @[toppipe.scala 188:53]
    node _T_35 = asUInt(register_module.io_writedata) @[toppipe.scala 190:61]
    node _T_36 = asUInt(register_module.io_rd1) @[toppipe.scala 195:55]
    node _GEN_11 = mux(_T_34, _T_35, _T_36) @[toppipe.scala 188:68 toppipe.scala 190:29 toppipe.scala 195:29]
    node _GEN_12 = mux(_T_34, register_module.io_rd1, register_module.io_rd1) @[toppipe.scala 188:68 toppipe.scala 191:38 toppipe.scala 194:38]
    node _GEN_13 = mux(_T_33, smem_module.io_output, _GEN_11) @[toppipe.scala 183:68 toppipe.scala 185:29]
    node _GEN_14 = mux(_T_33, register_module.io_rd1, _GEN_12) @[toppipe.scala 183:68 toppipe.scala 186:38]
    node _GEN_15 = mux(_T_31, _T_32, _GEN_13) @[toppipe.scala 178:68 toppipe.scala 180:29]
    node _GEN_16 = mux(_T_31, register_module.io_rd1, _GEN_14) @[toppipe.scala 178:68 toppipe.scala 181:37]
    node _GEN_17 = mux(_T_30, ex_mem_module.io_alu_out, _GEN_15) @[toppipe.scala 173:68 toppipe.scala 175:29]
    node _GEN_18 = mux(_T_30, register_module.io_rd1, _GEN_16) @[toppipe.scala 173:68 toppipe.scala 176:38]
    node _GEN_19 = mux(_T_29, alu_module.io_out, _GEN_17) @[toppipe.scala 168:67 toppipe.scala 170:29]
    node _GEN_20 = mux(_T_29, register_module.io_rd1, _GEN_18) @[toppipe.scala 168:67 toppipe.scala 171:38]
    node _GEN_21 = mux(_T_27, register_module.io_writedata, _GEN_20) @[toppipe.scala 163:68 toppipe.scala 165:37]
    node _GEN_22 = mux(_T_27, _T_28, _GEN_19) @[toppipe.scala 163:68 toppipe.scala 166:29]
    node _GEN_23 = mux(_T_24, _T_25, _GEN_21) @[toppipe.scala 158:68 toppipe.scala 160:38]
    node _GEN_24 = mux(_T_24, _T_26, _GEN_22) @[toppipe.scala 158:68 toppipe.scala 161:29]
    node _GEN_25 = mux(_T_22, register_module.io_writedata, _GEN_23) @[toppipe.scala 153:68 toppipe.scala 155:38]
    node _GEN_26 = mux(_T_22, _T_23, _GEN_24) @[toppipe.scala 153:68 toppipe.scala 156:29]
    node _GEN_27 = mux(_T_19, _T_20, _GEN_25) @[toppipe.scala 148:68 toppipe.scala 150:38]
    node _GEN_28 = mux(_T_19, _T_21, _GEN_26) @[toppipe.scala 148:68 toppipe.scala 151:29]
    node _GEN_29 = mux(_T_16, _T_17, _GEN_27) @[toppipe.scala 143:68 toppipe.scala 145:38]
    node _GEN_30 = mux(_T_16, _T_18, _GEN_28) @[toppipe.scala 143:68 toppipe.scala 146:29]
    node _GEN_31 = mux(_T_14, register_module.io_rd1, _GEN_29) @[toppipe.scala 138:61 toppipe.scala 140:38]
    node _GEN_32 = mux(_T_14, _T_15, _GEN_30) @[toppipe.scala 138:61 toppipe.scala 141:29]
    node _T_37 = eq(branchforward_module.io_forward_rs2, UInt<1>("h0")) @[toppipe.scala 200:46]
    node _T_38 = eq(branchforward_module.io_forward_rs2, UInt<1>("h1")) @[toppipe.scala 204:53]
    node _T_39 = asSInt(alu_module.io_out) @[toppipe.scala 206:60]
    node _T_40 = eq(branchforward_module.io_forward_rs2, UInt<2>("h2")) @[toppipe.scala 208:53]
    node _T_41 = asSInt(ex_mem_module.io_alu_out) @[toppipe.scala 210:67]
    node _T_42 = eq(branchforward_module.io_forward_rs2, UInt<2>("h3")) @[toppipe.scala 212:53]
    node _T_43 = eq(branchforward_module.io_forward_rs2, UInt<3>("h4")) @[toppipe.scala 216:53]
    node _T_44 = asSInt(smem_module.io_output) @[toppipe.scala 218:63]
    node _T_45 = eq(branchforward_module.io_forward_rs2, UInt<3>("h5")) @[toppipe.scala 220:53]
    node _GEN_33 = mux(_T_45, register_module.io_writedata, register_module.io_rd2) @[toppipe.scala 220:67 toppipe.scala 222:39 toppipe.scala 225:39]
    node _GEN_34 = mux(_T_43, _T_44, _GEN_33) @[toppipe.scala 216:67 toppipe.scala 218:38]
    node _GEN_35 = mux(_T_42, register_module.io_writedata, _GEN_34) @[toppipe.scala 212:67 toppipe.scala 214:39]
    node _GEN_36 = mux(_T_40, _T_41, _GEN_35) @[toppipe.scala 208:67 toppipe.scala 210:39]
    node _GEN_37 = mux(_T_38, _T_39, _GEN_36) @[toppipe.scala 204:67 toppipe.scala 206:39]
    node _GEN_38 = mux(_T_37, register_module.io_rd2, _GEN_37) @[toppipe.scala 200:60 toppipe.scala 202:39]
    node _T_46 = asUInt(register_module.io_rd1) @[toppipe.scala 233:54]
    node _T_47 = asUInt(register_module.io_rd2) @[toppipe.scala 234:52]
    node _T_48 = bits(if_id_module.io_instr_out, 14, 12) @[toppipe.scala 235:53]
    node _T_49 = bits(if_id_module.io_instr_out, 30, 30) @[toppipe.scala 236:53]
    node _T_50 = bits(if_id_module.io_instr_out, 19, 15) @[toppipe.scala 245:54]
    node _T_51 = bits(if_id_module.io_instr_out, 24, 20) @[toppipe.scala 246:54]
    node _T_52 = bits(if_id_module.io_instr_out, 11, 7) @[toppipe.scala 247:59]
    node _T_53 = eq(hazard_module.io_instr_forward, UInt<1>("h1")) @[toppipe.scala 259:41]
    node _GEN_39 = mux(_T_53, hazard_module.io_instr_out, imem_module.io_readdata) @[toppipe.scala 259:53 toppipe.scala 260:30 toppipe.scala 263:34]
    node _GEN_40 = mux(_T_53, hazard_module.io_current_pc_out, pc_module.io_pc_out) @[toppipe.scala 259:53 toppipe.scala 261:27 toppipe.scala 47:26]
    node _T_54 = eq(hazard_module.io_pc_forward, UInt<1>("h1")) @[toppipe.scala 267:38]
    node _T_55 = eq(control_module.io_nextpcsel, UInt<1>("h1")) @[toppipe.scala 270:38]
    node _T_56 = eq(branchlogic_module.io_output, UInt<1>("h1")) @[toppipe.scala 271:41]
    node _T_57 = eq(control_module.io_branch, UInt<1>("h1")) @[toppipe.scala 271:77]
    node _T_58 = and(_T_56, _T_57) @[toppipe.scala 271:49]
    node _T_59 = asUInt(immediate_module.io_sbimmd_se) @[toppipe.scala 272:60]
    node _GEN_41 = mux(_T_58, _T_59, pc_module.io_pc_out4) @[toppipe.scala 271:86 toppipe.scala 272:27 toppipe.scala 277:27]
    node _GEN_42 = mux(_T_58, UInt<1>("h0"), _GEN_40) @[toppipe.scala 271:86 toppipe.scala 273:31]
    node _GEN_43 = mux(_T_58, UInt<1>("h0"), pc_module.io_pc_out4) @[toppipe.scala 271:86 toppipe.scala 274:32 toppipe.scala 48:27]
    node _GEN_44 = mux(_T_58, UInt<1>("h0"), _GEN_39) @[toppipe.scala 271:86 toppipe.scala 275:34]
    node _T_60 = eq(control_module.io_nextpcsel, UInt<2>("h2")) @[toppipe.scala 280:46]
    node _T_61 = asUInt(immediate_module.io_ujimmd_se) @[toppipe.scala 281:58]
    node _T_62 = eq(control_module.io_nextpcsel, UInt<2>("h3")) @[toppipe.scala 285:45]
    node _GEN_45 = mux(_T_62, jalr_module.io_out, pc_module.io_pc_out4) @[toppipe.scala 285:58 toppipe.scala 286:25 toppipe.scala 292:25]
    node _GEN_46 = mux(_T_62, UInt<1>("h0"), _GEN_40) @[toppipe.scala 285:58 toppipe.scala 287:29]
    node _GEN_47 = mux(_T_62, UInt<1>("h0"), pc_module.io_pc_out4) @[toppipe.scala 285:58 toppipe.scala 288:30 toppipe.scala 48:27]
    node _GEN_48 = mux(_T_62, UInt<1>("h0"), _GEN_39) @[toppipe.scala 285:58 toppipe.scala 289:32]
    node _GEN_49 = mux(_T_60, _T_61, _GEN_45) @[toppipe.scala 280:59 toppipe.scala 281:25]
    node _GEN_50 = mux(_T_60, UInt<1>("h0"), _GEN_46) @[toppipe.scala 280:59 toppipe.scala 282:29]
    node _GEN_51 = mux(_T_60, UInt<1>("h0"), _GEN_47) @[toppipe.scala 280:59 toppipe.scala 283:30]
    node _GEN_52 = mux(_T_60, UInt<1>("h0"), _GEN_48) @[toppipe.scala 280:59 toppipe.scala 284:32]
    node _GEN_53 = mux(_T_55, _GEN_41, _GEN_49) @[toppipe.scala 270:51]
    node _GEN_54 = mux(_T_55, _GEN_42, _GEN_50) @[toppipe.scala 270:51]
    node _GEN_55 = mux(_T_55, _GEN_43, _GEN_51) @[toppipe.scala 270:51]
    node _GEN_56 = mux(_T_55, _GEN_44, _GEN_52) @[toppipe.scala 270:51]
    node _GEN_57 = mux(_T_54, hazard_module.io_pc_out, _GEN_53) @[toppipe.scala 267:50 toppipe.scala 268:23]
    node _GEN_58 = mux(_T_54, _GEN_40, _GEN_54) @[toppipe.scala 267:50]
    node _GEN_59 = mux(_T_54, pc_module.io_pc_out4, _GEN_55) @[toppipe.scala 267:50 toppipe.scala 48:27]
    node _GEN_60 = mux(_T_54, _GEN_39, _GEN_56) @[toppipe.scala 267:50]
    node _T_63 = eq(id_ex_module.io_opA_out, UInt<2>("h2")) @[toppipe.scala 304:35]
    node _T_64 = eq(forward_module.io_forward_A, UInt<1>("h0")) @[toppipe.scala 308:38]
    node _T_65 = asUInt(id_ex_module.io_rd1_out) @[toppipe.scala 309:52]
    node _T_66 = eq(forward_module.io_forward_A, UInt<1>("h1")) @[toppipe.scala 310:45]
    node _T_67 = eq(forward_module.io_forward_A, UInt<2>("h2")) @[toppipe.scala 312:45]
    node _T_68 = asUInt(register_module.io_writedata) @[toppipe.scala 313:56]
    node _T_69 = asUInt(id_ex_module.io_rd1_out) @[toppipe.scala 315:52]
    node _GEN_61 = mux(_T_67, _T_68, _T_69) @[toppipe.scala 312:58 toppipe.scala 313:24 toppipe.scala 315:25]
    node _GEN_62 = mux(_T_66, ex_mem_module.io_alu_out, _GEN_61) @[toppipe.scala 310:58 toppipe.scala 311:25]
    node _GEN_63 = mux(_T_64, _T_65, _GEN_62) @[toppipe.scala 308:51 toppipe.scala 309:25]
    node _GEN_64 = mux(_T_63, id_ex_module.io_pc_out4, _GEN_63) @[toppipe.scala 304:48 toppipe.scala 305:28]
    node _T_70 = eq(control_module.io_extendsel, UInt<1>("h0")) @[toppipe.scala 320:39]
    node _T_71 = eq(control_module.io_extendsel, UInt<1>("h1")) @[toppipe.scala 322:48]
    node _T_72 = eq(control_module.io_extendsel, UInt<2>("h2")) @[toppipe.scala 324:48]
    node _GEN_65 = mux(_T_72, immediate_module.io_uimmd_se, asSInt(UInt<1>("h0"))) @[toppipe.scala 324:60 toppipe.scala 325:41 toppipe.scala 326:45]
    node _GEN_66 = mux(_T_71, immediate_module.io_simmd_se, _GEN_65) @[toppipe.scala 322:60 toppipe.scala 323:41]
    node _GEN_67 = mux(_T_70, immediate_module.io_iimmd_se, _GEN_66) @[toppipe.scala 320:51 toppipe.scala 321:41]
    node _T_73 = eq(id_ex_module.io_opB_out, UInt<1>("h1")) @[toppipe.scala 331:34]
    node _T_74 = asUInt(id_ex_module.io_immd_out) @[toppipe.scala 332:60]
    node _T_75 = eq(forward_module.io_forward_B, UInt<1>("h0")) @[toppipe.scala 334:42]
    node _T_76 = eq(forward_module.io_forward_B, UInt<1>("h1")) @[toppipe.scala 335:53]
    node _T_77 = asSInt(ex_mem_module.io_alu_out) @[toppipe.scala 335:123]
    node _T_78 = eq(forward_module.io_forward_B, UInt<2>("h2")) @[toppipe.scala 336:52]
    node _GEN_68 = mux(_T_78, register_module.io_writedata, id_ex_module.io_rd2_out) @[toppipe.scala 336:64 toppipe.scala 336:92 toppipe.scala 338:40]
    node _GEN_69 = mux(_T_76, _T_77, _GEN_68) @[toppipe.scala 335:67 toppipe.scala 335:95]
    node _GEN_70 = mux(_T_75, id_ex_module.io_rd2_out, _GEN_69) @[toppipe.scala 334:54 toppipe.scala 334:82]
    node _T_79 = eq(forward_module.io_forward_B, UInt<1>("h0")) @[toppipe.scala 342:46]
    node _T_80 = asUInt(id_ex_module.io_rd2_out) @[toppipe.scala 343:55]
    node _T_81 = eq(forward_module.io_forward_B, UInt<1>("h1")) @[toppipe.scala 345:45]
    node _T_82 = asSInt(ex_mem_module.io_alu_out) @[toppipe.scala 347:64]
    node _T_83 = eq(forward_module.io_forward_B, UInt<2>("h2")) @[toppipe.scala 348:45]
    node _T_84 = asUInt(register_module.io_writedata) @[toppipe.scala 349:60]
    node _T_85 = asUInt(id_ex_module.io_rd2_out) @[toppipe.scala 352:54]
    node _GEN_71 = mux(_T_83, _T_84, _T_85) @[toppipe.scala 348:58 toppipe.scala 349:28 toppipe.scala 352:27]
    node _GEN_72 = mux(_T_83, register_module.io_writedata, id_ex_module.io_rd2_out) @[toppipe.scala 348:58 toppipe.scala 350:36 toppipe.scala 353:36]
    node _GEN_73 = mux(_T_81, ex_mem_module.io_alu_out, _GEN_71) @[toppipe.scala 345:58 toppipe.scala 346:28]
    node _GEN_74 = mux(_T_81, _T_82, _GEN_72) @[toppipe.scala 345:58 toppipe.scala 347:36]
    node _GEN_75 = mux(_T_79, _T_80, _GEN_73) @[toppipe.scala 342:59 toppipe.scala 343:28]
    node _GEN_76 = mux(_T_79, id_ex_module.io_rd2_out, _GEN_74) @[toppipe.scala 342:59 toppipe.scala 344:35]
    node _GEN_77 = mux(_T_73, _T_74, _GEN_75) @[toppipe.scala 331:42 toppipe.scala 332:32]
    node _GEN_78 = mux(_T_73, _GEN_70, _GEN_76) @[toppipe.scala 331:42]
    node _T_86 = asUInt(ex_mem_module.io_stdata_out) @[toppipe.scala 366:56]
    node _T_87 = eq(mem_wb_moodule.io_memtoreg_out, UInt<1>("h0")) @[toppipe.scala 387:37]
    node _T_88 = asSInt(mem_wb_moodule.io_alu_out) @[toppipe.scala 387:76]
    node _T_89 = eq(mem_wb_moodule.io_memtoreg_out, UInt<1>("h1")) @[toppipe.scala 388:37]
    node _T_90 = asSInt(mem_wb_moodule.io_dataout_out) @[toppipe.scala 388:80]
    node _T_91 = mux(_T_89, _T_90, asSInt(UInt<1>("h0"))) @[Mux.scala 98:16]
    node _T_92 = mux(_T_87, _T_88, _T_91) @[Mux.scala 98:16]
    io_address <= imem_module.io_address @[toppipe.scala 52:16]
    pc_module.clock <= clock
    pc_module.reset <= reset
    pc_module.io_addr <= _GEN_57
    aluctrl_module.clock <= clock
    aluctrl_module.reset <= reset
    aluctrl_module.io_alu <= id_ex_module.io_aluop_out @[toppipe.scala 63:27]
    aluctrl_module.io_f3 <= id_ex_module.io_f3_out @[toppipe.scala 65:25]
    aluctrl_module.io_f7 <= id_ex_module.io_f7_out @[toppipe.scala 64:26]
    alu_module.clock <= clock
    alu_module.reset <= reset
    alu_module.io_in_A <= _GEN_64
    alu_module.io_in_B <= _GEN_77
    alu_module.io_alu_Op <= aluctrl_module.io_alucontrolout @[toppipe.scala 356:26]
    control_module.clock <= clock
    control_module.reset <= reset
    control_module.io_in <= _T_1 @[toppipe.scala 51:25]
    imem_module.clock <= clock
    imem_module.reset <= reset
    imem_module.io_address <= _T @[toppipe.scala 43:27]
    immediate_module.clock <= clock
    immediate_module.reset <= reset
    immediate_module.io_instr <= if_id_module.io_instr_out @[toppipe.scala 59:30]
    immediate_module.io_pc <= if_id_module.io_pc_out @[toppipe.scala 60:27]
    jalr_module.clock <= clock
    jalr_module.reset <= reset
    jalr_module.io_addr <= _GEN_32
    jalr_module.io_pc <= _T_13 @[toppipe.scala 133:22]
    register_module.clock <= clock
    register_module.reset <= reset
    register_module.io_regwrite <= mem_wb_moodule.io_regwrite_out @[toppipe.scala 392:33]
    register_module.io_writereg <= mem_wb_moodule.io_rd_out @[toppipe.scala 393:33]
    register_module.io_rs1 <= _T_2 @[toppipe.scala 55:27]
    register_module.io_rs2 <= _T_3 @[toppipe.scala 56:27]
    register_module.io_writedata <= _T_92 @[toppipe.scala 386:34]
    smem_module.clock <= clock
    smem_module.reset <= reset
    smem_module.io_w_enable <= ex_mem_module.io_memwrite_out @[toppipe.scala 367:29]
    smem_module.io_r_enable <= ex_mem_module.io_memread_out @[toppipe.scala 368:29]
    smem_module.io_addr <= bits(ex_mem_module.io_alu_out, 7, 0) @[toppipe.scala 365:25]
    smem_module.io_data <= _T_86 @[toppipe.scala 366:25]
    if_id_module.clock <= clock
    if_id_module.reset <= reset
    if_id_module.io_pc_in <= _GEN_58
    if_id_module.io_pc_in4 <= _GEN_59
    if_id_module.io_instr_in <= _GEN_60
    id_ex_module.clock <= clock
    id_ex_module.reset <= reset
    id_ex_module.io_pc_in <= if_id_module.io_pc_out @[toppipe.scala 243:26]
    id_ex_module.io_pc_in4 <= if_id_module.io_pc_out4 @[toppipe.scala 244:27]
    id_ex_module.io_branch_in <= control_module.io_branch @[toppipe.scala 240:35]
    id_ex_module.io_regwrite_in <= control_module.io_regwrite @[toppipe.scala 232:32]
    id_ex_module.io_f3_in <= _T_48 @[toppipe.scala 235:26]
    id_ex_module.io_f7_in <= _T_49 @[toppipe.scala 236:26]
    id_ex_module.io_opA_in <= control_module.io_opA @[toppipe.scala 237:27]
    id_ex_module.io_opB_in <= control_module.io_opB @[toppipe.scala 238:27]
    id_ex_module.io_nextpcsel_in <= control_module.io_nextpcsel @[toppipe.scala 241:38]
    id_ex_module.io_memtoreg_in <= control_module.io_memtoreg @[toppipe.scala 231:32]
    id_ex_module.io_aluop_in <= control_module.io_aluop @[toppipe.scala 239:34]
    id_ex_module.io_memwrite_in <= control_module.io_memwrite @[toppipe.scala 229:32]
    id_ex_module.io_memread_in <= control_module.io_memread @[toppipe.scala 230:31]
    id_ex_module.io_immd_in <= _GEN_67
    id_ex_module.io_rs1_in <= _T_50 @[toppipe.scala 245:27]
    id_ex_module.io_rs2_in <= _T_51 @[toppipe.scala 246:27]
    id_ex_module.io_rd1_in <= register_module.io_rd1 @[toppipe.scala 248:28]
    id_ex_module.io_rd2_in <= register_module.io_rd2 @[toppipe.scala 249:31]
    id_ex_module.io_writereg_in <= _T_52 @[toppipe.scala 247:32]
    ex_mem_module.clock <= clock
    ex_mem_module.reset <= reset
    ex_mem_module.io_stdata_in <= _GEN_78
    ex_mem_module.io_alu_in <= alu_module.io_out @[toppipe.scala 299:29]
    ex_mem_module.io_rd_in <= id_ex_module.io_writereg_out @[toppipe.scala 300:28]
    ex_mem_module.io_memwrite_in <= id_ex_module.io_memwrite_out @[toppipe.scala 360:34]
    ex_mem_module.io_memread_in <= id_ex_module.io_memread_out @[toppipe.scala 361:33]
    ex_mem_module.io_regwrite_in <= id_ex_module.io_regwrite_out @[toppipe.scala 296:34]
    ex_mem_module.io_memtoreg_in <= id_ex_module.io_memtoreg_out @[toppipe.scala 297:34]
    mem_wb_moodule.clock <= clock
    mem_wb_moodule.reset <= reset
    mem_wb_moodule.io_alu_in <= ex_mem_module.io_alu_out @[toppipe.scala 382:30]
    mem_wb_moodule.io_rd_in <= ex_mem_module.io_rd_out @[toppipe.scala 383:29]
    mem_wb_moodule.io_dataout_in <= smem_module.io_output @[toppipe.scala 381:34]
    mem_wb_moodule.io_memread_in <= ex_mem_module.io_memread_out @[toppipe.scala 379:34]
    mem_wb_moodule.io_regwrite_in <= ex_mem_module.io_regwrite_out @[toppipe.scala 377:35]
    mem_wb_moodule.io_memwrite_in <= ex_mem_module.io_memwrite_out @[toppipe.scala 380:35]
    mem_wb_moodule.io_memtoreg_in <= ex_mem_module.io_memtoreg_out @[toppipe.scala 378:35]
    forward_module.clock <= clock
    forward_module.reset <= reset
    forward_module.io_EX_MEM_rd <= ex_mem_module.io_rd_out @[toppipe.scala 33:33]
    forward_module.io_ID_EX_rs1 <= id_ex_module.io_rs1_out @[toppipe.scala 34:33]
    forward_module.io_ID_EX_rs2 <= id_ex_module.io_rs2_out @[toppipe.scala 35:33]
    forward_module.io_EX_MEM_regwrite <= ex_mem_module.io_regwrite_out @[toppipe.scala 36:39]
    forward_module.io_MEM_WB_rd <= mem_wb_moodule.io_rd_out @[toppipe.scala 37:33]
    forward_module.io_MEM_WB_regwrite <= mem_wb_moodule.io_regwrite_out @[toppipe.scala 38:39]
    hazard_module.clock <= clock
    hazard_module.reset <= reset
    hazard_module.io_IF_ID_instr <= if_id_module.io_instr_out @[toppipe.scala 253:34]
    hazard_module.io_ID_EX_memread <= id_ex_module.io_memread_out @[toppipe.scala 254:36]
    hazard_module.io_ID_EX_rd <= id_ex_module.io_writereg_out @[toppipe.scala 255:31]
    hazard_module.io_pc_in <= if_id_module.io_pc_out4 @[toppipe.scala 256:28]
    hazard_module.io_current_pc_in <= if_id_module.io_pc_out @[toppipe.scala 257:36]
    branchlogic_module.clock <= clock
    branchlogic_module.reset <= reset
    branchlogic_module.io_in_rs1 <= _GEN_31
    branchlogic_module.io_in_rs2 <= _GEN_38
    branchlogic_module.io_in_func3 <= _T_11 @[toppipe.scala 125:36]
    branchforward_module.clock <= clock
    branchforward_module.reset <= reset
    branchforward_module.io_ID_EX_rd <= id_ex_module.io_writereg_out @[toppipe.scala 112:38]
    branchforward_module.io_ID_EX_memread <= id_ex_module.io_memread_out @[toppipe.scala 113:43]
    branchforward_module.io_EX_MEM_rd <= ex_mem_module.io_rd_out @[toppipe.scala 114:39]
    branchforward_module.io_EX_MEM_memread <= ex_mem_module.io_memread_out @[toppipe.scala 116:44]
    branchforward_module.io_MEM_WB_rd <= mem_wb_moodule.io_rd_out @[toppipe.scala 115:39]
    branchforward_module.io_MEM_WB_memread <= mem_wb_moodule.io_memread_out @[toppipe.scala 117:44]
    branchforward_module.io_rs1_sel <= _T_9 @[toppipe.scala 118:37]
    branchforward_module.io_rs2_sel <= _T_10 @[toppipe.scala 119:37]
    branchforward_module.io_ctrl_branch <= control_module.io_branch @[toppipe.scala 120:41]
    stractural_module.clock <= clock
    stractural_module.reset <= reset
    stractural_module.io_rs1_sel <= _T_4 @[toppipe.scala 68:34]
    stractural_module.io_rs2_sel <= _T_5 @[toppipe.scala 69:34]
    stractural_module.io_MEM_WB_regwrite <= mem_wb_moodule.io_regwrite_out @[toppipe.scala 71:42]
    stractural_module.io_MEM_WB_rd <= mem_wb_moodule.io_rd_out @[toppipe.scala 70:36]
