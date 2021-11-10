!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'wb 11/6/2021 16:06:35'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/4/2021 20:50:53'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'wb 11/6/2021 16:07:25'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'wb 11/6/2021 16:06:39'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/4/2021 20:50:53'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSoldByTheStore.
	self assert: (cart includes: testObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/4/2021 20:50:53'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'PhG 11/4/2021 20:50:53'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSoldByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'wb 11/7/2021 12:06:36'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory creditCardNonExpired 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'wb 11/7/2021 12:06:36'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSoldByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory creditCardNonExpired 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSoldByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'wb 11/7/2021 12:05:48'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory creditCardExpired 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'wb 11/7/2021 12:06:36'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory creditCardNonExpired
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'wb 11/7/2021 12:06:36'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	creditCard := testObjectsFactory creditCardNonExpired.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'wb 11/7/2021 12:06:36'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	creditCard := testObjectsFactory creditCardNonExpired.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #StoreServiceTest category: 'TusLibros'!
TestCase subclass: #StoreServiceTest
	instanceVariableNames: 'testObjectsFactory authenticationBehaviour debitBehavior timeoutBehaviour now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreServiceTest methodsFor: 'set up' stamp: 'PhG 11/4/2021 20:12:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!StoreServiceTest methodsFor: 'create cart tests' stamp: 'PhG 11/7/2021 22:21:24'!
test01CreateCartWithInvalidCredentialsThrowsError

	| storeService |

	storeService := self storeServiceWithAuthenticationBehaviour: [:aUsername :aPassword | self error: StoreService invalidCredentialsErrorDesciption].
	
	self should: [ storeService createCartFor: (testObjectsFactory invalidUser) with: (testObjectsFactory invalidPassword)]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = StoreService invalidCredentialsErrorDesciption.]! !

!StoreServiceTest methodsFor: 'create cart tests' stamp: 'PhG 11/7/2021 22:29:11'!
test02WhenCreatingACartCredentialsAreValidated

	| storeService userAuthenticated passwordAuthenticated |
	
	storeService := self storeServiceWithAuthenticationBehaviour: [:aUsername :aPassword | 
		userAuthenticated := aUsername.
		passwordAuthenticated := aPassword.
		].
	
	self createCartForValidUserIn: storeService.
	
	self assert: userAuthenticated equals: testObjectsFactory validUser.
	self assert: passwordAuthenticated equals: testObjectsFactory validPassword.
	! !

!StoreServiceTest methodsFor: 'create cart tests' stamp: 'PhG 11/8/2021 17:21:58'!
test03CreateCartWithValidCredentialsCreatesEmptyCart

	| storeService cartId |

	storeService := self storeServiceAuthenticatingUsers.
	
	cartId  := self createCartForValidUserIn: storeService.
	
	self assert: (storeService listCart: cartId) isEmpty.! !


!StoreServiceTest methodsFor: 'authentication protocol' stamp: 'PhG 11/4/2021 20:31:01'!
authenticate: aUsername with: aPassword

	^authenticationBehaviour value: aUsername value: aPassword.! !


!StoreServiceTest methodsFor: 'list carts tests' stamp: 'PhG 11/8/2021 18:16:19'!
test07ListCartsShouldWorkWithDifferentCarts

	| storeService cartId anotherCartId itemToBeAdded anotherItemToBeAdded cartContent anotherCartContent |

	storeService := self storeServiceAuthenticatingUsers.
	
	cartId  := self createCartForValidUserIn: storeService.
	anotherCartId  := self createCartForValidUserIn: storeService.
	
	itemToBeAdded := testObjectsFactory itemSoldByTheStore .
	anotherItemToBeAdded := testObjectsFactory anotherItemSoldByTheStore.
	
	storeService addToCart: cartId quantity: 1 of: itemToBeAdded.
	storeService addToCart: anotherCartId quantity: 2 of: anotherItemToBeAdded.
	
	cartContent := storeService listCart: cartId.
	anotherCartContent := storeService listCart: anotherCartId.

	self assert: cartContent size equals: 1.
	self assert: (cartContent occurrencesOf: itemToBeAdded) equals: 1.
	self assert: anotherCartContent size equals: 2.
	self assert: (anotherCartContent occurrencesOf: anotherItemToBeAdded) equals: 2.! !

