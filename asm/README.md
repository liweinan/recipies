# learn-assembly

## Introduction

I'll collect some interesting code snippets while I'm learning assembly here.

## Usage

All the codes inside this project can be compiled with a single make command:

	$ make

Please ensure you have installed nasm on your machine.

## Purpose of the register

* EAX - Calculation Register

EAX generally used for doing math caluation. Such as:

	mov eax, 1 ; set eax = 1
	add eax, 1 ; 1+1

* EBX - General Usage Register

* ECX - Counter Register

* EDX - Data Register

* ESI - Source Index Register

* EDI

* EBP - Base Pointer

Used to store a copy of ESP

* ESP - Stack Pointer

## Data Type

	+-------------+------+-----------+--------+-----------+
	| name        | bits |  register | define | hex       |
	+-------------+------+-----------+--------+-----------+
	| nybble      | 4    | -         | -      | Ah        |
	+-------------+------+-----------+--------+-----------+
	| byte        | 8    | al        | d      | 3Ah       |
	+-------------+------+-----------+--------+-----------+
	| word        | 16   | ax        | dw     | 3A3Ah     |
	+-------------+------+-----------+--------+-----------+
	| double word | 32   | eax       | dd     | 3A3A3A3Ah |
	+-------------+------+-----------+--------+-----------+
