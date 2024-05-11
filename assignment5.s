###########################################################
#  Assignment #: 5
#  Name: Ariel Gael Gutierrez
#  ASU email: agguti12@asu.edu
#  Course: CSE/EEE230, TTh 3:00pm - 4:15pm
#  Description: Allows the user to modify an array by inputting
#              an index to change and the new corresponding number
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
              .data
numbers_len:  .word   12
numbers:      .word   -4, 23, 15, -26, 27, 8, -21, 31, 15, -17, 11, -7
message1:     .asciiz "Enter an integer:\n"
message2:     .asciiz "Enter another integer:\n"
message3:     .asciiz "Result Array Content:\n"
newline:      .asciiz "\n"                             # Newline character

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

# the program begins execution at main()
main:
         # $s1 -> numbers_len
         # $s2 -> numbers array
         # $s3 -> num1
         # $s4 -> num2
         # $t0 -> i

         # Initialize $s1, $s2, and $t0
         lw        $s1, numbers_len                   # $s1 = numbers_len
         la        $s2, numbers                       # $s2 = address of numbers[0]
         li        $t0, 0                             # $t0 = 0

         # Prompt the user to enter an integer
         la        $a0, message1                      # Load message1
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message1
         li        $v0, 5                             # Call read_int()
         syscall                                      # Read integer
         move      $s3, $v0                           # num1 -> $s3

         # Prompt the user to enter another integer
         la        $a0, message2                      # Load message1
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message1
         li        $v0, 5                             # Call read_int()
         syscall                                      # Read integer
         move      $s4, $v0                           # num2 -> $s4

         j         Loop1

Loop1:
         # $t1 -> Decision variable
         # $t2 -> Address of numbers[i]
         # $t3 -> numbers[i]
         # $t4 -> numbers[i] / num1
         # $t5 -> numbers[i] % num2

         # Beginning of for loop
         slt       $t1, $t0, $s1                      # If (i < number_len) $t1 = 1; else: $t1 = 0;
         beq       $t1, $zero, Intermediate           # If (i >= number_len) jump to Intermediate

         # Body of for loop
         sll       $t2, $t0, 2                        # $t2 = 4*i
         add       $t2, $t2, $s2                      # $t2 = (4*i) + numbers[0]
         lw        $t3, 0($t2)                        # $t3 = numbers[i]
         div       $t3, $s3                           # numbers[i] / num1
         mflo      $t4                                # $t4 = numbers[i] / num1

         slti      $t1, $t4, 3                        # If (numbers[i] / num1 < 3) $t1 = 1; else: $t1 = 0;
         beq       $t1, $zero, EndOfLoop1             # If (numbers[i] / num1 >= 3) Jump to EndOfLoop1

         div       $t3, $s4                           # numbers[i] % num2
         mfhi      $t5                                # $t5 = numbers[i] % num2
         sw        $t5, 0($t2)                        # numbers[i] = numbers[i] % num2
         j         EndOfLoop1                         # Jump to the end of the for loop

EndOfLoop1:
         # End of for loop
         addi $t0, $t0, 1                             # i++
         j Loop1                                      # Jump to Loop1

Intermediate:
         la        $a0, message3                      # Load message3
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message3
         
         li        $t0, 0                             # $t0 = 0
         j         Loop2                              # Jump to Loop2


Loop2:
         # $t1 -> Decision variable
         # $t2 -> Address of numbers[i]

         # Beginning of for loop
         slt       $t1, $t0, $s1                      # If (i < number_len) $t1 = 1; else: $t1 = 0;
         beq       $t1, $zero, Return                 # If (i >= number_len) jump to Return

         # Body of for loop
         sll       $t2, $t0, 2                        # $t2 = 4*$t0
         add       $t2, $t2, $s2                      # $t2 = (4*i) + numbers[0]
         lw        $a0, 0($t2)                        # $t3 = numbers[i]
         li        $v0, 1                             # Call print_int()
         syscall                                      # Display num1

         la        $a0, newline                       # Load newline
         li        $v0, 4                             # Call print_string()
         syscall                                      # Move to the next line

         # End of for loop
         addi      $t0, $t0, 1                        # i++
         j         Loop2                              # Jump to Loop2

Return:
         jr        $ra                                # Return