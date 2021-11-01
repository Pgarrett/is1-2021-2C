!classDefinition: #TestsCart category: 'TusLibros'!
TestCase subclass: #TestsCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestsCart methodsFor: 'tests carritos' stamp: 'bt 10/30/2021 18:59:11'!
test01ANewCartShouldBeEmpty
	
	|cart|
	
	cart _ Cart withCatalogue: (OrderedCollection new).
	
	self assert: true equals: cart isEmpty.! !

!TestsCart methodsFor: 'tests carritos' stamp: 'bt 10/30/2021 19:00:13'!
test02ACartWithABookIsNotEmpty

	|cart book catalogue|

	book _ '1234'.
	catalogue _ OrderedCollection with: book.	
	cart _ Cart withCatalogue: catalogue .

	cart addBook: book.

	self assert: false equals: cart isEmpty.! !

!TestsCart methodsFor: 'tests carritos' stamp: 'bt 10/30/2021 19:00:21'!
test03ACartWithABookShouldContainIt

	|cart book|
	book _ '1234'.
	cart _ Cart withCatalogue: (OrderedCollection with: book).
	
	cart addBook: book.
	
	self assert: true equals: (cart contains: book).! !

!TestsCart methodsFor: 'tests carritos' stamp: 'bt 10/30/2021 19:00:30'!
test04AddingABookNotInCatalogueToAcartShouldThrowError

	|cart book catalogue |
	
	book _'1234'.
	catalogue _ OrderedCollection new.
	cart _ Cart withCatalogue: catalogue.
	
	self 
		should: [ cart addBook: book.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Cart canNotAddBookNotInCatalogue equals: anError messageText.
			self assert: true equals: cart isEmpty .]! !

!TestsCart methodsFor: 'tests carritos' stamp: 'bt 10/30/2021 19:00:39'!
test05ACartCanHaveMultipleCopiesOfTheSameBook

	|cart book catalogue|
	
	book _'1234'.
	catalogue _ OrderedCollection with: book.
	cart _ Cart withCatalogue: catalogue.
	cart addBook: book.
	cart addBook: book.
	
	self assert: 2 equals: (cart quantityOfBook: book).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'booksInCart catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'bt 10/30/2021 18:59:31'!
initializeWithCatalogue: aCatalogue

	catalogue _ aCatalogue.
	booksInCart _ OrderedCollection new.! !


!Cart methodsFor: 'operation' stamp: 'PhG 10/30/2021 09:14:55'!
addBook: aBook 
	
	self assertBookIsInCatalogue: aBook.
	
	booksInCart add: aBook.! !


!Cart methodsFor: 'testing' stamp: 'PhG 10/30/2021 09:14:55'!
contains: aBookToSearch 

	^booksInCart includes: aBookToSearch.! !

!Cart methodsFor: 'testing' stamp: 'PhG 10/30/2021 09:14:55'!
isEmpty

	^booksInCart isEmpty .! !

!Cart methodsFor: 'testing' stamp: 'PhG 10/30/2021 09:14:55'!
quantityOfBook: aBook

	^booksInCart occurrencesOf: aBook.! !


!Cart methodsFor: 'assertions' stamp: 'bt 10/30/2021 18:58:26'!
assertBookIsInCatalogue: aBook
	
	(catalogue includes: aBook) ifFalse: [ self signalBookNotInCatalogue ].! !


!Cart methodsFor: 'exceptions' stamp: 'PhG 10/30/2021 09:11:17'!
signalBookNotInCatalogue
	
	self error: self class canNotAddBookNotInCatalogue! !

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
