# Tus Libros

## Inicialización
Abrir un Workspace y ejecutar:

```server := TusLibrosRestAPI listeningOn: 8083.```

La primer ventana se abre con:

```TusLibrosCreateCartWindow open.```

Guardar el Workspace abierto.

## Usuarios Válidos
A continuación, los usuarios válidos, listados de forma `usuario:contraseña`:
* `maximoCozzetti:tortugaMaritima`
* `expiredUser:expiredPassword`

El usuario `maximoCozzetti` puede realizar todas las operaciones y cuenta con una tarjeta de crédito válida. El usuario `expiredUser` puede crear un carrito pero al intentar realizar la compra, su tarjeta será rechazada por encontrarse expirada.

La tarjeta de crédito de ambos usuarios ya es conocida por el sistema. Todo dato ingresado desde las pantallas de la interfaz gráfica será ignorado. Esta decisión fue tomada en pos de una mayor facilidad para el desarrollo del trabajo práctico.

Cualquier otro usuario que no sea uno de los dos listados, con su correspondiente contraseña, arrojará un error de autenticación.


## Finalización

En el Workspace abierto previamente, ejecutar:

```server destroy.```