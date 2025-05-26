C4  equ 523  ; m as agudo
Cs4 equ 494
D4  equ 466
Ds4 equ 440
E4  equ 415
F4  equ 392
Fs4 equ 370
G4  equ 349
Gs4 equ 330
A4  equ 311
As4 equ 294
B4  equ 277
C5  equ 262  ; mas grave

.model small
.stack 100h

.data
; ---------------------- MENU PRINCIPAL ----------------------
    menu_titulo      db 'MENU PRINCIPAL', 13, 10, 10, '$'
    menu_opcion1     db '1. Jugar Triqui Traki', 13, 10, '$'
    menu_opcion2     db '2. Test Princesa Disney', 13, 10, '$'
    menu_opcion3     db '3. Simulador Piano', 13, 10, '$'
    menu_salir       db '4. Salir', 13, 10, 10, '$'
    menu_seleccion   db 'Seleccione una opcion (1-4): $'
    opcion_invalida  db 'Opcion invalida! Lee bien, 1 2 3 o 4$'

    nueva_linea db 13, 10, "$"; pues una nueva linea
    ;------------MENSAJES JUEGO TRIKI TRAKI----------------------------------------------

    ;Tablero del juego
    tablero db " | | ", 13, 10    ; Fila 1 (posiciones 0,2,4)
            db " | | ", 13, 10    ; Fila 2 (posiciones 7,9,11)
            db " | | ", 13, 10, "$" ; Fila 3 (posiciones 14,16,18)
                  
    ;Posiciones reales del tablero
    mapa_posiciones db 0, 2, 4, 7, 9, 11, 14, 16, 18 
    
    hay_ganador db 0
    jugador_actual db "0$" ; 0 Jugador X, 1 Jugador O, estoy que cambio esa monda me tiene enredada  
    movimiento_valido db 0;
    delaytime db 10
    espacios_libres db 10

    ;Mensajes
    mensaje_fin db "Fin del juego!", 13, 10, "$"    
    mensaje_titulo db "            Triqui Traki", 13, 10, "$"
    mensaje_jugador db "JUGADOR $"   
    mensaje_ganador db " GANA!$"   
    mensaje_ingreso db "INGRESA POSICION (1-9): $"
    mensaje_ocupado db " Es una posicion ocupada tramposo!", 13, 10, "$"
    mensaje_empate db "EMPATE! Nadie gana.", 13, 10, "$"
    mensaje_inicio db "Presione cualquier tecla para comenzar...", 13, 10, "$"
    mensaje_reiniciar db "Una mas por el honor? (Escribe 's' para jugar otra vez, 'v' para volver al menu o cualquier otra para salir con dignidad): $"
    mensaje_salida    db "Gracias por jugar! Hasta pronto.", 13, 10, "$"
  
  ;-------MENSAJES JUEGO PRINCESA DISNEY -------------------------------------------------------
    msj_titulo db '       QUE PRINCESA DISNEY ERES?$'
    msj_inicio db 'Presiona cualquier tecla para comenzar...$'   
    instruccion db 'Elige A, B, C o D: $'
    msj_otraVez db 13, 10, 'Presione "v" para volver al menu, o cualquier otra tecla para salir.$'

    pregunta1 db 13, 10, '1. Que harias si te encierran en una torre?', 13, 10
              db 'A) Usar mi melena para escapar', 13, 10
              db 'B) Esperar a que me rescaten', 13, 10
              db 'C) Pintar murales hasta aburrirme', 13, 10
              db 'D) Construir una escalera', 13, 10, '$'
    pregunta2 db 13, 10, '2. Tu arma preferida es...', 13, 10
              db 'A) Una espada', 13, 10
              db 'B) Mis puños (le pega a la pared)', 13, 10
              db 'C) Un tenedor', 13, 10
              db 'D) Un arco y flecha', 13, 10, '$'
    pregunta3 db 13, 10, '3. Tu actividad favorita:', 13, 10
              db 'A) Montar a caballo', 13, 10
              db 'B) Cantarle a ardillas, ciervos y uno que otro arbol.', 13, 10
              db 'C) Coleccionar cosas', 13, 10
              db 'D) Mirarme al espejo', 13, 10, '$'
    pregunta4 db 13, 10, '4. Como es tu estilo de cabello?', 13, 10
              db 'A) Laaaaaargo y magico', 13, 10
              db 'B) Recogido elegantemente', 13, 10
              db 'C) Despeinado, como mi vida', 13, 10
              db 'D) No tengo cabello :C', 13, 10, '$'
    pregunta5 db 13, 10, '5. Tu animal favorito es...', 13, 10
              db 'A) Un caballo', 13, 10
              db 'B) Un pajarito cantor', 13, 10
              db 'C) Un dragon', 13, 10
              db 'D) Un oso', 13, 10, '$'
    pregunta6 db 13, 10, '6. Tu excusa para llegar tarde:', 13, 10
              db 'A) "Estaba salvando China"', 13, 10                                      
              db 'B) "Un enano me distrajo"', 13, 10                                       
              db 'C) "Se me convirtio el novio en sapo"', 13, 10                          
              db 'D) "Se me perdieron las llaves"', 13, 10, '$'   
    pregunta7 db 13, 10, '7. Tu perfil de Tinder dice:', 13, 10
              db 'A) "Busco alguien que sobreviva a mi madre"', 13, 10                    
              db 'B) "Soy buena cocinando... depende del paladar"', 13, 10                         
              db 'C) "Dispuesta a todo ;)"', 13, 10              
              db 'D) "Dormi 100 años y ahora estoy activa"', 13, 10, '$'
    pregunta8 db 13, 10, '8. Como te describirias en tres palabras?', 13, 10
            db 'A) Fuerte, magica, preciosa.', 13, 10
            db 'B) Dulce, diva, soñadora.', 13, 10
            db 'C) Rebelde, rara, fabulosa.', 13, 10
            db 'D) Valiente, intensa, libre.', 13, 10, '$'
    pregunta9 db 13, 10, '9. ¿Como reaccionas al ver una cucaracha?', 13, 10
          db 'A) Grito y salto.', 13, 10
          db 'B) Le pongo nombre y se queda en mi casa.', 13, 10
          db 'C) Me mudo', 13, 10
          db 'D) Le lanzo algo.', 13, 10, '$'

    ; --- Resultados
    res_cenicienta db 13, 10, 'Eres Cenicienta: Te levantas a las 5 a barrer y terminas en una fiesta.$'
    res_aurora     db 13, 10, 'Eres Blancanieves: Hablas con pajaros y limpias para siete señores que no pagan arriendo.$'
    res_ariel      db 13, 10, 'Eres Ariel: Te encanta meterte en problemas por amor.$'
    res_mulan      db 13, 10, 'Eres Mulan: Valiente y estrategica, haces mas en una tarde que yo en un año$'
    res_merida     db 13, 10, 'Eres Merida: Independiente y audaz.$'
    res_rapunzel   db 13, 10, 'Eres Rapunzel: Te la vives encerrada siendo feliz.$'
    res_tiana      db 13, 10, 'Eres Tiana: Te ganas la vida con esfuerzo y haces tremendas sopas, emprendedora. $'  ; 

    puntos dw 0
    return db 0
    ;--------------- MENSAJES PIANO ----------------------------------------------
    p_menu db 13,10,'                  _   ___   _   _   ___',13,10
         db '                  |  _ \| | / _ \ | \ | | / __ \',13,10
         db '                  | |_)|| || |_| ||  \| || |  | |',13,10
         db '                  |  __/| || | | || |\  || |__| | ',13,10
         db '                  |_|   |_||_| |_||_| \_| \____/ ',13,10,13,10
         db '$'
    p_instrucciones db 13,10,'Instrucciones:',13,10,13,10
                  db 'Teclas blancas (notas naturales):',13,10
                  db '  a - Do (C4)  s - Re (D4)  d - Mi (E4)',13,10
                  db '  f - Fa (F4)  g - Sol (G4) h - La (A4)',13,10
                  db '  j - Si (B4)  k - Do (C5)',13,10,13,10
                  db 'Teclas negras (sostenidos):',13,10
                  db '  w - Do#     e - Re#',13,10
                  db '  t - Fa#     y - Sol#     u - La#',13,10,13,10
                  db '"ESC" - Salir, "v" - Volver al menu.',13,10,13,10
                  db 'Presiona una tecla para tocar...',13,10,'$'
    mensaje_inicio_p db "Presione cualquier tecla para comenzar...", 13, 10, "$"

    
    p_canciones db 13,10,'No sabes que tocar? aca lo mas sonado:',13,10,13,10
                  db 'Estrellita: a a g g h h g f f d d s s a',13,10
                  db 'Fur elise: j u j u j g h g f a d g h f h g f',13,10,'$'

