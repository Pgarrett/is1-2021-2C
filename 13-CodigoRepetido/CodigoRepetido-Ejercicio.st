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

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 20:16:14'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook expectedError|
			
	customerBook := CustomerBook new.
		
	expectedError := self execute: [ customerBook addCustomerNamed: ''.] expectingError: Error.
	self assert: expectedError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 20:14:10'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self aCustomerBookWith: johnLennon.
	
	self execute: [ customerBook removeCustomerNamed: 'Paul McCartney'.] expectingError: NotFound.
	self assertTheOnlyCustomerIn: customerBook is: johnLennon
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 20:05:04'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self aCustomerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook totalCustomersIs: 1 activeCustomersAre: 0 suspendedCustomersAre: 1.	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 20:05:18'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self aCustomerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook totalCustomersIs: 0 activeCustomersAre: 0 suspendedCustomersAre: 0.	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 20:13:18'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self aCustomerBookWith: johnLennon.
		
	self execute: [ customerBook suspendCustomerNamed: 'George Harrison'.] expectingError: CantSuspend.
	self assertTheOnlyCustomerIn: customerBook is: johnLennon
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PhG 9/8/2021 20:10:36'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self aCustomerBookWith: johnLennon.
	
	customerBook suspendCustomerNamed: johnLennon.
	
	self execute: [ customerBook suspendCustomerNamed: johnLennon.] expectingError: CantSuspend.
	self assertTheOnlyCustomerIn: customerBook is: johnLennon
! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'PhG 9/8/2021 20:04:03'!
assertCustomerBook: aCustomerBook totalCustomersIs: expectedAmountOfCustomers activeCustomersAre: expectedAmountOfActiveCustomers suspendedCustomersAre: expectedAmountOfSuspendedCustomers
	
	self assert: expectedAmountOfCustomers equals: aCustomerBook numberOfCustomers.
	self assert: expectedAmountOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: expectedAmountOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'PhG 9/8/2021 20:06:08'!
assertTheOnlyCustomerIn: aCustomerBook is: expectedCustomer

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: expectedCustomer)! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'PhG 9/8/2021 20:08:09'!
execute: aClosure expectingError: expectedError

	[ aClosure value.
	self fail ]
		on: expectedError
		do: [ :anError | ^anError ].! !


!CustomerBookTest methodsFor: 'builders' stamp: 'PhG 9/8/2021 08:15:31'!
aCustomerBookWith: aCustomerName

	|customerBook|

	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	^customerBook.
! !


!CustomerBookTest methodsFor: 'measuring' stamp: 'PhG 9/8/2021 20:21:23'!
measureExecutionTimeInMillisOf: aClosure

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

!CustomerBook methodsFor: 'customer management' stamp: 'PhG 9/8/2021 20:30:19'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'bt 9/8/2021 17:36:51'!
removeCustomerNamed: aName 
 	
	| throwError tryToRemoveFromSuspended |
	
	throwError := [^NotFound signal].
	tryToRemoveFromSuspended := [suspended remove: aName ifAbsent: throwError ].
	active remove: aName ifAbsent: tryToRemoveFromSuspended.
	
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
