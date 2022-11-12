package riscv
import chisel3._
import chisel3 . util . _

class Top extends Module{
    val io = IO(new Bundle{
        val address =Output(UInt(32.W))
    })
    val pc_module = Module(new pc)
    val aluctrl_module = Module(new alucontrol)
    val alu_module = Module(new ALU)
    val control_module = Module(new controller)
    val imem_module = Module(new imem)
    val immediate_module = Module(new immediate)
    val jalr_module = Module(new JALR)
    val register_module = Module(new register)
    val smem_module = Module(new memory)
    //val branch_module = Module(new branchControl)

     //pipline modules
    val if_id_module=Module(new IF_ID_Reg)
    val id_ex_module= Module(new ID_EX_Reg)
    val ex_mem_module= Module(new EX_MEM_Reg)
    val mem_wb_moodule=Module(new MEM_WB_Reg)

	val forward_module=Module(new ForwardUnit)
	val hazard_module = Module(new HazardDetection)
	val branchlogic_module =Module(new BranchLogic)
	val branchforward_module =Module(new BranchForward)
	val stractural_module =Module(new StructuralDetector)


    forward_module.io.EX_MEM_rd := ex_mem_module.io.rd_out
    forward_module.io.ID_EX_rs1 := id_ex_module.io.rs1_out
    forward_module.io.ID_EX_rs2 := id_ex_module.io.rs2_out
    forward_module.io.EX_MEM_regwrite := ex_mem_module.io.regwrite_out
    forward_module.io.MEM_WB_rd := mem_wb_moodule.io.rd_out
    forward_module.io.MEM_WB_regwrite := mem_wb_moodule.io.regwrite_out


    pc_module.io.addr := pc_module.io.pc_out4

    imem_module.io.address:=pc_module.io.pc_out(11,2)

    val instruction = imem_module .io.readdata

    if_id_module.io.pc_in:=pc_module.io.pc_out
    if_id_module.io.pc_in4:=pc_module.io.pc_out4
    if_id_module.io.instr_in:=instruction

    control_module.io.in:=if_id_module.io.instr_out(6,0)
    io.address :=imem_module.io.address

    //register
    register_module.io.rs1:=if_id_module.io.instr_out(19,15)
    register_module.io.rs2:=if_id_module.io.instr_out(24,20)

     // immediate work
    immediate_module.io.instr:=if_id_module.io.instr_out  
    immediate_module.io.pc:=if_id_module.io.pc_out 

    //alucontrol work
    aluctrl_module.io.alu := id_ex_module.io.aluop_out  
    aluctrl_module.io.f7 := id_ex_module.io.f7_out
    aluctrl_module.io.f3:= id_ex_module.io.f3_out      


    stractural_module.io.rs1_sel := if_id_module.io.instr_out(19, 15)
    stractural_module.io.rs2_sel := if_id_module.io.instr_out(24, 20)
    stractural_module.io.MEM_WB_rd := mem_wb_moodule.io.rd_out
    stractural_module.io.MEM_WB_regwrite := mem_wb_moodule.io.regwrite_out


    // for rs1
    when(stractural_module.io.fwd_rs1 === 1.U) {
    id_ex_module.io.rd1_in := register_module.io.writedata
    } .otherwise {
    id_ex_module.io.rd1_in := register_module.io.rd1
    }
    // for rs2
    when(stractural_module.io.fwd_rs2 === 1.U) {
    id_ex_module.io.rd2_in := register_module.io.writedata
    } .otherwise {
    id_ex_module.io.rd2_in := register_module.io.rd2
    }


