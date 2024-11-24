section .rodata
    LC0 db "Failed to initialize GLFW", 0
    LC1 db "X86GL", 0
    LC2 db "Failed to create GLFW window", 0
    LC3 db "Failed to initialize GLEW", 0

section .text
    global _start

    extern glfwInit
    extern puts
    extern glfwCreateWindow
    extern glfwTerminate
    extern glfwMakeContextCurrent
    extern glfwSwapInterval
    extern glewInit
    extern glClear
    extern glfwSwapBuffers
    extern glfwPollEvents
    extern glfwWindowShouldClose
    extern glfwDestroyWindow

_start:
    ; Initialize GLFW
    call glfwInit
    test eax, eax
    jnz .L2

    ; Failed to initialize GLFW
    lea rdi, [LC0]
    call puts
    mov eax, -1
    jmp .L3

.L2:
    ; Create a window
    mov r8d, 0
    mov ecx, 0
    lea rdx, [LC1]
    mov esi, 600
    mov edi, 800
    call glfwCreateWindow
    mov rbx, rax
    cmp rbx, 0
    jne .L4

    ; Failed to create GLFW window
    call glfwTerminate
    lea rdi, [LC2]
    call puts
    mov eax, -1
    jmp .L3

.L4:
    ; Make context current
    mov rdi, rbx
    call glfwMakeContextCurrent

    ; Set swap interval
    mov edi, 1
    call glfwSwapInterval

    ; Initialize GLEW
    call glewInit
    test eax, eax
    jz .L6

    ; Failed to initialize GLEW
    lea rdi, [LC3]
    call puts
    mov eax, -1
    jmp .L3

.L7:
    ; Clear screen
    mov edi, 16384
    call glClear
    mov rdi, rbx
    call glfwSwapBuffers
    call glfwPollEvents

.L6:
    ; Check if the window should close
    mov rdi, rbx
    call glfwWindowShouldClose
    test eax, eax
    jz .L7

    ; Cleanup
    mov rdi, rbx
    call glfwDestroyWindow
    call glfwTerminate

    mov eax, 0

.L3:
    ; Exit program
    ret