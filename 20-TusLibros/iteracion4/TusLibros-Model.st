!classDefinition: #Cart category: 'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'PhG 11/13/2021 12:42:05'!
canNotRemoveFromEmptyCartErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'PhG 11/13/2021 12:43:24'!
assertCartIsNotEmpty

	self isEmpty ifTrue: [self signalCanNotRemoveFromEmptyCart ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !

!Cart methodsFor: 'assertions' stamp: 'PhG 11/14/2021 17:12:31'!
assertValidRemovedItems: aQuantity of: anItem

	(aQuantity > (items occurrencesOf: anItem)) ifTrue: [self signalInvalidQuantity ].! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'PhG 11/13/2021 12:41:54'!
signalCanNotRemoveFromEmptyCart

	self error: self canNotRemoveFromEmptyCartErrorMessage ! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'removing' stamp: 'PhG 11/13/2021 12:45:15'!
remove: anItem 

	^self remove: 1 of: anItem.
	! !

!Cart methodsFor: 'removing' stamp: 'PhG 11/14/2021 17:13:09'!
remove: aQuantity of: anItem 

	self assertCartIsNotEmpty.	
	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	self assertValidRemovedItems: aQuantity of: anItem.
	
	aQuantity timesRepeat: [items remove: anItem.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'PhG 11/13/2021 12:42:17'!
canNotRemoveFromEmptyCartErrorMessage

	^'Can not remove items from empty cart'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: 'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear)
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !

!CartSession methodsFor: 'cart' stamp: 'PhG 11/14/2021 21:13:21'!
remove: anAmount of: aBook 
	
	^cart remove: anAmount of: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: 'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
totalOf: anItem quantity: aQuantity

	^(cart catalog at: anItem) * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Catalogue category: 'TusLibros-Model'!
Object subclass: #Catalogue
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Catalogue methodsFor: 'catalogue' stamp: 'PhG 11/13/2021 11:43:33'!
catalogue
	self subclassResponsibility.! !


!classDefinition: #MockCatalogue category: 'TusLibros-Model'!
Catalogue subclass: #MockCatalogue
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MockCatalogue methodsFor: 'catalogue' stamp: 'PhG 11/13/2021 11:48:18'!
catalogue
	^ Dictionary new
		at: self itemSoldByTheStore put: self itemSoldByTheStorePrice;
		at: self anotherItemSoldByTheStore put: self anotherItemSoldByTheStorePrice;
		yourself ! !


!MockCatalogue methodsFor: 'items' stamp: 'PhG 11/13/2021 11:47:13'!
anotherItemSoldByTheStore

	^'Los Impresentables'! !

!MockCatalogue methodsFor: 'items' stamp: 'PhG 11/13/2021 11:47:56'!
anotherItemSoldByTheStorePrice

	^15! !

!MockCatalogue methodsFor: 'items' stamp: 'PhG 11/13/2021 12:27:11'!
itemSoldByTheStore

	^ 'El Pacto Copernico'! !

!MockCatalogue methodsFor: 'items' stamp: 'PhG 11/13/2021 11:48:04'!
itemSoldByTheStorePrice

	^10! !


!classDefinition: #Clock category: 'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #RealClock category: 'TusLibros-Model'!
Clock subclass: #RealClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!RealClock methodsFor: 'time' stamp: 'PhG 11/13/2021 12:14:43'!
now
	^DateAndTime now.! !

!RealClock methodsFor: 'time' stamp: 'PhG 11/13/2021 12:14:47'!
today
	^DateAndTime now.! !


!classDefinition: #CreditCard category: 'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth

	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth

	^self new initializeExpiringOn: aMonth! !


!classDefinition: #LineItem category: 'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: 'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: 'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #MockMerchantProcessor category: 'TusLibros-Model'!
MerchantProcessor subclass: #MockMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MockMerchantProcessor methodsFor: 'debit' stamp: 'PhG 11/13/2021 12:01:54'!
debit: anAmount from: aCreditCard

	(self creditCardToBeRejected = aCreditCard) ifTrue: [self error: Cashier creditCardHasNoCreditErrorMessage].! !


!MockMerchantProcessor methodsFor: 'private - rejected credit card' stamp: 'PhG 11/13/2021 12:03:53'!
creditCardToBeRejected

	^CreditCard expiringOn: self expiredMonthOfYear.! !

!MockMerchantProcessor methodsFor: 'private - rejected credit card' stamp: 'PhG 11/13/2021 12:04:27'!
expiredMonthOfYear

	| today |
	today := DateAndTime now.
	^ Month month: today monthIndex year: today yearNumber - 1! !


!classDefinition: #Sale category: 'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #Ticket category: 'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: 'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosRestAPI category: 'TusLibros-Model'!
Object subclass: #TusLibrosRestAPI
	instanceVariableNames: 'webServer port tusLibrosFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosRestAPI methodsFor: 'initialization' stamp: 'PhG 11/14/2021 22:20:06'!
initializeWith: aPortNumber
	
	tusLibrosFacade := TusLibrosSystemFacade
		authenticatingWith: MockUserDB new users
		acceptingItemsOf: MockCatalogue new catalogue 
		registeringOn: OrderedCollection new
		debitingThrought: MockMerchantProcessor new
		measuringTimeWith: RealClock new.
	
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: self port.
	
	self registerCreateCartEndpoint.
	self registerAddToCartEndpoint.
	self registerListCartEndpoint.
	self registerCheckoutCartEndpoint.
	self registerListPurchasesEndpoint.
	self registerListCatalogueEndpoint.
	self registerRemoveFromCartEndpoint.! !

!TusLibrosRestAPI methodsFor: 'initialization' stamp: 'PhG 11/11/2021 21:12:13'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].
	
	! !


!TusLibrosRestAPI methodsFor: 'enabling services' stamp: 'PhG 11/11/2021 21:11:08'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosRestAPI methodsFor: 'enabling services' stamp: 'PhG 11/11/2021 21:11:35'!
startListening
	
	webServer startListener.

	^'Listening on port: ', self port asString.
	! !

!TusLibrosRestAPI methodsFor: 'enabling services' stamp: 'PhG 11/11/2021 21:11:57'!
stopListening
	
	webServer stopListener.

	^'Stopped listening on port: ', self port asString.
	! !


!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/13/2021 11:37:41'!
registerAddToCartEndpoint

	webServer addService: '/addToCart' action:[:request |	 | cartId bookIsbn bookQuantity |
		[cartId := (request fields at: 'cartId' ).
		bookIsbn := (request fields at: 'bookIsbn' ).
		bookQuantity := (request fields at: 'bookQuantity' ).
		tusLibrosFacade add: bookQuantity of: bookIsbn toCartIdentifiedAs: cartId.
		self respond200WithBody: 'OK' for: request]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/13/2021 11:37:11'!
registerCheckoutCartEndpoint
	
	webServer addService: '/checkOutCart' action:[:request |	 | cartId cardNumber cardExpirationDate cardHolder ticket |
		[cartId := (request fields at: 'cartId' ).
		cardNumber := (request fields at: 'ccn' ).
		cardExpirationDate := (request fields at: 'cced' ).
		cardHolder := (request fields at: 'cco' ).
		ticket := tusLibrosFacade checkOutCartIdentifiedAs: cartId withCreditCardNumbered: cardNumber ownedBy: cardHolder expiringOn: cardExpirationDate.
		self respond200WithBody: ('OK') for: request. "consultar transaction id"]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/13/2021 11:35:08'!
registerCreateCartEndpoint
	
	webServer addService: '/createCart' action:[:request |	| cartId password username |
		[username := (request fields at: 'username' ).
		password := (request fields at: 'password' ).
		cartId := tusLibrosFacade createCartFor: username authenticatedWith: password.
		self respond200WithBody: cartId for: request
		 ]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/13/2021 11:36:36'!
registerListCartEndpoint
	
	webServer addService: '/listCart' action:[:request |	 | cartId cartContent |
		[cartId := (request fields at: 'cartId' ).
		cartContent := tusLibrosFacade listCartIdentifiedAs: cartId.
		self respond200WithBody: cartContent for: request.]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/13/2021 12:26:00'!
registerListCatalogueEndpoint
	
	webServer addService: '/listCatalogue' action:[:request |	 
		[self respond200WithBody: tusLibrosFacade listCatalogue for: request.]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/13/2021 11:35:44'!
registerListPurchasesEndpoint
	
	webServer addService: '/listPurchases' action:[:request |	 | purchases password username |
		[username := (request fields at: 'username' ).
		password := (request fields at: 'password' ).
		purchases := tusLibrosFacade listPurchasesOf: username authenticatingWith: password.
		self respond200WithBody: purchases for: request.]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/14/2021 17:14:27'!
registerRemoveFromCartEndpoint

	webServer addService: '/removeFromCart' action:[:request |	 | cartId bookIsbn bookQuantity |
		[cartId := (request fields at: 'cartId' ).
		bookIsbn := (request fields at: 'bookIsbn' ).
		bookQuantity := (request fields at: 'bookQuantity' ).
		tusLibrosFacade remove: bookQuantity of: bookIsbn toCartIdentifiedAs: cartId.
		self respond200WithBody: 'OK' for: request]
		on: Error 
		do: (self respond400ErrorFor: request)]! !


!TusLibrosRestAPI methodsFor: 'http response' stamp: 'PhG 11/11/2021 21:44:55'!
respond200WithBody: responseBody for: request
	
	| encodedResponse |

	encodedResponse := WebUtils jsonEncode: responseBody.
	^ request send200Response: (encodedResponse)! !

!TusLibrosRestAPI methodsFor: 'http response' stamp: 'PhG 11/11/2021 21:40:52'!
respond400ErrorFor: request

	^ [ :anError |
			request send400Response: (anError messageText) ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestAPI class' category: 'TusLibros-Model'!
TusLibrosRestAPI class
	instanceVariableNames: ''!

!TusLibrosRestAPI class methodsFor: 'instance creation' stamp: 'PhG 11/11/2021 21:09:13'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #TusLibrosSystemFacade category: 'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalogue lastId merchantProcessor salesBook clock cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:47'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | cartSession
			checkOutCartWithCreditCardNumbered: aCreditCartNumber
			ownedBy: anOwner
			expiringOn: anExpirationMonthOfYear ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'PhG 11/13/2021 12:25:02'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalogue) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'PhG 11/13/2021 12:25:12'!
listCatalogue
	^catalogue copy! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:33:49'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [ | sales |
		sales := self salesDoneBy: aUser.
		sales
			inject: Dictionary new
			into: [ :salesOrderedByBook :aSale |
				self list: aSale on: salesOrderedByBook.
				salesOrderedByBook ] ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'PhG 11/14/2021 21:10:04'!
remove: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession remove: anAmount of: aBook ]! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:56'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldTotal newTotal |
		oldTotal := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newTotal := oldTotal + aLineItem total.
		salesOrderedByBook at: aLineItem item put: newTotal ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'PhG 11/13/2021 12:25:02'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalogue := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: 'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock! !


!classDefinition: #UserDB category: 'TusLibros-Model'!
Object subclass: #UserDB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!UserDB methodsFor: 'users' stamp: 'PhG 11/13/2021 11:39:29'!
users
	self subclassResponsibility.! !


!classDefinition: #MockUserDB category: 'TusLibros-Model'!
UserDB subclass: #MockUserDB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MockUserDB methodsFor: 'users' stamp: 'PhG 11/13/2021 11:40:47'!
users
	^Dictionary new
		at: 'maximilianoCozzetti' put: 'admin';
		yourself! !
