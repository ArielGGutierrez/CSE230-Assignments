###########################################################
#  Assignment #: 3
#  Name: Ariel Gael Gutierrez
#  ASU email: agguti12@asu.edu
#  Course: CSE/EEE230, TTh 3:00pm - 4:15pm
#  Description: This program acquires 4 numbers from the user
#               and performs various operations on those numbers
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
             .data  
message1:    .asciiz "Enter a value:\n"
message2:    .asciiz "Enter another value:\n"
message3:    .asciiz "Enter one more value:\n"

message4:    .asciiz "num2+num4="
message5:    .asciiz "num4-num1="
message6:    .asciiz "num2*num3="
message7:    .asciiz "num1/num4="
message8:    .asciiz "num4 mod num3="
message9:    .asciiz "((num3/num2)-7)*(num4 mod num1)="
newline:     .asciiz "\n"              # Newline character

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

# the program begins execution at main()
main:
         # Prompt the user to enter the first number
         la        $a0, message1       # Load message1
         li        $v0, 4              # Call print_string()
         syscall                       # Display message1
         li        $v0, 5              # Call read_int()
         syscall                       # Read integer
         add       $s1, $v0, $zero     # Store first num in $s1

         # Prompt the user to enter the second number
         la        $a0, message2       # Load message2
         li        $v0, 4              # Call print_string()
         syscall                       # Display message2
         li        $v0, 5              # Call read_int()
         syscall                       # Read integer
         add       $s2, $v0, $zero     # Store second num in $s2

         # Prompt the user to enter the third number
         la        $a0, message3       # Load message3
         li        $v0, 4              # Call print_string()
         syscall                       # Display message3
         li        $v0, 5              # Call read_int()
         syscall                       # Read integer
         add       $s3, $v0, $zero     # Store third num in $s3

         # Prompt the user to enter the fourth number
         la        $a0, message3       # Load message3
         li        $v0, 4              # Call print_string()
         syscall                       # Display message3
         li        $v0, 5              # Call read_int()
         syscall                       # Read integer
         add       $s4, $v0, $zero     # Store fourth num in $s4

         # Add num2 and num4
         la        $a0, message4       # Load message4
         li        $v0, 4              # Call print_string()
         syscall                       # Display message4
         add       $a0, $s2, $s4       # Add num2 and num4
         li        $v0, 1              # Call print_int()
         syscall                       # Display $a0
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line

         # Subtract num4 and num1
         la        $a0, message5       # Load message5
         syscall                       # Display message5
         sub       $a0, $s4, $s1       # Subtract num4 and num1
         li        $v0, 1              # Call print_int()
         syscall                       # Display $a0
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line

         # Multiply num2 and num3
         la        $a0, message6       # Load message6
         syscall                       # Display message6
         mult      $s2, $s3            # Multiply num2 and num3
         mflo      $a0                 # Load the bottom result
         li        $v0, 1              # Call print_int()
         syscall                       # Display $a0
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line

         # Divide num1 and num4
         la        $a0, message7       # Load message7
         syscall                       # Display message7
         div       $s1, $s4            # Divide num1 by num4
         mflo      $a0                 # Load the quotient
         li        $v0, 1              # Call print_int()
         syscall                       # Display $a0
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line

         # Mod num4 and num3
         la        $a0, message8       # Load message8
         syscall                       # Display message8
         div       $s4, $s3            # Divide num4 and num3
         mfhi      $a0                 # Load the remainder
         li        $v0, 1              # Call print_int()
         syscall                       # Display $a0
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line

         # Do the following sequence of operations: ((num3/num2)-7)*(num4 mod num1)
         la        $a0, message9       # Load message9
         syscall                       # Display message9
         div       $s3, $s2            # Divide num3 and num2
         mflo      $t0                 # Load the quotient to $t0
         addi      $t1, $t0, -7        # Subtract the quotient by 7 and load it to $t1
         div       $s4, $s1            # Divide num4 and num1
         mfhi      $t2                 # Load the remainder into $t2
         mult      $t1, $t2            # Multiply $t1 and $t2
         mflo      $a0                 # Load the bottom result
         li        $v0, 1              # Call print_int()
         syscall                       # Display $a0
         la        $a0, newline        # Load newline
         li        $v0, 4              # Call print_string()
         syscall                       # Move to the next line

         jr        $ra                 # return