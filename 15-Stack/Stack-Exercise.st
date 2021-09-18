!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/18/2021 15:30:32'!
test01FindOnEmptyStackReturnsEmpty

	|sentenceFinderByPrefix stack |
	
	stack := OOStack new.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: 'wint') equals: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/18/2021 15:35:17'!
test02FindOnStackWithContentContainingPrefixReturnsCollectionWithContent

	|sentenceFinderByPrefix stack prefix content|
	
	prefix := 'win'.
	content := (prefix, 'ter').
	stack := OOStack new.
	
	stack push: content.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: prefix) equals: (OrderedCollection with: content).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/18/2021 16:01:20'!
test03FindOnStackIsCaseSensitive

	|sentenceFinderByPrefix stack prefix content|
	
	prefix := 'win'.
	content := 'Winter'.
	stack := OOStack new.
	
	stack push: content.
	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: prefix) equals: (OrderedCollection new).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'PhG 9/18/2021 16:10:29'!
test04ElementsContainingPrefixAfterWhitespaceAreNotIncluded

	|sentenceFinderByPrefix stack prefix expectedContent|
	
	prefix := 'Wint'.
	expectedContent := 'Winter is here'.

	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: expectedContent.

	sentenceFinderByPrefix  := SentenceFinderByPrefix on: stack.
	
	self assert: (sentenceFinderByPrefix find: prefix) equals: (OrderedCollection with: expectedContent).! !


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


!OOStack methodsFor: 'removing' stamp: 'PhG 9/18/2021 14:25:36'!
pop
	contents isEmpty ifTrue: [^self error: OOStack stackEmptyErrorDescription.].
	^contents removeLast .! !


!OOStack methodsFor: 'accessing' stamp: 'PhG 9/18/2021 14:26:35'!
size
	^contents size.! !

!OOStack methodsFor: 'accessing' stamp: 'PhG 9/18/2021 14:24:51'!
top

	contents isEmpty ifTrue: [^self error: OOStack stackEmptyErrorDescription.].
	^contents at: (contents size)! !

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

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'PhG 9/18/2021 15:27:41'!
initializeWith: aStack

	stackToObserve := aStack.! !


!SentenceFinderByPrefix methodsFor: 'searching' stamp: 'PhG 9/18/2021 15:59:34'!
find: aPrefix 
	
	|elementsWithPrefix elementHolder currentStackElement|
	
	elementsWithPrefix := OrderedCollection new.
	elementHolder := OrderedCollection new.
	
	[stackToObserve isEmpty not] whileTrue: [
		currentStackElement := stackToObserve pop.
		(currentStackElement beginsWith: aPrefix) ifTrue: [elementsWithPrefix add: currentStackElement].
		elementHolder add: currentStackElement.
	].

	[elementHolder isEmpty not] whileTrue: [
		stackToObserve push: (elementHolder removeFirst).
	].
	
	^elementsWithPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'PhG 9/18/2021 15:29:14'!
on: aStack

	^SentenceFinderByPrefix new initializeWith: aStack .! !