!StoreServiceTest methodsFor: 'list carts tests' stamp: 'PhG 11/7/2021 22:36:50'!
test08ListCartsShouldFailWithInvalidCart

	| storeService invalidCartId |

	storeService := self storeServiceAuthenticatingUsers.
	
	invalidCartId  := self invalidCartIdIn: storeService.
	
	self should: [ storeService listCart: invalidCartId. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = StoreService invalidCartErrorDescription.]! !


!StoreServiceTest methodsFor: 'add to cart tests' stamp: 'PhG 11/8/2021 18:14:23'!
test04WhenAddingBookToCreatedCartBookIsReturnedInListCart

	| storeService cartId itemToBeAdded cartContent |

	storeService := self storeServiceAuthenticatingUsers.
	
	cartId  := self createCartForValidUserIn: storeService.
	itemToBeAdded := testObjectsFactory itemSoldByTheStore.
	
	storeService addToCart: cartId quantity: 1 of: itemToBeAdded.
	cartContent := storeService listCart: cartId.

	self assert: cartContent size equals: 1.
	self assert: (cartContent occurrencesOf: itemToBeAdded) equals: 1.! !

!StoreServiceTest methodsFor: 'add to cart tests' stamp: 'PhG 11/7/2021 22:34:11'!
test05AddBookNotSoldErrorIsInvalidBookError

	| storeService cartId |

	storeService := self storeServiceAuthenticatingUsers.
	
	cartId  := self createCartForValidUserIn: storeService.
		
	self should: [ storeService addToCart: cartId quantity: 1 of: (testObjectsFactory itemNotSoldByTheStore).]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = Cart invalidItemErrorMessage .]! !

!StoreServiceTest methodsFor: 'add to cart tests' stamp: 'PhG 11/7/2021 22:37:13'!
test06AddBookToInvalidCartThrowsError

	| storeService invalidCartId |

	storeService := self storeServiceAuthenticatingUsers.
	
	invalidCartId := self invalidCartIdIn: storeService.
		
	self should: [ storeService addToCart: invalidCartId quantity: 1 of: testObjectsFactory itemSoldByTheStore.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = StoreService invalidCartErrorDescription .]! !


!StoreServiceTest methodsFor: 'checkout cart tests' stamp: 'PhG 11/7/2021 22:36:34'!
test09CheckoutInvalidCartShouldFail

	| storeService invalidCartId |

	storeService := self storeServiceAuthenticatingUsers.
	
	invalidCartId  := self invalidCartIdIn: storeService.
	
	self should: [ self checkoutCart: invalidCartId usingValidCreditCardIn: storeService. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = StoreService invalidCartErrorDescription .]! !

!StoreServiceTest methodsFor: 'checkout cart tests' stamp: 'PhG 11/7/2021 22:31:34'!
test10CheckoutWithValidCartShouldReturnTransactionId

	| storeService cartId transactionId|

	storeService := self storeServiceAuthenticatingUsers.
	debitBehavior := [ :anAmount :aCreditCard | true ].
	
	cartId  := self createCartForValidUserIn: storeService.
	storeService addToCart: cartId quantity: 1 of:  (testObjectsFactory itemSoldByTheStore ).
	
	transactionId := self checkoutCart: cartId usingValidCreditCardIn: storeService.

	self assert: 1 equals: transactionId.! !


!StoreServiceTest methodsFor: 'merchant processor protocol' stamp: 'wb 11/7/2021 13:02:47'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard.! !


!StoreServiceTest methodsFor: 'store service creation' stamp: 'PhG 11/7/2021 22:38:21'!
storeServiceAuthenticatingUsers

	^self storeServiceWithAuthenticationBehaviour: [:aUsername :aPassword | true ].! !

!StoreServiceTest methodsFor: 'store service creation' stamp: 'PhG 11/8/2021 20:37:22'!
storeServiceWithAuthenticationBehaviour: anAuthenticationBehaviour

	authenticationBehaviour := anAuthenticationBehaviour.
	now := DateAndTime now.

	^StoreService 
		withAuthService: self 
		withMerchantProcessor: self 
		withCatalogue: testObjectsFactory defaultCatalogue
		withClock: self.! !


!StoreServiceTest methodsFor: 'checkout cart' stamp: 'PhG 11/8/2021 17:17:12'!
checkoutCart: cartId usingValidCreditCardIn: storeService

	^ storeService checkoutCart: cartId 
		 payingWithCreditCard: testObjectsFactory validCardNumber 
		 expiringOn: testObjectsFactory validCardExpirationDate 
		 ownedBy: testObjectsFactory validCardOwner! !


