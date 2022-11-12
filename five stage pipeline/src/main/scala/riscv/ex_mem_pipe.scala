package riscv
import chisel3._
import chisel3.util._

class EX_MEM_Reg extends Module {
  val io = IO (new Bundle {

	val stdata_in = Input(SInt(32.W))
	val stdata_out = Output(SInt(32.W))

	val alu_in = Input(UInt(32.W))
	val alu_out = Output(UInt(32.W))

	val rd_in = Input(UInt(5.W))
	val rd_out = Output(UInt(5.W))
 
	val memwrite_in = Input(Bool())
	val memread_in = Input(Bool())

	val regwrite_in = Input(UInt(1.W))
	val memtoreg_in = Input(Bool())

	val memwrite_out = Output(Bool())
	val memread_out = Output(Bool())

	val regwrite_out = Output(UInt(1.W))
	val memtoreg_out = Output(Bool())
  })

	val stdatareg = RegInit(0.S(32.W))
	val memwritereg = RegInit(0.B)
	val memreadreg = RegInit(0.B)
	val regwritereg = RegInit(0.U(1.W))
	val memtoregreg = RegInit(0.B)
	val alureg = RegInit(0.U(32.W))
	val rdreg = RegInit(0.U(5.W))

	stdatareg := io.stdata_in
	io.stdata_out := stdatareg

	alureg := io.alu_in
	io.alu_out := alureg

	rdreg := io.rd_in
	io.rd_out := rdreg

	memwritereg := io.memwrite_in
	io.memwrite_out := memwritereg

	memreadreg := io.memread_in
	io.memread_out := memreadreg

	regwritereg := io.regwrite_in
	io.regwrite_out := regwritereg

	memtoregreg := io.memtoreg_in
	io.memtoreg_out := memtoregreg

}