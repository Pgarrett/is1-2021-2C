!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'PhG 9/19/2021 19:14:40'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/19/2021 21:12:53'!
test01FindOnEmptyStackReturnsEmpty

	|sentenceFinderByPrefix stack |
	
	stack := OOStack new.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: 'wint') equals: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/19/2021 21:15:01'!
test02PrefixShouldBeFoundWhenStackOnlyContainsThePrefix

	|sentenceFinderByPrefix stack prefix |
	
	prefix := 'win'.
		
	stack := self initializeStackWith: prefix.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: prefix) equals: (OrderedCollection with: prefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/19/2021 21:15:12'!
test03FindOnStackWithContentContainingPrefixReturnsCollectionWithContent

	|sentenceFinderByPrefix stack prefix content|
	
	prefix := 'win'.
	content := (prefix, 'ter').
	
	stack := self initializeStackWith: content.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: prefix) equals: (OrderedCollection with: content).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/19/2021 21:15:23'!
test04FindOnStackIsCaseSensitive

	|sentenceFinderByPrefix stack prefix content|
	
	prefix := 'win'.
	content := 'Winter'.
	
	stack := self initializeStackWith: content.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: prefix) equals: (OrderedCollection new).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/19/2021 21:15:32'!
test05PrefixMustStartTheSentenceStartingWithThePrefix

	|sentenceFinderByPrefix stack prefix sentenceWithPrefix|
	
	prefix := 'Wint'.
	sentenceWithPrefix :=  (prefix, 'er is here').

	stack := self initializeStackWith: ('The winds of ', prefix, 'er').
	stack push: sentenceWithPrefix.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: prefix) equals: (OrderedCollection with: sentenceWithPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/19/2021 21:15:42'!
test06MultipleSentencesWithPrefixAreFound

	|sentenceFinderByPrefix stack prefix firstSentenceWithPrefix secondSentenceWithPrefix|
	
	prefix := 'Win'.
	firstSentenceWithPrefix :=  (prefix, 'ter is here').
	secondSentenceWithPrefix :=  (prefix, 'ning is awesome').

	stack := self initializeStackWith: firstSentenceWithPrefix.
	stack push: secondSentenceWithPrefix.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: prefix) equals: (OrderedCollection with: secondSentenceWithPrefix with: firstSentenceWithPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/19/2021 21:15:51'!
test07EmptyPrefixIsNotAllowed

	|sentenceFinderByPrefix stack|

	stack := self initializeStackWith: 'winter is coming'.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self executing: [ (sentenceFinderByPrefix find: '') ] 
		shouldFailWith: SentenceFinderByPrefix prefixCanNotBeEmptyErrorDescription.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/19/2021 21:15:58'!
test08PrefixWithWhitespaceIsNotAllowed

	|sentenceFinderByPrefix stack|

	stack := self initializeStackWith: 'winter is coming'.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self executing: [ (sentenceFinderByPrefix find: 'winter is') ] 
		shouldFailWith: SentenceFinderByPrefix prefixCanNotContainWhitespacesErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/19/2021 21:16:07'!
test09StackIsPreservedAfterFind

	|sentenceFinderByPrefix stack prefix firstPushedSentence secondPushedSentence lastPushedSentence|
	
	prefix := 'Wint'.
	firstPushedSentence := 'winter is coming'.
	secondPushedSentence := 'The winds of Winter'.
	lastPushedSentence := 'Winter is here'.

	stack := self initializeStackWith: firstPushedSentence.
	stack push: secondPushedSentence.
	stack push: lastPushedSentence.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	sentenceFinderByPrefix find: prefix.
	
	self assert: stack pop = lastPushedSentence.
	self assert: stack pop = secondPushedSentence.
	self assert: stack pop = firstPushedSentence.
	self assert: stack isEmpty.
	
	! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'PhG 9/19/2021 19:57:56'!
executing: aClosure shouldFailWith: anErrorDescription

	self
		should: aClosure
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: anError messageText = anErrorDescription ]! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'PhG 9/19/2021 20:04:47'!
initializeStackWith: anElement
	
	|stack|
	
	stack := OOStack new.
	stack push: anElement. 
	
	^stack.

	
	! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'PhG 9/19/2021 20:24:03'!
setUp
! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'PhG 9/18/2021 11:35:28'!
initialize
	
	contents := OrderedCollection new.! !


!OOStack methodsFor: 'testing' stamp: 'PhG 9/18/2021 14:17:49'!
isEmpty

	^contents isEmpty ! !


!OOStack methodsFor: 'adding' stamp: 'PhG 9/18/2021 14:19:20'!
push: anElement

	contents add: anElement.! !


!OOStack methodsFor: 'removing' stamp: 'PhG 9/19/2021 19:14:34'!
pop

	self validateNonEmpty.
	^contents removeLast .! !


