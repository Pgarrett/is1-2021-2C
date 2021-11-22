!classDefinition: #TusLibrosCatalogueWindow category: 'TusLibros-Model'!
SystemWindow subclass: #TusLibrosCatalogueWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosCatalogueWindow methodsFor: 'GUI building' stamp: 'wgb 11/22/2021 12:17:16'!
buildListColumnCart
	| columnLayoutMorph catalogueListMorph |
	
	catalogueListMorph := PluggableListMorph model: self model listGetter: #cartItems indexGetter: #cartItemSelectedIndex indexSetter: #cartItemSelectedIndex:.
	catalogueListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
	
	columnLayoutMorph := LayoutMorph newColumn.
	columnLayoutMorph separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Carrito');
	addMorph: catalogueListMorph.
	
	^columnLayoutMorph.
	! !

!TusLibrosCatalogueWindow methodsFor: 'GUI building' stamp: 'wgb 11/22/2021 11:54:25'!
buildListColumnCatalogue
	| columnLayoutMorph catalogueListMorph |
	
	catalogueListMorph := PluggableListMorph model: self model listGetter: #catalogue indexGetter: #catalogueSelectedIndex indexSetter: #catalogueSelectedIndex:.
	catalogueListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
	
	columnLayoutMorph := LayoutMorph newColumn.
	columnLayoutMorph separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Catalogo');
	addMorph: catalogueListMorph.
	
	^columnLayoutMorph.
	! !

!TusLibrosCatalogueWindow methodsFor: 'GUI building' stamp: 'wgb 11/22/2021 12:18:34'!
buildListsAndAddRemoveRow
	| rowLayoutMorph |
	
	
	rowLayoutMorph := LayoutMorph newRow.
	rowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (self buildListColumnCatalogue);
	addMorph: self buildQuantityAndAddRemoveColumn;
	addMorph: (self buildListColumnCart).
	
	^rowLayoutMorph.
	! !

!TusLibrosCatalogueWindow methodsFor: 'GUI building' stamp: 'wgb 11/22/2021 10:35:04'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: (self buildRowWithFirstButton: 'Logout' andSecondButton: 'Historial'); "logout + blank + historial"
	addMorph: self buildListsAndAddRemoveRow; "catalogo + cantidad + '>>' + '<<' carrito"
	addMorph: (self buildRowWithFirstButton: 'Carrito Nuevo' andSecondButton: 'Checkout'). "new + blank + checkout"
	
"- catalogo
	* label catalogo
	* lista catalogo
	* label cantidad a agregar
	* textbox cantidad a agregar
	* boton agregar al carrito
	* label contenido carrito
	* lista contenido carrito
	* label cantidad a sacar
	* textbox cantidad a sacar
	* boton sacar del carrito
	* boton de checkout (consultar si podemos hardcodear cual tarjeta es valida o si hay que ingresarlos al momento de checkout)
	* label de error de compra
	* boton desloguearse
	* boton nueva compra
	* historial de compras"	! !

!TusLibrosCatalogueWindow methodsFor: 'GUI building' stamp: 'PhG 11/15/2021 20:38:00'!
buildQuantityAndAddRemoveColumn
	| columnLayoutMorph addToCartButtonMorph removeFromCartButtonMorph |
	
	addToCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #showWordInTranscript label: '>>'.	
	removeFromCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #showWordInTranscript label: '<<'.	
	
	columnLayoutMorph := LayoutMorph newColumn.
	columnLayoutMorph separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: self buildQuantityRow;
	addMorph: addToCartButtonMorph;
	addMorph: removeFromCartButtonMorph .
	
	^columnLayoutMorph.! !

!TusLibrosCatalogueWindow methodsFor: 'GUI building' stamp: 'PhG 11/15/2021 21:11:30'!
buildQuantityRow

	| quantityBoxMorph rowLayoutMorph |
	
	quantityBoxMorph := SimpleNumberEntryMorph integerDefault: 0 maxNumChars: 10.
	quantityBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 10; morphHeight: 25. 
		
	rowLayoutMorph := LayoutMorph newRow.
	rowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Cantidad:');
	addMorph: quantityBoxMorph.
	
	^rowLayoutMorph.! !

