%include "includes/io.inc"

extern getAST
extern freeAST

section .bss
    ; La aceasta adresa, scheletul stocheaza radacina arborelui
    root: resd 1
    
section .data
    zece dd 10
    plm db "12",0
section .text

atoi: ;care printr-un miracol mergeeeee, se intoarce in main si-mi salveaza valorile registrilor dinainte
    push ebp
    mov ebp, esp;pun pe stiva fostul ebp
    
    mov ecx, [ebp + 8] ;stochez stringul in ecx
;    mov ecx, [ebx]
    cmp byte [ecx], '-'
    je atoi_negative
    
    
    xor ebx, ebx
    xor eax, eax ;numar = 0
    xor edx, edx ; i = 0
atoi_loop_pozitive: ;while (string[i] != '\0')
    mov bl, byte [ecx + edx] ; o cifra
    cmp byte bl, 0
    jz end
    push edx
    mul dword [zece] ;rezultat *= 10
    pop edx
    inc edx; i++
    sub ebx, 48 ; string[i] - '0'
    add eax, ebx ; rezultat += string[i]

    jmp atoi_loop_pozitive
    
    jmp end ;sar la final, peste negative
   
atoi_negative: 
    xor ebx, ebx
    xor eax, eax ;numar = 0
    xor edx, edx ; i = 0
    inc edx ; i = 1 ca incepe cu minus
atoi_loop_negative: ;while (string[i] != '\0')
    mov bl, byte [ecx + edx] ; o cifra
    cmp byte bl, 0
    jz end_negative
    push edx
    mul dword [zece] ;rezultat *= 10
    pop edx
    inc edx; i++
    sub ebx, 48 ; string[i] - '0'
    add eax, ebx ; rezultat += string[i]
    jmp atoi_loop_negative
end_negative:
    not eax ;complementul fata de 2
    inc eax
end:
    leave;restabilesc ebp
    ret ;return rezultat, stocat in eax

preorder:
    push ebp
    mov ebp, esp;pun pe stiva fostul ebp
    
    xor ebx, ebx
    mov ecx, [ebp + 8] ;pun in ecx root-ul
    mov edx, [ecx] ;celula de date
    mov bl, byte [edx]
    ;PRINT_UDEC 4, bl
   ; NEWLINE
    cmp bl, 47
    ja numar
    cmp bl, '+'
    jz suma
    cmp bl, '/'
    jz impartire
    cmp bl, '*'
    jz inmultire
    cmp bl, '-'
    jz diferenta
    
diferenta:
    mov bl, byte [edx+1]
    cmp bl, 0
    jnz numar
;left 
    mov ecx, [ebp + 8] ;pun in ebx left
    add ecx, 4
    push dword [ecx]
    call preorder ;apelez preorder de left
    add esp, 4
    push eax
    
;right
    mov ecx, [ebp + 8] ;pun in ebx right
    add ecx, 8
    push dword [ecx]
    call preorder ;apelez preorder de right
    add esp, 4 
    push eax
    
    pop ebx
    pop eax
    sub eax, ebx
    jmp final
    
suma:
;left 
    mov ecx, [ebp + 8] ;pun in ebx left
    add ecx, 4
    push dword [ecx]
    call preorder ;apelez preorder de left
    add esp, 4
    push eax
    
;right
    mov ecx, [ebp + 8] ;pun in ebx right
    add ecx, 8
    push dword [ecx]
    call preorder ;apelez preorder de right
    add esp, 4 
    push eax
    
    pop ebx
    pop eax
    add eax, ebx
    jmp final
    
inmultire:
;left 
    mov ecx, [ebp + 8] ;pun in ebx left
    add ecx, 4
    push dword [ecx]
    call preorder ;apelez preorder de left
    add esp, 4
    push eax
    
;right
    mov ecx, [ebp + 8] ;pun in ebx right
    add ecx, 8
    push dword [ecx]
    call preorder ;apelez preorder de right
    add esp, 4 
    push eax
    
    pop ebx
    pop eax
    imul ebx
    jmp final
    
impartire:
;left 
    mov ecx, [ebp + 8] ;pun in ebx left
    add ecx, 4
    push dword [ecx]
    call preorder ;apelez preorder de left
    add esp, 4
    push eax
    
;right
    mov ecx, [ebp + 8] ;pun in ebx right
    add ecx, 8
    push dword [ecx]
    call preorder ;apelez preorder de right
    add esp, 4 
    push eax
    
    xor edx, edx
    pop ebx
    pop eax
    cdq
    idiv ebx
    jmp final
    
numar:
    mov edx, [ebp + 8] ;am ajuns la o frunza pe care o pun in
    mov edx, dword [edx]
    push edx  ;stiva ca sa apelez atoi
    call atoi ;in eax am valoarea din frunze
    add esp, 4
    ;PRINT_DEC 4, eax
    ;NEWLINE

final: 
    leave
    ret
    
global main
main:
    mov ebp, esp; for correct debugging
    ; NU MODIFICATI
    push ebp
    mov ebp, esp
    
    ; Se citeste arborele si se scrie la adresa indicata mai sus
    call getAST
    mov [root], eax
    
    ; Implementati rezolvarea aici
    push dword [root]
    call preorder
    PRINT_DEC 4, eax
    add esp, 4
    
    ; NU MODIFICATI
    ; Se elibereaza memoria alocata pentru arbore
    push dword [root]
    call freeAST
    
    xor eax, eax
    leave
    ret