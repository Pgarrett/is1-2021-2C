Para simplificar los reportes podemos devolver un ordered collection donde cada elemento sea el string que habria que imprimir.

Lo primero a hacer es un reporte naive haciendo TDD sobre las cuentas (no portfolio) usando ifs


## Preguntar:
* En el caso del resumen de cuentas de un portfolio, se imprime el balance de cada cuenta y al final el balance del portfolio? Como separamos una cuenta de otra?
* Vamos bien encarados con nuestro visitor?
* Como hacemos la indentacion de los reportes bonus si usamos ordered collection?
* Lo que hicimos de wire esta bien?
* Boleteamos las llamadas de transactions en todos lados? Dado que lo deberiamos considerar radioactivo




Cuales son las responsabilidades que debería saber responder una transferencia?
* value
* patas

Cuales son las responsabilidades que debería saber responder una pata de transferencia?
* value
* patas
* la otra pata
* ?