    when(hazard_module.io.ctrl_forward === "b1".U) {
        id_ex_module.io.memwrite_in := 0.B
        id_ex_module.io.memread_in := 0.B
        id_ex_module.io.branch_in := 0.B
        id_ex_module.io.regwrite_in := 0.U
        id_ex_module.io.memtoreg_in := 0.B
        id_ex_module.io.aluop_in := 0.U
        id_ex_module.io.opA_in := 0.U
        id_ex_module.io.opB_in := 0.U
        id_ex_module.io.nextpcsel_in := 0.U

    } .otherwise {
        id_ex_module.io.memwrite_in :=control_module.io.memwrite
        id_ex_module.io.memread_in :=control_module.io.memread
        id_ex_module.io.branch_in  :=control_module.io.branch
        id_ex_module.io.regwrite_in :=control_module.io.regwrite
        id_ex_module.io.memtoreg_in := control_module.io.memtoreg
        id_ex_module.io.aluop_in := control_module.io.aluop
        id_ex_module.io.opA_in := control_module.io.opA
        id_ex_module.io.opB_in := control_module.io.opB
        id_ex_module.io.nextpcsel_in := control_module.io.nextpcsel
    }

    //branch forward work
    branchforward_module.io.ID_EX_rd := id_ex_module.io.writereg_out
    branchforward_module.io.ID_EX_memread := id_ex_module.io.memread_out
    branchforward_module.io.EX_MEM_rd := ex_mem_module.io.rd_out
    branchforward_module.io.MEM_WB_rd := mem_wb_moodule.io.rd_out
    branchforward_module.io.EX_MEM_memread := ex_mem_module.io.memread_out
    branchforward_module.io.MEM_WB_memread := mem_wb_moodule.io.memread_out
    branchforward_module.io.rs1_sel := if_id_module.io.instr_out(19, 15)
    branchforward_module.io.rs2_sel := if_id_module.io.instr_out(24, 20)
    branchforward_module.io.ctrl_branch := control_module.io.branch

    //branch logic work
    branchlogic_module.io.in_rs1 := register_module.io.rd1
    branchlogic_module.io.in_rs2 := register_module.io.rd2
    branchlogic_module.io.in_func3 := if_id_module.io.instr_out(14,12)


    //jalr_module.io.addr:=immediate_module.io.iimmd_se.asUInt
    //jalr_module.io.pc:=register_module.io.rd1.asUInt

    //jalr work
    jalr_module.io.addr:=immediate_module.io.iimmd_se.asUInt
    jalr_module.io.pc:=register_module.io.rd1.asUInt




