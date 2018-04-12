//
//  File.swift
//  SwiftHackAssemblerTests
//
//  Created by Piotr Gorzelany on 12/04/2018.
//

import Foundation

let fillInput = """
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

@pixel_register // This address holds either 0(clear 16 pixels) or -1(black 16 pixels)

(check_keyboard)
@KBD // set the address to the keyboard register
D=M // store the currently pressed key in D
@clear_screen // set the address to clear screen instruction
D;JEQ // if no key is pressed (0) go to clear screen
@black_screen
0;JMP // Otherwise black the screen

(black_screen)
@pixel_register
M=-1 // Set the pixel register to -1 (all black pixels)
@paint_screen
0;JMP // Goto paint_screen

(clear_screen)
@pixel_register
M=0 // Set the pixel register to 0 (all clear pixels)
@paint_screen
0;JMP // Goto paint_screen

(paint_screen)
// Paints the whole screen with colors as defined in pixel_register

// The screen holds 8192 registers and we need to iterate over all of them
@8192 // address of the number of left iterations
D=A
@i
M=D // At the beggining we have 8192 iterations left

@current_iteration // holds the address of the current screen register
M=0 // We start at register 0

(loop)

// Check if the number of iterations left is 0 and if so finish
@i
D=M
@finish
D;JEQ

// If its not equal assign the value under pixel_register to current_screen_register
@SCREEN
D=A
@current_iteration
D=D+M
@current_pixel_address
M=D // current_pixel_address now holds the memory address that should be filled

@pixel_register
D=M // store pixel color in D

@current_pixel_address
A=M // set the current address to the pixel address stored in memory
M=D // set pixel color

// Increment iteration
@current_iteration
M=M+1

// Decrement current loop index
@i
M=M-1

// Loop
@loop
0;JMP

(finish)
// Finish and go back to checking keyboard
@check_keyboard
0;JMP
"""

let fillOutput = """
0000000000010000
0110000000000000
1111110000010000
0000000000001011
1110001100000010
0000000000000111
1110101010000111
0000000000010000
1110111010001000
0000000000001111
1110101010000111
0000000000010000
1110101010001000
0000000000001111
1110101010000111
0010000000000000
1110110000010000
0000000000010001
1110001100001000
0000000000010010
1110101010001000
0000000000010001
1111110000010000
0000000000101010
1110001100000010
0100000000000000
1110110000010000
0000000000010010
1111000010010000
0000000000010011
1110001100001000
0000000000010000
1111110000010000
0000000000010011
1111110000100000
1110001100001000
0000000000010010
1111110111001000
0000000000010001
1111110010001000
0000000000010101
1110101010000111
0000000000000001
1110101010000111
"""
