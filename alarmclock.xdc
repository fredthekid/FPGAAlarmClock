#########
## CLK ##
#########
set_property PACKAGE_PIN E3 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name external_clock -period 10.00 [get_ports clk] 

#######################
## 7 SEGMENT DISPLAY ##
#######################
#Sch name = CA
set_property PACKAGE_PIN L3 [get_ports {ca}]					
set_property IOSTANDARD LVCMOS33 [get_ports {ca}]

#Sch name = CB
set_property PACKAGE_PIN N1 [get_ports {cb}]					
set_property IOSTANDARD LVCMOS33 [get_ports {cb}]

#Sch name = CC
set_property PACKAGE_PIN L5 [get_ports {cc}]					
set_property IOSTANDARD LVCMOS33 [get_ports {cc}]
	
#Sch name = CD
set_property PACKAGE_PIN L4 [get_ports {cd}]					
set_property IOSTANDARD LVCMOS33 [get_ports {cd}]
	
#Sch name = CE
set_property PACKAGE_PIN K3 [get_ports {ce}]					
set_property IOSTANDARD LVCMOS33 [get_ports {ce}]
	
#Sch name = CF
set_property PACKAGE_PIN M2 [get_ports {cf}]					
set_property IOSTANDARD LVCMOS33 [get_ports {cf}]
	
#Sch name = CG
set_property PACKAGE_PIN L6 [get_ports {cg}]					
set_property IOSTANDARD LVCMOS33 [get_ports {cg}]

#Sch name = AN0
set_property PACKAGE_PIN N6 [get_ports {an0}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an0}]

#Sch name = AN1
set_property PACKAGE_PIN M6 [get_ports {an1}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an1}]

#Sch name = AN2
set_property PACKAGE_PIN M3 [get_ports {an2}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an2}]
	
#Sch name = AN3
set_property PACKAGE_PIN N5 [get_ports {an3}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an3}]
	
#Sch name = AN4
set_property PACKAGE_PIN N2 [get_ports {an4}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an4}]
	
#Sch name = AN5
set_property PACKAGE_PIN N4 [get_ports {an5}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an5}]

#Sch name = AN6
set_property PACKAGE_PIN L1 [get_ports {an6}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an6}]

#Sch name = AN7
set_property PACKAGE_PIN M1 [get_ports {an7}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an7}]

#############
## Speaker ##
#############
#Sch name = AUD_PWM
set_property PACKAGE_PIN A11 [get_ports speaker]					
set_property IOSTANDARD LVCMOS33 [get_ports speaker]

#Sch name = AUD_SD
set_property PACKAGE_PIN D12 [get_ports vcc]						
set_property IOSTANDARD LVCMOS33 [get_ports vcc]

##############
## SWITCHES ##
##############
#Sch name = SW0
set_property PACKAGE_PIN U9 [get_ports {switch[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {switch[0]}]

#Sch name = SW1
set_property PACKAGE_PIN U8 [get_ports {switch[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {switch[1]}]

#############
## BUTTONS ##
#############
#Sch name = BTNC
set_property PACKAGE_PIN E16 [get_ports middle]						
set_property IOSTANDARD LVCMOS33 [get_ports middle]

#Sch name = BTNU
set_property PACKAGE_PIN F15 [get_ports up]						
set_property IOSTANDARD LVCMOS33 [get_ports up]
	
#Sch name = BTNL
set_property PACKAGE_PIN T16 [get_ports left]						
set_property IOSTANDARD LVCMOS33 [get_ports left]
	
#Sch name = BTNR
set_property PACKAGE_PIN R10 [get_ports right]						
set_property IOSTANDARD LVCMOS33 [get_ports right]

#Sch name = BTND
set_property PACKAGE_PIN V10 [get_ports down]						
set_property IOSTANDARD LVCMOS33 [get_ports down]

## LEDs
#Sch name = LED0
set_property PACKAGE_PIN T8 [get_ports {led[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

#Sch name = LED1
set_property PACKAGE_PIN V9 [get_ports {led[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

#Sch name = LED2
set_property PACKAGE_PIN R8 [get_ports {led[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
	
#Sch name = LED3
set_property PACKAGE_PIN T6 [get_ports {led[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
	
#Sch name = LED4
set_property PACKAGE_PIN T5 [get_ports {led[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
	
#Sch name = LED5
set_property PACKAGE_PIN T4 [get_ports {led[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
	
#Sch name = LED6
set_property PACKAGE_PIN U7 [get_ports {led[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
	
#Sch name = LED7
set_property PACKAGE_PIN U6 [get_ports {led[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
