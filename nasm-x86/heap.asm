[bits 32]

section .text
	global _main
	extern _printf

N equ 10000000

_main:
  xor eax, eax
  mov ecx, N
  mov edi, h
  initloop:
    stosd
    inc eax
  loop initloop


  mov ecx, N / 2
  remloop:

  call pushDown

  dec ecx
  cmp ecx, -1
  jnz remloop
;	push dword [h + 4 * 0]
;	push string
;	call _printf
;	add esp, 8

	xor eax, eax
	ret

pushDown: ; ecx = startPos
  push ecx

  lea eax, [2 * ecx + 1]
  cmp eax, N
  jae pushDown_end

  mov edx, dword [h + eax * 4]

  cmp eax, N - 1
  jz no_brother

  mov ecx, dword [h + eax * 4 + 4]
  cmp ecx, edx
  ja no_brother

  inc eax
  xchg ecx, edx

  no_brother:

  pushDown_end:
  pop ecx
  ret

section .data
	string db 'Hello World %d', 0

section .bss
	h: resd N
