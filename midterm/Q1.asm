.data
	prompt:						.asciiz "Enter an integer number:\n"
	msgDivisible:			.asciiz "the number is a multiple of 4\n"
	msgNotDivisible:	.asciiz "the number is NOT a multiple of 4\n"
	
	.text
	# prompt the user to enter an integer
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5 # get user's input
	syscall
	
	#lw $s0, 0($v0) # save user's input to $s0
	add $s0, $v0, $0 # save user's input to $s0
	
	# set $t0 to 1111...1100, then apply xor, if the last two bits were 0, then $t1 will be equal to $s0
	addi $t0, $0, 0xfffffffc
	and $t1, $t0, $s0

	li $v0, 4
	bne $t1, $s0, notDivisible
		la $a0, msgDivisible
		j exitApp
	notDivisible:
		la $a0, msgNotDivisible
		
	exitApp:
	syscall
	li $v0, 10
	syscall