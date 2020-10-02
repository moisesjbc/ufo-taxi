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

# Refinamiento de la idea

## Objetivo

El personaje del jugador itera siguiendo un polígono donde uno de las aristas es la meta. El objetivo en cada nivel es pasar N veces por la meta, pero cada vez que el personaje pasa por ella, pierde una carga. Hay N cargas sueltas por el mapa, pero están fuera del polígono original, así que el jugador tiene que alterar dicho polígono para recolectar las cargas antes de quedarse sin energía.

## Mecánicas

- Añadir un nuevo vértice:
    1. El jugador selecciona un punto a lo largo de cualquier arista AB.
    2. Se dibuja una perpendicular a la arista en dicho punto. El jugador situa el punto nuevo C en la arista y esto rompe la arista original, convirtíendola en ACB.

- Quitar un vértice:
    1. El jugador clica en un vértice N.
    2. Se elimina el vértice N, conectándose entre sí los vértices N-1 y N+1

## Restricciones / condiciones de muerte

- Restricción: el polígono nunca se rompe.
- Game over: el jugador se queda sin cargas tras pasar por la meta.
- Game over: el jugador se sale del polígono (pe. porque al añadir o quitar un vértice se rompe la arista en la que se encuentra actualmente.