.code
main proc
    mov ax, @data
    mov ds, ax
menu_principal:
    mov return, 0
    call limpiar_pantalla
    call mostrar_menu

    call leer_caracter
    ;Procesar seleccion
    cmp al, '1'
    je jugar_triqui
    cmp al, '2'
    je jugar_princesas
    cmp al, '3'
    je jugar_piano
    cmp al, '4'
    je salir_programa

    ; Opción inválida
    mov dx, offset opcion_invalida
    call imprimir_cadena
    call sonido_error
    call delay
    jmp menu_principal

jugar_triqui:
    call reinicio_valores_tic
    call juego_trikitraki
    jmp menu_principal

jugar_princesas:
    mov puntos, 0
    call juego_princesa_disney
    cmp return, 1
    je menu_principal
    jmp salir_programa

jugar_piano:
    call juego_piano
    je menu_principal

salir_programa:
    call limpiar_pantalla
    mov dx, offset mensaje_salida
    call imprimir_cadena
    mov ax, 4C00h
    int 21h
main endp

mostrar_menu proc
    ; Mostrar título del menú
    mov dx, offset menu_titulo
    call imprimir_cadena
    
    ; Mostrar opciones
    mov dx, offset menu_opcion1
    call imprimir_cadena
    mov dx, offset menu_opcion2
    call imprimir_cadena
    mov dx, offset menu_opcion3
    call imprimir_cadena
    mov dx, offset menu_salir
    call imprimir_cadena
    
    ; Mostrar prompt de selección
    mov dx, offset menu_seleccion
    call imprimir_cadena
    ret
