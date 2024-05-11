###########################################################
#  Assignment #: 4
#  Name: Ariel Gael Gutierrez
#  ASU email: agguti12@asu.edu
#  Course: CSE/EEE230, TTh 3:00pm - 4:15pm
#  Description: This program asks the user how many shirts
#               they'd like to purchase and returns the price
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
             .data  
message1:    .asciiz "How many T-shirts would you like to order?\n"
message2:    .asciiz "Invalid Number of T-shirts."
message3:    .asciiz "Do you have a discount coupon? Enter 1 for yes. (any other integer will indicate no discount)\n"
message4:    .asciiz "Your total payment is $"
newline:     .asciiz "\n"                             # Newline character

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

# the program begins execution at main()
main:
         # $s1 -> howMany
         # $s2 -> discount
         # $s3 -> payment
         # Prompt the user to enter the number of shirts they want to buy
         la        $a0, message1                      # Load message1
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message1
         li        $v0, 5                             # Call read_int()
         syscall                                      # Read integer
         move      $s1, $v0                           # howMany -> $s1

         # Check if the user inputted a number bigger than 0
         sle       $t0, $s1, $zero                    # If (howMany <= 0) 1 else 0 
         beq       $t0, $zero, LessThanFifty          # howMany > 0

         # User inputted a non-valid input
         la        $a0, message2                      # Load message1
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message1
         jr        $ra                                # return

LessThanFifty:
         # Check if the user's number is less than 50
         slti      $t0, $s1, 50                       # If (howMany < 50) 1 else 0
         beq       $t0, $zero, GreaterThanFifty       # howMany >= 50

         # User's number is less than 50
         li        $t1, 7                             # $t1 = 7
         mult      $s1, $t1                           # howMany * 7
         mflo      $s3                                # payment = howMany * 7
         j         Discount                           # Jump to Discount Calculation

GreaterThanFifty:
         # Check if the user's number is less than 100
         slti      $t0, $s1, 100                      # If (howMany < 100) 1 else 0
         beq       $t0, $zero, GreaterThanHundred     # howMany > 100

         # User's number is less than 100
         li        $t1, 6                             # $t1 = 6
         mult      $s1, $t1                           # howMany * 6
         mflo      $s3                                # payment = howMany * 6
         j         Discount                           # Jump to Discount Calculation

GreaterThanHundred:
         # Apply calculations if the number is greater than 100
         li        $t1, 5                             # $t1 = 5
         mult      $s1, $t1                           # howMany * 5
         mflo      $s3                                # payment = howMany * 5
         j         Discount                           # Jump to Discount Calculation

Discount:
         # Ask user if they have a discount coupon
         la        $a0, message3                      # Load message3
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message2
         li        $v0, 5                             # Call read_int()
         syscall                                      # Read integer
         move      $s2, $v0                           # discount -> $s2

         # User doesn't have a discount coupon
         beq       $s2, $zero, Result                 # If (discount == 0) 1 else 0
         addi      $s3, $s3, -5                       # payment = payment - 5
         j         Result                             # Jump to Result

Result:
         # Display a message to the user, telling them the price
         la        $a0, message4                      # Load message4
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message4

         # Display the total price
         move      $a0, $s3                           # Load payment
         li        $v0, 1                             # Call print_int()
         syscall                                      # Display payment

         # Display a newline character
         la        $a0, newline                       # Load newline
         li        $v0, 4                             # Call print_string()
         syscall                                      # Display message4

         jr        $ra                                # return