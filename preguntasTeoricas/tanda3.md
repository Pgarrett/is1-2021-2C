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

2. Ahora encuentre y explique las desventajas que su compañero puede encontrarse por haber tomado la decisión de utilizar este patrón para resolver su problema.


## Visitor Pattern

Capítulo de Visitor de Design Patterns - Lo visto en clase

1. En TODO problema resuelto mediante el patrón Visitor, subyacen los patrones:

2. ¿Cuál es el beneficio de utilizar un method object en lo que respecta al double dispatch genérico?


## Pattern Abuser

https://ubadao.files.wordpress.com/2013/07/pattern-abuser.pdf

1. ¿Es conveniente en algún caso aplicar patrones sistemáticamente como describe el artículo? ¿De qué depende?

2. ¿Es cierto que siempre es mala idea combinar más de un patrón de diseño en una solución? Justificar (puede incluir ejemplos)


## Alan Kay en Quora

https://www.quora.com/Was-computing-dumbed-down-by-the-arrival-of-computer-science-in-academia/answer/Alan-Kay-11

1. ¿Qué relevancia tiene la noción de 'algoritmo' en Ciencias de la Computación según Alan Kay? 

* PG: Según Alan Kay, la noción de 'algoritmo' es una pequeña parte de la computación.

2. ¿Cual o cuales son la nociones centrales de la disciplina según Alan Kay?

* PG: Es más relevante para la disciplina el hecho de poder entender, inventar y construir sistemas. Eso nos permite, por ejemplo, explorar las teorías que se formulan. La interacción con los sistemas permite que los mismos crezcan cuando "se quedan cortos" (en la respuesta lo relaciona con la matemática), de esta forma los sistemas evolucionan con el paso del tiempo y no son formulaciones estáticas. Dicho de otra forma, nos permiten seguir aprendiendo.