!TusLibrosCatalogueWindow methodsFor: 'GUI building' stamp: 'PhG 11/15/2021 20:44:52'!
buildRowWithFirstButton: firstButtonLabel andSecondButton: secondButtonLabel
	| logoutButtonMorph rowLayoutMorph historialButtonMorph |
	
	logoutButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #showWordInTranscript label: firstButtonLabel.	
	historialButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #showWordInTranscript label: secondButtonLabel.	
	
	rowLayoutMorph := LayoutMorph newRow.
	rowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: logoutButtonMorph;
	addMorph: LayoutMorph newColumn;
	addMorph: historialButtonMorph.
	
	^rowLayoutMorph.
	! !


!TusLibrosCatalogueWindow methodsFor: 'initialization' stamp: 'wgb 11/22/2021 10:29:59'!
initializeWith: aTitle

	self setLabel: aTitle.
	self model: TusLibrosCatalogueWindowModel new.
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #newWordsArrived send: #showCatalogueWindow to: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCatalogueWindow class' category: 'TusLibros-Model'!
TusLibrosCatalogueWindow class
	instanceVariableNames: ''!

!TusLibrosCatalogueWindow class methodsFor: 'instance creation' stamp: 'wgb 11/22/2021 10:28:54'!
open
	^self new initializeWith: 'TusLibros: List Catalogue'.! !


!classDefinition: #TusLibrosCreateCartWindow category: 'TusLibros-Model'!
SystemWindow subclass: #TusLibrosCreateCartWindow
	instanceVariableNames: 'invalidCredentialsRow usernameTextMorph passwordTextMorph createCartButtonMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosCreateCartWindow methodsFor: 'initialization' stamp: 'wgb 11/22/2021 09:41:50'!
initializeWith: aTitle

	self setLabel: aTitle.
	self model: TusLibrosCreateCartWindowModel new.
	self buildMorphicWindow.
	self openInWorld.
	
	self model when: #successfulLogin send: #showCatalogueWindow to: self.		
	self model when: #unsuccessfulLogin send: #showInvalidCredentialsRow to: self.! !


!TusLibrosCreateCartWindow methodsFor: 'GUI building' stamp: 'PhG 11/18/2021 21:27:18'!
buildCreateCartButtonRow
	| rowLayoutMorph |
	
	createCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #submitLoginRequest label: 'Create Cart'.	
	
	rowLayoutMorph := LayoutMorph newRow.
	rowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: createCartButtonMorph.
	
	^rowLayoutMorph.
	! !

!TusLibrosCreateCartWindow methodsFor: 'GUI building' stamp: 'PhG 11/15/2021 20:11:15'!
buildInvalidCredentialsRow
	| rowLayoutMorph |
	
	invalidCredentialsRow := (LabelMorph contents:'Invalid Credentials' ).
		
	rowLayoutMorph := LayoutMorph newRow.
	rowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: invalidCredentialsRow.
	invalidCredentialsRow hide.
	
	^rowLayoutMorph.! !

!TusLibrosCreateCartWindow methodsFor: 'GUI building' stamp: 'PhG 11/18/2021 21:02:55'!
buildMorphicWindow

	usernameTextMorph := self buildTextBoxWithTextGetter: #usernameText withTextSetter: #usernameText:.
	passwordTextMorph := self buildTextBoxWithTextGetter: #passwordText withTextSetter: #passwordText:.
		
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: (self buildTextBoxRowIdentifiedBy: 'Username:' andTextMorph: usernameTextMorph);
	addMorph: (self buildTextBoxRowIdentifiedBy: 'Password:' andTextMorph: passwordTextMorph);
	addMorph: self buildInvalidCredentialsRow;
	addMorph: self buildCreateCartButtonRow.
	
	"- login/createCart:
	* label username
	* textbox username
	* label password
	* textbox password (checkear despues si se puede ocultar la contraseña)
	* boton de crear carrito
	* label credenciales invalidas (o ventana de error)"
	! !