!StoreServiceTest methodsFor: 'create cart' stamp: 'PhG 11/8/2021 17:17:30'!
createCartForValidUserIn: storeService

	^ storeService createCartFor: testObjectsFactory validUser 
		with: testObjectsFactory validPassword! !

!StoreServiceTest methodsFor: 'create cart' stamp: 'PhG 11/7/2021 22:36:34'!
invalidCartIdIn: storeService

	^ (self createCartForValidUserIn: storeService) + 1! !


!StoreServiceTest methodsFor: 'timer tests' stamp: 'PhG 11/8/2021 20:37:40'!
test11OperatingCartAfterExpirationTimeThrowsTimeoutError

	| storeService cartId |

	storeService := self storeServiceAuthenticatingUsers.
	debitBehavior := [ :anAmount :aCreditCard | true ].
	
	cartId  := self createCartForValidUserIn: storeService.
	storeService addToCart: cartId quantity: 1 of:  (testObjectsFactory itemSoldByTheStore ).
	
	now := now + (Duration minutes: 31).

	self should: [ self checkoutCart: cartId usingValidCreditCardIn: storeService.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = StoreService cartTimeoutErrorDescription. ]! !

!StoreServiceTest methodsFor: 'timer tests' stamp: 'PhG 11/8/2021 21:37:16'!
test12OperatingCartJustBeforeExpirationTimeRenewsExpirationTime

	| storeService cartId |

	storeService := self storeServiceAuthenticatingUsers.
	debitBehavior := [ :anAmount :aCreditCard | true ].
	
	cartId  := self createCartForValidUserIn: storeService.
	storeService addToCart: cartId quantity: 1 of:  (testObjectsFactory itemSoldByTheStore ).
	
	now := now + (Duration minutes: 29).
	
	storeService listCart: cartId.
	
	now := now + (Duration minutes: 25).

	self shouldnt: [ self checkoutCart: cartId usingValidCreditCardIn: storeService.]
		raise: Error.! !


!StoreServiceTest methodsFor: 'cart timeout protocol' stamp: 'PhG 11/8/2021 20:28:31'!
now
	^now! !


!StoreServiceTest methodsFor: 'list purchases tests' stamp: 'PhG 11/9/2021 23:34:08'!
test13ListPurchasesOfInvalidClientThrowsInvalidCredentialsError

	| storeService cartId |

	storeService := self storeServiceAuthenticatingUsers.
	debitBehavior := [ :anAmount :aCreditCard | true ].
	
	cartId  := self createCartForValidUserIn: storeService.
	storeService addToCart: cartId quantity: 1 of:  (testObjectsFactory itemSoldByTheStore ).
	
	self checkoutCart: cartId usingValidCreditCardIn: storeService.

	authenticationBehaviour := [:aUsername :aPassword | self error: StoreService invalidCredentialsErrorDesciption].
	
	self should: [ storeService listPurchasesFor: (testObjectsFactory invalidUser) with: (testObjectsFactory invalidPassword)]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = StoreService invalidCredentialsErrorDesciption.]! !

!StoreServiceTest methodsFor: 'list purchases tests' stamp: 'PhG 11/10/2021 08:57:04'!
test14ListPurchasesOfClientWithOnePurchaseIsLastPurchase

	| storeService cartId purchases |

	storeService := self storeServiceAuthenticatingUsers.
	debitBehavior := [ :anAmount :aCreditCard | true ].
	
	cartId  := self createCartForValidUserIn: storeService.
	storeService addToCart: cartId quantity: 1 of:  (testObjectsFactory itemSoldByTheStore ).
	
	self checkoutCart: cartId usingValidCreditCardIn: storeService.
	
	purchases := storeService listPurchasesFor: (testObjectsFactory validUser) with: (testObjectsFactory validPassword).
	
	self assert: purchases key size equals: 1.
	self assert: (purchases key occurrencesOf: testObjectsFactory itemSoldByTheStore) equals: 1.
	self assert: purchases value equals: testObjectsFactory itemSoldByTheStorePrice.
	! !

