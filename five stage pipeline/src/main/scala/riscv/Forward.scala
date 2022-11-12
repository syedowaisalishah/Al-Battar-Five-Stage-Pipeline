package riscv
import chisel3._
import chisel3.util._

class ForwardUnit extends Module {
    val io = IO(new Bundle {
        val EX_MEM_rd = Input(UInt(5.W))
        val ID_EX_rs1 = Input(UInt(5.W))
        val ID_EX_rs2 = Input(UInt(5.W))
        val EX_MEM_regwrite = Input(UInt(1.W))
        val MEM_WB_rd = Input(UInt(5.W))
        val MEM_WB_regwrite = Input(UInt(1.W))
        val forward_A = Output(UInt(2.W))
        val forward_B = Output(UInt(2.W))
    })
    io.forward_A := "b00".U
    io.forward_B := "b00".U

// EX HAZARD
      
    when(io.EX_MEM_regwrite === 1.U && io.EX_MEM_rd =/= "b00000".U && (io.EX_MEM_rd=== io.ID_EX_rs1) && (io.EX_MEM_rd === io.ID_EX_rs2)) {
        io.forward_A := "b01".U
		io.forward_B := "b01".U
    } .elsewhen(io.EX_MEM_regwrite === 1.U && io.EX_MEM_rd =/= "b00000".U && (io.EX_MEM_rd === io.ID_EX_rs2)) {
		io.forward_B := "b01".U
    } .elsewhen(io.EX_MEM_regwrite === 1.U && io.EX_MEM_rd =/= "b00000".U && (io.EX_MEM_rd === io.ID_EX_rs1)) {
		io.forward_A := "b01".U
    }

// MEM HAZARD
       when(io.MEM_WB_regwrite === 1.U && io.MEM_WB_rd =/= "b00000".U && ~((io.EX_MEM_regwrite === "b1".U) && (io.EX_MEM_rd =/= "b00000".U) && 
       (io.EX_MEM_rd === io.ID_EX_rs1) && (io.EX_MEM_rd === io.ID_EX_rs2)) && (io.MEM_WB_rd=== io.ID_EX_rs1) && 
       (io.MEM_WB_rd === io.ID_EX_rs2)) {
    		io.forward_A := "b10".U
    		io.forward_B := "b10".U
	} .elsewhen(io.MEM_WB_regwrite === 1.U && io.MEM_WB_rd =/= "b00000".U && ~((io.EX_MEM_regwrite === 1.U) && (io.EX_MEM_rd =/= "b00000".U) && 
    (io.EX_MEM_rd === io.ID_EX_rs2)) && (io.MEM_WB_rd === io.ID_EX_rs2)) {
    		io.forward_B := "b10".U
	} .elsewhen(io.MEM_WB_regwrite === 1.U && io.MEM_WB_rd =/= "b00000".U && ~((io.EX_MEM_regwrite ===1.U) && (io.EX_MEM_rd =/= "b00000".U) && 
    (io.EX_MEM_rd === io.ID_EX_rs2))  &&  (io.MEM_WB_rd === io.ID_EX_rs1)) {
		io.forward_A := "b10".U
	}
}