!TusLibrosCreateCartWindow methodsFor: 'GUI building' stamp: 'PhG 11/18/2021 21:03:14'!
buildTextBoxRowIdentifiedBy: aLabel andTextMorph: aTextMorph
	| rowLayoutMorph |
		
	rowLayoutMorph := LayoutMorph newRow.
	rowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:aLabel);
	addMorph: aTextMorph.
	
	^rowLayoutMorph.! !

!TusLibrosCreateCartWindow methodsFor: 'GUI building' stamp: 'PhG 11/18/2021 20:59:55'!
buildTextBoxWithTextGetter: aTextGetter withTextSetter: aTextSetter
	| textBoxMorph |
	
	textBoxMorph := TextModelMorph textProvider: self model textGetter: aTextGetter textSetter: aTextSetter. 
	textBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | textBoxMorph innerTextMorph acceptContents ] .
	textBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300; morphHeight: 25. 
		
	^textBoxMorph ! !


!TusLibrosCreateCartWindow methodsFor: 'access' stamp: 'wgb 11/22/2021 10:25:25'!
showCatalogueWindow
	TusLibrosCatalogueWindow open.! !

!TusLibrosCreateCartWindow methodsFor: 'access' stamp: 'PhG 11/18/2021 21:21:51'!
showInvalidCredentialsRow
	
	invalidCredentialsRow show.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCreateCartWindow class' category: 'TusLibros-Model'!
TusLibrosCreateCartWindow class
	instanceVariableNames: ''!

!TusLibrosCreateCartWindow class methodsFor: 'instance creation' stamp: 'PhG 11/21/2021 21:58:28'!
open
	
	^self new initializeWith: 'TusLibros: Create Cart'.! !


!classDefinition: #TusLibrosListItemsWindow category: 'TusLibros-Model'!
SystemWindow subclass: #TusLibrosListItemsWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosListItemsWindow methodsFor: 'initialization' stamp: 'PhG 11/21/2021 22:01:38'!
initializeWith: aTitle

	self setLabel: aTitle.
	self model: TusLibrosListItemsWindowModel new.
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #newWordsArrived send: #showCatalogueWindow to: self.! !


!TusLibrosListItemsWindow methodsFor: 'GUI building' stamp: 'PhG 11/15/2021 21:02:13'!
buildDetailRow: aPrice

	| rowLayoutMorph |
		
	rowLayoutMorph := LayoutMorph newRow.
	rowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'aBookIsbn');
	addMorph: (LabelMorph contents: '1');
	addMorph: (LabelMorph contents: ('$', aPrice)).
	
	^rowLayoutMorph.! !

!TusLibrosListItemsWindow methodsFor: 'GUI building' stamp: 'PhG 11/15/2021 21:00:35'!
buildHeaderRow

	| rowLayoutMorph |
		
	rowLayoutMorph := LayoutMorph newRow.
	rowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'Libro');
	addMorph: (LabelMorph contents: 'Cantidad');
	addMorph: (LabelMorph contents: 'Precio').
	
	^rowLayoutMorph.! !

!TusLibrosListItemsWindow methodsFor: 'GUI building' stamp: 'PhG 11/15/2021 21:02:53'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: (self buildHeaderRow); "Libro + Cantidad + Precio"
	addMorph: (self buildDetailRow: '15'); "ver como construir esto dinamicamente"
	addMorph: (self buildDetailRow: '10'); "ver como construir esto dinamicamente"
	addMorph: (self buildTotalRow: '25'). "blank + totalLabel + totalNumber"
	
	"- ticket
	* lista items
		+ titulo libro
		+ cantidad libro
		+ precio unitario/total (ver cual)
	* total


		column1		column2		  column3
row	| bookIsbn1 | bookQuantity1 | price1 |
	| bookIsbn2 | bookQuantity2 | price2 |
	| bookIsbn3 | bookQuantity3 | price3 |
	| bookIsbn4 | bookQuantity4 | price4 |
	| total								 |"! !