mostrar_menu endp

juego_trikitraki proc
call mostrar_inicio_tic
    
    inicializo_mov_valido:
        mov movimiento_valido, 0

    juego_loop:
        call limpiar_pantalla
        call mostrar_interfaz_inicial
        call mostrar_tablero
        call solicitar_movimiento
        call procesar_movimiento
        cmp movimiento_valido, 1 ;osea si es uno es porque es invalido
        je inicializo_mov_valido; al ser invalido no continua, vuelve al inicio

        call verificar_ganador
        cmp hay_ganador, 1 ; si es 1 hay ganador, va al fin
        je fin_del_juego

        cmp espacios_libres, 1
        je fin_del_juego

        call cambiar_jugador
        jmp juego_loop
    
    fin_del_juego:
        call mostrar_resultado_final
        cmp return, 1
        je volver
        jmp inicializo_mov_valido
    volver:
        ret

juego_trikitraki endp

juego_princesa_disney proc

    call mostrar_pantalla_inicio
    call limpiar_pantalla

    ; preguntdas
    lea dx, pregunta1
    call mostrar_y_leer
    lea dx, pregunta2
    call mostrar_y_leer
    lea dx, pregunta3
    call mostrar_y_leer
    lea dx, pregunta4
    call mostrar_y_leer
    lea dx, pregunta5
    call mostrar_y_leer
    lea dx, pregunta6
    call mostrar_y_leer
    lea dx, pregunta7
    call mostrar_y_leer
    lea dx, pregunta8
    call mostrar_y_leer
    lea dx, pregunta9
    call mostrar_y_leer

    call evaluar_resultado
    ret