!OOStack methodsFor: 'accessing' stamp: 'PhG 9/18/2021 14:26:35'!
size
	^contents size.! !

!OOStack methodsFor: 'accessing' stamp: 'PhG 9/19/2021 19:14:17'!
top

	self validateNonEmpty.
	^contents last! !


!OOStack methodsFor: 'private' stamp: 'PhG 9/19/2021 19:29:05'!
validateNonEmpty

	"Después de debatir por un rato, optamos por esta implementación porque entendemos que el if no se va a poder sacar por completo, en algún lado tiene que estar. No llegamos a un punto en el que supimos encontrar los dominions distintos que justifiquen el if, no nos quedó claro donde hacer esa distinción de dominio, y por eso lo dejamos acá donde es declarativo porque no comparamos el tamaño de pila para tomar la decisión. Tuvimos en cuenta que tener dos tipos de stack (empty/nonEmpty) trae problemas de implementación (por lo visto en clase), y creemos que debe ser el mismo stack quien resuelva el caso. A su vez, nos inspiramos en la implementación de Collection que utiliza el emptyCheck como forma de validar que la colección no está vacía."

	self isEmpty ifTrue: [^self error: OOStack stackEmptyErrorDescription.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackToObserve'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'searching' stamp: 'PhG 9/19/2021 21:12:29'!
find: aPrefix
	
	|elementsWithPrefix elementHolder currentStackElement|
	
	self validatePrefixIsNotEmpty: aPrefix.
	self validatePrefixDoesNotContainWhitespace: aPrefix.
	
	elementsWithPrefix := OrderedCollection new.
	elementHolder := OrderedCollection new.
	
	"Esto no lo abstraemos a otro mensaje porque tiene dos responsabilidades y para separarlas necesitaríamos una nueva abstracción. Por el enunciado, y el horario de resolución, no nos quedó claro si valía generar nuevas abstracciones en nuevos objetos."
	[stackToObserve isEmpty not] whileTrue: [
		currentStackElement := stackToObserve pop.
		(currentStackElement beginsWith: aPrefix) ifTrue: [elementsWithPrefix add: currentStackElement].
		elementHolder add: currentStackElement.
	].

	self restoreStackFrom: elementHolder.
	
	^elementsWithPrefix.! !

!SentenceFinderByPrefix methodsFor: 'searching' stamp: 'PhG 9/19/2021 21:12:01'!
find: aPrefix on: aStack
	
	|elementsWithPrefix elementHolder currentStackElement|
	
	self validatePrefixIsNotEmpty: aPrefix.
	self validatePrefixDoesNotContainWhitespace: aPrefix.
	
	elementsWithPrefix := OrderedCollection new.
	elementHolder := OrderedCollection new.
	
	"Esto no lo abstraemos a otro mensaje porque tiene dos responsabilidades y para separarlas necesitaríamos una nueva abstracción. Por el enunciado, y el horario de resolución, no nos quedó claro si valía generar nuevas abstracciones en nuevos objetos."
	[stackToObserve isEmpty not] whileTrue: [
		currentStackElement := stackToObserve pop.
		(currentStackElement beginsWith: aPrefix) ifTrue: [elementsWithPrefix add: currentStackElement].
		elementHolder add: currentStackElement.
	].

	self restoreStackFrom: elementHolder.
	
	^elementsWithPrefix.! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'PhG 9/19/2021 20:57:30'!
restore: aStack from: stackContentHolder

	[stackContentHolder isEmpty not] whileTrue: [
		aStack push: (stackContentHolder removeLast).
	].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'PhG 9/19/2021 21:11:47'!
restoreStackFrom: stackContentHolder

	[stackContentHolder isEmpty not] whileTrue: [
		stackToObserve push: (stackContentHolder removeLast).
	].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'PhG 9/19/2021 20:53:56'!
validatePrefixDoesNotContainWhitespace: aPrefix

	(aPrefix includesSubString: ' ') ifTrue: 
		[^self error: SentenceFinderByPrefix prefixCanNotContainWhitespacesErrorDescription .].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'PhG 9/19/2021 20:52:25'!
validatePrefixIsNotEmpty: aPrefix

	aPrefix isEmpty ifTrue: [^self error: SentenceFinderByPrefix prefixCanNotBeEmptyErrorDescription.].! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'PhG 9/19/2021 21:09:38'!
initializeWith: aStack

	stackToObserve := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'errror descriptions' stamp: 'PhG 9/19/2021 19:30:49'!
prefixCanNotBeEmptyErrorDescription

	^'Prefix can not be empty!!'! !

!SentenceFinderByPrefix class methodsFor: 'errror descriptions' stamp: 'PhG 9/19/2021 19:31:11'!
prefixCanNotContainWhitespacesErrorDescription

	^'Prefix can not contain whitespaces!!'! !


!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'PhG 9/19/2021 21:10:21'!
on: aStack

	^self new initializeWith: aStack.! !
