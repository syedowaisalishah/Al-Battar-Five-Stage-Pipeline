package riscv
import chisel3._
import chisel3.util._

class IF_ID_Reg extends Module {
  val io = IO (new Bundle {

	val pc_in = Input(UInt(32.W))
	val pc_out = Output(UInt(32.W))
	val pc_in4 = Input(UInt(32.W))
	val pc_out4 = Output(UInt(32.W))
	val instr_in = Input(UInt(32.W))
	val instr_out = Output(UInt(32.W))
})

	val pcreg = RegInit(0.U(32.W))
	val pc4reg = RegInit(0.U(32.W))
	val instrreg= RegInit(0.U(32.W))

	pcreg := io.pc_in
	io.pc_out := pcreg
	pc4reg := io.pc_in4
	io.pc_out4 := pc4reg
	instrreg := io.instr_in
	io.instr_out := instrreg
}
