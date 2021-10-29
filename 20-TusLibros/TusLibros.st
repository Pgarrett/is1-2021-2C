!classDefinition: #TestsCart category: 'TusLibros'!
TestCase subclass: #TestsCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestsCart methodsFor: 'tests carritos' stamp: 'wb 10/28/2021 22:35:41'!
test01ANewCartShouldBeEmpty
	
	|cart|
	
	cart _ Cart withCatalogue: (Catalogue new).
	
	self assert: true equals: cart isEmpty.! !

!TestsCart methodsFor: 'tests carritos' stamp: 'wb 10/28/2021 22:35:41'!
test02ACartWithABookIsNotEmpty

	|cart book catalogue|

	book _ '1234'.
	catalogue _ Catalogue with: book.	
	cart _ Cart withCatalogue: catalogue .

	cart addBook: book.

	self assert: false equals: cart isEmpty.! !

!TestsCart methodsFor: 'tests carritos' stamp: 'wb 10/28/2021 22:35:41'!
test03ACartWithABookShouldContainIt

	|cart book|
	book _ '1234'.
	cart _ Cart withCatalogue: (Catalogue with: book).
	
	cart addBook: book.
	
	self assert: true equals: (cart contains: book).! !

!TestsCart methodsFor: 'tests carritos' stamp: 'wb 10/28/2021 22:35:41'!
test04AddingABookNotInCatalogueToAcartShouldThrowError

	|cart book catalogue |
	
	book _'1234'.
	catalogue _ Catalogue new.
	cart _ Cart withCatalogue: catalogue.
	
	self 
		should: [ cart addBook: book.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Cart canNotAddBookNotInCatalogue equals: anError messageText.
			self assert: true equals: cart isEmpty .]! !

!TestsCart methodsFor: 'tests carritos' stamp: 'wb 10/28/2021 22:40:52'!
test05ACartCanHaveMultipleCopiesOfTheSameBook

	|cart book catalogue|
	
	book _'1234'.
	catalogue _ Catalogue with: book.
	cart _ Cart withCatalogue: catalogue.
	cart addBook: book.
	cart addBook: book.
	
	self assert: 2 equals: (cart quantityOfBook: book).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'wb 10/28/2021 22:33:35'!
initializeWithCatalogue: aCatalogo
	catalogue _ aCatalogo.
	books _ OrderedCollection new.! !


!Cart methodsFor: 'operation' stamp: 'wb 10/28/2021 22:33:00'!
addBook: aBook 
	(catalogue contains: aBook) ifFalse: [ ^self error: self class canNotAddBookNotInCatalogue.].
	books add: aBook.! !


!Cart methodsFor: 'testing' stamp: 'wb 10/28/2021 22:23:16'!
contains: aBookToSearch 
	^(books select: [:bookInCart | bookInCart = aBookToSearch] ) notEmpty .! !

!Cart methodsFor: 'testing' stamp: 'wb 10/28/2021 22:22:49'!
isEmpty
	^books isEmpty .! !

!Cart methodsFor: 'testing' stamp: 'wb 10/28/2021 22:39:21'!
quantityOfBook: aBook
	^(books select: [ :aBookInCart | aBookInCart = aBook]) size .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialization' stamp: 'wb 10/28/2021 22:35:51'!
withCatalogue: aCatalogue 
	^self basicNew initializeWithCatalogue: aCatalogue.! !


!Cart class methodsFor: 'error message' stamp: 'wb 10/28/2021 21:58:30'!
canNotAddBookNotInCatalogue
	^'Book not in catalogue'.! !


!classDefinition: #Catalogue category: 'TusLibros'!
Object subclass: #Catalogue
	instanceVariableNames: 'listOfBooksInCatalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogue methodsFor: 'initialization' stamp: 'wb 10/28/2021 22:04:47'!
initialize
	listOfBooksInCatalogue _ OrderedCollection new.! !

!Catalogue methodsFor: 'initialization' stamp: 'wb 10/28/2021 22:23:53'!
initializeWithBook: aBook
	self initialize .
	listOfBooksInCatalogue add: aBook .! !

!Catalogue methodsFor: 'initialization' stamp: 'wb 10/28/2021 22:15:45'!
with: aBook
	listOfBooksInCatalogue add: aBook .! !


!Catalogue methodsFor: 'testing' stamp: 'wb 10/28/2021 22:04:47'!
contains: aBookToSearch
	^ (listOfBooksInCatalogue select: [:aBook| aBook = aBookToSearch ]) notEmpty .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogue class' category: 'TusLibros'!
Catalogue class
	instanceVariableNames: ''!

!Catalogue class methodsFor: 'initialization' stamp: 'wb 10/28/2021 22:14:43'!
with: aBook
	^self basicNew initializeWithBook: aBook.! !
