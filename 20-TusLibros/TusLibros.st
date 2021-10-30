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
	instanceVariableNames: 'booksInCart catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'PhG 10/30/2021 09:15:09'!
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


!Cart methodsFor: 'assertions' stamp: 'PhG 10/30/2021 09:12:11'!
assertBookIsInCatalogue: aBook
	
	(catalogue contains: aBook) ifFalse: [ self signalBookNotInCatalogue ].! !


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


!classDefinition: #Catalogue category: 'TusLibros'!
Object subclass: #Catalogue
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogue methodsFor: 'initialization' stamp: 'PhG 10/30/2021 09:05:26'!
initialize
	books _ OrderedCollection new.! !

!Catalogue methodsFor: 'initialization' stamp: 'PhG 10/30/2021 09:05:40'!
initializeWithBook: aBook
	self initialize.
	books add: aBook.! !

!Catalogue methodsFor: 'initialization' stamp: 'PhG 10/30/2021 09:05:53'!
with: aBook
	books add: aBook.! !


!Catalogue methodsFor: 'testing' stamp: 'PhG 10/30/2021 09:05:26'!
contains: aBookToSearch
	^books includes: aBookToSearch.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogue class' category: 'TusLibros'!
Catalogue class
	instanceVariableNames: ''!

!Catalogue class methodsFor: 'initialization' stamp: 'wb 10/28/2021 22:14:43'!
with: aBook
	^self basicNew initializeWithBook: aBook.! !
