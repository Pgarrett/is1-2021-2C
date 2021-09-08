!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/6/2021 21:34:35'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook addingSomeoneToCustomerBook addingSomeoneExecutionTime |
	
	customerBook := CustomerBook new.
	
	addingSomeoneToCustomerBook := [customerBook addCustomerNamed: 'John Lennon'.].	
	addingSomeoneExecutionTime := self measureExecutionTimeInMillisOf: addingSomeoneToCustomerBook.
	
	self assert: addingSomeoneExecutionTime < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 08:16:00'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook removingSomeoneFromCustomerBook removingSomeoneExecutionTime paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self aCustomerBookWith: paulMcCartney.
	
	removingSomeoneFromCustomerBook := [customerBook removeCustomerNamed: paulMcCartney.].
	removingSomeoneExecutionTime := self measureExecutionTimeInMillisOf: removingSomeoneFromCustomerBook.
	
	self assert: removingSomeoneExecutionTime < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 08:19:11'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self aCustomerBookWith: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | self assertJohnLennonIsTheOnlyCustomerIn: customerBook ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 08:42:04'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self aCustomerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook hasActiveCustomers: 0 hasNumberOfCustomers:  1 hasSuspendedCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 08:42:54'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self aCustomerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook hasActiveCustomers: 0 hasNumberOfCustomers:  0 hasSuspendedCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 08:19:11'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self aCustomerBookWith: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | self assertJohnLennonIsTheOnlyCustomerIn: customerBook ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 08:19:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self aCustomerBookWith: johnLennon.
	
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend
		do: [ :anError | self assertJohnLennonIsTheOnlyCustomerIn: customerBook].
! !


!CustomerBookTest methodsFor: 'testUtils' stamp: 'PhG 9/8/2021 08:15:31'!
aCustomerBookWith: aCustomerName

	|customerBook|

	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	^customerBook.
! !

!CustomerBookTest methodsFor: 'testUtils' stamp: 'PhG 9/8/2021 08:42:30'!
assertCustomerBook: aCustomerBook hasActiveCustomers: amountOfActiveCustomers hasNumberOfCustomers: amountOfCustomers hasSuspendedCustomers: amountOfSuspendedCustomers
	
	self assert: amountOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: amountOfCustomers equals: aCustomerBook numberOfCustomers.
	self assert: amountOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.! !

!CustomerBookTest methodsFor: 'testUtils' stamp: 'PhG 9/8/2021 08:19:11'!
assertJohnLennonIsTheOnlyCustomerIn: aCustomerBook

	| johnLennon |
	johnLennon := 'John Lennon'.
	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: johnLennon)! !

!CustomerBookTest methodsFor: 'testUtils' stamp: 'PhG 9/6/2021 21:30:42'!
measureExecutionTimeInMillisOf: aClosure
	"comment stating purpose of message"

	| millisecondsBeforeRunning millisecondsAfterRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning-millisecondsBeforeRunning! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'bt 9/8/2021 17:14:38'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'bt 9/8/2021 17:36:51'!
removeCustomerNamed: aName 
 	
	| throwError tryToRemoveFromActive |
	
	throwError := [^NotFound signal].
	tryToRemoveFromActive := [active remove: aName ifAbsent: throwError ].
	suspended remove: aName ifAbsent: tryToRemoveFromActive.
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'bt 9/8/2021 17:15:14'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].

	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