juego_princesa_disney endp

juego_piano proc
    ; Mostrar pantalla de inicio
    call mostrar_inicio_p
    ; Limpiar pantalla
    call limpiar_pantalla
    call piano
    ret
juego_piano endp


; Procedimiento para mostrar menú inicial
mostrar_inicio_p proc
    ; Para cambiar color de fondo y texto
    mov ax, 0600h ; limpiar pantalla
    mov bh, 3Fh ; colorcitos: fondo azul (1), texto amarillo (E)
    mov cx, 0000h ; esquina superior izquierda/ ch fila inicio, dl columna inicio, 
    mov dx, 184Fh ; esquina inferior derecha, lo mismo de arriba pero pues los finales 
    int 10h
    
    ; Posicionar cursor para centrar el titulo
    mov ah, 02h ; posicionar cursor
    mov bh, 00h ; Página 0
    mov dh, 08h ; Fila 8
    mov dl, 20 ; Columna 20
    int 10h
    
    ; Mostrar titulo
    mov dx, offset p_menu
    call imprimir_cadena
    
    ; Posicionar cursor para el mensaje de inicio
    mov ah, 02h
    mov dh, 12h      ; Fila 18
    mov dl, 18       ; Columna 18
    int 10h
    
    ; Mostrar mensaje de inicio
    mov dx, offset mensaje_inicio_p
    call imprimir_cadena
    
    ; Esperar cualquier tecla
    call leer_caracter
mostrar_inicio_p endp

; Procedimiento para mostrar instrucciones
mostrar_instrucciones_p proc
    push ax
    push dx
    
    mov ah, 09h
    lea dx, p_instrucciones
    int 21h
    
    pop dx
    pop ax
    ret
mostrar_instrucciones_p endp

; Procedimiento principal del piano
piano proc
    call mostrar_instrucciones_p

    mov dx, offset p_canciones
    call imprimir_cadena
    
    
    ciclo_piano:
        ; Leer tecla del teclado
        mov ah, 00h
        int 16h
        
        cmp al, 'a'
        je tocar_C4
        cmp al, 'w'
        je tocar_Cs4
        cmp al, 's'
        je tocar_D4
        cmp al, 'e'
        je tocar_Ds4
        cmp al, 'd'
        je tocar_E4
        cmp al, 'f'
        je tocar_F4
        cmp al, 't'
        je tocar_Fs4
        cmp al, 'g'
        je tocar_G4
        cmp al, 'y'
        je tocar_Gs4
        cmp al, 'h'
        je tocar_A4
        cmp al, 'u'
        je tocar_As4
        cmp al, 'j'
        je tocar_B4
        cmp al, 'k'
        je tocar_C5



        cmp al, 27      ; ESC para salir
        je salir_piano

        cmp al, 'v'
        je retornar

        jmp ciclo_piano ; Otra tecla - ignorar
        
    tocar_C4:
        mov bx, C4
        jmp reproducir_nota
    tocar_Cs4:
        mov bx, Cs4
        jmp reproducir_nota
    tocar_D4:
        mov bx, D4
        jmp reproducir_nota
    tocar_Ds4:
        mov bx, Ds4
        jmp reproducir_nota
    tocar_E4:
        mov bx, E4
        jmp reproducir_nota
    tocar_F4:
        mov bx, F4
        jmp reproducir_nota
    tocar_Fs4:
        mov bx, Fs4
        jmp reproducir_nota
    tocar_G4:
        mov bx, G4
        jmp reproducir_nota
    tocar_Gs4:
        mov bx, Gs4
        jmp reproducir_nota
    tocar_A4:
        mov bx, A4
        jmp reproducir_nota
    tocar_As4:
        mov bx, As4
        jmp reproducir_nota
    tocar_B4:
        mov bx, B4
        jmp reproducir_nota
    tocar_C5:
        mov bx, C5
        jmp reproducir_nota
        
    reproducir_nota:
        call sonar_nota
        jmp ciclo_piano
        
    salir_piano:
        call limpiar_pantalla
        mov dx, offset mensaje_salida
        call imprimir_cadena
        mov ax, 4c00h
        int 21h
    retornar:
      ret
