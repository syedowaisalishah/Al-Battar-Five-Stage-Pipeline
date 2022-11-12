package riscv
import chisel3._
import chisel3.util._


class MEM_WB_Reg extends Module {
  val io = IO (new Bundle {

	val alu_in = Input(UInt(32.W))
	val alu_out = Output(UInt(32.W))

	val rd_in = Input(UInt(5.W))
	val rd_out = Output(UInt(5.W))

    val dataout_in = Input(UInt(32.W))
    val dataout_out = Output(UInt(32.W))

    val memread_in = Input(Bool())
    val memread_out = Output(Bool())

	val regwrite_in = Input(UInt(1.W))
	val regwrite_out = Output(UInt(1.W))

    val memwrite_in = Input(Bool())
    val memwrite_out = Output(Bool())

	val memtoreg_in = Input(Bool())
	val memtoreg_out = Output(Bool())
  })
	val dataoutreg = RegInit(0.U(32.W))
    val alureg = RegInit(0.U(32.W))
    val rdreg = RegInit(0.U(5.W))
    val regwritereg = RegInit(0.U(1.W))
    val memtoregreg = RegInit(0.B)
    val memreadreg = RegInit(0. B)
    val memwritereg = RegInit(0.B)


	dataoutreg := io.dataout_in
	io.dataout_out := dataoutreg

	alureg := io.alu_in
	io.alu_out := alureg

	rdreg := io.rd_in
	io.rd_out := rdreg

	regwritereg := io.regwrite_in
	io.regwrite_out := regwritereg

	memtoregreg := io.memtoreg_in
	io.memtoreg_out := memtoregreg

    memreadreg := io.memread_in
    io.memread_out := memreadreg

    memwritereg := io.memwrite_in
    io.memwrite_out := memwritereg
	
}