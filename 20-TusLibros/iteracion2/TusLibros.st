!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:50:20'!
test01NewCartsAreCreatedEmpty

	self assert: factory createCartWithDefaultPriceList isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:51:35'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := factory createCartWithDefaultPriceList.
	
	self 
		should: [ cart add: factory itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:51:42'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := factory createCartWithDefaultPriceList.
	
	cart add: factory itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:51:49'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := factory createCartWithDefaultPriceList.
	
	self 
		should: [cart add: 0 of: factory itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:53:58'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := factory createCartWithDefaultPriceList.
	
	self 
		should: [cart add: 2 of: factory itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:52:03'!
test06CartRemembersAddedItems

	| cart |
	
	cart := factory createCartWithDefaultPriceList.
	
	cart add: factory itemSoldByTheStore.
	self assert: (cart includes: factory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:52:08'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := factory createCartWithDefaultPriceList.
	
	self deny: (cart includes: factory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:52:14'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := factory createCartWithDefaultPriceList.
	
	cart add: 2 of: factory itemSoldByTheStore.
	self assert: (cart occurrencesOf: factory itemSoldByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:52:25'!
test09TotalPriceOfEmptyCartIsZero

	| cart |
	
	cart := factory createCartWithDefaultPriceList.
	
	self assert: (cart totalPrice) = 0.! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:53:44'!
test10TotalPriceOfCartWithItemIsItemPrice

	| cart item |
	
	cart := factory createCartWithDefaultPriceList.
	item := 	factory itemSoldByTheStore.

	cart add: 1 of: item.

	self assert: (cart totalPrice ) = (factory priceOf: item).! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:54:21'!
test11TotalPriceOfCartWithItemsIsAddedItemsPrice

	| cart item |
	
	cart := factory createCartWithDefaultPriceList.
	item := factory itemSoldByTheStore.

	cart add: 2 of: item.

	self assert: (cart totalPrice ) = ((factory priceOf: item)*2).! !


!CartTest methodsFor: 'initialization' stamp: 'PhG 11/3/2021 08:50:34'!
initialize
	
	factory := TestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'checkout tests' stamp: 'PhG 11/3/2021 08:47:55'!
test01checkoutOnEmptyCartThrowsError

	| cart creditCard today |
	
	cart := factory createCartWithDefaultPriceList.
	today := factory currentMonthOfYear.
	creditCard := factory createCreditCardExpiringTwoMonthsFrom: today.
	
	self assertCheckingOut: creditCard payingWith: today onDate: cart willFailWith: (Cashier cartCanNotBeEmptyErrorDescription).! !

!CashierTest methodsFor: 'checkout tests' stamp: 'PhG 11/3/2021 08:44:23'!
test02checkoutTotalOnCartWithOneProductIsProductPrice

	| cart cashier item |
	
	cart := factory createCartWithDefaultPriceList.
	item := factory itemSoldByTheStore.
	
	cart add: item.
	
	cashier := self cashierCheckingOutWithValidCardFor: cart.
	
	self assert: (factory priceOf: item) equals: (cashier checkout).
	! !

!CashierTest methodsFor: 'checkout tests' stamp: 'PhG 11/3/2021 08:45:07'!
test03checkoutTotalOnCartWithManyProductsIsProductsPriceSum

	| cart cashier item otherItem |
	
	cart := factory createCartWithPriceListWithTwoItems.
	item := factory itemSoldByTheStore.
	otherItem := factory otherItemSoldByTheStore.

	cart add: item.
	cart add: otherItem.
	
	cashier := self cashierCheckingOutWithValidCardFor: cart.
	
	self assert: (factory priceOf: item) + (factory priceOf: otherItem) equals: (cashier checkout).! !

!CashierTest methodsFor: 'checkout tests' stamp: 'PhG 11/3/2021 08:48:07'!
test04checkoutWithExpiredCreditCardIsRejected

	| cart expiredCreditCard today |
	
	cart := factory createCartWithDefaultPriceList.
	today := factory currentMonthOfYear.
	expiredCreditCard := factory createCreditCardExpiringTwoMonthsSince: today.
	
	cart add: factory itemSoldByTheStore.
	
	self assertCheckingOut: expiredCreditCard payingWith: today onDate: cart willFailWith: (Cashier creditCardCanNotBeExpiredErrorDescription).
	! !

!CashierTest methodsFor: 'checkout tests' stamp: 'asd 11/3/2021 16:45:11'!
test05theCardBilledIsTheOneUsedByTheClient
	| cart creditCard today cashier merchantProcessor billedCreditCard |

	cart := factory createCartWithDefaultPriceListAndAnItem.
	today := factory currentMonthOfYear.
	creditCard := factory createCreditCardExpiringTwoMonthsFrom: today.
	merchantProcessor := MerchantProcessorDouble new.
	merchantProcessor whenBillingDo: [:aCreditCard :amount | billedCreditCard := aCreditCard. true ].

	cashier := Cashier prepareCheckoutFor: cart payingWith: creditCard on: today with: merchantProcessor.
	cashier checkout.
	
	self assert: (creditCard ) equals: (billedCreditCard ).
	! !

!CashierTest methodsFor: 'checkout tests' stamp: 'asd 11/3/2021 16:45:22'!
test06theAmountBilledIsTheCartTotal
	| cart item creditCard today cashier merchantProcessor billedAmount |
	cart := factory createCartWithDefaultPriceList.
	item := factory itemSoldByTheStore.
	cart add: item.
	
	today := factory currentMonthOfYear.
	creditCard := factory createCreditCardExpiringTwoMonthsFrom: today.
	merchantProcessor := MerchantProcessorDouble new.
	merchantProcessor whenBillingDo: [:aCreditCard :amount | billedAmount := amount. true ].

	cashier := Cashier prepareCheckoutFor: cart payingWith: creditCard on: today with: merchantProcessor.
	cashier checkout.
	
	self assert: (factory priceOf: item ) equals: (billedAmount ).
	! !

!CashierTest methodsFor: 'checkout tests' stamp: 'asd 11/3/2021 16:42:13'!
test07theCheckoutShouldFailForCreditCardsRejectedByTheMerchantProcessor

	| cart creditCard today cashier merchantProcessor |
	cart := factory createCartWithDefaultPriceListAndAnItem.
	
	today := factory currentMonthOfYear.
	creditCard := factory createCreditCardExpiringTwoMonthsFrom: today.
	merchantProcessor := MerchantProcessorDouble new.
	merchantProcessor whenBillingDo: [:aCreditCard :amount | false ].

	cashier := Cashier prepareCheckoutFor: cart payingWith: creditCard on: today with: merchantProcessor.
	
	 self should: [ cashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardRejectedByMerchantProcessorDescription. ]
	
	! !


!CashierTest methodsFor: 'initialization' stamp: 'PhG 11/3/2021 08:27:35'!
initialize

	factory := TestObjectsFactory new.! !


!CashierTest methodsFor: 'support' stamp: 'asd 11/3/2021 16:34:15'!
cashierCheckingOutWithValidCardFor: aCart

	| creditCard today merchantProcessor |

	today := factory currentMonthOfYear.
	creditCard := factory createCreditCardExpiringTwoMonthsFrom: today.
	
	merchantProcessor := factory createMerchantProcessorWithSuccesfulBillingResponse.
	
	^Cashier prepareCheckoutFor: aCart payingWith: creditCard on: today with: merchantProcessor.! !


!CashierTest methodsFor: 'assertions' stamp: 'asd 11/3/2021 16:33:52'!
assertCheckingOut: creditCard payingWith: today onDate: cart willFailWith: anErrorDescription
	| merchantProcessor |

	merchantProcessor := factory createMerchantProcessorWithSuccesfulBillingResponse.
	
	^ self 
		should: [ Cashier prepareCheckoutFor: cart payingWith: creditCard on: today with: merchantProcessor]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = anErrorDescription. ]! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'factory'
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

!CreditCardTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:25:07'!
test03CreditCardWithExpirationDateInTheFutureIsNotExpired

	| creditCard currentMonthOfYear twoMonthsToTheFuture |
	
	currentMonthOfYear := factory currentMonthOfYear.
	twoMonthsToTheFuture := factory twoMonthsFrom: currentMonthOfYear.

	creditCard := CreditCard withNumber: '0123456789123456'	 withExpirationDate: twoMonthsToTheFuture.
	
	self deny: (creditCard isExpiredOn: currentMonthOfYear).! !

!CreditCardTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:25:51'!
test04CreditCardWithExpirationDateInThePastIsExpired

	| creditCard currentMonthOfYear twoMonthsToThePast |
	
	currentMonthOfYear := factory currentMonthOfYear.
	twoMonthsToThePast := factory twoMonthsSince: currentMonthOfYear.

	creditCard := CreditCard withNumber: '0123456789123456'	 withExpirationDate: twoMonthsToThePast.
	
	self assert: (creditCard isExpiredOn: currentMonthOfYear).! !

!CreditCardTest methodsFor: 'tests' stamp: 'PhG 11/3/2021 08:25:57'!
test05CreditCardWithExpirationDateInThePresentIsNotExpired

	| creditCard currentMonthOfYear |
	
	currentMonthOfYear := factory currentMonthOfYear.

	creditCard := CreditCard withNumber: '0123456789123456'	 withExpirationDate: currentMonthOfYear.
	
	self assert: (creditCard isExpiredOn: currentMonthOfYear).! !


!CreditCardTest methodsFor: 'assertions' stamp: 'PhG 11/3/2021 08:26:45'!
assertCreditCardMustContain16DigitsForCardNumber: aCardNumber

	| twoMonthsToTheFuture |

	twoMonthsToTheFuture := factory twoMonthsFrom: factory currentMonthOfYear.
	
	self 
		should: [CreditCard withNumber: aCardNumber withExpirationDate: twoMonthsToTheFuture ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard creditCardMustContain16Digits. ]! !


!CreditCardTest methodsFor: 'initialization' stamp: 'PhG 11/3/2021 08:24:29'!
initialize
	factory := TestObjectsFactory new.! !


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
	instanceVariableNames: 'priceList cart creditCard date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'asd 11/3/2021 16:44:31'!
checkout	
	| transactionSuccessful |
	
	transactionSuccessful := merchantProcessor bill: creditCard for: (cart totalPrice).
	transactionSuccessful ifFalse: [self error: Cashier creditCardRejectedByMerchantProcessorDescription ].
	
	^cart totalPrice.! !


!Cashier methodsFor: 'initialization' stamp: 'asd 11/3/2021 16:14:43'!
initializeCheckingOutFor: aCart payingWith: aCreditCard on: aDate with: aMerchantProcessor 
	
	cart := aCart.
	creditCard := aCreditCard.
	date := aDate.
	
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'asd 11/3/2021 16:15:08'!
prepareCheckoutFor: aCart payingWith: aCreditCard on: aDate with: aMerchantProcessor 

	self assertCartCanNotBeEmpty: aCart.
	self assertCreditCard: aCreditCard isNotExpiredOn: aDate.

	^self basicNew initializeCheckingOutFor: aCart payingWith: aCreditCard on: aDate with: aMerchantProcessor! !


!Cashier class methodsFor: 'error descriptions' stamp: 'PhG 11/3/2021 07:58:35'!
cartCanNotBeEmptyErrorDescription

	^'Cart can not be empty'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'PhG 11/3/2021 08:15:08'!
creditCardCanNotBeExpiredErrorDescription

	^'Credit card can not be expired'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'asd 11/3/2021 16:41:59'!
creditCardRejectedByMerchantProcessorDescription

	^'Credit card was rejected by the merchant processor'.! !


!Cashier class methodsFor: 'assertions' stamp: 'PhG 11/3/2021 08:04:06'!
assertCartCanNotBeEmpty: aCart

	^ (aCart isEmpty) ifTrue: [self error: Cashier cartCanNotBeEmptyErrorDescription]! !

!Cashier class methodsFor: 'assertions' stamp: 'PhG 11/3/2021 08:17:42'!
assertCreditCard: aCreditCard isNotExpiredOn: aDate

	^ (aCreditCard isExpiredOn: aDate) ifTrue: [self error: Cashier creditCardCanNotBeExpiredErrorDescription ]! !


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


!classDefinition: #MerchantProcessorDouble category: 'TusLibros'!
Object subclass: #MerchantProcessorDouble
	instanceVariableNames: 'whenBilling'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorDouble methodsFor: 'mocking' stamp: 'asd 11/3/2021 16:21:48'!
whenBillingDo: billingBehaviour
	^ whenBilling := billingBehaviour.! !


!MerchantProcessorDouble methodsFor: 'mocked' stamp: 'asd 11/3/2021 16:26:37'!
bill: aCreditCard for: amount
	^ whenBilling value: aCreditCard value: amount.! !


!classDefinition: #TestObjectsFactory category: 'TusLibros'!
Object subclass: #TestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjectsFactory methodsFor: 'date' stamp: 'PhG 11/3/2021 08:21:50'!
currentMonthOfYear

	^GregorianMonthOfYear current.! !

!TestObjectsFactory methodsFor: 'date' stamp: 'PhG 11/3/2021 08:25:21'!
twoMonthsFrom: aMonthOfYear

	^aMonthOfYear next: (TimeUnits month with: 2).! !

!TestObjectsFactory methodsFor: 'date' stamp: 'PhG 11/3/2021 08:25:32'!
twoMonthsSince: aMonthOfYear

	^aMonthOfYear previous: (TimeUnits month with: 2).! !


!TestObjectsFactory methodsFor: 'credit card' stamp: 'PhG 11/3/2021 08:30:16'!
createCreditCardExpiring: anExpirationDate

	^CreditCard withNumber: '0123456789123456'	 withExpirationDate: anExpirationDate.! !

!TestObjectsFactory methodsFor: 'credit card' stamp: 'PhG 11/3/2021 08:31:22'!
createCreditCardExpiringTwoMonthsFrom: anExpirationDate

	^self createCreditCardExpiring: (self twoMonthsFrom: anExpirationDate).! !

!TestObjectsFactory methodsFor: 'credit card' stamp: 'PhG 11/3/2021 08:31:17'!
createCreditCardExpiringTwoMonthsSince: anExpirationDate

	^self createCreditCardExpiring: (self twoMonthsSince: anExpirationDate).! !


!TestObjectsFactory methodsFor: 'item' stamp: 'asd 11/3/2021 16:32:51'!
createMerchantProcessorWithSuccesfulBillingResponse
	| merchantProcessor |

	merchantProcessor := MerchantProcessorDouble new.
	merchantProcessor whenBillingDo: [:aCreditCard :amount | true ].
	^merchantProcessor .! !

!TestObjectsFactory methodsFor: 'item' stamp: 'PhG 11/3/2021 08:51:19'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!TestObjectsFactory methodsFor: 'item' stamp: 'PhG 11/3/2021 08:33:01'!
itemSoldByTheStore
	
	^ 'validBook'! !

!TestObjectsFactory methodsFor: 'item' stamp: 'PhG 11/3/2021 08:33:11'!
otherItemSoldByTheStore
	
	^ 'otherValidBook'! !


!TestObjectsFactory methodsFor: 'cart' stamp: 'PhG 11/3/2021 08:35:53'!
createCartWith: aPriceList
	
	^Cart acceptingItemsOf: aPriceList! !

!TestObjectsFactory methodsFor: 'cart' stamp: 'asd 11/3/2021 16:17:48'!
createCartWithDefaultPriceList

	^self createCartWith: self defaultPriceList! !

!TestObjectsFactory methodsFor: 'cart' stamp: 'asd 11/3/2021 16:17:39'!
createCartWithDefaultPriceListAndAnItem
	| cart |
	
	cart := self createCartWith: self defaultPriceList.
	cart add: self itemSoldByTheStore.
	^ cart.! !

!TestObjectsFactory methodsFor: 'cart' stamp: 'PhG 11/3/2021 08:38:04'!
createCartWithPriceListWithTwoItems
	
	^self createCartWith: self priceListwithTwoItems.! !


!TestObjectsFactory methodsFor: 'price list' stamp: 'PhG 11/3/2021 08:32:50'!
defaultPriceList

	| priceList |
	
	priceList := Dictionary new.
	priceList add: (self itemSoldByTheStore)-> 100.
	^priceList.! !

!TestObjectsFactory methodsFor: 'price list' stamp: 'PhG 11/3/2021 08:32:23'!
priceListwithTwoItems

	| priceList |
	
	priceList := Dictionary new.
	priceList add: (self itemSoldByTheStore)-> 100.
	priceList add: (self otherItemSoldByTheStore)-> 60.
	^priceList.! !

!TestObjectsFactory methodsFor: 'price list' stamp: 'PhG 11/3/2021 08:40:23'!
priceOf: anItem 
	^self priceListwithTwoItems at: anItem.! !
