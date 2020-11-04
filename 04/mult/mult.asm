// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
    @mul            //INITIALISING MULTIPLICATION VARIABLE
    M=0
    @R2             //INITIALISING R2 WHICH IS OUTPUT TO 0
    M=0

    @R0             
    D=M
    @END
    D;JEQ           //IF R0 IS ZERO THEN END THE PROGRAM
    @t1
    M=D              //TI=R0
    @R1
    D=M
    @END
    D;JEQ           //IF R1 IS ZERO THE END THE PROGRAM
    @t2
    M=D             //T2=R1
    
    (LOOP)          // LOOP FOR CALCULATING THE MULTIPLICATION
    @mul            
    D=M             //D=MUL
    @t2             
    D=D+M           //D=MUL+T2
    @mul
    M=D            //MUL=D        

    @t1             
    M=M-1          //T1=T1-1
    D=M            //D=T1
    @LOOP          //LOOP
    D;JGT

    @mul           
    D=M            //D=MUL
    @R2
    M=D            //R2=D

    (END)          //END LOOP
    @END
    0;JMP
