!StoreServiceTest methodsFor: 'list purchases tests' stamp: 'PhG 11/10/2021 09:14:51'!
test15ListPurchasesOfClientWithTwoPurchaseIncludesBothPurchases

	| storeService cartId purchases anotherCartId |

	storeService := self storeServiceAuthenticatingUsers.
	debitBehavior := [ :anAmount :aCreditCard | true ].
	
	cartId  := self createCartForValidUserIn: storeService.
	storeService addToCart: cartId quantity: 1 of:  (testObjectsFactory itemSoldByTheStore ).
	self checkoutCart: cartId usingValidCreditCardIn: storeService.

	anotherCartId  := self createCartForValidUserIn: storeService.
	storeService addToCart: anotherCartId quantity: 1 of:  (testObjectsFactory itemSoldByTheStore ).
	storeService addToCart: anotherCartId quantity: 2 of:  (testObjectsFactory anotherItemSoldByTheStore).
	self checkoutCart: anotherCartId usingValidCreditCardIn: storeService.
	
	purchases := storeService listPurchasesFor: (testObjectsFactory validUser) with: (testObjectsFactory validPassword).
	
	self assert: purchases key size equals: 4.
	self assert: (purchases key occurrencesOf: testObjectsFactory itemSoldByTheStore) equals: 2.
	self assert: (purchases key occurrencesOf: testObjectsFactory anotherItemSoldByTheStore) equals: 2.
	self assert: purchases value equals: (testObjectsFactory itemSoldByTheStorePrice * 2) + (testObjectsFactory anotherItemSoldByTheStorePrice * 2).
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'wb 11/6/2021 16:03:55'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: Cart invalidItemErrorMessage. ]! !

!Cart methodsFor: 'assertions' stamp: 'wb 11/6/2021 16:04:00'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: Cart invalidQuantityErrorMessage. ]! !


!Cart methodsFor: 'initialization' stamp: 'wb 11/6/2021 16:44:12'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'content' stamp: 'PhG 11/8/2021 18:12:59'!
content

	^Bag new 
		addAll: items;
		yourself.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'wb 11/6/2021 16:44:39'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog.! !


!Cart class methodsFor: 'error descriptions' stamp: 'wb 11/6/2021 16:04:34'!
invalidItemErrorMessage

	^'Item is not in catalog'.! !

!Cart class methodsFor: 'error descriptions' stamp: 'wb 11/6/2021 16:05:09'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'PhG 11/10/2021 08:24:11'!
createSale

	^ Sale of: total with: cart content.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'wb 11/7/2021 13:19:01'!
registerSale

	salesBook add: (self createSale).! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'wb 11/7/2021 12:45:19'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate cardNumber cardOwner expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'PhG 11/7/2021 22:06:29'!
isExpiredOn: aDate 
	
	^expirationDate start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'PhG 11/7/2021 22:06:34'!
initializeWithCardNumber: aCardNumber expirationDate: anExpirationDate withCardOwner: aCardOwner 

	cardNumber := aCardNumber.
	expirationDate := anExpirationDate.
	cardOwner := aCardOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: 'expiration'!

!CreditCard class methodsFor: 'instance creation' stamp: 'PhG 11/7/2021 22:07:47'!
withCardNumber: aCardNumber expiring: anExpirationDate cardOwner: aCardOwner 
	
	^self new initializeWithCardNumber: aCardNumber expirationDate: anExpirationDate withCardOwner: aCardOwner.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'wb 11/7/2021 13:30:58'!
total
	
	^ total.! !


!Sale methodsFor: 'initialization' stamp: 'wb 11/7/2021 13:30:52'!
initializeTotal: aTotal

	total := aTotal.! !

!Sale methodsFor: 'initialization' stamp: 'PhG 11/10/2021 08:24:42'!
initializeTotal: aTotal withProducts: someProducts

	total := aTotal.
	products := someProducts.! !


!Sale methodsFor: 'products' stamp: 'PhG 11/10/2021 08:24:59'!
products
	^products copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'PhG 11/10/2021 08:23:01'!
of: aTotal

	self assertTotalIsPositive: aTotal.
	
	^self new initializeTotal: aTotal.! !

!Sale class methodsFor: 'instance creation' stamp: 'PhG 11/10/2021 08:23:42'!
of: aTotal with: someProducts

	self assertTotalIsPositive: aTotal.
	
	^self new initializeTotal: aTotal withProducts: someProducts.! !


!Sale class methodsFor: 'error descriptions' stamp: 'PhG 11/10/2021 08:22:34'!
totalIsNotAPositiveNumber
	^'Total must be a positive number'! !


