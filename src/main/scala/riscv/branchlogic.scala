package riscv
import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

class BranchLogic extends Module {
  val io = IO(new Bundle {
    val in_rs1 = Input(SInt(32.W))
    val in_rs2 = Input(SInt(32.W))
    val in_func3 = Input(UInt(3.W))
    val output = Output(Bool())
  })

  when(io.in_func3 === "b000".U) {
    // BEQ
    when(io.in_rs1 === io.in_rs2) {
      io.output := 1.B
    } .otherwise {
      io.output := 0.B
    }
  } .elsewhen(io.in_func3 === "b001".U) {
    // BNE
    when(io.in_rs1 =/= io.in_rs2) {
      io.output := 1.B
    } .otherwise {
      io.output := 0.B
    }
  } .elsewhen(io.in_func3 === "b100".U) {
    // BLT
    when(io.in_rs1 < io.in_rs2) {
      io.output := 1.B
    } .otherwise {
      io.output := 0.B
    }
  } .elsewhen(io.in_func3 === "b101".U) {
    // BGE
    when(io.in_rs1 >= io.in_rs2) {
      io.output := 1.B
    } .otherwise {
      io.output := 0.B
    }
  } .elsewhen(io.in_func3 === "b110".U) {
    // BLTU
    when(io.in_rs1.asUInt < io.in_rs2.asUInt) {
      io.output := 1.B
    } .otherwise {
      io.output := 0.B
    }
  } .elsewhen(io.in_func3 === "b111".U) {
    // BGEU
    when(io.in_rs1.asUInt >= io.in_rs2.asUInt) {
      io.output := 1.B
    } .otherwise {
      io.output := 0.B
    }
  } .otherwise {
    io.output := 0.B
  }

}