!TusLibrosListItemsWindow methodsFor: 'GUI building' stamp: 'PhG 11/15/2021 21:02:22'!
buildTotalRow: aTotal

	| rowLayoutMorph |
		
	rowLayoutMorph := LayoutMorph newRow.
	rowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: LayoutMorph newColumn;
	addMorph: (LabelMorph contents: 'Total:');
	addMorph: (LabelMorph contents: ('$',aTotal)).
	
	^rowLayoutMorph.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosListItemsWindow class' category: 'TusLibros-Model'!
TusLibrosListItemsWindow class
	instanceVariableNames: ''!

!TusLibrosListItemsWindow class methodsFor: 'instance creation' stamp: 'PhG 11/15/2021 20:54:47'!
open: detailType
	
	^self new initializeWith: ('TusLibros: ', detailType).! !


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

!MockCatalogue methodsFor: 'catalogue' stamp: 'wgb 11/22/2021 11:22:52'!
catalogue
	^ Dictionary new
		at: self itemSoldByTheStore put: self itemSoldByTheStorePrice;
		at: self anotherItemSoldByTheStore put: self anotherItemSoldByTheStorePrice;
		yourself ! !


!MockCatalogue methodsFor: 'items' stamp: 'wgb 11/22/2021 11:24:25'!
anotherItemSoldByTheStore

	^ 'El Pacto Copernico'! !

!MockCatalogue methodsFor: 'items' stamp: 'wgb 11/22/2021 11:24:36'!
anotherItemSoldByTheStorePrice

	^10! !

!MockCatalogue methodsFor: 'items' stamp: 'wgb 11/22/2021 11:23:19'!
itemSoldByTheStore

	^'Los Impresentables'! !

!MockCatalogue methodsFor: 'items' stamp: 'wgb 11/22/2021 11:23:27'!
itemSoldByTheStorePrice

	^15! !


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


!classDefinition: #TusLibrosCatalogueWindowModel category: 'TusLibros-Model'!
Object subclass: #TusLibrosCatalogueWindowModel
	instanceVariableNames: 'restInterface username password cartId catalogue catalogueSelectedIndex cartItems cartItemSelectedIndex errorDescription'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosCatalogueWindowModel methodsFor: 'initialization' stamp: 'wgb 11/22/2021 11:57:55'!
initialize

	restInterface := TusLibrosRestInterface new.
	catalogue := restInterface listCatalogue keys.
	catalogueSelectedIndex := 0.
	cartItems := OrderedCollection new.
	cartItemSelectedIndex := 0.! !


!TusLibrosCatalogueWindowModel methodsFor: 'catalogue list' stamp: 'wgb 11/22/2021 11:21:09'!
catalogue
	^catalogue sort.
	! !

!TusLibrosCatalogueWindowModel methodsFor: 'catalogue list' stamp: 'wgb 11/22/2021 12:16:42'!
catalogueSelectedIndex
	^catalogueSelectedIndex.

	! !

!TusLibrosCatalogueWindowModel methodsFor: 'catalogue list' stamp: 'wgb 11/22/2021 12:16:33'!
catalogueSelectedIndex: anIndex
	catalogueSelectedIndex := anIndex.

	! !


!TusLibrosCatalogueWindowModel methodsFor: 'cart items' stamp: 'wgb 11/22/2021 11:55:42'!
cartItemSelectedIndex
	^cartItemSelectedIndex .! !

!TusLibrosCatalogueWindowModel methodsFor: 'cart items' stamp: 'wgb 11/22/2021 11:55:58'!
cartItemSelectedIndex: anIndex
	cartItemSelectedIndex := anIndex .! !

!TusLibrosCatalogueWindowModel methodsFor: 'cart items' stamp: 'wgb 11/22/2021 11:55:15'!
cartItems
	^cartItems .! !


!classDefinition: #TusLibrosCreateCartWindowModel category: 'TusLibros-Model'!
Object subclass: #TusLibrosCreateCartWindowModel
	instanceVariableNames: 'restInterface username password cartId errorDescription'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosCreateCartWindowModel methodsFor: 'initialization' stamp: 'PhG 11/21/2021 21:59:46'!
initialize

	restInterface := TusLibrosRestInterface new.
	username := ''.
	password := ''.
	cartId := ''.! !


