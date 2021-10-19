Para simplificar los reportes podemos devolver un ordered collection donde cada elemento sea el string que habria que imprimir.

Lo primero a hacer es un reporte naive haciendo TDD sobre las cuentas (no portfolio) usando ifs


## Preguntar:
* Que entendemos por navegar de una pata a la otra, que a nivel codigo podamos ver que hay una conexion entre un objeto y el otro? O que podamos pedirle a una punta de la transaccion la otra cuenta de la transaccion? En este ultimo caso, eso no romperia encapsulamiento?
	* Como lo testeamos?



Cuales son las responsabilidades que debería saber responder una transferencia?
* value
* patas

Cuales son las responsabilidades que debería saber responder una pata de transferencia?
* value
* patas
* la otra pata
* ?