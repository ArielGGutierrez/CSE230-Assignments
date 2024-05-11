###########################################################
#  Assignment #: 6
#  Name: Ariel Gael Gutierrez
#  ASU email: agguti12@asu.edu
#  Course: CSE/EEE230, TTh 3:00pm - 4:15pm
#  Description: This program allows the user to create
#               an array of 12 integers and compares it to
#               a two numbers.  The result of this comparison
#               fills a secondary array which is then displayed
#               to the user.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
              .data
numbers1:     .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
numbers2:     .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
askInt:       .asciiz "Enter an integer:\n"
askInt2:      .asciiz "Enter an integer: \n"
askAnotherInt:.asciiz "Enter another integer:\n"
askInts:      .asciiz "Enter 12 integers.\n"
content:      .asciiz "Array Content:\n"
numChange:    .asciiz "The number of changed items is "
colon:        .asciiz ":\n"
maxChange:    .asciiz "The maximum number of changed items is "
newLine:      .asciiz "\n"

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

############################################################################
# Procedure/Function readArray
# Description: The function reads integers from user input and stores them in the array
# parameters: 
#                       $a1 = address of array to be used
#                       $a2 = length
# return value:
#                       none
# registers to be used:
#                       $t0 = i
#                       $t1 = address of current element
############################################################################
readArray:
         la        $a0, askInts                       # Load askInts
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display askInts

         li        $t1, 0                             # i = 0
         j         readWhile                          # Jump to loop

readWhile:
         bge       $t0, $a2, return                   # If (i >= arraySize) jump to endOfLoop

         sll       $t1, $t0, 2                        # $t1 = i * 4
         add       $t1, $a1, $t1                      # $t1 = A[0] + 4 * i

         # Prompt the user to enter an integer
         la        $a0, askInt2                       # Load askInt2
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display askInt2
         li        $v0, 5                             # Call read_int()
         syscall                                      # Read integer

         sw        $v0, 0($t1)                        # A[i] = readInt
         addi      $t0, 1                             # i++
         j         readWhile                          # Jump to beginning

return:
         jr        $ra                                # Return

############################################################################
# Procedure/Function printArray
# Description: The printArray function prints integers of the array
# parameters:
#                       $a1 = address of array to be used
#                       $a2 = arraySize
# return value: none
# registers to be used:
#                       $t0 = i
#                       $t1 = address of current element
############################################################################
printArray:
         la        $a0, content                       # Load content
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display content

         li        $t0, 0                             # i = 0
         j         printWhile                         # Jump to loop

printWhile:
         bge       $t0, $a2, return                   # If (i >= arraySize) jump to endOfLoop

         sll       $t1, $t0, 2                        # $t1 = i * 4
         add       $t1, $a1, $t1                      # $t1 = A[0] + 4 * i

         lw        $a0, 0($t1)                        # $a0 = A[i]
         li        $v0, 1                             # Call print_int()
         syscall                                      # Display A[i]
         la        $a0, newLine                       # Load newLine
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display newLine

         addi      $t0, 1                             # i++
         j         printWhile                         # Jump to beginning

############################################################################
# Procedure/Function function1
# Description: The function1 takes two arrays of integers, its size, 
#              and two integers and modifies the content of the second array
#              using the two integers. It also counts the number of changed items
# parameters:
#                       $a1 -> address of numbers1
#                       $a2 -> address of numbers2
#                       $a3 -> arraySize
#                       $s7 -> a
#                       $s8 -> b
# return value: 
#                       $v1 -> count
# registers to be used:
#                       $t0 = i
#                       $t1 = address of current element in numbers1
#                       $t2 = address of current element in numbers2
#                       $t3 = temporary number for arithmetic
############################################################################
function1:
         li        $t0, 0                             # i = 0
         li        $v1, 0                             # count = 0
         j         forLoop                            # Jump to loop