!TusLibrosCreateCartWindowModel methodsFor: 'CredentialsModelMorphSelectors' stamp: 'PhG 11/18/2021 20:56:31'!
passwordText
	^password.! !

!TusLibrosCreateCartWindowModel methodsFor: 'CredentialsModelMorphSelectors' stamp: 'PhG 11/18/2021 20:56:18'!
passwordText: aPassword
	password := aPassword.
	^true.! !

!TusLibrosCreateCartWindowModel methodsFor: 'CredentialsModelMorphSelectors' stamp: 'PhG 11/18/2021 20:55:29'!
usernameText
	^username.! !

!TusLibrosCreateCartWindowModel methodsFor: 'CredentialsModelMorphSelectors' stamp: 'PhG 11/18/2021 20:55:22'!
usernameText: aUsername
	username := aUsername.
	^true.! !


!TusLibrosCreateCartWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'wgb 11/22/2021 10:24:52'!
submitLoginRequest

	[
		cartId := restInterface createCartFor: username authenticatedBy: password.
		self triggerEvent: #successfulLogin.
	]
	on: Error
	do: [:error | 
		errorDescription := error description.
		self triggerEvent: #unsuccessfulLogin.
	].
	
	
	
	"Investiguen mensajes como:
	self triggerEvent: #newWordsArrived with: 1.
	self triggerEvent: #newWordsArrived withArguments: (Array with: 1 with: 2)"! !


!classDefinition: #TusLibrosListItemsWindowModel category: 'TusLibros-Model'!
Object subclass: #TusLibrosListItemsWindowModel
	instanceVariableNames: 'restInterface username password cartId errorDescription'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosListItemsWindowModel methodsFor: 'initialization' stamp: 'PhG 11/21/2021 22:01:50'!
initialize

	restInterface := TusLibrosRestInterface new.! !


!classDefinition: #TusLibrosRestAPI category: 'TusLibros-Model'!
Object subclass: #TusLibrosRestAPI
	instanceVariableNames: 'webServer port tusLibrosFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosRestAPI methodsFor: 'initialization' stamp: 'wgb 11/22/2021 10:12:31'!
initializeWith: aPortNumber
	
	tusLibrosFacade := TusLibrosSystemFacade
		authenticatingWith: MockUserDB new users
		acceptingItemsOf: MockCatalogue new catalogue 
		registeringOn: OrderedCollection new
		debitingThrought: MockMerchantProcessor new
		measuringTimeWith: RealClock new.
	
	port := aPortNumber.
	
	webServer := WebServer new listenOn: self port.
	
	self registerHealthcheck.
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


!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/21/2021 21:48:52'!
registerAddToCartEndpoint

	webServer addService: '/addToCart' action:[:request |	 | cartId bookIsbn bookQuantity |
		[cartId := (request fields at: 'cartId' ) asNumber .
		bookIsbn := request fields at: 'bookIsbn'.
		bookQuantity := (request fields at: 'bookQuantity') asNumber .
		tusLibrosFacade add: bookQuantity of: bookIsbn toCartIdentifiedAs: cartId.
		self respond200WithBody: 'OK' for: request]
		on: Error 
		do: (self respond400ErrorFor: request)
		]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/15/2021 17:33:43'!
