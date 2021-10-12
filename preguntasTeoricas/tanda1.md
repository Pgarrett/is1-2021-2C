# Preguntas Teóricas - Tanda 1

## Programming as Theory Building:

1. Explique brevemente las diferencias entre las ideas de Naur y Dijkstra.

	* PG: Dijkstra quería llevar la computación hacia un modelo axiomático. Si están los axiomas, las personas no importan, derivamos el conocimiento de los axiomas y seguimos desde ahí. Naur claramente se opone a esta idea. La teoría del programa, que nos dice por que se tomo tal o cual decisión, que se estaba intentando modelar, está en las personas y no es axiomatizable.

2. ¿Qué opina Naur del programador reemplazable como componente?
	* PG: Naur plantea que el programador no es reemplazable, es quien tiene la teoría del programa. Su conocimiento trasciende a la documentación en al menos tres puntos escenciales:
		1. Puede explicar como la solución se corresponde con las partes del mundo real que intentamos modelar.
		2. Puede justificar cada parte del programa.
		3. Es capaz de contestar constructivamente hacia cualquier demanda de modelar o soportar alguna parte del universo que intentamos modelar de una forma nueva.

	* BT: Para Naur, el programador es un componente no reemplazable, al cual se le debe dar la posibilidad de seguir desarrollando y manteniendo el mismo proyecto desde su creacion. Cada programador forma una teoria y modelo completamente personal acerca del proyecto, la cual es imposible de transmitir por completo a quien vaya a ser su reemplazo. Cada reemplazo solo sirve para degradar y enlentecer este transpaso (y descubrimiento) de la teoria del proyecto, enlentenciendo y complejizando su desarrollo y mantenimiento.


## The Design of Everyday Things

1. Marque aquellas opciones que crea que están relacionadas de forma directa, exclusiva y estricta al concepto de diseño (de objetos de todos los días) de "visibilidad":

	* PG: 
		* Aprovechar los "affordances" o "prestaciones" de los materiales de los objetos.
		* Determinar que partes de un objeto operar y cómo.
		* Las pistas o señales que brinda un objeto para ser usado.


2. Relacione en una única oración a la paradoja de la tecnología con los principios del buen diseño de objetos de todos los días.

	* Paradox of technology: "The same technology that simplifies life by providing more functions in each device also complicates life by making the device harder to learn, harder to use."
	
	* Fundamental principles of designing for people:
		1. Provide a good conceptual model.
		2. Make things visible.

	* PG: Por un lado, a mayor cantidad de funcionalidades que se intentan cubrir/resolver, más difícil es hacer visible todo sin tener un objeto lleno de controles; por otro lado, el avance de la tecnología también nos ayuda a abstraer ciertas operaciones/controles del objeto, lo cual nos impide formar un buen modelo conceptual.

## No Silver Bullet

1. ¿Cuales son las diferencias y similitudes entre las concepciones de Naur y de Brooks en lo que refiere a qué son los programas?
	
	* PG: Ambos coinciden en que los programas son la representación de una parte del universo, llevada a cabo por los programadores. Naur, por su parte, habla de los programas como teorías concebidas por una persona y/o su equipo. Esas personas son quienes conocen las decisiones sobre las cuales se creo la teoría que está representada por el programa. Brooks, en cambio, hace mucho énfasis en los programas como frutos del diseño, y que los mismos deben poder crecer y no simplemente ser construidos. Los dos mencionan que es importante la transferencia de conocimiento como parte de la vida del programa, y que fundamentalmente, un programa existe por la gente que lo crea. Por último, pero más a modo de apreciación personal, me dio la impresión de que Naur y su concepto de Teoría llaman a un programa más estático, donde los cambios son más difíciles. En cambio, Brooks y la noción de diseño + crecimiento, dan la impresión de que el programa y su vida son mucho más dinámicos.


2. ¿Cuales es la propuestas de Brooks en lo que refiere a la formación de los desarrolladores de programas?
	
	* PG: A lo largo del paper, podemos identificar algunos indicios de las propuestas de Brooks para la formación de los desarrolladores de programas. Por un lado, menciona que es importante tener buenas herramientas como programas para escribir, dibujar y hojas de cálculo. Por otro lado, y más importante, menciona que hay que enseñarle a los programadores con menos experiencia mediante aquellos con más experiencia/sabiduría. Esto vuelve a ser mencionado cerca del final cuando sugiere asignar un mentor para cada persona y tener un seguimiento de esa carrera con un plan que incluya por ejemplo cursos con grandes diseñadores, ejercicios desafiantes y oportunidad para que los diseñadores que estén aprendiendo puedan interactuar entre ellos, estimulando su crecimiento.
		

## Self: The Power Of Simplicity

1. Nombre y explique los 3 principios que guiaron el diseño de Self.

	* PG:
		1. Messages-at-the-bottom: Todas las operaciones en Self se realizan mediante el envío de mensajes entre objetos. No existen las variables y solo se puede acceder al estado interno de un objeto mediante el envío de un mensaje.
		2. Occam's Razor: La simpleza como bandera de diseño del lenguaje. Como fue mencionado anteriormente, todas las operaciones se realizan mediante el envío de mensajes y todos los objetos se obtienen mediante la clonación de prototipos, incluidos los closures y procedures. Esto nos permite una interacción más simple al momento de utilizar el lenguaje.
		3. Concreteness: En cierta sintonía con que todo sea lo más simple posible, Self opta por que sus elementos sean lo más concreto posibles, que no haya "magia" detrás, podríamos decir. Es por eso que, por ejemplo en la creación de objetos, la decisión fue de utilizar prototipos. Esto permite utilizar el concepto biológico de clonación para poder crear nuevas instancias de objetos, una metáfora mucho más entendible que la de creación mediante un plano escrito en una clase.

2. En Self los objetos se crean a partir de:
	* PG: Ninguna de las anteriores.
