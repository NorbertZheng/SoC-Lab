<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <blockdef name="add_32">
            <timestamp>2015-6-28T14:11:36</timestamp>
            <line x2="16" y1="-48" y2="-48" style="linewidth:W" x1="32" />
            <line x2="16" y1="-16" y2="-16" style="linewidth:W" x1="32" />
            <line x2="96" y1="4" y2="-16" x1="32" />
            <line x2="32" y1="-24" y2="4" x1="32" />
            <line x2="44" y1="-24" y2="-32" x1="32" />
            <line x2="44" y1="-40" y2="-32" x1="32" />
            <line x2="32" y1="-40" y2="-68" x1="32" />
            <line x2="96" y1="-68" y2="-48" x1="32" />
            <line x2="96" y1="-48" y2="-16" x1="96" />
            <line x2="112" y1="-32" y2="-32" style="linewidth:W" x1="96" />
        </blockdef>
        <blockdef name="ADC32">
            <timestamp>2014-6-26T17:20:38</timestamp>
            <line x2="48" y1="-256" y2="-256" style="linewidth:W" x1="64" />
            <line x2="48" y1="-128" y2="-128" style="linewidth:W" x1="64" />
            <line x2="64" y1="-224" y2="-300" x1="64" />
            <line x2="112" y1="-224" y2="-192" x1="64" />
            <line x2="112" y1="-160" y2="-192" x1="64" />
            <line x2="64" y1="-160" y2="-76" x1="64" />
            <line x2="224" y1="-76" y2="-140" x1="64" />
            <line x2="224" y1="-300" y2="-236" x1="64" />
            <line x2="224" y1="-140" y2="-236" x1="224" />
            <line x2="240" y1="-192" y2="-192" style="linewidth:W" x1="224" />
            <line x2="128" y1="-304" y2="-276" x1="128" />
        </blockdef>
        <blockdef name="or32">
            <timestamp>2014-3-19T13:34:26</timestamp>
            <line x2="64" y1="-16" y2="-16" x1="128" />
            <arc ex="208" ey="-64" sx="128" sy="-16" r="88" cx="132" cy="-104" />
            <arc ex="128" ey="-112" sx="208" sy="-64" r="88" cx="132" cy="-24" />
            <line x2="236" y1="-64" y2="-64" style="linewidth:W" x1="208" />
            <line x2="64" y1="-112" y2="-112" x1="128" />
            <line x2="48" y1="-96" y2="-96" style="linewidth:W" x1="80" />
            <arc ex="64" ey="-112" sx="64" sy="-16" r="56" cx="32" cy="-64" />
            <line x2="48" y1="-32" y2="-32" style="linewidth:W" x1="80" />
        </blockdef>
        <blockdef name="and32">
            <timestamp>2014-3-19T13:28:4</timestamp>
            <line x2="32" y1="-96" y2="-96" style="linewidth:W" x1="64" />
            <line x2="28" y1="-32" y2="-32" style="linewidth:W" x1="64" />
            <line x2="64" y1="-16" y2="-16" x1="144" />
            <line x2="64" y1="-16" y2="-112" x1="64" />
            <line x2="144" y1="-112" y2="-112" x1="64" />
            <arc ex="144" ey="-112" sx="144" sy="-16" r="48" cx="144" cy="-64" />
            <line x2="224" y1="-64" y2="-64" style="linewidth:W" x1="192" />
        </blockdef>
        <blockdef name="nor32">
            <timestamp>2014-3-19T13:43:44</timestamp>
            <line x2="64" y1="-112" y2="-112" x1="128" />
            <arc ex="64" ey="-112" sx="64" sy="-16" r="56" cx="32" cy="-64" />
            <line x2="64" y1="-16" y2="-16" x1="128" />
            <arc ex="208" ey="-64" sx="128" sy="-16" r="88" cx="132" cy="-104" />
            <arc ex="128" ey="-112" sx="208" sy="-64" r="88" cx="132" cy="-24" />
            <line x2="224" y1="-64" y2="-64" style="linewidth:W" x1="256" />
            <circle style="linewidth:W" r="8" cx="216" cy="-64" />
            <line x2="48" y1="-96" y2="-96" style="linewidth:W" x1="80" />
            <line x2="48" y1="-32" y2="-32" style="linewidth:W" x1="80" />
        </blockdef>
        <blockdef name="xor32">
            <timestamp>2014-3-19T14:4:0</timestamp>
            <arc ex="80" ey="-112" sx="80" sy="-16" r="56" cx="48" cy="-64" />
            <line x2="80" y1="-112" y2="-112" x1="144" />
            <line x2="80" y1="-16" y2="-16" x1="144" />
            <arc ex="144" ey="-112" sx="224" sy="-64" r="88" cx="148" cy="-24" />
            <arc ex="60" ey="-112" sx="64" sy="-16" r="56" cx="32" cy="-64" />
            <arc ex="224" ey="-64" sx="144" sy="-16" r="88" cx="148" cy="-104" />
            <line x2="80" y1="-96" y2="-96" style="linewidth:W" x1="32" />
            <line x2="80" y1="-32" y2="-32" style="linewidth:W" x1="32" />
            <line x2="228" y1="-64" y2="-64" style="linewidth:W" x1="256" />
        </blockdef>
        <blockdef name="or_bit_32">
            <timestamp>2014-3-19T14:52:26</timestamp>
            <rect width="220" x="64" y="-104" height="112" />
            <line x2="32" y1="-48" y2="-48" style="linewidth:W" x1="64" />
            <arc ex="260" ey="-48" sx="180" sy="0" r="88" cx="184" cy="-88" />
            <line x2="116" y1="0" y2="0" x1="180" />
            <line x2="116" y1="-96" y2="-96" x1="180" />
            <arc ex="116" ey="-96" sx="116" sy="0" r="56" cx="84" cy="-48" />
            <arc ex="180" ey="-96" sx="260" sy="-48" r="88" cx="184" cy="-8" />
            <line x2="120" y1="-96" y2="-96" x1="184" />
            <line x2="88" y1="-80" y2="-80" x1="128" />
            <line x2="92" y1="-16" y2="-16" x1="132" />
            <line x2="304" y1="-48" y2="-48" x1="284" />
        </blockdef>
        <blockdef name="srl32">
            <timestamp>2014-3-19T13:48:12</timestamp>
            <rect width="184" x="64" y="-128" height="128" />
            <line x2="32" y1="-96" y2="-96" style="linewidth:W" x1="64" />
            <line x2="32" y1="-32" y2="-32" style="linewidth:W" x1="64" />
            <line x2="288" y1="-64" y2="-64" style="linewidth:W" x1="248" />
        </blockdef>
        <blockdef name="Ext_32">
            <timestamp>2014-6-26T5:42:40</timestamp>
            <circle style="linewidth:W;linecolor:rgb(255,0,0);linestyle:Dash" r="69" cx="185" cy="-33" />
            <line x2="124" y1="0" y2="0" style="linewidth:W" x1="96" />
            <line x2="272" y1="-64" y2="-64" style="linewidth:W" x1="248" />
            <rect style="linecolor:rgb(255,255,255)" width="128" x="120" y="-80" height="88" />
        </blockdef>
        <blockdef name="SignalExt_32">
            <timestamp>2015-6-25T6:52:52</timestamp>
            <line x2="12" y1="-32" y2="-32" x1="0" />
            <line x2="144" y1="-32" y2="-32" style="linewidth:W" x1="132" />
            <rect width="120" x="12" y="-52" height="40" />
        </blockdef>
        <blockdef name="MUX2T1_5">
            <timestamp>2015-12-29T14:47:37</timestamp>
            <line x2="16" y1="-80" y2="-72" x1="16" />
            <line x2="4" y1="-48" y2="-48" style="linewidth:W" x1="0" />
            <line x2="4" y1="-16" y2="-16" style="linewidth:W" x1="0" />
            <line x2="28" y1="-32" y2="-32" style="linewidth:W" x1="32" />
            <rect width="24" x="4" y="-72" height="72" />
        </blockdef>
        <blockdef name="MUX4T1_5">
            <timestamp>2015-12-29T14:51:9</timestamp>
            <rect width="24" x="4" y="-136" height="136" />
            <line x2="16" y1="-144" y2="-136" x1="16" />
            <line x2="4" y1="-112" y2="-112" style="linewidth:W" x1="0" />
            <line x2="4" y1="-80" y2="-80" style="linewidth:W" x1="0" />
            <line x2="28" y1="-64" y2="-64" style="linewidth:W" x1="32" />
            <line x2="4" y1="-48" y2="-48" style="linewidth:W" x1="0" />
        </blockdef>
        <blockdef name="MUX2T1_32">
            <timestamp>2015-12-29T3:52:31</timestamp>
            <rect width="40" x="12" y="-100" height="100" />
            <line x2="32" y1="-112" y2="-100" x1="32" />
            <line x2="52" y1="-48" y2="-48" style="linewidth:W;linecolor:rgb(0,0,0)" x1="64" />
            <line x2="0" y1="-80" y2="-80" style="linewidth:W" x1="12" />
            <line x2="0" y1="-16" y2="-16" style="linewidth:W" x1="12" />
        </blockdef>
        <blockdef name="MUX4T1_32">
            <timestamp>2015-12-29T3:46:53</timestamp>
            <line x2="0" y1="-80" y2="-80" style="linewidth:W" x1="12" />
            <line x2="0" y1="-48" y2="-48" style="linewidth:W" x1="12" />
            <line x2="0" y1="-16" y2="-16" style="linewidth:W" x1="12" />
            <rect width="40" x="12" y="-136" height="128" />
            <line x2="0" y1="-112" y2="-112" style="linewidth:W" x1="12" />
            <line x2="32" y1="-136" y2="-144" style="linewidth:W" x1="32" />
            <line x2="52" y1="-96" y2="-96" style="linewidth:W;linecolor:rgb(0,0,0)" x1="64" />
        </blockdef>
        <blockdef name="MUX8T1_8">
            <timestamp>2015-12-29T3:54:24</timestamp>
            <rect width="68" x="12" y="-264" height="264" />
            <line x2="48" y1="-264" y2="-272" style="linewidth:W" x1="48" />
            <line x2="0" y1="-16" y2="-16" style="linewidth:W" x1="12" />
            <line x2="0" y1="-48" y2="-48" style="linewidth:W" x1="12" />
            <line x2="0" y1="-80" y2="-80" style="linewidth:W" x1="12" />
            <line x2="0" y1="-112" y2="-112" style="linewidth:W" x1="12" />
            <line x2="0" y1="-144" y2="-144" style="linewidth:W" x1="12" />
            <line x2="0" y1="-176" y2="-176" style="linewidth:W" x1="12" />
            <line x2="0" y1="-208" y2="-208" style="linewidth:W" x1="12" />
            <line x2="0" y1="-240" y2="-240" style="linewidth:W" x1="12" />
            <line x2="96" y1="-160" y2="-160" style="linewidth:W" x1="80" />
        </blockdef>
        <blockdef name="MUX8T1_32">
            <timestamp>2015-12-29T14:54:6</timestamp>
            <rect width="68" x="12" y="-264" height="264" />
            <line x2="48" y1="-264" y2="-272" style="linewidth:W" x1="48" />
            <line x2="0" y1="-16" y2="-16" style="linewidth:W" x1="12" />
            <line x2="0" y1="-48" y2="-48" style="linewidth:W" x1="12" />
            <line x2="0" y1="-80" y2="-80" style="linewidth:W" x1="12" />
            <line x2="0" y1="-112" y2="-112" style="linewidth:W" x1="12" />
            <line x2="0" y1="-144" y2="-144" style="linewidth:W" x1="12" />
            <line x2="0" y1="-176" y2="-176" style="linewidth:W" x1="12" />
            <line x2="0" y1="-208" y2="-208" style="linewidth:W" x1="12" />
            <line x2="0" y1="-240" y2="-240" style="linewidth:W" x1="12" />
            <line x2="96" y1="-160" y2="-160" style="linewidth:W" x1="80" />
        </blockdef>
        <blockdef name="MUX2T1_64">
            <timestamp>2015-7-2T6:16:38</timestamp>
            <line x2="0" y1="-48" y2="-48" style="linewidth:W" x1="16" />
            <rect width="96" x="16" y="-224" height="224" />
            <line x2="64" y1="-224" y2="-240" x1="64" />
            <line x2="0" y1="-176" y2="-176" style="linewidth:W" x1="16" />
            <line x2="112" y1="-112" y2="-112" style="linewidth:W" x1="128" />
        </blockdef>
        <blockdef name="MUX2T1_8">
            <timestamp>2015-12-28T14:19:21</timestamp>
            <line x2="80" y1="-80" y2="-80" style="linewidth:W" x1="96" />
            <rect width="64" x="16" y="-160" height="160" />
            <line x2="0" y1="-128" y2="-128" style="linewidth:W" x1="16" />
            <line x2="48" y1="-176" y2="-160" x1="48" />
            <line x2="0" y1="-32" y2="-32" style="linewidth:W" x1="16" />
        </blockdef>
        <block symbolname="add_32" name="E1">
            <blockpin name="b(31:0)" />
            <blockpin name="a(31:0)" />
            <blockpin name="c(31:0)" />
        </block>
        <block symbolname="ADC32" name="E2">
            <blockpin name="B(31:0)" />
            <blockpin name="A(31:0)" />
            <blockpin name="C0" />
            <blockpin name="S(32:0)" />
        </block>
        <block symbolname="or32" name="E4">
            <blockpin name="res(31:0)" />
            <blockpin name="A(31:0)" />
            <blockpin name="B(31:0)" />
        </block>
        <block symbolname="and32" name="E3">
            <blockpin name="res(31:0)" />
            <blockpin name="A(31:0)" />
            <blockpin name="B(31:0)" />
        </block>
        <block symbolname="nor32" name="E5">
            <blockpin name="res(31:0)" />
            <blockpin name="A(31:0)" />
            <blockpin name="B(31:0)" />
        </block>
        <block symbolname="xor32" name="E6">
            <blockpin name="A(31:0)" />
            <blockpin name="B(31:0)" />
            <blockpin name="res(31:0)" />
        </block>
        <block symbolname="or_bit_32" name="E7">
            <blockpin name="o" />
            <blockpin name="A(31:0)" />
        </block>
        <block symbolname="srl32" name="E8">
            <blockpin name="A(31:0)" />
            <blockpin name="B(31:0)" />
            <blockpin name="res(31:0)" />
        </block>
        <block symbolname="Ext_32" name="E9">
            <blockpin name="imm_16(15:0)" />
            <blockpin name="Imm_32(31:0)" />
        </block>
        <block symbolname="SignalExt_32" name="E10">
            <blockpin name="So(31:0)" />
            <blockpin name="S" />
        </block>
        <block symbolname="MUX2T1_5" name="MUX1">
            <blockpin name="I1(4:0)" />
            <blockpin name="I0(4:0)" />
            <blockpin name="o(4:0)" />
            <blockpin name="s" />
        </block>
        <block symbolname="MUX4T1_5" name="MUX2">
            <blockpin name="s(1:0)" />
            <blockpin name="I1(4:0)" />
            <blockpin name="I0(4:0)" />
            <blockpin name="o(4:0)" />
            <blockpin name="I2(4:0)" />
            <blockpin name="I3(4:0)" />
        </block>
        <block symbolname="MUX2T1_64" name="MUX8">
            <blockpin name="b(63:0)" />
            <blockpin name="sel" />
            <blockpin name="a(63:0)" />
            <blockpin name="o(63:0)" />
        </block>
        <block symbolname="MUX2T1_8" name="MUX7">
            <blockpin name="o(7:0)" />
            <blockpin name="I0(7:0)" />
            <blockpin name="s" />
            <blockpin name="I1(7:0)" />
        </block>
        <block symbolname="MUX2T1_32" name="MUX3">
            <blockpin name="s" />
            <blockpin name="I0(31:0)" />
            <blockpin name="I1(31:0)" />
            <blockpin name="o(31:0)" />
        </block>
        <block symbolname="MUX4T1_32" name="MUX4">
            <blockpin name="s(1:0)" />
            <blockpin name="I0(31:0)" />
            <blockpin name="I1(31:0)" />
            <blockpin name="I2(31:0)" />
            <blockpin name="I3(31:0)" />
            <blockpin name="o(31:0)" />
        </block>
        <block symbolname="MUX8T1_8" name="MUX5">
            <blockpin name="s(2:0)" />
            <blockpin name="I7(7:0)" />
            <blockpin name="I6(7:0)" />
            <blockpin name="I5(7:0)" />
            <blockpin name="I4(7:0)" />
            <blockpin name="I3(7:0)" />
            <blockpin name="I2(7:0)" />
            <blockpin name="I1(7:0)" />
            <blockpin name="I0(7:0)" />
            <blockpin name="o(7:0)" />
        </block>
        <block symbolname="MUX8T1_32" name="MUX6">
            <blockpin name="s(2:0)" />
            <blockpin name="I7(31:0)" />
            <blockpin name="I6(31:0)" />
            <blockpin name="I5(31:0)" />
            <blockpin name="I4(31:0)" />
            <blockpin name="I3(31:0)" />
            <blockpin name="I2(31:0)" />
            <blockpin name="I1(31:0)" />
            <blockpin name="I0(31:0)" />
            <blockpin name="o(31:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="1760" height="1360">
        <instance x="240" y="544" name="E1" orien="R0">
        </instance>
        <instance x="352" y="704" name="E2" orien="R0">
        </instance>
        <instance x="624" y="624" name="E4" orien="R0">
        </instance>
        <instance x="624" y="496" name="E3" orien="R0">
        </instance>
        <instance x="880" y="496" name="E5" orien="R0">
        </instance>
        <instance x="896" y="624" name="E6" orien="R0">
        </instance>
        <instance x="1168" y="496" name="E7" orien="R0">
        </instance>
        <instance x="1184" y="672" name="E8" orien="R0">
        </instance>
        <instance x="1152" y="800" name="E9" orien="R0">
        </instance>
        <instance x="1248" y="928" name="E10" orien="R0">
        </instance>
        <instance x="272" y="912" name="MUX2" orien="R0">
            <attrtext attrname="InstName" x="0" y="16" type="instance" />
        </instance>
        <instance x="384" y="912" name="MUX3" orien="R0">
            <attrtext attrname="InstName" x="0" y="16" type="instance" />
        </instance>
        <instance x="624" y="928" name="MUX5" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial" attrname="InstName" x="0" y="16" type="instance" />
        </instance>
        <instance x="768" y="928" name="MUX6" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial" attrname="InstName" x="0" y="16" type="instance" />
        </instance>
        <instance x="1056" y="944" name="MUX8" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial" attrname="InstName" x="32" y="32" type="instance" />
        </instance>
        <instance x="928" y="896" name="MUX7" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial" attrname="InstName" x="16" y="32" type="instance" />
        </instance>
        <instance x="176" y="912" name="MUX1" orien="R0">
            <attrtext attrname="InstName" x="0" y="16" type="instance" />
        </instance>
        <instance x="512" y="912" name="MUX4" orien="R0">
            <attrtext attrname="InstName" x="0" y="8" type="instance" />
        </instance>
    </sheet>
</drawing>