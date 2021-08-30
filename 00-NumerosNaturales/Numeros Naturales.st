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

!I class methodsFor: 'operaciones' stamp: 'PhG 8/28/2021 18:33:36'!
*unNumeroNatural

	^unNumeroNatural ! !

!I class methodsFor: 'operaciones' stamp: 'WB 8/26/2021 21:16:32'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/28/2021 19:54:27'!
- aNaturalNumber
	^Error new signal: 'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/28/2021 19:53:41'!
/ unNumeroNatural
	(unNumeroNatural = self) ifTrue: [^self].
	^Error new signal: 'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/28/2021 20:10:05'!
> aNaturalNumber
	^False! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/28/2021 19:45:08'!
multiplica: unNumero
	^unNumero! !

!I class methodsFor: 'operaciones' stamp: 'WB 8/26/2021 20:42:35'!
next
	"comment stating purpose of message"

	^II! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/28/2021 19:41:40'!
serMultiplicado: n
^1! !

!I class methodsFor: 'operaciones' stamp: 'PhG 8/28/2021 18:55:36'!
serRestado: unNumeroNatural
	^unNumeroNatural previous.! !


!I class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:42:13'!
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

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/28/2021 19:53:15'!
* aNaturalNumber
	^(aNaturalNumber multiplica: self previous) + aNaturalNumber! !

!II class methodsFor: 'NumerosNaturales' stamp: 'WB 8/28/2021 17:52:17'!
+ aNaturalNumber
	^self previous + aNaturalNumber next! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/28/2021 19:24:34'!
- aNaturalNumber 
	^aNaturalNumber serRestado: self! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/28/2021 20:22:12'!
/ aNaturalNumber
	self > aNaturalNumber ifTrue: [^Error new signal: 'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'].! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/28/2021 20:09:47'!
> aNaturalNumber 
	aNaturalNumber = I ifTrue: [^True ].
	^self previous > aNaturalNumber previous ! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/28/2021 20:12:16'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/28/2021 19:44:42'!
multiplica: numeroAMultiplicar
	^numeroAMultiplicar + (self previous multiplica: numeroAMultiplicar)! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/30/2021 19:32:36'!
next

	next ifNotNil: [^next].
	next _ self createChildNamed: self name, 'I'.
	next previous: self.
	^next! !

!II class methodsFor: 'NumerosNaturales' stamp: 'WB 8/26/2021 21:23:35'!
previous
	^previous! !

!II class methodsFor: 'NumerosNaturales' stamp: 'WB 8/26/2021 21:31:17'!
previous: aNaturalNumber
	previous _ aNaturalNumber! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/28/2021 19:40:52'!
serMultiplicado: nVeces
	^self + (self serMultiplicado: nVeces previous)! !

!II class methodsFor: 'NumerosNaturales' stamp: 'PhG 8/28/2021 19:23:33'!
serRestado: unNumeroNatural
	^ self previous serRestado: unNumeroNatural previous.! !


!II class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:42:13'!
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

!III class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:42:13'!
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

!IIII class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:42:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!