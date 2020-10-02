# Tema

Stuck in a loop

# Lluvia de ideas

- El jugador avanza por un bucle entrando por la izquierda de la pantalla y saliendo por la derecha. En cada iteración sólo puede hacer una acción para ayudarse a salir del bucle.
- El jugador tiene que correr en una pista circular mientras lo observan. Cuando no le vigilan tiene que ir haciendo cosas para intentar escapar.
- El jugador revive el mismo día una y otra vez: se levanta en su habitación, se prepara, teletrabaja, etc. Va emprendiendo pequeñas acciones para huir.
- El jugador va girando por un círculo / otro circuito cerrado que puede alterar para moverse por el mapa para conseguir diferentes objetivos mientras se mantenga en el bucle. ¿Qué acciones se pueden realizar?
    - El circuito puede tener forma de polígono.
    - Una de las acciones puede ser añadir un nuevo vértice a cierta distancia en la perpendicular de una arista.
        - Seleccionas posición en la arista y luego seleccionas en la perpendicular.
        - Si rompe la arista por la que va el personaje, este queda fuera del bucle y muere.
    - Otra acción es quitar un vértice.
        - Esto rompería temporalmente el polígono, ¿no?
        - Puedo añadir la restricción: siempre mantener el bucle cerrado.
    - ¿Puedo tener aristas sueltas por el mapa con las que me puede conectar?
    - Mecánica: aristas que no pueden dividirse (rojas).
        - Posible mecánica adicional: una acción para mover la restricción "roja" a la arista siguiente o anterior.
    - Mecánica adicional: zonas sobre las que si el personaje pasa va más lento / más rápido / se muere.
    - Añadir vértice "meta" por la que el usuario tiene que pasar N veces, pero cada iteración le resta una carga. Entonces tiene que ir consiguiendo las cargas en cada iteración.
    - El vértice meta no te lo puedes cargar.