piano endp

; Procedimiento para generar sonido de una nota específica
; Entrada: BX = frecuencia de la nota
sonar_nota proc
    push ax
    push bx
    push cx
    
    ; Activar el altavoz
    mov al, 182         ; Preparar el altavoz
    out 43h, al         ; Enviar comando al puerto 43h
    mov ax, bx          ; Frecuencia (pasada en BX)
    out 42h, al         ; Enviar byte bajo
    mov al, ah
    out 42h, al         ; Enviar byte alto
    in al, 61h          ; Leer estado del puerto 61h
    or al, 00000011b    ; Activar bits 0 y 1
    out 61h, al         ; Encender el altavoz
    
    ; mantener el sonido por un tiempo corto
    mov cx, 1           ; Duración más corta para respuesta rápida
    delay_nota:
        push cx
        mov cx, 0FFFFh
        loop_sonido:
            loop loop_sonido
        pop cx
        loop delay_nota
    
    ; Apagar el altavoz
    in al, 61h          ; Leer estado del puerto 61h
    and al, 11111100b   ; Desactivar bits 0 y 1
    out 61h, al         ; Apagar el altavoz
    
    pop cx
    pop bx
    pop ax
    ret
sonar_nota endp



mostrar_pantalla_inicio proc
    mov ax, 0600h
    mov bh, 5Fh     
    mov cx, 0000h
    mov dx, 184Fh
    int 10h

    ;titulo
    mov ah, 02h     ; Posicionar cursor
    mov bh, 00h
    mov dh, 5       ; Fila 5
    mov dl, 15      ; Columna 15
    int 10h
    
    mov ah, 09h
    lea dx, msj_titulo
    int 21h         ;

    ;mensaje presione la tecla
    mov ah, 02h
    mov dh, 16       ; Fila 16
    mov dl, 15       ; Columna 15
    int 10h          ; Posiciona cursor

    ;
    mov ah, 09h
    mov al, ' '      ; pa borrar
    mov bh, 00h      ; pagina no se porque 0
    mov bl, 0DFh     ; Atributo parpadeante
    mov cx, 41       ; Longitud fija
    int 10h          ; Pinta el fondo con atributo

    ; Imprimir el mensaje (hereda atributo)
    mov ah, 09h
    lea dx, msj_inicio
    int 21h

    ; 6. Esperar tecla
    mov ah, 00h
    int 16h
    ret
mostrar_pantalla_inicio endp

mostrar_y_leer proc
    ; Mostrar pregunta
    mov ah, 09h
    int 21h
    
    ; Mostrar instrucción
    lea dx, instruccion
    int 21h
    
    ; Leer tecla
    mov ah, 00h
    int 16h
    
    ; Convertir a mayúscula y procesar
    and al, 11011111b
    cmp al, 'A'
    je sum5
    cmp al, 'B'
    je sum3
    cmp al, 'C'
    je sum1
    cmp al, 'D'
    je sum2    ; 
    
    ret
    
sum5: add puntos, 5
    ret
sum3: add puntos, 3
    ret
sum2: add puntos, 2   
    ret
sum1: add puntos, 1
    ret
mostrar_y_leer endp