    when(branchforward_module.io.forward_rs1 === "b0000".U) {
  // No hazard just use register file data
        branchlogic_module.io.in_rs1 := register_module.io.rd1
        jalr_module.io.addr := register_module.io.rd1.asUInt

    } .elsewhen(branchforward_module.io.forward_rs1 === "b0001".U) {
    // hazard in alu stage forward data from alu output
        branchlogic_module.io.in_rs1 := alu_module.io.out.asSInt
        jalr_module.io.addr := register_module.io.rd1.asUInt

    } .elsewhen(branchforward_module.io.forward_rs1 === "b0010".U) {
    // hazard in EX/MEM stage forward data from EX/MEM.alu_output
        branchlogic_module.io.in_rs1 := ex_mem_module.io.alu_out.asSInt
        jalr_module.io.addr := register_module.io.rd1.asUInt

    } .elsewhen(branchforward_module.io.forward_rs1 === "b0011".U) {
    // hazard in MEM/WB stage forward data from register file write data which will have correct data from the MEM/WB mux
        branchlogic_module.io.in_rs1 := register_module.io.writedata
        jalr_module.io.addr := register_module.io.rd1.asUInt

    } .elsewhen(branchforward_module.io.forward_rs1 === "b0100".U) {
    // hazard in EX/MEM stage and load type instruction so forwarding from data memory data output instead of EX/MEM.alu_output
        branchlogic_module.io.in_rs1 := smem_module.io.output.asSInt
        jalr_module.io.addr := register_module.io.rd1.asUInt

    } .elsewhen(branchforward_module.io.forward_rs1 === "b0101".U) {
    // hazard in MEM/WB stage and load type instruction so forwarding from register file write data which will have the correct output from the mux
        branchlogic_module.io.in_rs1:= register_module.io.writedata
        jalr_module.io.addr := register_module.io.rd1.asUInt

    }.elsewhen(branchforward_module.io.forward_rs1 === "b0110".U) {
        // hazard in alu stage forward data from alu output
        jalr_module.io.addr := alu_module.io.out
        branchlogic_module.io.in_rs1 := register_module.io.rd1

    } .elsewhen(branchforward_module.io.forward_rs1 === "b0111".U) {
        // hazard in EX/MEM stage forward data from EX/MEM.alu_output
        jalr_module.io.addr := ex_mem_module.io.alu_out
        branchlogic_module.io.in_rs1 := register_module.io.rd1

    } .elsewhen(branchforward_module.io.forward_rs1 === "b1000".U) {
        // hazard in MEM/WB stage forward data from register file write data which will have correct data from the MEM/WB mux
        jalr_module.io.addr := register_module.io.writedata.asUInt
        branchlogic_module.io.in_rs1:= register_module.io.rd1

    } .elsewhen(branchforward_module.io.forward_rs1 === "b1001".U) {
        // hazard in EX/MEM stage and load type instruction so forwarding from data memory data output instead of EX/MEM.alu_output
        jalr_module.io.addr := smem_module.io.output
        branchlogic_module.io.in_rs1 := register_module.io.rd1

    } .elsewhen(branchforward_module.io.forward_rs1 === "b1010".U) {
        // hazard in MEM/WB stage and load type instruction so forwarding from register file write data which will have the correct output from the mux
        jalr_module.io.addr := register_module.io.writedata.asUInt
        branchlogic_module.io.in_rs1 := register_module.io.rd1
        
    }.otherwise {
        branchlogic_module.io.in_rs1 := register_module.io.rd1
        jalr_module.io.addr := register_module.io.rd1.asUInt
    }

    
    // FOR REGISTER RS2 in BRANCH LOGIC UNIT
    when(branchforward_module.io.forward_rs2 === "b000".U) {
    // No hazard just use register file data
        branchlogic_module.io.in_rs2  := register_module.io.rd2
    
    } .elsewhen(branchforward_module.io.forward_rs2 === "b001".U) {
    // hazard in alu stage forward data from alu output
        branchlogic_module.io.in_rs2  := alu_module.io.out.asSInt

    } .elsewhen(branchforward_module.io.forward_rs2 === "b010".U) {
    // hazard in EX/MEM stage forward data from EX/MEM.alu_output
        branchlogic_module.io.in_rs2  := ex_mem_module.io.alu_out.asSInt

    } .elsewhen(branchforward_module.io.forward_rs2 === "b011".U) {
    // hazard in MEM/WB stage forward data from register file write data which will have correct data from the MEM/WB mux
        branchlogic_module.io.in_rs2  := register_module.io.writedata

    } .elsewhen(branchforward_module.io.forward_rs2 === "b100".U) {
    // hazard in EX/MEM stage and load type instruction so forwarding from data memory data output instead of EX/MEM.alu_output
        branchlogic_module.io.in_rs2 := smem_module.io.output.asSInt

    } .elsewhen(branchforward_module.io.forward_rs2 === "b101".U) {
    // hazard in MEM/WB stage and load type instruction so forwarding from register file write data which will have the correct output from the mux
        branchlogic_module.io.in_rs2  := register_module.io.writedata
    }
    .otherwise {
        branchlogic_module.io.in_rs2  := register_module.io.rd2
    }

    //id work
    id_ex_module.io.memwrite_in:=control_module.io.memwrite
    id_ex_module.io.memread_in:=control_module.io.memread
    id_ex_module.io.memtoreg_in:=control_module.io.memtoreg
    id_ex_module.io.regwrite_in:=control_module.io.regwrite
    id_ex_module.io.opA_in := register_module.io.rd1.asUInt
    id_ex_module.io.opB_in:=register_module.io.rd2.asUInt
    id_ex_module.io.f3_in:=if_id_module.io.instr_out(14,12)
    id_ex_module.io.f7_in:=if_id_module.io.instr_out(30)
    id_ex_module.io.opA_in:=control_module.io.opA
    id_ex_module.io.opB_in:=control_module.io.opB
	id_ex_module.io.aluop_in := control_module.io.aluop
	id_ex_module.io.branch_in := control_module.io.branch
	id_ex_module.io.nextpcsel_in := control_module.io.nextpcsel

