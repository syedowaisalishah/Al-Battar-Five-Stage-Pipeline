package riscv
import chisel3._
import org.scalatest._
import chiseltest._

class toptest  extends FreeSpec with ChiselScalatestTester {
    "top test" in {
        test(new Top()){c=>
        c.clock.step(100)
        }
    }
}