evaluar_resultado proc
    call limpiar_pantalla

    cmp puntos, 40
    jge rapunzel    ; 40-45 
    cmp puntos, 34
    jge merida      ; 34-39 
    cmp puntos, 28
    jge mulan       ; 28-33 
    cmp puntos, 22
    jge tiana       ; 22-27 
    cmp puntos, 16
    jge ariel       ; 16-21 
    cmp puntos, 10
    jge aurora      ; 10-15 
    
    lea dx, res_cenicienta  ; 0-9 
    jmp mostrar
rapunzel:
    lea dx, res_rapunzel
    jmp mostrar
merida:
    lea dx, res_merida
    jmp mostrar
mulan:
    lea dx, res_mulan
    jmp mostrar
tiana:           
    lea dx, res_tiana
    jmp mostrar
ariel:
    lea dx, res_ariel
    jmp mostrar
aurora:
    lea dx, res_aurora
    
mostrar:
    mov ah, 09h
    int 21h

    mov dx, offset msj_otraVez
    call imprimir_cadena

    call leer_caracter
    cmp al, "v"
    je volver_al_menu
    mov return, 0  ; Cualquier otra tecla - salir
    ret
volver_al_menu:
    mov return, 1   ; 'v' - volver al menu
    ret
evaluar_resultado endp

mostrar_inicio_tic proc
    ; Para cambiar color de fondo y texto
    mov ax, 0600h ; limpiar pantalla
    mov bh, 1Eh ; colorcitos: fondo azul (1), texto amarillo (E)
    mov cx, 0000h ; esquina superior izquierda/ ch fila inicio, dl columna inicio, 
    mov dx, 184Fh ; esquina inferior derecha, lo mismo de arriba pero pues los finales 
    int 10h
    
    ; Posicionar cursor para centrar el titulo
    mov ah, 02h ; posicionar cursor
    mov bh, 00h ; Página 0
    mov dh, 08h ; Fila 8
    mov dl, 20 ; Columna 20
    int 10h
    
    ; Mostrar titulo
    mov dx, offset mensaje_titulo
    call imprimir_cadena
    
    ; Posicionar cursor para el mensaje de inicio
    mov ah, 02h
    mov dh, 12h      ; Fila 18
    mov dl, 18       ; Columna 18
    int 10h
    
    ; Mostrar mensaje de inicio
    mov dx, offset mensaje_inicio
    call imprimir_cadena
    
    ; Esperar cualquier tecla
    call leer_caracter

mostrar_inicio_tic endp

mostrar_interfaz_inicial proc
   mov dx, offset nueva_linea
    call imprimir_cadena
    mov dx, offset mensaje_titulo
    call imprimir_cadena
    mov dx, offset nueva_linea
    call imprimir_cadena
    
    mov dx, offset mensaje_jugador
    call imprimir_cadena
    mov dx, offset jugador_actual
    call imprimir_cadena
    mov dx, offset nueva_linea
    call imprimir_cadena
    ret
mostrar_interfaz_inicial endp

mostrar_tablero proc
    mov dx, offset tablero
    call imprimir_cadena
    mov dx, offset nueva_linea
    call imprimir_cadena
    ret
mostrar_tablero endp

solicitar_movimiento proc
    mov dx, offset mensaje_ingreso
    call imprimir_cadena
    call leer_caracter
    ret
solicitar_movimiento endp

mostrar_resultado_final proc
    call limpiar_pantalla
    call mostrar_interfaz_inicial
    call mostrar_tablero
    
    mov dx, offset mensaje_fin
    call imprimir_cadena

    cmp hay_ganador, 1
    je ganador

    mov dx, offset mensaje_empate
    call imprimir_cadena
    jmp preguntar_reinicio

ganador:

    mov dx, offset mensaje_jugador
    call imprimir_cadena
    mov dx, offset jugador_actual
    call imprimir_cadena
    mov dx, offset mensaje_ganador
    call imprimir_cadena
   