!Sale class methodsFor: 'assertions' stamp: 'PhG 11/10/2021 08:23:01'!
assertTotalIsPositive: aTotal

	^ aTotal <= 0 ifTrue: [self error: Sale totalIsNotAPositiveNumber.]! !


!classDefinition: #StoreService category: 'TusLibros'!
Object subclass: #StoreService
	instanceVariableNames: 'authenticationService merchantProcessor carts latestCartId latestTransactionId catalogue salesBook cartTimeout clock cartsByUser salesByUser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreService methodsFor: 'rest interface' stamp: 'PhG 11/8/2021 20:22:51'!
addToCart: aCartId quantity: aQuantity of: anItem 
	
	| cart |
	
	self assertCartExists: aCartId.
	self assertCartTimeout: aCartId.
	
	cart := carts at: aCartId.
	cart add: aQuantity of: anItem.! !

!StoreService methodsFor: 'rest interface' stamp: 'PhG 11/10/2021 09:12:17'!
checkoutCart: aCartId payingWithCreditCard: aCardNumber expiringOn: anExpirationDate ownedBy: aCardOwner

	| creditCard cart salesByUserKey |
	
	self assertCartExists: aCartId.
	self assertCartTimeout: aCartId.
	
	creditCard := CreditCard withCardNumber: aCardNumber expiring: anExpirationDate cardOwner: aCardOwner.
	cart := carts at: aCartId.
	
	self checkout: cart chargingOn: creditCard.
	
	salesByUserKey := (cartsByUser at: aCartId).
	salesByUser at: salesByUserKey
		ifPresent: [:userSales | userSales add: salesBook last]
		ifAbsent: [ salesByUser at: salesByUserKey put: (OrderedCollection with: salesBook last)].
	cartsByUser removeKey: aCartId.
	
	^self nextTransactionId.! !

!StoreService methodsFor: 'rest interface' stamp: 'PhG 11/10/2021 08:36:54'!
createCartFor: aUsername with: aPassword
		
	| cartId |
	self assertAuthenticationForUser: aUsername withPassword: aPassword.
	
	cartId := self nextCartId.
	carts at: cartId put: (Cart acceptingItemsOf: catalogue).
	cartTimeout at: cartId put: clock now.
	cartsByUser at: cartId put: (aUsername,aPassword).

	^latestCartId.! !

!StoreService methodsFor: 'rest interface' stamp: 'PhG 11/8/2021 21:26:40'!
listCart: aCartId

	self assertCartExists: aCartId.
	self assertCartTimeout: aCartId.
	
	^(carts at: aCartId) content copy.! !

!StoreService methodsFor: 'rest interface' stamp: 'PhG 11/10/2021 09:14:32'!
listPurchasesFor: aUsername with: aPassword

	| allProducts total |
	self assertAuthenticationForUser: aUsername withPassword: aPassword.
	
	allProducts := Bag new.
	total := 0.
	
	(salesByUser at: (aUsername,aPassword)) do: [:aSale |
		allProducts addAll: aSale products.
		total := total + aSale total.
	].
	
	^allProducts->total.! !


!StoreService methodsFor: 'initialization' stamp: 'PhG 11/10/2021 08:38:02'!
initializeWithAuthService: anAuthenticationService withMerchantProcessor: aMerchantProcessor withCatalogue: aCatalogue withClock: aClock
	
	authenticationService := anAuthenticationService.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	catalogue := aCatalogue.
	carts := Dictionary new.
	cartTimeout := Dictionary new.
	cartsByUser := Dictionary new.
	latestCartId := 0.
	latestTransactionId := 0.
	salesBook := OrderedCollection new.
	salesByUser := Dictionary new.! !


!StoreService methodsFor: 'assertions' stamp: 'PhG 11/7/2021 22:41:32'!
assertAuthenticationForUser: aUsername withPassword: aPassword

	^ authenticationService authenticate: aUsername with: aPassword! !

!StoreService methodsFor: 'assertions' stamp: 'wb 11/6/2021 16:52:53'!
assertCartExists: aCartId

	(carts includesKey: aCartId) ifFalse: [ self error: StoreService invalidCartErrorDescription. ]! !

!StoreService methodsFor: 'assertions' stamp: 'PhG 11/8/2021 21:35:19'!
assertCartTimeout: aCartId 
	
	| lastUsage now |
	
	lastUsage := cartTimeout at: aCartId.
	now := clock now.
	
	((Duration minutes: 30) < (now - lastUsage)) ifTrue: [self error: StoreService cartTimeoutErrorDescription].
	
	cartTimeout at: aCartId put: now.! !


