#Al Battar ، البتار
Five-Stage-Pipeline
<img src='https://github.com/syedowaisalishah/5-stage-pieline/blob/main/5stage_pipeline' height=600 width=100%>
<br>
First of all get started by cloning this repository on your machine.

```ruby
git clone https://github.com/syedowaisalishah/Al-Battar-Five-Stage-Pipeline.git-.git
```

Create a .txt file and place the ***hexadecimal*** code of your instructions simulated on ***Venus*** (RISC-V Simulator)\
Each instruction's hexadecimal code must be on seperate line as following. This program consists of 9 instructions.

```ruby
00500113
00500193
014000EF
00120293
00502023
00002303
00628663
00310233
00008067
```
Then perform the following step
```
cd Al-Battar-Five-Stage-Pipeline\src\riscv\scala\main\scala\hazard
```
Open **InstructionMem.scala** with this command. You can also manually go into the above path and open the file in your favorite text editor.
```ruby
open iMem.scala(instructionmemory)
```
Find the following line
``` python
loadMemoryFromFile(mem, "/home/owais/5-stage-pieline/src/main/scala/riscv/file.txt")
```
Change the .txt file path to match your file that you created above storing your own program instructions. or you can also use this file\
After setting up the InstructionMem.scala file, go inside the RV32i folder.
```ruby
cd Al-Battar-Five-Stage-Pipeline
```
And enter
```ruby
sbt
```
When the terminal changes to this type
```ruby
sbt:Al-Battar-FIVE-STAGE-PIELINE>
```
Enter this command
```ruby
sbt:Al-Battar-FIVE-STAGE-PIELINE> testOnly riscv.toptest -- -DwriteVcd=1
```

After success you will get a folder ***test_run_dir*** on root of your folder. Go into the examples folder inside.\
There you will find the folder named Top. Enter in it and you can find the Top.vcd file which you visualise on **gtkwave** to\
see your program running.

