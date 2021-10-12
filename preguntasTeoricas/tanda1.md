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

##3. No Silver Bullet – Essence and Accident in Software Engineering

3.1 ¿Cuales son las diferencias y similitudes entre las concepciones de Naur y de Brooks en lo que refiere a qué son los programas?
	* Al igual que para Naur, el software es una construcción de conceptos interrelacionados. Surge de la relación entre los datos, los algoritmos y las funciones del programa. Esto se diferencia de entender al software como un conjunto de instrucciones, al darle una esencia más abstracta y no tan mecánica.
	

3.2 ¿Cuales es la propuestas de Brooks en lo que refiere a la formación de los desarrolladores de programas?
	* Brooks propone que los buenos desarrolladores deben encontrarse, cultivarse y ser reconocidos como parte fundamental de una organización. 
	

## 4. Self: The Power Of Simplicity

4.1 Nombre y explique los 3 principios que guiaron el diseño de Self.
	* Los mensajes ocupan un lugar central, incluso más que en SmallTalk. No existen las variables,
	la única forma de acceder al estado de un objecto es a través de mensajes.
	* Un lenguaje diseñado para ser simple y económico de conceptos. Por ejemplo: no existen clases ni variables; cualquier objeto puede servir para guardar información; se omiten las estructuras de control (de esta manera todo se reduce a usar clausuras y polimorfismo); todos los objetos se crean de la misma manera, utilizando prototipado.
	* Concretitud. El lenguaje Self está basado en la idea de prototipos. En un lenguaje basado en clases, los nuevos objetos se crean instanciando una clase. En un lenguaje basado en prototipos, los objetos se crean clonando (copiando) otro objeto, que funciona como "prototipo" del nuevo.

4.2 En Self los objetos se crean a partir de:
	* Ninguna de las anteriores.