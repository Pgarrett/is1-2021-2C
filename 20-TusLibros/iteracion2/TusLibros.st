!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/1/2021 20:09:09'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/1/2021 20:09:09'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/1/2021 20:09:09'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self assert: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/1/2021 20:09:09'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/1/2021 20:09:09'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSoldByTheStore.
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/2/2021 17:57:28'!
test09TotalPriceOfEmptyCartIsZero

	| cart |
	
	cart := self createCart.
	
	self assert: (cart totalPrice ) = 0.! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/2/2021 17:58:21'!
test10TotalPriceOfCartWithItemIsItemPrice

	| cart |
	
	cart := self createCart.
	
	cart add: 1 of: self itemSoldByTheStore.
	self assert: (cart totalPrice ) = 100.! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/2/2021 18:00:17'!
test11TotalPriceOfCartWithItemsIsAddedItemsPrice

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSoldByTheStore.
	self assert: (cart totalPrice ) = 200.! !


!CartTest methodsFor: 'support' stamp: 'PhG 11/1/2021 20:06:57'!
createCart
	
	^Cart acceptingItemsOf: self defaultPriceList! !

!CartTest methodsFor: 'support' stamp: 'PhG 11/1/2021 20:09:09'!
defaultCatalog
	
	^ Array with: self itemSoldByTheStore! !

!CartTest methodsFor: 'support' stamp: 'PhG 11/1/2021 20:09:09'!
defaultPriceList

	| priceList |
	
	priceList := Dictionary new.
	priceList add: (self itemSoldByTheStore)-> 100.
	^priceList.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'PhG 11/1/2021 20:09:09'!
itemSoldByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'PhG 11/1/2021 19:33:32'!
createCart
	
	^Cart acceptingItemsOf: self defaultPriceList! !

!CashierTest methodsFor: 'support' stamp: 'PhG 11/1/2021 20:10:07'!
createCartWith: aPriceList
	
	^Cart acceptingItemsOf: aPriceList! !

!CashierTest methodsFor: 'support' stamp: 'PhG 11/1/2021 20:09:09'!
defaultPriceList

	| priceList |
	
	priceList := Dictionary new.
	priceList add: (self itemSoldByTheStore)-> 100.
	^priceList.! !

!CashierTest methodsFor: 'support' stamp: 'PhG 11/1/2021 20:09:09'!
itemSoldByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'support' stamp: 'PhG 11/1/2021 20:09:20'!
otherItemSoldByTheStore
	
	^ 'otherValidBook'! !

!CashierTest methodsFor: 'support' stamp: 'PhG 11/1/2021 20:09:25'!
priceListwithTwoItems

	| priceList |
	
	priceList := Dictionary new.
	priceList add: (self itemSoldByTheStore)-> 100.
	priceList add: (self otherItemSoldByTheStore)-> 60.
	^priceList.! !


!CashierTest methodsFor: 'checkout tests' stamp: 'PhG 11/1/2021 19:26:55'!
test01checkoutOnEmptyCartThrowsError

	| cart cashier |
	
	cart := self createCart.
	cashier := Cashier new.
	
	self 
		should: [cashier checkout: cart ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier cartCanNotBeEmpty. ]! !

!CashierTest methodsFor: 'checkout tests' stamp: 'PhG 11/2/2021 17:53:32'!
test02checkoutTotalOnCartWithOneProductIsProductPrice

	| cart cashier |
	
	cart := self createCart.
	cashier := Cashier new.
	
	cart add: self itemSoldByTheStore.
	
	self assert: 100 equals: (cashier checkout: cart)
	! !

!CashierTest methodsFor: 'checkout tests' stamp: 'PhG 11/2/2021 17:53:38'!
test03checkoutTotalOnCartWithManyProductsIsProductsPriceSum

	| cart cashier |
	
	cart := self createCartWith: self priceListwithTwoItems.
	cashier := Cashier new.
	
	cart add: self itemSoldByTheStore.
	cart add: self otherItemSoldByTheStore.
	
	self assert: 160 equals: (cashier checkout: cart)
	! !

!CashierTest methodsFor: 'checkout tests' stamp: 'PhG 11/2/2021 17:53:44'!
test04checkoutWithExpiredCreditCardIsRejected

	| cart cashier today expiredDate |
	
	cart := self createCartWith: self priceListwithTwoItems.
	cashier := Cashier new.
	
	cart add: self itemSoldByTheStore.
	cart add: self otherItemSoldByTheStore.
	
	today := FixedGregorianDate today.
	
	expiredDate := today previous: (TimeUnits month with: 1).
	
	self assert: 160 equals: (cashier checkout: cart withCardExpirationDate: expiredDate)
	! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'PhG 11/2/2021 17:50:42'!
test01CreditCardWithLessThan16DigitsCanNotBeInstantiated

	| cardNumber |
	
	cardNumber := '0123456789'	.

	self assertCreditCardMustContain16DigitsForCardNumber: cardNumber.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PhG 11/2/2021 17:51:11'!
test02CreditCardWithMoreThan16DigitsCanNotBeInstantiated
	
	| cardNumber |
	
	cardNumber := '01234567890123456789'	.

	self assertCreditCardMustContain16DigitsForCardNumber: cardNumber.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PhG 11/2/2021 17:52:16'!
