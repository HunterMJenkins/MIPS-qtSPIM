
# Hunter Jenkins
#Parallel Addition
#Dec 12, 2023

.data
    array1: .space 16       # Allocates 16 bytes for the first integer array (4 integers x 4 bytes each)
    array2: .space 16       # Allocates 16 bytes for the second integer array
    newLine: .asciiz "\n"   # Stores a newline character for printing
    printArr1: .asciiz "Array 1: " # String to display before printing the first array
    printArr2: .asciiz "Array 2: " # String to display before printing the second array
    getUserInput: .asciiz "Enter an integer: " # Prompt for user input
    printSumArr: .asciiz "Sum of Arrays: " # String to display before printing the sum of arrays

# Text segment for the program code
.text
main:
    # Initialize indices and loop counters for the first array input
    li $t0, 0 # Set index for array1 to 0
    li $t1, 0 # Set loop counter to 0

    # Loop for getting user input and storing in the first array
    input_loop1:
        beq $t1, 4, end_input_loop1 # Exit loop after 4 integers are input

        # Display prompt and read integer from user
        li $v0, 4 # System call code for print string
        la $a0, getUserInput # Load address of input prompt string
        syscall
        li $v0, 5 # System call code for reading an integer
        syscall

        sw $v0, array1($t0) # Store the input integer in array1 at current index

        addi $t0, $t0, 4 # Increment index to next integer position in array1
        addi $t1, $t1, 1 # Increment loop counter
        j input_loop1
    end_input_loop1:

    # Reinitialize for input of the second array
    li $t0, 0 # Set index for array2 to 0
    li $t1, 0 # Set loop counter to 0

    # Loop for getting user input and storing in the second array
    input_loop2:
        beq $t1, 4, end_input_loop2 # Exit loop after 4 integers are input

        # Similar process as input_loop1 for array2
        li $v0, 4
        la $a0, getUserInput
        syscall
        li $v0, 5
        syscall

        sw $v0, array2($t0) # Store input integer in array2

        addi $t0, $t0, 4 # Increment index for array2
        addi $t1, $t1, 1 # Increment loop counter
        j input_loop2
    end_input_loop2:

    # Printing the first array
    li $v0, 4
    la $a0, printArr1
    syscall
    li $t0, 0 # Reset index for printing array1

    print_loop1:
        bge $t0, 16, end_print_loop1 # Exit loop after 4 integers

        lw $t1, array1($t0) # Load integer from array1
        li $v0, 1 # System call code for print integer
        move $a0, $t1 # Move integer to be printed to $a0
        syscall

        li $v0, 4 # System call code for print string
        la $a0, newLine # Print newline
        syscall

        addi $t0, $t0, 4 # Move to next integer in array1
        j print_loop1
    end_print_loop1:

    # Printing the second array, similar to the first
    li $v0, 4
    la $a0, printArr2
    syscall
    li $t0, 0 # Reset index for printing array2

    print_loop2:
        bge $t0, 16, end_print_loop2 # Exit loop after 4 integers

        lw $t1, array2($t0) # Load integer from array2
        li $v0, 1 # System call code for print integer
        move $a0, $t1 # Move integer to be printed to $a0
        syscall

        li $v0, 4 # System call code for print string
        la $a0, newLine # Print newline
        syscall

        addi $t0, $t0, 4 # Move to next integer in array2
        j print_loop2
    end_print_loop2:

    # Sum calculation and storing back in array1
    li $t0, 0 # Reset index for array processing

    sum_loop:
        bge $t0, 16, end_sum_loop # Exit loop after 4 integers

        lw $t1, array1($t0) # Load integer from array1
        lw $t2, array2($t0) # Load integer from array2
        add $t3, $t1, $t2 # Add the integers
        sw $t3, array1($t0) # Store sum in array1

        addi $t0, $t0, 4 # Move to next integer position
        j sum_loop
    end_sum_loop:

    # Print the sum array
    li $v0, 4
    la $a0, printSumArr
    syscall
    li $t0, 0 # Reset index for printing the sum array

    print_sum_loop:
        bge $t0, 16, end_print_sum_loop # Exit loop after 4 integers

        lw $t1, array1($t0) # Load the sum from array1
        li $v0, 1 # System call code for print integer
        move $a0, $t1 # Move sum to be printed to $a0
        syscall

        li $v0, 4 # System call code for print string
        la $a0, newLine # Print newline
        syscall

        addi $t0, $t0, 4 # Move to next sum integer
        j print_sum_loop
    end_print_sum_loop:

    # Exit program
    li $v0, 10 # System call code for exit
    syscall
