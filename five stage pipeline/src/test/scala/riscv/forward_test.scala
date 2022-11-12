package riscv
import chisel3._
import org.scalatest._
import chiseltest._
class forwardtest extends FreeSpec with ChiselScalatestTester{
    "Forward test" in {
        test(new ForwardUnit){ c =>
        c.io.EX_MEM_rd.poke(1.U)
        c.io.ID_EX_rs2.poke(1.U)
        c.io.ID_EX_rs1.poke(1.U)
        c.io.EX_MEM_regwrite.poke(1.U)
        c.io.MEM_WB_rd.poke(1.U)
        c.io.MEM_WB_regwrite.poke(1.U)
        c.io.forward_A.expect(1.U)
        c.io.forward_B.expect(1.U)
        c.clock.step(20)

        
       
        }
    }
}