    id_ex_module.io.pc_in:=if_id_module.io.pc_out
    id_ex_module.io.pc_in4:=if_id_module.io.pc_out4
    id_ex_module.io.rs1_in:=if_id_module.io.instr_out(19,15)
    id_ex_module.io.rs2_in:=if_id_module.io.instr_out(24,20)
    id_ex_module.io.writereg_in:=if_id_module.io.instr_out(11,7)
    id_ex_module.io.rd1_in := register_module.io.rd1
	id_ex_module.io.rd2_in:= register_module.io.rd2


    //hazard work
    hazard_module.io.IF_ID_instr := if_id_module.io.instr_out
    hazard_module.io.ID_EX_memread := id_ex_module.io.memread_out
    hazard_module.io.ID_EX_rd := id_ex_module.io.writereg_out
    hazard_module.io.pc_in := if_id_module.io.pc_out4
    hazard_module.io.current_pc_in := if_id_module.io.pc_out

    when(hazard_module.io.instr_forward === "b1".U) {
    if_id_module.io.instr_in := hazard_module.io.instr_out
    if_id_module.io.pc_in := hazard_module.io.current_pc_out
    }.otherwise {
        if_id_module.io.instr_in := imem_module.io.readdata
    }


    when(hazard_module.io.pc_forward === "b1".U) {
    pc_module.io.addr := hazard_module.io.pc_out
    }.otherwise {
    when(control_module.io.nextpcsel === "b01".U) {
      when(branchlogic_module.io.output === 1.B && control_module.io.branch === 1.B) {
        pc_module.io.addr := immediate_module.io.sbimmd_se.asUInt
        if_id_module.io.pc_in := 0.U
        if_id_module.io.pc_in4 := 0.U
        if_id_module.io.instr_in := 0.U
      }.otherwise {
        pc_module.io.addr := pc_module.io.pc_out4
      }

      }.elsewhen(control_module.io.nextpcsel === "b10".U) {
      pc_module.io.addr := immediate_module.io.ujimmd_se.asUInt
      if_id_module.io.pc_in := 0.U
      if_id_module.io.pc_in4 := 0.U
      if_id_module.io.instr_in := 0.U
    } .elsewhen(control_module.io.nextpcsel === "b11".U) {
      pc_module.io.addr := jalr_module.io.out
      if_id_module.io.pc_in := 0.U
      if_id_module.io.pc_in4 := 0.U
      if_id_module.io.instr_in := 0.U

    }.otherwise {
      pc_module.io.addr := pc_module.io.pc_out4
    }}

    
    ex_mem_module.io.regwrite_in := id_ex_module.io.regwrite_out
    ex_mem_module.io.memtoreg_in := id_ex_module.io.memtoreg_out
    ex_mem_module.io.stdata_in := id_ex_module.io.rd2_out
    ex_mem_module.io.alu_in := alu_module.io.out
    ex_mem_module.io.rd_in := id_ex_module.io.writereg_out


    // alu A work
    when (id_ex_module.io.opA_out === "b10".U) {
        alu_module.io.in_A := id_ex_module.io.pc_out4
    } .otherwise{

    when(forward_module.io.forward_A === "b00".U) {
    alu_module.io.in_A  := id_ex_module.io.rd1_out.asUInt
    } .elsewhen(forward_module.io.forward_A === "b01".U) {
    alu_module.io.in_A  := ex_mem_module.io.alu_out
    } .elsewhen(forward_module.io.forward_A === "b10".U) {
    alu_module.io.in_A := register_module.io.writedata.asUInt
    } .otherwise {
    alu_module.io.in_A  := id_ex_module.io.rd1_out.asUInt
    }}


