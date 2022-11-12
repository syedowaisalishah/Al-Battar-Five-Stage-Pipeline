package riscv
import chisel3._
import org.scalatest._
import chiseltest._

class ifidtest extends FreeSpec with ChiselScalatestTester{
    "if_id testing" in {
        test(new IF_ID_Reg()){c=>
            c.io.pc_in.poke(0.U)
            c.io.pc_in4.poke(0.U)
            c.io.instr_in.poke(0.U)
            c.io.pc_out.expect(0.U)
            c.io.instr_out.expect(0.U)
            c.io.pc_out4.expect(0.U)
            c.clock.step(10)
        }
    }
}       