!StoreService methodsFor: 'next id' stamp: 'PhG 11/8/2021 17:55:03'!
nextCartId
	
	^latestCartId := latestCartId + 1.! !

!StoreService methodsFor: 'next id' stamp: 'PhG 11/7/2021 22:40:44'!
nextTransactionId

	^ latestTransactionId := latestTransactionId +1! !


!StoreService methodsFor: 'checkout' stamp: 'PhG 11/7/2021 22:45:50'!
checkout: aCart chargingOn: aCreditCard 
	
	| cashier |

	cashier := Cashier toCheckout: aCart 
					charging: aCreditCard 
					throught: merchantProcessor 
					on: (DateAndTime now) 
					registeringOn: salesBook.
	cashier checkOut.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreService class' category: 'TusLibros'!
StoreService class
	instanceVariableNames: ''!

!StoreService class methodsFor: 'error descriptions' stamp: 'PhG 11/8/2021 21:22:08'!
cartTimeoutErrorDescription
	^'Timeout exceeded.'.! !

!StoreService class methodsFor: 'error descriptions' stamp: 'wb 11/6/2021 16:08:24'!
invalidBookErrorDesciption
	^'Trying to add an invalid book.'.! !

!StoreService class methodsFor: 'error descriptions' stamp: 'wb 11/6/2021 16:50:25'!
invalidCartErrorDescription
	^'Trying to access an invalid cart.'.! !

!StoreService class methodsFor: 'error descriptions' stamp: 'wb 11/6/2021 16:08:29'!
invalidCredentialsErrorDesciption
	^'Username or password invalid.'.! !


!StoreService class methodsFor: 'instance creation' stamp: 'PhG 11/8/2021 20:26:18'!
withAuthService: anAuthenticationService withMerchantProcessor: aMerchantProcessor withCatalogue: aCatalogue withClock: aClock

	^self new initializeWithAuthService: anAuthenticationService withMerchantProcessor: aMerchantProcessor withCatalogue: aCatalogue withClock: aClock! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'wb 11/6/2021 16:28:54'!
anotherItemSoldByTheStore

	^ 'validBook2'.! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'wb 11/6/2021 16:28:47'!
anotherItemSoldByTheStorePrice

	^20.
! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'wb 11/6/2021 16:29:00'!
itemNotSoldByTheStore
	
	^'invalidBook'.! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'wb 11/6/2021 16:29:04'!
itemSoldByTheStore
	
	^ 'validBook'.! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'wb 11/6/2021 16:29:08'!
itemSoldByTheStorePrice
	
	^10.! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'wb 11/6/2021 16:45:06'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalogue.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'wb 11/6/2021 16:28:27'!
defaultCatalogue
	
	^ Dictionary new
		at: self itemSoldByTheStore put: self itemSoldByTheStorePrice;
		at: self anotherItemSoldByTheStore put: self anotherItemSoldByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PhG 11/7/2021 22:09:38'!
creditCardExpired
	
	^CreditCard withCardNumber: '1234567890123456'
				expiring: (Month month: today monthIndex year: today yearNumber - 1)
			     	cardOwner: 'pepito'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PhG 11/7/2021 22:07:31'!
creditCardNonExpired
	
	^CreditCard withCardNumber: '123456789123456'
			     expiring: (Month month: today monthIndex year: today yearNumber + 1)
			     cardOwner: 'pepito'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PhG 11/7/2021 22:12:27'!
validCardExpirationDate
	^Month month: today monthIndex year: today yearNumber + 1.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PhG 11/7/2021 22:12:52'!
validCardNumber
	^'123456789123456'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PhG 11/7/2021 22:13:02'!
validCardOwner
	^'pepito'.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'user credentials' stamp: 'PhG 11/4/2021 20:08:05'!
invalidPassword
	^'invalidPassword'! !

!StoreTestObjectsFactory methodsFor: 'user credentials' stamp: 'PhG 11/4/2021 20:07:46'!
invalidUser
	^'invalidUser'! !

!StoreTestObjectsFactory methodsFor: 'user credentials' stamp: 'PhG 11/4/2021 20:20:06'!
validPassword
	^'validPassword'! !

!StoreTestObjectsFactory methodsFor: 'user credentials' stamp: 'PhG 11/4/2021 21:11:58'!
validUser
	^'maximilianoCozzetti'! !