preguntar_reinicio:
    mov dx, offset nueva_linea
    call imprimir_cadena
    mov dx, offset mensaje_reiniciar
    call imprimir_cadena
    ; el usuario ya eligio, se vera si se reinicia, se vuelve al menu, o si se sale sigue derecho con el codigo
    call leer_caracter
    cmp al, "s"
    je reiniciar_juego
    cmp al, "v"
    je volver_menu
    ;si se quiere salir 
    call limpiar_pantalla

    ; Posicionar cursor para centrar el titulo
    mov ah, 02h ; posicionar cursor
    mov bh, 00h ; Página 0
    mov dh, 08h ; Fila 8
    mov dl, 20 ; Columna 20
    int 10h

    mov dx, offset mensaje_salida
    call imprimir_cadena
    
    ; Pequeña pausa antes de salir
    call delay
    mov ax, 4c00h
    int 21h

reiniciar_juego:
    call reinicio_valores_tic
    ret

volver_menu:
    call reinicio_valores_tic
    mov return, 1
    ret
mostrar_resultado_final endp

reinicio_valores_tic proc
; Reiniciar variables del juego
    mov hay_ganador, 0
    mov jugador_actual, '0'
    mov espacios_libres, 10
    mov movimiento_valido, 0
    ; Limpiar el tablero
    call reiniciar_tablero
    ; Volver al juego
    ret

reinicio_valores_tic endp

reiniciar_tablero proc
    push si
    push cx
    
    mov si, offset tablero
    mov cx, 3  ; 3 filas
    
reiniciar_fila:
    mov byte ptr [si], ' '
    mov byte ptr [si+2], ' '
    mov byte ptr [si+4], ' '
    add si, 7  ; Saltar a la siguiente fila 
    loop reiniciar_fila
    
    pop cx
    pop si
    ret
reiniciar_tablero endp


procesar_movimiento proc
    
    sub al, '1' ;el jugador elige(1-9), las posiciones se manejan desde 0 so resto 1
    mov ah, 0
    mov bx, ax
    
    ; obtengo la posicion real en el tablero
    mov bl, mapa_posiciones[bx]
    mov bh, 0 

    ;Actualizo el tablero dependiendo del jugador actual
    mov si, offset tablero ;cargo en si la dirección de memoria donde comienza el string
    add si, bx ;luego le paso la direccion especifica


    ;--------------aca empiezo a verificar si esta ocupado 
    cmp byte ptr [si], ' '  ; esta vacia?
    je posicion_valida
    
    ; esta ocupada, aviso
    mov dx, offset mensaje_ocupado
    call imprimir_cadena
    call sonido_error
    
    ;delay para que se vea el mensaje porque se me desaparece re rápido ;_;
    call delay
    
    mov movimiento_valido, 1  ; modifico lo de mov invalido
    ret
    
    posicion_valida:
    ;---------------aca acaba 

        dec [espacios_libres]

    cmp jugador_actual, '0'
    je colocar_x
    mov byte ptr [si], 'o' ;solo especifico el tamaño, podria ser mov [si], 'o'

 
    jmp movimiento_completo
    
    colocar_x:
    mov byte ptr [si], 'x'
    
    movimiento_completo:
    ret
procesar_movimiento endp

verificar_ganador proc
    mov si, offset tablero ;cargo en si la dirección de memoria donde comienza el string
    
    ; Verificar filas
    call verificar_linea
    cmp hay_ganador, 1
    je fin_verificacion
    
    ; Verificar columnas
    call verificar_columnas
    cmp hay_ganador, 1
    je fin_verificacion
    
    ; Verificar diagonales
    call verificar_diagonales
    
    fin_verificacion:
    ret
verificar_ganador endp

verificar_linea proc
    ; Fila 1 (0,2,4)
    mov al, [si] ; comparo a todas con este
    cmp al, ' '; pues si esta vacia ya 
    je fila2
    cmp al, [si+2]
    jne fila2
    cmp al, [si+4]
    jne fila2
    ; si llega aca pues si eran las tres iguales, yaper
    jmp ganador
    
    fila2:
    ; Fila 2 (7,9,11)
    mov al, [si+7]
    cmp al, ' '
    je fila3
    cmp al, [si+9]
    jne fila3
    cmp al, [si+11]
    jne fila3
    jmp ganador
    
    fila3:
    ; Fila 3 (14,16,18)
    mov al, [si+14]
    cmp al, ' '
    je no_ganador
    cmp al, [si+16]
    jne no_ganador
    cmp al, [si+18]
    jne no_ganador
    
    ganador:
    mov hay_ganador, 1
    
    no_ganador:
    ret
