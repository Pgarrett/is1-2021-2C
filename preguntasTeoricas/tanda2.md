# Preguntas Teóricas - Tanda 2

## Null Object Pattern

https://www.google.com/url?q=https://drive.google.com/file/d/1WytOS3c5_PlNFXnV_7fOn0715w0Pl5FL/view&sa=D&source=editors&ust=1635631520791000&usg=AOvVaw2Bbap7o9VxP2muEvYVm55A

1. El paper original sugiere utilizar un Singleton para implementar el null object. ¿Qué ventajas y desventajas le ven?

* PG: Como ventaja, el NullObject no va a cambiar su comportamiento, así que nos ahorramos tener varias instancias del mismo que hacen lo mismo y nunca van a cambiar. La desventaja es que al ser justamente un singleton, su manera de "no hacer nada" no es modificable, y como aclara el paper, los distintos clientes del null object pueden requerir diferente comportamiento al "no hacer nada".
 
2. En un lenguaje dinámicamente tipado ¿Cuál es la condición más débil para que el real object y el null object sean intercambiables?

* PG: Que implementen los mismos métodos.


## Object Recursion

https://www.google.com/url?q=http://www.industriallogic.com/patterns/P21.pdf&sa=D&source=editors&ust=1635631545454000&usg=AOvVaw2xOc6mgTRZdVTKw1zXnuv2

1. ¿Qué es necesario para llevar a cabo la recursión a nivel de objetos? (Marque la opcion correcta)

* PG: Un mensaje polimórfico implementado en toda la jerarquia, ya sean casos base o recursivos. Además, un mensaje adicional como inciador de la petición.

2. Dada la siguiente afirmación: "Una vez que en una jerarquía de clases, alguna/s cumple/n el rol de Recurser y otra/s el de Terminator, cualquier otra operación recursiva a implementar en esa jerarquía debe cumplir esos mismos roles." Decidir si es verdadera o falsa. En ambos casos, justificar la respuesta con los motivos por los que sucede (puede dar ejemplos o contra ejemplos)

* PG: Falsa. El paper nombra "Role flexibility" como una ventaja de Object Recursion, ahí se explica que un handler que actúa como Recurser en un request puede actuar como Terminator en otro. En el caso del ejercicio de Portfolio, las operaciones de 'hasRegistered' se delegan recursivamente desde Portfolio como Recurser hasta llegar al ReceptiveAccount como Terminator. Podríamos agregar la opción de pedirle al ReceptiveAccount que nos indique cual es el nodo raíz del árbol en el que se encuentra, devolverá vacío si es solo la cuenta, pero si pertenece a un Portfolio el Terminator será el mismo Portfolio y no el ReceptiveAccount


## Method Object

Pág 34 del libro Smalltalk Best Practices Patterns - Kent Beck

1. ¿Qué problema intenta resolver el patrón Method Object? (máximo 3 líneas).

* PG: El Method Object intenta proveer una abstracción para un método de un sistema que fue creciendo y complejizandose. No siempre que un sistema crece, el contenido puede lograr generalizarse en una abstracción, un objeto, que "mapee" con el mundo que queremos modelar, en esos casos sirve el Method Object.

2. Explique las características de un objeto que sigue este patrón y cómo es utilizado. (máximo 5 líneas).

* Un objeto que sigue este patrón está definido por una clase que lleva el nombre del método que estamos refactorizando. En la estructura interna, el objeto que recibía el mensaje que estamos refactorizando pasa a ser una variable de instancia que se asigna en la construcción del objeto Method Object. Los argumentos que recibía el mensaje se pasan en la construcción también y son parte de las variables de instancia. Por último, las variables temporales que se generaban en la ejecución del método, son variables de instancia también.


## State Pattern

Capítulo de State de Design Patterns - Lo visto en clase

1. ¿Por qué es preferible que las transiciones de estados las haga el objeto context?

* PG: Si las transiciones las hacen las mismas subclases de estado, estaríamos obligando a que los estados conozcan al menos uno estado distinto a el mismo, generando una dependencia entre estados en su implementación.

2. ¿Qué cosas nos indican que debemos aplicar este patrón?

* PG: tenemos colaboradores internos y condicionales en nuestros métodos para modelar el comportamiento.


## Decorator Pattern

Capítulo de Decorator de Design Patterns - Lo visto en clase

1. ¿Qué patrón se puede utilizar cuando la cadena de decoraciones es compleja de construir? (Solo el nombre del patrón)

* PG: Strategy

2. ¿Cómo debe ser el decorator respecto del decoratee? (Una sola palabra)

* PG: Polimórfico


## Proxy Pattern

Capítulo de Proxy de Design Patterns - Lo visto en clase

1. Describa una similitud y una diferencia con el Decorator. (Solo UNA similitud y UNA diferencia)

* PG: Similitud: ambos son polimórficos con respecto al objeto que decoran/proxean. Diferencia: El proxy controla el acceso a un objeto, mientras que el decorator agrega una o más responsabilidades a un objeto.

2. ¿En Smalltalk, cómo se puede hacer que el Proxy sea polimórfico con el proxee fácilmente?

* PG: Utilizando el mensaje `doesNotUnderstand` para que el Proxy redefina y capture el envío de ese mensaje y se lo forwardee al proxee acordemente.


## Adapter Pattern

Capítulo de Adapter de Design Patterns - Lo visto en clase

1. ¿Nombre UNA similitud y UNA diferencia entre Adapter y Decorator?

* PG: Diferencia: El adapter y el objeto adaptado no son polimórficos, como si lo son el decorator y decoratee. Similitud: Ambos evitan generar una explosión de subclases.

2. ¿En Smalltalk, cómo se puede implementar un Adapter genérico?

* PG: Parametrizando un adapter con uno o más closures que tengan competencia sobre cada request.
