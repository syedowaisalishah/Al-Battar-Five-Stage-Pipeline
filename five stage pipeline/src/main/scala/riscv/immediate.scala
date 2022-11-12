package riscv
import chisel3 . _
import chisel3 . util . _

class immediateIO extends Bundle {
    val instr = Input (UInt (32. W ) )
    val iimmd_se = Output ( SInt (32. W ) )
    val simmd_se = Output ( SInt (32. W ) )
    val sbimmd_se = Output ( SInt (32. W ) )
    val uimmd_se = Output ( SInt(32. W ) )
    val ujimmd_se = Output ( SInt (32. W ) )
    val pc=Input(UInt(32.W))
}
class immediate extends Module {
    val io = IO (new immediateIO )
    val opcodes =io.instr(6,0)
    io.iimmd_se:=0.S
    io.simmd_se:=0.S
    io.sbimmd_se:=0.S
    io.ujimmd_se:=0.S
    io.uimmd_se:=0.S

    io.iimmd_se:=(Cat(Fill(20,io.instr(31)),io.instr(31,20))).asSInt//i type
        
    io.simmd_se:=(Cat(Fill(20,io.instr(31)),io.instr(31,25),io.instr(11,7))).asSInt//s type
        
    io.sbimmd_se:=(Cat(Fill(19,io.instr(31)),io.instr(31),io.instr(7),io.instr(30,25),io.instr(11,8), "b0".U) + io.pc).asSInt//sb type

    io.uimmd_se:=((Cat(Fill(12,io.instr(31)),io.instr(31,12)))<<12).asSInt//u type

    io.ujimmd_se:=(Cat(Fill(12,io.instr(31)),io.instr(31),io.instr(19,12),io.instr(20),io.instr(31,21),"b0".U) +io.pc).asSInt//uj type
}