    //alu B work
    when (control_module.io.extendsel === "b00".U){
		id_ex_module.io.immd_in :=immediate_module.io.iimmd_se}
	.elsewhen (control_module.io.extendsel === "b01".U){
		id_ex_module.io.immd_in :=immediate_module.io.simmd_se}
	.elsewhen (control_module.io.extendsel === "b10".U){
		id_ex_module.io.immd_in := immediate_module.io.uimmd_se}
	.otherwise {id_ex_module.io.immd_in := 0.S}


    
    alu_module.io.in_B := 0.U
    when(id_ex_module.io.opB_out === 1.U){
            alu_module.io.in_B := id_ex_module.io.immd_out.asUInt
        
        when(forward_module.io.forward_B === "b00".U){ex_mem_module.io.stdata_in := id_ex_module.io.rd2_out}
            .elsewhen ( forward_module.io.forward_B === "b01".U  ){ex_mem_module.io.stdata_in := ex_mem_module.io.alu_out.asSInt}
            .elsewhen (forward_module.io.forward_B === "b10".U){ex_mem_module.io.stdata_in := register_module.io.writedata}
        .otherwise {
            ex_mem_module.io.stdata_in := id_ex_module.io.rd2_out
            }
        }                      
        .otherwise{
            when(forward_module.io.forward_B === "b00".U) {
        alu_module.io.in_B := id_ex_module.io.rd2_out.asUInt
        ex_mem_module.io.stdata_in:= id_ex_module.io.rd2_out
    } .elsewhen(forward_module.io.forward_B === "b01".U) {
        alu_module.io.in_B := ex_mem_module.io.alu_out
        ex_mem_module.io.stdata_in := ex_mem_module.io.alu_out.asSInt
    } .elsewhen(forward_module.io.forward_B === "b10".U) {
        alu_module.io.in_B := register_module.io.writedata.asUInt
        ex_mem_module.io.stdata_in := register_module.io.writedata
    } .otherwise {
        alu_module.io.in_B:= id_ex_module.io.rd2_out.asUInt
        ex_mem_module.io.stdata_in := id_ex_module.io.rd2_out
        }}

    alu_module.io.alu_Op := aluctrl_module.io.alucontrolout


    // memory work
    ex_mem_module.io.memwrite_in := id_ex_module.io.memwrite_out
    ex_mem_module.io.memread_in := id_ex_module.io.memread_out



    smem_module.io.addr := ex_mem_module.io.alu_out
    smem_module.io.data := ex_mem_module.io.stdata_out.asUInt
    smem_module.io.w_enable := ex_mem_module.io.memwrite_out
    smem_module.io.r_enable := ex_mem_module.io.memread_out

     //smem_module.io.addr:=alu_module.io.out(9,2)
    // smem_module.io.data:=register_module.io.rd2.asUInt
    // smem_module.io.w_enable:=control_module.io.memwrite
    // smem_module.io.r_enable:=control_module.io.memread

    
    //memory write back work
    mem_wb_moodule.io.regwrite_in := ex_mem_module.io.regwrite_out
    mem_wb_moodule.io.memtoreg_in := ex_mem_module.io.memtoreg_out
    mem_wb_moodule.io.memread_in := ex_mem_module.io.memread_out
    mem_wb_moodule.io.memwrite_in := ex_mem_module.io.memwrite_out
    mem_wb_moodule.io.dataout_in := smem_module.io.output
    mem_wb_moodule.io.alu_in := ex_mem_module.io.alu_out
    mem_wb_moodule.io.rd_in := ex_mem_module.io.rd_out


    register_module.io.writedata := MuxCase( 0.S , Array ( 
    (mem_wb_moodule.io.memtoreg_out === 0.B ) -> mem_wb_moodule.io.alu_out.asSInt ,
    (mem_wb_moodule.io.memtoreg_out === 1.B ) -> mem_wb_moodule.io.dataout_out.asSInt))

    //register_module.io.writedata := Mux(control_module.io.memtoreg,smem_module.io.output.asSInt,alu_module.io.out.asSInt  ) 

    register_module.io.regwrite := mem_wb_moodule.io.regwrite_out
    register_module.io.writereg := mem_wb_moodule.io.rd_out
}





    
    
    
      

    
 
    
    