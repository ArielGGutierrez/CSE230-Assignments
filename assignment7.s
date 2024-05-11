###########################################################
#  Assignment #: 7
#  Name: Ariel Gael Gutierrez
#  ASU email: agguti12@asu.edu
#  Course: CSE/EEE230, TTh 3:00pm - 4:15pm
#  Description: This program allows the user to enter an
#               integer and recursively changes that integer
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
              .data
message1:     .asciiz "Enter an integer:\n"
message2:     .asciiz "The solution is: "
newLine:      .asciiz "\n"

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

############################################################################
# Procedure/Function function1
# Description: The function1 is a recursive procedure/function defined by:
#              function1(n) = (n % 3) + 5          if n <= 5
#                           = function1(n-3)/n + function1(n-4)*6 - n   otherwise
# parameters: 
#                       $a0 = n value
# return value: 
#                       $v0 = computed value
# registers to be used:
#                       $s3 -> Answer from first recursive call
#                       $s4 -> Answer from second recursive call
#                       $t0 -> Decision Variable
#                       $t1 -> Arithmetic Variable
#                       $t2 -> Arithemtic Variable
############################################################################
function1:
         addi      $t0, $a0, -5                       # $t0 = n - 5
         bgt       $t0, $zero, Decision               # if (n - 5 > 0) jump to Decision

         li        $t1, 3                             # $t1 = 3

         div       $a0, $t1                           # n / 3
         mfhi      $t1                                # $t1 = n % 3
         addi      $t1, $t1, 5                        # $t1 = (n % 3) + 5

         move      $v0, $t1                           # Return Value = $t1
         jr        $ra                                # Return

Decision:
         # Store return address
         addi      $sp, $sp, -4
         sw        $ra, 0($sp)

         #------------------------------------------------------------------------
         addi      $t1, $a0, -3                       # $t1 = n - 3

         # Store Parameter Value
         addi      $sp, $sp, -4
         sw        $a0, 0($sp)

         move      $a0, $t1                           # Parameter of function1 = n - 3
         jal       function1                          # Recursively call function1

         move      $s3, $v0                           # $s3 = function1(n - 3)

         # load Parameter Value
         lw        $a0, 0($sp)
         addi      $sp, $sp, 4

         div       $s3, $a0                           # function1(n - 3) / n
         mflo      $t1                                # $t1 = function1(n - 3) / n

         #------------------------------------------------------------------------
         addi      $t2, $a0, -4                       # $t2 = n - 4

         # Store Parameter Value
         addi      $sp, $sp, -4
         sw        $a0, 0($sp)

         # Store $t1
         addi      $sp, $sp, -4
         sw        $t1, 0($sp)

         move      $a0, $t2                           # Parameter of function1 = n - 4
         jal       function1                          # Recursively call function1

         move      $s4, $v0                           # $s4 = function1(n - 4)

         # load $t1
         lw        $t1, 0($sp)
         addi      $sp, $sp, 4

         # load Parameter Value
         lw        $a0, 0($sp)
         addi      $sp, $sp, 4

         li        $t2, 6                             # $t2 = 6

         mult      $s4, $t2                           # function1(n - 4) * 6
         mflo      $t2                                # $t2 = function1(n - 4) * 6

         sub       $t2, $t2, $a0                      # $t2 = function1(n - 4) * 6 - n
         #------------------------------------------------------------------------
         add       $v0, $t1, $t2                      # Return Value = function1(n - 3) / n + function1(n - 4) * 6 - n
         
         # load return address
         lw        $ra, 0($sp)
         addi      $sp, $sp, 4

         jr        $ra                                # Return


############################################################################
# Procedure/Function main
# Description: The main calls function1 by entering an integer given by a user.
# registers to be used:
#                       $s0 -> n
#                       $s1 -> ans
############################################################################
# the program begins execution at main()
main:
         # Prompt the user to enter an integer
         la        $a0, message1                      # Load message1
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message1
         li        $v0, 5                             # Call read_int()
         syscall                                      # Read integer
         move      $s0, $v0                           # n -> $s0

         # Store return address
         addi      $sp, $sp, -4
         sw        $ra, 0($sp)

         move      $a0, $s0                           # Parameter of function1 = n
         jal       function1                          # Call function1
         move      $s1, $v0                           # ans = Return value of function1

         # load return address
         lw        $ra, 0($sp)
         addi      $sp, $sp, 4

         # Display the final answer to the user
         la        $a0, message2                      # Load message2
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message2

         move      $a0, $s1                           # Move ans to display it
         li        $v0, 1                             # Call print_int()
         syscall                                      # Display ans

         la        $a0, newLine                       # Load newLine
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display newLine

         jr        $ra                                # Return