forLoop:
         bge       $t0, $a3, endOfFunction            # If (i >= arraySize) jump to endOfFunction

         sll       $t1, $t0, 2                        # $t1 = i * 4
         add       $t1, $a1, $t1                      # $t1 = numbers1[0] + 4 * i

         sll       $t2, $t0, 2                        # $t2 = i * 4
         add       $t2, $a2, $t2                      # $t2 = numbers2[0] + 4 * i

         lw        $t3, 0($t1)                        # $t3 = numbers1[i]

         bge       $t3, $s7, forDecision              # if (numbers1[i] >= a) Jump to F\forDecision

         sub       $t3, $t3, $s8                      # $t3 = numbers1[i] - b
         sw        $t3, 0($t2)                        # numbers2[i] = numbers1[i] - b
         addi      $v1, $v1, 1                        # count++

         addi      $t0, $t0, 1                        # i++
         j         forLoop                            # Jump to beginning of loop

forDecision:
         sw        $t3, 0($t2)                        # numbers2[i] = numbers1[i]

         addi      $t0, $t0, 1                        # i++
         j         forLoop                            # Jump to beginning of loop

endOfFunction:
         la        $a0, numChange                     # Load numChange
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display numChange

         move      $a0, $v1                           # Load count
         li        $v0, 1                             # Call print_int()
         syscall                                      # Display count
         
         la        $a0, colon                         # Load colon
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display newLine

         jr        $ra                                # Return

############################################################################
# Procedure/Function checkCount
# Description: The checkCount checks count and count2 and changes count2 accordingly
# parameters:
#                       $a1 -> count
#                       $a2 -> count2
# return value: 
#                       $v1 -> count2
# registers to be used: none
############################################################################
checkCount:
         blt       $a1, $a2, decision
         move      $v1, $a1
         jr        $ra

decision:
         move      $v1, $a2
         jr        $ra