test03CreditCardWithExpirationDateInTheFutureIsNotExpired

	| creditCard currentMonthOfYear twoMonthsToTheFuture |
	
	currentMonthOfYear := self currentMonthOfYear.
	twoMonthsToTheFuture := self twoMonthsFrom: currentMonthOfYear.

	creditCard := CreditCard withNumber: '0123456789123456'	 withExpirationDate: twoMonthsToTheFuture.
	
	self deny: (creditCard isExpiredOn: currentMonthOfYear).! !

!CreditCardTest methodsFor: 'tests' stamp: 'PhG 11/2/2021 17:46:08'!
test04CreditCardWithExpirationDateInThePastIsExpired

	| creditCard currentMonthOfYear twoMonthsToThePast |
	
	currentMonthOfYear := self currentMonthOfYear.
	twoMonthsToThePast := self twoMonthsSince: currentMonthOfYear.

	creditCard := CreditCard withNumber: '0123456789123456'	 withExpirationDate: twoMonthsToThePast.
	
	self assert: (creditCard isExpiredOn: currentMonthOfYear).! !

!CreditCardTest methodsFor: 'tests' stamp: 'PhG 11/2/2021 17:45:48'!
test05CreditCardWithExpirationDateInThePresentIsNotExpired

	| creditCard currentMonthOfYear |
	
	currentMonthOfYear := self currentMonthOfYear.

	creditCard := CreditCard withNumber: '0123456789123456'	 withExpirationDate: currentMonthOfYear.
	
	self assert: (creditCard isExpiredOn: currentMonthOfYear).! !


!CreditCardTest methodsFor: 'dates' stamp: 'PhG 11/2/2021 17:44:19'!
currentMonthOfYear

	^GregorianMonthOfYear current.! !

!CreditCardTest methodsFor: 'dates' stamp: 'PhG 11/2/2021 17:45:33'!
twoMonthsFrom: aMonthOfYear

	^aMonthOfYear next: (TimeUnits month with: 2).! !

!CreditCardTest methodsFor: 'dates' stamp: 'PhG 11/2/2021 17:45:22'!
twoMonthsSince: aMonthOfYear

	^aMonthOfYear previous: (TimeUnits month with: 2).! !


!CreditCardTest methodsFor: 'assertions' stamp: 'PhG 11/2/2021 17:50:20'!
assertCreditCardMustContain16DigitsForCardNumber: aCardNumber

	| twoMonthsToTheFuture |

	twoMonthsToTheFuture := self twoMonthsSince: self currentMonthOfYear.
	
	self 
		should: [CreditCard withNumber: aCardNumber withExpirationDate: twoMonthsToTheFuture ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard creditCardMustContain16Digits. ]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'PhG 11/1/2021 19:47:11'!
assertIsValidItem: anItem

	(priceList includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'PhG 11/1/2021 19:47:17'!
initializeAcceptingItemsOf: aPriceList

	priceList := aPriceList.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'PhG 11/1/2021 19:49:08'!
items
	^items.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'total price' stamp: 'PhG 11/2/2021 18:02:36'!
totalPrice

	^items sum: [:anItem | priceList at: anItem] ifEmpty: [0].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'error messages' stamp: 'PhG 11/1/2021 19:28:29'!
cartCanNotBeEmpty

	^'Cart can not be empty'! !


!Cashier methodsFor: 'checkout' stamp: 'PhG 11/2/2021 17:55:43'!
checkout: aCart

	(aCart isEmpty) ifTrue: [self error: self cartCanNotBeEmpty].
	
	^aCart totalPrice.! !

!Cashier methodsFor: 'checkout' stamp: 'PhG 11/2/2021 18:03:45'!
checkout: aCart withCardExpirationDate: anExpirationDate

	(aCart isEmpty) ifTrue: [self error: self cartCanNotBeEmpty].
	
	^aCart totalPrice.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'cardNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'PhG 11/2/2021 17:26:57'!
initializeWith: aCardNumber withExpirationDate: anExpirationDate 
	
	cardNumber := aCardNumber.
	expirationDate := anExpirationDate.! !


!CreditCard methodsFor: 'testing' stamp: 'PhG 11/2/2021 17:43:27'!
isExpiredOn: aDate 
	^((aDate < expirationDate) and: (expirationDate ~= aDate)) not.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error messages' stamp: 'PhG 11/2/2021 17:11:20'!
creditCardMustContain16Digits
	^'A credit card must contain 16 digits'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'PhG 11/2/2021 17:13:45'!
withNumber: aCardNumber

	aCardNumber size ~= 16 ifTrue: [self error: CreditCard creditCardMustContain16Digits].! !

!CreditCard class methodsFor: 'instance creation' stamp: 'PhG 11/2/2021 17:26:09'!
withNumber: aCardNumber withExpirationDate: anExpirationDate 

	self assertCardNumberIs16DigitsLong: aCardNumber.
	
	^self basicNew initializeWith: aCardNumber withExpirationDate: anExpirationDate.! !


!CreditCard class methodsFor: 'private' stamp: 'PhG 11/2/2021 17:26:09'!
assertCardNumberIs16DigitsLong: aCardNumber

	^ aCardNumber size ~= 16 ifTrue: [self error: CreditCard creditCardMustContain16Digits]! !
