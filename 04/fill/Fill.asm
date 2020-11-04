// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
    @8191           //THERE ARE 8192 PIXELS SO N=8191
    D=A             //D=8191
    @R0
    M=D             //R0=D

    (LOOP)          //INFINITE LOOP
    @KBD        
    D=M             //D=KBD
    @WHITEP
    D;JEQ           //IF NO KEY IS PRESSED THEN D=0 AND GO TO WHITE ELSE CONTINUE
    
    //BLACK
    @R0
    D=M             //D=R0=8191
    //DISPLAY
    (BLACK)         //HERE STARTS THE BLACKING SCREEN LOOP
    @SCREEN         //A=SCREEN
    A=A+D           //A=A+D ==> SCREEN+D
    M=-1            //RAM[A]=FFFFh ==>RAM[A]=-1d
    D=D-1           //D=D-1
    @BLACK          
    D;JGE           //GOTO BLACK LABLE FOR THE LOOP
    @SKIP           
    0;JMP           //AFTER EXECUTING THE LOOP SKIP THE WHITE PART AND GOTO END

    (WHITEP)         //WHITE pre setting D
    @R0
    D=M              //D=R0=8191
    (WHITE)           //ACTUAL WHITE PIXEL DRAWING LOOP
    @SCREEN
    A=A+D
    M=0                // RAM[A]=0 FOR THE WHITE TO DRAW         
    D=D-1
    @WHITE
    D;JGE               // GOTO WHITE IF D IS GREATER THAN OR EQUAL TO 0
    (SKIP)
    @LOOP
    0;JMP               //INFINITE LOOP GOTO



    














