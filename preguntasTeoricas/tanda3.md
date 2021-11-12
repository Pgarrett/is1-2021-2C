# Preguntas Teóricas - Tanda 3

## **Observer Pattern**

Capítulo de Observer de Design Patterns - Lo visto en clase

1. Explique un motivo por el cual el objeto observado puede verse afectado por el observador cuando el primero notifica de un cambio

* BT: Cuando el primer observer es notificado, el mismo puede interactuar con el objeto observado modificando el estado interno, por ejemplo, pidiendo ser removido de la lista de observadores.
    
2. ¿Qué sucedería si el observador modifica el objeto observado cuando el primero fue notificado que el segundo cambió? De un ejemplo

* BT: Pueden haber muchos casos. Por dar un ejemplo, si al modificar el objeto observado se produce una nueva notificacion de cambio, en el peor caso se podria producir un ciclo. Otro caso posible es que al momento de que el proximo observador sea notificado, el primer observador haya "consumido" o modificado cierta informacion del objeto observado, dandole importancia al orden en el cual se notifican los observadores. Por ultimo, y viendo en mayor profundidad la implementacion, hay que tomar precauciones a la hora de iterar los observadores a notificar, ya que si un observador se desuscribe al ser notificado, podria llegar a haber problemas al estar modificando una lista que esta siendo recorrida.

## Composite Pattern

Capítulo de Composite de Design Patterns - Lo visto en clase

1. Un compañero de trabajo utiliza un composite para resolver un problema. Explicite todas las razones que considera lo llevaron a utilizarlo.

* PG: El problema que el compañero está resolviendo seguramente tenga como participantes a objetos que pueden ser compuestos o individuales, formando una especie de árbol, donde los objetos individuales pueden ser parte de los objetos compuestos que a su vez pueden ser parte de otros objetos compuestos. Tanto los objetos compuestos como los individuales deben ser tratados de la misma forma

2. Ahora encuentre y explique las desventajas que su compañero puede encontrarse por haber tomado la decisión de utilizar este patrón para resolver su problema.

* PG: Al utilizar un composite para resolver su problema, el compañero puede tener dificultades si en los nuevos requirimientos alguno de los objetos pertenecientes al árbol empieza a necesitar un comportamiento muy distinto en el que la pertenencia al árbol ya no sea tan consistente, desacoplarlo puede llevar un gran trabajo.


## Visitor Pattern

Capítulo de Visitor de Design Patterns - Lo visto en clase

1. En TODO problema resuelto mediante el patrón Visitor, subyacen los patrones:
* BT+PG: Composite y Double Dispatch

2. ¿Cuál es el beneficio de utilizar un method object en lo que respecta al double dispatch genérico?

* BT: Usar un method object para el double dispatch nos permite reutilizar esa lógica a través de las distintas clases sobre las que se va a realizar el double dispatch. De esa manera podemos preservar una jerarquia existente pero logrando el mismo comportamiento por medio de compoisición.


## Pattern Abuser

https://ubadao.files.wordpress.com/2013/07/pattern-abuser.pdf

1. ¿Es conveniente en algún caso aplicar patrones sistemáticamente como describe el artículo? ¿De qué depende?
* WB: Aplicar patrones sistemáticamente, sin pensar, con reglas preestablecidas y rígidas, no es recomendable, ya que podríamos caer en la falla de sobre-diseñar algo simple, o de querer aplicar siempre la misma solución a distintos problemas ("si mi única herramienta es un martillo, todos mis problemas son clavos", etcétera). Idealmente debemos aplicar un patrón a un diseño si llegamos naturalmente a él (no porque ya teníamos la intención previa de usarlo), y solamente si estamos convencidos de que mejorará nuestra aplicación (la hará más fácil de modificar y entender, más testeable, más escalable).

2. ¿Es cierto que siempre es mala idea combinar más de un patrón de diseño en una solución? Justificar (puede incluir ejemplos)
* WB: En principio no es mala idea incluir más de un patrón de diseño en una solución. Algunas veces un patrón es en realidad combinación de dos patrones; por ejemplo, el Visitor es una mezcla de Composite y Double Dispatch. En otras ocasiones, un patrón resuelve una parte del problema y otro patrón, una diferente. Un Adapter para lidiar con una clase legacy que debemos mantener, luego puede ser incluído en una jerarquía de objetos en un Composite. O en un aeropuerto, para mostrar información de los vuelos en sus pantallas: un Observer para que se vea la info en las pantallas mezclado con un State para mostrar de cierta forma o en ciertas pantallas los vuelos que estén en cierto estado.

## Alan Kay en Quora

https://www.quora.com/Was-computing-dumbed-down-by-the-arrival-of-computer-science-in-academia/answer/Alan-Kay-11

1. ¿Qué relevancia tiene la noción de 'algoritmo' en Ciencias de la Computación según Alan Kay? 

* PG: Según Alan Kay, la noción de 'algoritmo' es una pequeña parte de la computación.

2. ¿Cual o cuales son la nociones centrales de la disciplina según Alan Kay?

* PG: Es más relevante para la disciplina el hecho de poder entender, inventar y construir sistemas. Eso nos permite, por ejemplo, explorar las teorías que se formulan. La interacción con los sistemas permite que los mismos crezcan cuando "se quedan cortos" (en la respuesta lo relaciona con la matemática), de esta forma los sistemas evolucionan con el paso del tiempo y no son formulaciones estáticas. Dicho de otra forma, nos permiten seguir aprendiendo.
