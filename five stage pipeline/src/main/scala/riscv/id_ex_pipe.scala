package riscv
import chisel3._
import chisel3.util._

class ID_EX_Reg extends Module {
  val io = IO (new Bundle {

	val pc_in = Input(UInt(32.W))
	val pc_out = Output(UInt(32.W))

    val pc_in4 = Input(UInt(32.W))
	val pc_out4 = Output(UInt(32.W))

    //val instr_in = Input(UInt(32.W))
	//val instr_out = Output(UInt(32.W))

    //val imm_in = Input(SInt(32.W))
	//val imm_out = Output(SInt(32.W))

	//val w_enable_in = Input(UInt(1.W))
   // val w_enable_out = Output(UInt(1.W))

    //val r_enable_in = Input(UInt(1.W))
    //val r_enable_out = Output(UInt(1.W))

	val branch_in = Input(Bool())
    val branch_out = Output(Bool())

	val regwrite_in = Input(UInt(1.W))
    val regwrite_out = Output(UInt(1.W))

    val f3_in = Input(UInt(3.W))
    val f3_out = Output(UInt(3.W))

    val f7_in= Input(UInt(1.W))
    val f7_out= Output(UInt(1.W))

    val opA_in=Input(UInt(4.W))
    val opA_out=Output(UInt(4.W))

    val opB_in=Input(UInt(2.W))
    val opB_out=Output(UInt(2.W))

    val nextpcsel_in=Input(UInt(4.W))
    val nextpcsel_out=Output(UInt(4.W))

    val memtoreg_in=Input(Bool())
    val memtoreg_out=Output(Bool())

	val aluop_in = Input(UInt(3.W))
    val aluop_out=Output(UInt(3.W))

	val memwrite_in = Input(Bool())
    val memwrite_out = Output ( Bool())
    
	val memread_in=Input(Bool())
	val memread_out = Output(Bool())
	
	val immd_in = Input(SInt(32.W))
	val immd_out = Output(SInt(32.W))

	val rs1_in = Input(UInt(5.W))
    val rs1_out = Output(UInt(5.W))

	val rs2_in = Input(UInt(5.W))
	val rs2_out = Output(UInt(5.W))

    val rd1_in = Input(SInt(32.W))
    val rd1_out = Output(SInt(32.W))

	val rd2_in = Input(SInt(32.W))
	val rd2_out = Output(SInt(32.W))

	val writereg_in = Input(UInt(5.W))
	val writereg_out = Output(UInt(5.W))

})
    val pcreg = RegInit(0.U(32.W))
    val pc4reg = RegInit(0.U(32.W))
    //val instrreg= RegInit(0.U(32.W))
    //val immreg = RegInit(0.S(32.W))
    val f3reg = RegInit(0.U(3.W))
    val f7reg = RegInit(0.U(1.W))
    //val w_enablereg = RegInit(0.U(1.W))
    //val r_enablereg = RegInit(0.U(1.W))
    val branchreg = RegInit(0.B)
    val regwritereg = RegInit(0.U(1.W))
    val opAreg = RegInit(0.U(4.W))
    val opBreg = RegInit(0.U(2.W))
    val nextpcselreg = RegInit(0.U(4.W))
    val memtoregreg = RegInit(0.B)
    val aluopreg = RegInit(0.U(3.W))
    val memwritereg = RegInit(0.B)
    val memreadreg = RegInit(0.B)
    val immdreg = RegInit(0.S(32.W))
    val rs1reg = RegInit(0.U(5.W))
    val rs2reg = RegInit(0.U(5.W))
    val writeregreg = RegInit(0.U(5.W))
    val rd1reg = RegInit(0.S(32.W))
    val rd2reg = RegInit(0.S(32.W))


    pcreg:=io.pc_in
    io.pc_out:=pcreg

    pc4reg := io.pc_in4
    io.pc_out4 := pc4reg

    //instrreg := io.instr_in
	//io.instr_out := instrreg

    //immdreg := io.immd_in
	//io.immd_out := immdreg


    f3reg := io.f3_in
    io.f3_out := f3reg

    f7reg := io.f7_in
    io.f7_out := f7reg

    //w_enablereg := io.w_enable_in
    //io.w_enable_out := w_enablereg

    //r_enablereg := io.r_enable_in
    //io.r_enable_out := r_enablereg

    branchreg := io.branch_in
    io.branch_out := branchreg

    regwritereg := io.regwrite_in
    io.regwrite_out := regwritereg

    opAreg := io.opA_in
    io.opA_out := opAreg

    opBreg := io.opB_in
    io.opB_out := opBreg
     
    nextpcselreg := io.nextpcsel_in
    io.nextpcsel_out := nextpcselreg

    memtoregreg := io.memtoreg_in
    io.memtoreg_out := memtoregreg

    aluopreg := io.aluop_in
    io.aluop_out := aluopreg

    memwritereg := io.memwrite_in
    io.memwrite_out := memwritereg

    memreadreg := io.memread_in
    io.memread_out := memreadreg

    immdreg := io.immd_in
    io.immd_out := immdreg

    rs1reg := io.rs1_in
    io.rs1_out := rs1reg

    rs2reg := io.rs2_in
    io.rs2_out := rs2reg

    writeregreg := io.writereg_in
    io.writereg_out := writeregreg

    rd1reg := io.rd1_in
    io.rd1_out := rd1reg

    rd2reg := io.rd2_in
    io.rd2_out := rd2reg
}

    







	