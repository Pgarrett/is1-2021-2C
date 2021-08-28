!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'nil' stamp: 'WB 8/26/2021 21:16:32'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'nil' stamp: 'WB 8/26/2021 20:42:35'!
next
	"comment stating purpose of message"

	^II! !


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

!II class methodsFor: 'NumerosNaturales' stamp: 'WB 8/28/2021 17:52:17'!
+ aNaturalNumber
	^self previous + aNaturalNumber next! !

!II class methodsFor: 'NumerosNaturales' stamp: 'WB 8/26/2021 21:53:11'!
- aNaturalNumber 
	aNaturalNumber = I ifTrue: [^ self previous].
	^ self previous - aNaturalNumber previous.! !

!II class methodsFor: 'NumerosNaturales' stamp: 'WB 8/26/2021 21:31:43'!
next

	next ifNotNil: [^next].
	next _ II createChildNamed: self name, 'I'.
	next previous: self.
	^next! !

!II class methodsFor: 'NumerosNaturales' stamp: 'WB 8/26/2021 21:23:35'!
previous
	^previous! !

!II class methodsFor: 'NumerosNaturales' stamp: 'WB 8/26/2021 21:31:17'!
previous: aNaturalNumber
	previous _ aNaturalNumber! !


!II class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:58:08'!
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

!III class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:58:08'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:58:08'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!