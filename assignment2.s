###########################################################
#  Assignment #: 2
#  Name: Ariel Gael Gutierrez
#  ASU email: agguti12@asu.edu
#  Course: CSE/EEE230, TTh 3:00pm - 4:15pm
#  Description: This program displays, adds, and subtracts two numbers
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
             .data  
num1:        .word 69482               # Number 69482
num2:        .word 0xBC7               # Number 3015
message1:    .asciiz "num1 is: "
message2:    .asciiz "num2 is: "
message3:    .asciiz "num1+num2 = "
message4:    .asciiz "num1-num2 = "
newline:     .asciiz "\n"              # Newline character

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

# the program begins execution at main()
main:
         # Load the two numbers into temporary registers
         lw        $s0, num1
         lw        $s1, num2
         
         # Display "num1 is: 69482\n"
         la        $a0, message1       # Load message1
         li        $v0, 4              # Call print_string()
         syscall                       # Display "num1 is: "
         lw        $a0, num1           # Load num1
         li        $v0, 1              # Call print_int()
         syscall                       # Display num1
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line
             
         # Display "num2 is: 3015\n"
         la        $a0, message2       # Load message1
         syscall                       # Display "num2 is: "
         lw        $a0, num2           # Load num2
         li        $v0, 1              # Call print_int()
         syscall                       # Display num2
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line
         
         # Add the two numbers and show the result
         la        $a0, message3       # Load message1
         syscall                       # Display "num1+num2 = "
         add       $a0, $s0, $s1       # Load the sum of num1 and num2
         li        $v0, 1              # Call print_int()
         syscall                       # Display $a0
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line
         
         # Subtract the two numbers and show the result
         la        $a0, message4       # Load message1
         syscall                       # Display "num1-num2 = "
         sub       $a0, $s0, $s1       # Load the difference of num1 and num2
         li        $v0, 1              # Call print_int()
         syscall                       # Display $a0
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line
         
         jr        $ra                 # return