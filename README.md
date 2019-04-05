# SoC-Lab

[![Travis](https://img.shields.io/badge/build-passing-green.svg)](https://github.com/Fassial/SoC-Lab/commits/master)
[![Language](https://img.shields.io/badge/language-Verilog-yellow.svg)](https://baike.baidu.com/item/Verilog%20HDL/596353?fr=aladdin)
[![GitHub last commit (branch)](https://img.shields.io/badge/last%20commit-March-red.svg)](https://github.com/Fassial/SoC-Lab/commits/master)

大二下学期<b>` 计算机系统综合 - (SoC) `</b>专业课的MIPS-FPGA设计实验代码(基于`Xilinx ISE`EDA软件开发平台和`浙江大学Sword(Xilinx Kintex7)`物理开发板).

## 实验一

&emsp;&emsp;一个可以在板子上运行的`Hello World`工程。实现了普通的 4-bit 加法器，低八位开关(视为两个 4-bit 数)作为加法器的输入，低四位LED灯作为加法器的输出。熟悉了ucg配置文件(指示FPGA上引脚具体接给哪一个信号，这些信号都来自于 `Top` 文件中定义的输入输出)的编写，如，本实验中使用的<a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab1/adder_4bit/myucf.ucf">myucf.ucf</a>。

## 实验二

&emsp;&emsp;本实验实际编写的部分只有最上层的 <a href = "https://github.com/Fassial/SoC-Lab/blob/master/Lab2/Lab2/source_code/Top.v">Top</a> 文件，其他组件如<b>矩阵键盘译码器</b>、<b>7段显示器controller</b>等等都是使用了施青松教授封装好的`ngc`文件，参照`*.v`文件例化而来。本实验调试通了外设的controller代码，但尚未向其中添加CPU等模块。
