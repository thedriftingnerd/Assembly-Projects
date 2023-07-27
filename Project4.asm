INCLUDE Irvine32.inc

.data
num1 DWORD 1h
num2 DWORD 2h
num3 DWORD 3h
num4 DWORD 4h
num5 DWORD 5h

displayText MACRO text:newLine
    IFB <newLine>
        mov edx, OFFSET text
        call WriteString
    ELSE
        mov edx, OFFSET text
        call WriteString
        mov eax, newLine
        call WriteInt
        mov edx, OFFSET crlf
        call WriteString
    ENDIF
ENDM

.code
main PROC
    ; push five variables on the stack
    push num1
    push num2
    push num3
    push num4
    push num5

    ; call runLevelOne procedure
    call runLevelOne

    ; clean up the stack
    add esp, 20h

    exit
main ENDP

runLevelOne PROC
    ; push number of variables on the stack as a parameter
    push 5

    ; call runLevelTwo procedure
    call runLevelTwo

    ret
runLevelOne ENDP

runLevelTwo PROC
    ; display system parameters on the stack
    pushad
    displayText "System Parameters on Stack", 1
    mov eax, DWORD PTR [esp + 20h]
    mov ebx, esp
    add ebx, 24
    displayText "Address: ", 0
    mov edx, OFFSET format
    call WriteString
    mov edx, ebx
    call WriteHex
    displayText " => Content: ", 0
    mov edx, OFFSET format
    call WriteString
    mov edx, [ebx]
    call WriteHex
    add ebx, 4
    mov ecx, eax
    dec ecx
    jz done
loop1:
    displayText "Address: ", 0
    mov edx, OFFSET format
    call WriteString
    mov edx, ebx
    call WriteHex
    displayText " => Content: ", 0
    mov edx, OFFSET format
    call WriteString
    mov edx, [ebx]
    call WriteHex
    add ebx, 4
    dec eax
    jnz loop1
done:
    displayText "---------------------------------------", 1
    popad

    ret
runLevelTwo ENDP

END main