############################################################################
# Procedure/Function main
# Description: The main calls the readArray function to read in integers
#              and two integers, then calls function1 four times and also
#              print the changed array content. It also prints out
#              the maximum count of changed items.
# registers to be used:
#                       $s0 -> arraySize
#                       $s1 -> address of numbers1
#                       $s2 -> address of numbers2
#                       $s3 -> x
#                       $s4 -> y
#                       $s5 -> count
#                       $s6 -> count2
############################################################################
# the program begins execution at main()
main:
         # Load initial values
         li        $s0, 12                            # arraySize = 12
         la        $s1, numbers1                      # numbers1 = address of numbers1
         la        $s2, numbers2                      # numbers2 = address of numbers2
         li        $s5, 0                             # count  = 0
         li        $s6, 0                             # count2 = 0

         # Prompt the user to enter an integer
         la        $a0, askInt                        # Load askInt
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display askInt
         li        $v0, 5                             # Call read_int()
         syscall                                      # Read integer
         move      $s3, $v0                           # x -> $s3

         # Prompt the user to enter another integer
         la        $a0, askAnotherInt                 # Load askAnotherInt
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display askAnotherInt
         li        $v0, 5                             # Call read_int()
         syscall                                      # Read integer
         move      $s4, $v0                           # y -> $s4

         # Get ready for readArray function call
         move      $a1, $s1                           # First parameter of readArray:  address of numbers1
         move      $a2, $s0                           # Second parameter of readArray: arraySize

         # Store return address
         addi      $sp, $sp, -4
         sw        $ra, 0($sp)
         
         jal       readArray                          # Call readArray to create numbers1

         #---------------------------------------------------------------------------------------------------
         # Get ready for function1 function call
         move      $a1, $s1                           # First parameter of function1:  address of numbers1
         move      $a2, $s2                           # Second parameter of function1: address of numbers2
         move      $a3, $s0                           # Third parameter of function1:  arraySize
         move      $s7, $s3                           # Fourth parameter of function1: x
         move      $s8, $s4                           # Fifth parameter of function1:  y

         jal       function1                          # Call function1
         move      $s5, $v1                           # $s5 = Return value of function1

         # Get ready for checkCount function call
         move      $a1, $s5                           # First parameter of function1:  count
         move      $a2, $s6                           # Second parameter of function1: count2

         jal       checkCount                         # Call checkCount
         move      $s6, $v1                           # $s6 (count2) = Return value of checkCount

         # Get ready for printArray function call
         move      $a1, $s2                           # First parameter of printArray:  address of numbers2
         move      $a2, $s0                           # Second parameter of printArray: arraySize

         jal       printArray                         # Call printArray to print numbers2
         #---------------------------------------------------------------------------------------------------
         # Get ready for function1 function call
         move      $a1, $s1                           # First parameter of function1:  address of numbers1
         move      $a2, $s2                           # Second parameter of function1: address of numbers2
         move      $a3, $s0                           # Third parameter of function1:  arraySize
         move      $s7, $s4                           # Fourth parameter of function1: y
         move      $s8, $s3                           # Fifth parameter of function1:  x

         jal       function1                          # Call function1
         move      $s5, $v1                           # $s5 = Return value of function1

         # Get ready for checkCount function call
         move      $a1, $s5                           # First parameter of function1:  count
         move      $a2, $s6                           # Second parameter of function1: count2

         jal       checkCount                         # Call checkCount
         move      $s6, $v1                           # $s6 (count2) = Return value of checkCount

         # Get ready for printArray function call
         move      $a1, $s2                           # First parameter of printArray:  address of numbers2
         move      $a2, $s0                           # Second parameter of printArray: arraySize

         jal       printArray                         # Call printArray to print numbers2
         #---------------------------------------------------------------------------------------------------
         # Get ready for function1 function call
         move      $a1, $s1                           # First parameter of function1:  address of numbers1
         move      $a2, $s2                           # Second parameter of function1: address of numbers2
         move      $a3, $s0                           # Third parameter of function1:  arraySize
         move      $s7, $s3                           # Fourth parameter of function1: x
         move      $s8, $s3                           # Fifth parameter of function1:  x

         jal       function1                          # Call function1
         move      $s5, $v1                           # $s5 = Return value of function1

         # Get ready for checkCount function call
         move      $a1, $s5                           # First parameter of function1:  count
         move      $a2, $s6                           # Second parameter of function1: count2

         jal       checkCount                         # Call checkCount
         move      $s6, $v1                           # $s6 (count2) = Return value of checkCount

         # Get ready for printArray function call
         move      $a1, $s2                           # First parameter of printArray:  address of numbers2
         move      $a2, $s0                           # Second parameter of printArray: arraySize

         jal       printArray                         # Call printArray to print numbers2
         #---------------------------------------------------------------------------------------------------
         # Get ready for function1 function call
         move      $a1, $s1                           # First parameter of function1:  address of numbers1
         move      $a2, $s2                           # Second parameter of function1: address of numbers2
         move      $a3, $s0                           # Third parameter of function1:  arraySize
         move      $s7, $s4                           # Fourth parameter of function1: y
         move      $s8, $s4                           # Fifth parameter of function1:  y

         jal       function1                          # Call function1
         move      $s5, $v1                           # $s5 = Return value of function1

         # Get ready for checkCount function call
         move      $a1, $s5                           # First parameter of function1:  count
         move      $a2, $s6                           # Second parameter of function1: count2

         jal       checkCount                         # Call checkCount
         move      $s6, $v1                           # $s6 (count2) = Return value of checkCount

         # Get ready for printArray function call
         move      $a1, $s2                           # First parameter of printArray:  address of numbers2
         move      $a2, $s0                           # Second parameter of printArray: arraySize

         jal       printArray                         # Call printArray to print numbers2
         #---------------------------------------------------------------------------------------------------

         la        $a0, maxChange                     # Load maxChange
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display maxChange

         move      $a0, $s6                           # Load count2
         li        $v0, 1                             # Call print_int()
         syscall                                      # Display count2
         
         la        $a0, colon                         # Load colon
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display colon

         # load return address
         lw        $ra, 0($sp)
         addi      $sp, $sp, 4

         jr        $ra                                # Return