verificar_linea endp

verificar_columnas proc
    ; Columna 1 (0,7,14)
    mov al, [si]
    cmp al, ' '
    je col2
    cmp al, [si+7]
    jne col2
    cmp al, [si+14]
    jne col2
    jmp col_ganador
    
    col2:
    ; Columna 2 (2,9,16)
    mov al, [si+2]
    cmp al, ' '
    je col3
    cmp al, [si+9]
    jne col3
    cmp al, [si+16]
    jne col3
    jmp col_ganador
    
    col3:
    ; Columna 3 (4,11,18)
    mov al, [si+4]
    cmp al, ' '
    je fin_columnas
    cmp al, [si+11]
    jne fin_columnas
    cmp al, [si+18]
    jne fin_columnas
    
    col_ganador:
    mov hay_ganador, 1
    
    fin_columnas:
    ret
verificar_columnas endp

verificar_diagonales proc
    ; Diagonal 1 (0,9,18)
    mov al, [si]
    cmp al, ' '
    je diag2
    cmp al, [si+9]
    jne diag2
    cmp al, [si+18]
    jne diag2
    jmp diag_ganador
    
    diag2:
    ; Diagonal 2 (4,9,14)
    mov al, [si+4]
    cmp al, ' '
    je fin_diagonales
    cmp al, [si+9]
    jne fin_diagonales
    cmp al, [si+14]
    jne fin_diagonales
    
    diag_ganador:
    mov hay_ganador, 1
    
    fin_diagonales:
    ret
verificar_diagonales endp

cambiar_jugador proc
    xor jugador_actual, 1  ; Alterna entre 0 y 1, soy muy inteligente mano
    ret
cambiar_jugador endp

imprimir_cadena proc
    mov ah, 9 
    int 21h
    ret
imprimir_cadena endp

leer_caracter proc
    mov ah, 07h
    int 21h
    ret
leer_caracter endp

limpiar_pantalla proc
    mov ah, 0fh
    int 10h              
    mov ah, 0
    int 10h
    ret
limpiar_pantalla endp

delay proc 
    mov ah, 00
    int 1Ah
    mov bx, dx
jmp_delay:
    int 1Ah
    sub dx, bx
    cmp dl, delaytime                                                      
    jl jmp_delay    
    ret
delay endp

; Procedimiento para generar sonido de error
sonido_error proc
    push ax
    push bx
    push cx
    
    ; Activar el altavoz
    mov al, 182         ; Preparar el altavoz
    out 43h, al         ; Enviar comando al puerto 43h
    mov ax, 4560        ; Frecuencia (más agudo = menor número)
    out 42h, al         ; Enviar byte bajo
    mov al, ah
    out 42h, al         ; Enviar byte alto
    in al, 61h          ; Leer estado del puerto 61h
    or al, 00000011b    ; Activar bits 0 y 1
    out 61h, al         ; Encender el altavoz
    
    ; mantener el sonid
    mov cx, 2           ; la duracion, le puedes mover si quiere mas o menos tiempo, asi esta nice igual
    delay_sonido:
        push cx
        mov cx, 0FFFFh
        sonido_loop:
            loop sonido_loop
        pop cx
        loop delay_sonido
    
    ; Apagar el altavoz
    in al, 61h          ; Leer estado del puerto 61h
    and al, 11111100b   ; Desactivar bits 0 y 1
    out 61h, al         ; Apagar el altavoz
    
    pop cx
    pop bx
    pop ax
    ret
sonido_error endp

end main