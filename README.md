# SoC-Lab

[![Travis](https://img.shields.io/badge/build-passing-green.svg)](https://github.com/Fassial/SoC-Lab/commits/master)
[![Language](https://img.shields.io/badge/language-Verilog-yellow.svg)](https://baike.baidu.com/item/Verilog%20HDL/596353?fr=aladdin)
[![GitHub last commit (branch)](https://img.shields.io/badge/last%20commit-April-red.svg)](https://github.com/Fassial/SoC-Lab/commits/master)

大二下学期<b>` 计算机系统综合 - (SoC) `</b>专业课的MIPS-FPGA设计实验代码(基于`Xilinx ISE`EDA软件开发平台和`浙江大学Sword(Xilinx Kintex7)`物理开发板).

## 实验一

&emsp;&emsp;一个可以在板子上运行的`Hello World`工程。实现了普通的 4-bit 加法器，低八位开关(视为两个 4-bit 数)作为加法器的输入，低四位LED灯作为加法器的输出。熟悉了ucf配置文件(指示FPGA上引脚具体接给哪一个信号，这些信号都来自于 `Top` 文件中定义的输入输出)的编写，如，本实验中使用的<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab1/adder_4bit/myucf.ucf">myucf.ucf</a>。

## 实验二 & 实验三 & 实验四

&emsp;&emsp;实验二实际编写的部分只有最上层的 <a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab2/Lab2/source_code/Top.v">Top</a> 文件，其他组件如<b>矩阵键盘译码器</b>、<b>7段显示器controller</b>等等都是使用了施青松教授封装好的`ngc`文件，参照`*.v`文件例化而来。本实验调试通了外设的controller代码，但尚未向其中添加CPU等模块。
&emsp;&emsp;实验三是在实验二的基础上向其中添加了<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab3/Lab3/SoC/source_code/CPU/SCPU.ngc">SCPU处理器模块</a>、<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab3/Lab3/SoC/source_code/externel_device/MIO_BUS.ngc">MIO_BUS总线模块</a>以及<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab3/Lab3/SoC/source_code/externel_device/Counter_3_IO.v">INT中断产生模块</a>。由此，整个SoC架构搭建完毕，这就是一个计算机系统了。
&emsp;&emsp;实验四可以看作为实验三之后的一些零碎工作，将`SCPU`微处理器模块进一步划分为<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab4/SoC/source_code/CPU/Data_path.ngc">Datapath</a>和<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab4/SoC/source_code/CPU/SCPU_ctrl.ngc">Control</a>。说是方便以后Debug使用（哈哈哈我倒感觉并没有什么用处，Control的ALUOp信号都和我们定义的不一样，还怎么进行替换找错？而且只是分成了两个模块，我们的Datapath里面可是包含了PC、Registers、Mux等一大堆单元啊！这个Debug效果微乎其微）。

## 实验五

&emsp;&emsp;本实验主要是尝试将SCPU模块替换为上学期<a href = "https://github.com/Fassial/PH-Experiment">计组实验</a>单周期处理器。由于ROM的初始文件<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab5/SoC/ipcore_dir/I9_mem.coe">I9_mem.coe</a>中使用的9条指令(j、beq、add、and、or、slt、nor、lw、sw)不是没有被之前写的单周期微处理器所实现，于是我就按照之前的架构重写了一下该单周期处理器。除了在Control信号上做了一些精简之外，还对代码中一些不可综合的部分进行了改正。
&emsp;&emsp;在这里，我想插一句什么是可综合代码什么是不可综合代码。关于这个问题，网上有一篇博客对此做了一个比较全面的概括 —— <a href = "https://blog.csdn.net/shengzhuzhu/article/details/29673633">`https://blog.csdn.net/shengzhuzhu/article/details/29673633`</a>。我呢，想谈谈我在修改代码的时候遇到的一些坑吧：
<hr>
&emsp;&emsp;1、initial一定不可取不可取不可取！！！重要的事情说三遍！在我之前写的单周期里面，经常喜欢用initial给一些模块赋初值，如Registers、PC等等。其实如果你想该模块初始值被复位为0，并写在initial中，真正在FPGA上执行时，是不会有什么异样。你或许会说，initial在部分情况下还是可以的嘛。哈哈哈，综合布线的时候，initial早就被去掉了，不会有一样只是FPGA的初始状态就是0罢了。要是你想去给Registers的一些特殊寄存器赋初值如：
<pre>
      registers[28] <= 32'h00001800;
			registers[29] <= 32'h00002ffe;
</pre>
&emsp;&emsp;你就会发现异样了。其实替代方案也很简单，使用reset信号就行了。我是这样做的：
<pre>
      always@(negedge clk or negedge reset)
        begin
        if(!reset)
          begin
          for(i = 0;i < num;i = i + 1)
            registers[i] <= 0;
          registers[28] <= 32'h00001800;
          registers[29] <= 32'h00002ffe;
          end
        ...
</pre>

&emsp;&emsp;2、关于异步复位，我有一位同学曾和我一块讨论过这个问题。他说，他当时在没有删除`or negedge reset`的时候，无论怎么修改其他地方都不能让自己的CPU成功在Sword平台上运行起来。对于这个问题我持一种比较谨慎的态度，但我还是更倾向于这是一种可综合的代码。因为，当时我在`Quartus Prime`上综合布线的时候，是完全可以在`Altera CyloneⅣ`上运行的。而且我参考学长的这一实验的代码，也是有这种写法的，我也是这样写的，并也是可以成功嵌入了。

&emsp;&emsp;3、casex、casez这样的语句，能去掉就去掉吧。不是说它是绝对不可综合的代码，但是有些编译器是不认可的，而没法通过它的综合步骤，鬼知道它生成了个什么玩意。我之前在Control中写了不少这样的语句，如：
<pre>
      RegDst = 2'bxx;
</pre>
&emsp;&emsp;因为，我感觉RegWrite都被设置为1'b0了，不会去进行Registers的写操作，那RegDst选择信号是什么不都无所谓了么。Bang！恭喜中奖，还真不行！

&emsp;&emsp;4、还有一个我最最最想吐槽！！！你猜猜硬件晶振产生的reset信号是高位复位还是低位复位？反正当我意识到是高位复位的时候，我已经被它坑了一个星期了。那一整个星期我一直在纳闷为什么在`Altera CyloneⅣ`上已经可以跑通的代码，换到`Sword`就死活跑不了。直到我再翻我在Quartus上源码的时候，发现我在<b>Top文件</b>中实例化了一个`PLL`模块(锁相环)。而实例化时的接线，如下:
<pre>
        pll_controller pll_controller_inst(
          .areset(!ext_rst_n),
          .inclk0(ext_clk_25m),
          .c0(clk_1m),
          .c1(clk_12m5),
          .c2(clk_25m),
          .c3(clk_50m),
          .c4(clk_100m),
          .locked(sys_rst_n)
        );
</pre>
&emsp;&emsp;发现了么！我当时接入的是!ext_rst_n。看到这里我也就明白为什么跑马灯那些效果都显示不出来。这时，我又检查了一下之前代码下到板子上的PC值，果然卡在0x00003000就没变过。为了简便我只对SCPU实例化Mips的地方做了修改:
<pre>
        Mips m_Mips(
          .clk(clk),
          .reset(!reset),
          .MIO_ready(MIO_ready), 
          .inst_in(inst_in),
          .Data_in(Data_in),
          .mem_w(mem_w),
          .PC_out(PC_out),
          .Addr_out(Addr_out),
          .Data_out(Data_out),
          .CPU_MIO(CPU_MIO),
          .INT(INT)
        );
</pre>
<hr>
&emsp;&emsp;今天晚上下到，实验室板子上之后终于出现跑马灯效果了！呜呜呜！！！折腾了我一个半星期终于找到问题关键所在了。过程是很痛苦，但是仔细回想这一阶段的收获——不仅对各种外设熟悉了不少，还学会了很多硬件DEBUG的方法，如通过SW、BTN、Seg7等控制clk_CPU来达到单步调试、查看RF数据的目的(具体项目我是在Quartus中实现的)，使用Quartus自带的逻辑分析仪来通过板子的UART端口在PC机上直接查看信号值等等。

## 实验六

&emsp;&emsp;本实验主要是在实验五的基础上，增加支持指令条数。目前实现了:
<pre>
        R-type：add，sub，and，or，nor，slt，srl，jr，jalr；
        I-type：addi，andi，ori，lui，lw，sw，beq，bne，slti；
        J-type：j，jal；
</pre>
&emsp;&emsp;当然本实验中的ROM初始数据(即测试指令也变了),详情见<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab6/SoC/ipcore_dir/I9_mem.coe">I9_mem.coe</a>。在`Sword`平台上展现的效果与实验五是完全一样的。

## 实验七 & 实验八

&emsp;&emsp;这两个实验老师还没有布置，我只是尝试将上学期写的多周期、流水线嵌入该Soc系统中。测试数据集暂时使用的是和实验五相同的<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab5/SoC/ipcore_dir/I9_mem.coe">I9_mem.coe</a>。注意！多周期的跑马灯等效果会相比单周期慢一些，这主要是由于clk_CPU一定时，多周期中一条指令执行的时间几乎相当于单周期一条指令执行时间的3~5倍。流水线的各种效果和单周期基本无差别。
<hr>
&emsp;&emsp;注意！！！在多周期、流水线中实现的lb、lh、sb、sh指令是暂时没有支持的因为当时是将be信号的处理交由 DataMemory 来处理，但是使用IP核例化而来的RAM可不具备这种功能。后期打算，使用先读后写的方式或者改变RAM每一单元的位宽来实现(如，之前实例化的是 32 * 1024 将之变化为 8 * 4096 )。