registerCheckoutCartEndpoint
	
	webServer addService: '/checkOutCart' action:[:request |	 | cartId cardNumber cardExpirationDate cardHolder ticket |
		[cartId := (request fields at: 'cartId') asNumber.
		cardNumber := (request fields at: 'ccn') asNumber.
		cardExpirationDate := request fields at: 'cced'.
		cardHolder := request fields at: 'cco'.
		ticket := tusLibrosFacade checkOutCartIdentifiedAs: cartId withCreditCardNumbered: cardNumber ownedBy: cardHolder expiringOn: cardExpirationDate.
		self respond200WithBody: 'OK' for: request.]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'wgb 11/22/2021 12:10:52'!
registerCreateCartEndpoint
	
	webServer addService: '/createCart' action:[:request |	| cartId password username |
		[
		username := request fields at: 'username'.
		password := request fields at: 'password'.
		cartId := tusLibrosFacade createCartFor: username authenticatedWith: password.
		self respond200WithBody: cartId for: request
		 ]
		on: Error 
		do: [self respond400ErrorFor: request]]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'wgb 11/22/2021 10:16:32'!
registerHealthcheck

	webServer addService: '/status' action:[:request |	
		[
		self respond200WithBody: 'Server up' for: request]
		on: Error 
		do: [self halt.
			self respond500ErrorFor: request]
		]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/21/2021 21:50:19'!
registerListCartEndpoint
	
	webServer addService: '/listCart' action:[:request |	 | cartId cartContent |
		[cartId := (request fields at: 'cartId') asNumber.
		cartContent := self bagToDictionary: (tusLibrosFacade listCartIdentifiedAs: cartId).
		self respond200WithBody: cartContent for: request.]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/13/2021 12:26:00'!
registerListCatalogueEndpoint
	
	webServer addService: '/listCatalogue' action:[:request |	 
		[self respond200WithBody: tusLibrosFacade listCatalogue for: request.]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/15/2021 17:33:12'!
registerListPurchasesEndpoint
	
	webServer addService: '/listPurchases' action:[:request |	 | purchases password username |
		[username := request fields at: 'username'.
		password := request fields at: 'password'.
		purchases := tusLibrosFacade listPurchasesOf: username authenticatingWith: password.
		self respond200WithBody: purchases for: request.]
		on: Error 
		do: (self respond400ErrorFor: request)]! !

!TusLibrosRestAPI methodsFor: 'register endpoints' stamp: 'PhG 11/15/2021 17:33:03'!
registerRemoveFromCartEndpoint

	webServer addService: '/removeFromCart' action:[:request |	 | cartId bookIsbn bookQuantity |
		[cartId := request fields at: 'cartId'.
		bookIsbn := request fields at: 'bookIsbn'.
		bookQuantity := request fields at: 'bookQuantity'.
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

!TusLibrosRestAPI methodsFor: 'http response' stamp: 'wgb 11/22/2021 10:14:25'!
respond500ErrorFor: request

	^ [ :anError |
			request send500Response: (anError messageText). ].! !


!TusLibrosRestAPI methodsFor: 'private' stamp: 'PhG 11/21/2021 21:49:25'!
bagToDictionary: aBag

	| dictionary |
	
	dictionary := Dictionary new.
	
	aBag do: [:bagElement | 
		dictionary at: bagElement ifPresent:[:value | dictionary at: bagElement put: (value + 1)].
		dictionary at: bagElement ifAbsent: [dictionary at: bagElement put: 1].
	].
	
	^dictionary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestAPI class' category: 'TusLibros-Model'!
TusLibrosRestAPI class
	instanceVariableNames: ''!

!TusLibrosRestAPI class methodsFor: 'instance creation' stamp: 'PhG 11/11/2021 21:09:13'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #TusLibrosRestInterface category: 'TusLibros-Model'!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'PhG 11/21/2021 21:47:10'!
port
	
	^port ifNil: [port:=8083].! !

!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'PhG 11/21/2021 21:47:22'!
url
	
	^'http://localhost:', self port asString! !


!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'PhG 11/21/2021 21:47:33'!
addToCart: aQuantity of: aBook toCartIdentifiedAs: aCartId

	| fieldDict resp formattedBookIsbn |
	
	formattedBookIsbn := self correctlyEncodeSpacesForUrlRequestParameter: aBook.
	fieldDict := Dictionary newFromPairs: {'cartId'. aCartId. 'bookIsbn'. formattedBookIsbn. 'bookQuantity'. aQuantity }.		
	
	resp:= WebClient htmlSubmit: (self url,'/addToCart') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream))] 
		ifFalse:[^self error: resp content].! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'PhG 11/21/2021 21:47:45'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCardNumber ownedBy: aCardHolder expiringOn: aCardExpirationDate

	| fieldDict resp |
	
	fieldDict := Dictionary newFromPairs: {'cartId'. aCartId. 'ccn'. aCardNumber. 'cced'. aCardExpirationDate. 'cco'. aCardHolder.}.		
	
	resp:= WebClient htmlSubmit: (self url,'/checkOutCart') fields: fieldDict.
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream))] 
		ifFalse:[^self error: resp content].! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'PhG 11/21/2021 21:47:51'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'wgb 11/22/2021 11:45:30'!
