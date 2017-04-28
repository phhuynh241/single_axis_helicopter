ORG 0H

LJMP INIT
ORG 000BH
LJMP TO_ISR

ORG 0030H

INIT:
		MOV TMOD, #01H
		MOV TH0, #0H
		MOV TL0, #0H
		MOV IE, #82H //Initializes ENABLE and TIMER 1
		SETB TR0 //start timer 0
		CLR F0
MAIN:
		JB P3.7, BACKUP
		
		CLR C
		MOV A, P1 // Reads Sensor/ADC value
		CPL A
		MOV R5, A
		MOV P0, R5 // LED displays ADC value
		RRC A // PV/2
		CLR C
		MOV R3, A // Loads PV/2 value into R3
		
		MOV A, P2 // Reads switches
		RRC A // SP/2
		CLR C
		MOV R7, A // Moves SP into scratch register SP = R7
		
		SUBB A, R3//  ERROR = (SP/2) - (PV/2)
		CLR C
		MOV R6, A // Moves ERROR into scratch register R6
		
		ADD A, #127 //Manipulative Variable
		CLR C
		MOV R1, A // R1 <-- MV

		SETB P3.6
		SETB P3.7
		
BACKUP:		
		SJMP MAIN
TO_ISR:
		CLR TR0
		JB F0, LOW_P
HIGH_P: //WANTS TO GO TO HIGH PULSE FROM LOW PULSE
		MOV A, #0FFH
		SETB P3.4
		SETB F0
		CLR C //CLEARS CARRY FLAG
		SUBB A, R1 // subtracts FF and A = A
		MOV TL0, A
		MOV TH0, #0FFH 
		SETB TR0
		CLR P3.7
		CLR P3.6 
		RETI
LOW_P: //WANTS TO GO LOW PULSE FROM HIGH PULSE
		CLR F0 //CLEARS FLAG FOR NEXT HIGH PULSE
		CLR P3.4
		MOV TL0, R1 //TIMER = PWM_VALUE
		MOV TH0, #0FFH 
		SETB TR0
		RETI
END
