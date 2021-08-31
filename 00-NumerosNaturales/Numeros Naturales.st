!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 21:01:46'!
*unNumeroAMultiplicar

	^unNumeroAMultiplicar ! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 21:01:22'!
+ unSumando
	^unSumando next.! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 21:01:12'!
- unNumeroARestar
	^Error signal: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 21:01:04'!
/ unDivisor
	(unDivisor = self) ifTrue: [^self].
	^Error new signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 21:00:54'!
> unNumeroAComparar
	^false! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 20:24:31'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 20:27:59'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 21:00:33'!
multiplica: unNumeroAMultiplicar
	^unNumeroAMultiplicar! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 21:00:21'!
next
	^II! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 21:00:14'!
serMultiplicado: unNumeroAMultiplicar
^1! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/30/2021 21:00:01'!
serRestado: unNumeroARestar
	^unNumeroARestar previous.! !


!I class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 21:02:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:58:11'!
* unNumeroAMultiplicar
	^(unNumeroAMultiplicar multiplica: self previous) + unNumeroAMultiplicar! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:57:19'!
+ unSumando
	^self previous + unSumando next! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:57:59'!
- unNumeroARestar 
	^unNumeroARestar serRestado: self! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:58:23'!
/ unDivisor
	unDivisor > self
		ifTrue: [^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
		^unDivisor divide: self! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:58:45'!
> unNumeroAComparar 
	unNumeroAComparar = I ifTrue: [^true ].
	^self previous > unNumeroAComparar previous ! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:28:08'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:56:47'!
divide: unDividendo
	^unDividendo ! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:59:00'!
multiplica: unNumeroAMultiplicar
	^unNumeroAMultiplicar + (self previous multiplica: unNumeroAMultiplicar)! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 19:32:36'!
next

	next ifNotNil: [^next].
	next _ self createChildNamed: self name, 'I'.
	next previous: self.
	^next! !

!II class methodsFor: 'NumerosNaturales' stamp: 'WB 8/26/2021 21:23:35'!
previous
	^previous! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:59:17'!
previous: unNumeroPrevio
	previous _ unNumeroPrevio! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/28/2021 19:40:52'!
serMultiplicado: nVeces
	^self + (self serMultiplicado: nVeces previous)! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 20:59:31'!
serRestado: nVeces
	^ self previous serRestado: nVeces previous.! !


!II class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 21:02:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 21:02:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 21:02:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!