createCartFor: aUsername authenticatedBy: aPassword

	| fieldDict resp |

	fieldDict := Dictionary newFromPairs: {'username'. aUsername. 'password'. aPassword.}.		
	resp:= WebClient htmlSubmit: (self url,'/createCart') fields: fieldDict.
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream))] 
		ifFalse:[^self error: resp content].! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'PhG 11/21/2021 21:48:06'!
listCartIdentifiedAs: aCartId

	| fieldDict resp |

	fieldDict := Dictionary newFromPairs: {'cartId'. aCartId.}.		
	
	resp:= WebClient htmlSubmit: (self url,'/listCart') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream))] 
		ifFalse:[^self error: resp content].! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'PhG 11/21/2021 21:48:13'!
listCatalogue

	| resp |
	
	resp:= WebClient htmlSubmit: (self url,'/listCatalogue') fields: Dictionary new.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream))] 
		ifFalse:[^self error: resp content].! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'PhG 11/21/2021 21:48:20'!
listPurchasesFor: aUsername authenticatedBy: aPassword

	| fieldDict resp |

	fieldDict := Dictionary newFromPairs: {'username'. aUsername. 'password'. aPassword.}.		
	
	resp:= WebClient htmlSubmit: (self url,'/listPurchases') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream))] 
		ifFalse:[^self error: resp content].! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'PhG 11/21/2021 21:48:27'!
removeFromCart: aQuantity of: aBook toCartIdentifiedAs: aCartId

	| fieldDict resp formattedBookIsbn |
	
	formattedBookIsbn := self correctlyEncodeSpacesForUrlRequestParameter: aBook.
	fieldDict := Dictionary newFromPairs: {'cartId'. aCartId. 'bookIsbn'. formattedBookIsbn. 'bookQuantity'. aQuantity }.		
	
	resp:= WebClient htmlSubmit: (self url,'/removeFromCart') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream))] 
		ifFalse:[^self error: resp content].! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'PhG 11/21/2021 21:48:34'!
sendWordsRequest: sentence

	| fieldDict resp urlEncodedSentence |

	urlEncodedSentence := self correctlyEncodeSpacesForUrlRequestParameter: sentence.	
	fieldDict := Dictionary newFromPairs: {'sentence'. urlEncodedSentence.}.		
	
	resp:= WebClient htmlSubmit: (self url,'/createCart') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection .] 
		ifFalse:[^self error: resp content].! !


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

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'wgb 11/22/2021 12:15:19'!
createCartFor: aUser authenticatedWith: aPassword
	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |
		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalogue) on: self.
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


!classDefinition: #User category: 'TusLibros-Model'!
Object subclass: #User
	instanceVariableNames: 'username password creditCardNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!User methodsFor: 'initialization' stamp: 'PhG 11/21/2021 21:51:19'!
initializeWith: aUsername authenticatedBy: aPassword paysWith: aCreditCardNumber

	username := aUsername.
	password := aPassword.
	creditCardNumber := aCreditCardNumber.! !


!User methodsFor: 'testing' stamp: 'PhG 11/21/2021 21:51:31'!
isAuthenticatedBy: aUsername and: aPassword

	^username = aUsername and: [password = aPassword].! !


!User methodsFor: 'credit card' stamp: 'PhG 11/21/2021 21:51:48'!
creditCardNumber
	^creditCardNumber ! !


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

!MockUserDB methodsFor: 'users' stamp: 'PhG 11/21/2021 21:52:24'!
users
	^Dictionary new
		at: 'maximoCozzetti' put: 'tortugaMaritima';
		"at: 'maximoCozzetti' put: (User initializeWith: 'mcozzetti' authenticatedBy: 'tortugaMaritima' paysWith: 1234567890123456);"
		yourself! !
