!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 12:37:14'!
test01NewPortfolioIsEmtpy
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: true equals: portfolio isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/7/2021 21:15:39'!
test02PortfolioWithAnAccountAddedIsNotEmtpy
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	portfolio add: ReceptiveAccount new.
	
	self assert: false equals: portfolio isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/7/2021 21:15:05'!
test03PortfolioWithAPortfolioAddedIsNotEmtpy
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	portfolio add: Portfolio new.
	
	self assert: false equals: portfolio isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/7/2021 20:59:45'!
test04BalanceOfNewPortfolioIsZero
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/7/2021 21:15:25'!
test05BalanceOfPortfolioWithAccountIsAccountBalance
	
	|portfolio account|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	portfolio add: account.
	
	self assert: (account balance) equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/7/2021 21:15:33'!
test06BalanceOfPortfolioWithPortfolioIsPortfolioBalance
	
	|portfolio innerPortfolio account|
	
	portfolio := Portfolio new.
	innerPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	innerPortfolio add: account.
	
	portfolio add: innerPortfolio .
	
	self assert: (innerPortfolio balance) equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/14/2021 21:12:09'!
test07BalanceOfPortfolioWithManyAccountsIsAddedBalance
	
	|portfolio innerPortfolio anAccount otherAccount|
	
	portfolio := Portfolio new.
	innerPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
	innerPortfolio add: anAccount.
	Deposit register: 200 on: otherAccount.
	innerPortfolio add: otherAccount.
	
	portfolio add: innerPortfolio .
	
	self assert: 300 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/14/2021 21:20:29'!
test08BalanceOfPortfolioWithManyPortfoliosIsAddedBalance
	
	|portfolio innerPortfolio anAccount otherAccount|
	
	portfolio := Portfolio new.
	innerPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
	innerPortfolio add: anAccount.
	Deposit register: 200 on: otherAccount.
	portfolio add: otherAccount.
	
	portfolio add: innerPortfolio .
	
	self assert: 300 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 15:13:30'!
test09PortfolioCanNotBeAddedToItself
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	self should: [portfolio add: portfolio]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 11:31:46'!
test10PortfolioCanNotAddTheSameAccountMoreThanOnce
	
	|portfolio anAccount|
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	portfolio add: anAccount .
	
	self should: [portfolio add: anAccount]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 11:31:46'!
test11PortfolioCanNotAddTheSamePortfolioMoreThanOnce
	
	|portfolio anAccount innerPortfolio| 
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	innerPortfolio := Portfolio new.
	
	innerPortfolio add: anAccount.
	portfolio add: innerPortfolio.
		
	self should: [portfolio add: innerPortfolio]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 11:31:46'!
test12PortfolioCanNotAddAccountPresentInAListedPortfolio
	
	|portfolio anAccount innerPortfolio| 
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	innerPortfolio := Portfolio new.
	
	innerPortfolio add: anAccount.
	portfolio add: innerPortfolio.
		
	self should: [portfolio add: innerPortfolio]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 15:27:08'!
test13AccountPresentInAListedPortfolioCanNotBeAdded
	
	|p1 a1 p2 p3| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := ReceptiveAccount withId: 'a1'.
	p2 := Portfolio withId: 'p2'.
	p3 := Portfolio withId: 'p3'.
	
	p2 add: a1.
	p3 add: a1.
	p1 add: p2.
		
	self should: [p1 add: p3]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 12:22:45'!
test14PortfolioCanNotBeAddedMoreThanOnce
	
	|p1 a1 p2 p3| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	a1 := ReceptiveAccount withId: 'a1'.
	p3 := Portfolio withId: 'p3'.
	
	p2 add: a1.
	p2 add: p3.
	p1 add: p2.
		
	self should: [p1 add: p3]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 12:29:14'!
test15ExistingAccountInRootPortfolioCanNotBeAddedToChildPortfolio
	
	|p1 a1 p2| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	a1 := ReceptiveAccount withId: 'a1'.
	
	p1 add: a1.
	p1 add: p2.
		
	self should: [p2 add: a1.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 14:01:01'!
test16CheckAccountNotPresentInParentsTree
	
	|p1 p2 p3 p4 a2| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	p3 := Portfolio withId: 'p3'.
	p4 := Portfolio withId: 'p4'.
	a2 := ReceptiveAccount withId: 'a2'.
	
	p1 add: p2.
	p2 add: p3.
	p3 add: a2.
	p1 add: p4.
		
	self should: [p4 add: a2.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 14:02:00'!
test17ParentPortfolioCanNotBeChildOfAnotherPortfolio
	
	|p1 p2| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	
	p1 add: p2.
		
	self should: [p2 add: p1.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 14:10:40'!
test18CheckPortfolioNotPresentInParentsTree
	
	|p1 p2 p3 p4| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	p3 := Portfolio withId: 'p3'.
	p4 := Portfolio withId: 'p4'.
	
	p1 add: p2.
	p2 add: p3.
	p1 add: p4.
		
	self should: [p4 add: p3.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 14:15:47'!
test19CheckAccountIsNotPresentInHigherParentTree
	
	|p1 p2 p3 p4 p5 a1| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	p3 := Portfolio withId: 'p3'.
	p4 := Portfolio withId: 'p4'.
	p5 := Portfolio withId: 'p5'.
	a1 := ReceptiveAccount withId: 'a1'.
	
	p1 add: p2.
	p2 add: p3.
	p3 add: a1.
	p1 add: p4.
	p4 add: p5.
		
	self should: [p5 add: a1.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 16:03:14'!
test20xxx
	
	|p1 p2 p3 p4 a1| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	p3 := Portfolio withId: 'p3'.
	p4 := Portfolio withId: 'p4'.
	a1 := ReceptiveAccount withId: 'a1'.
	
	Deposit register: 100 on: a1.
	p1 add: p2.
	p1 add: p3.
	p4 add: p3.
	p4 add: a1.
	
	p2 add: a1.
		
	self assert: (a1 balance) equals: p4 balance.
	self assert: (a1 balance) equals: p1 balance.		
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 16:04:22'!
test21xxx
	
	|p1 p2 p3 p4 a1| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	p3 := Portfolio withId: 'p3'.
	p4 := Portfolio withId: 'p4'.
	a1 := ReceptiveAccount withId: 'a1'.
	
	Deposit register: 100 on: a1.
	p1 add: p2.
	p1 add: p3.
	p4 add: p2.
	p3 add: a1.
	
	p4 add: p3.
		
	self assert: (a1 balance) equals: p4 balance.
	self assert: (a1 balance) equals: p1 balance.		
	! !



!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'testing' stamp: 'PhG 10/7/2021 20:32:09'!
isDeposit
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'testing' stamp: 'PhG 10/7/2021 20:32:21'!
isDeposit
	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Holding category: 'Portfolio-Ejercicio'!
Object subclass: #Holding
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Holding subclass: #Portfolio
	instanceVariableNames: 'holdings id parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'PhG 10/16/2021 11:30:51'!
isEmpty
	^holdings isEmpty.! !


!Portfolio methodsFor: 'operations' stamp: 'PhG 10/16/2021 14:47:41'!
add: holdingToBeAdded
	
	(self holdingCanBeAdded: holdingToBeAdded) 
		ifFalse: [self error: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].
	
	holdings add: holdingToBeAdded.

	(holdingToBeAdded isKindOf: Portfolio) ifTrue: [ 		holdingToBeAdded addParent: self ].! !

!Portfolio methodsFor: 'operations' stamp: 'PhG 10/16/2021 12:34:51'!
addParent: parentHolding
	
	parents add: parentHolding.! !

!Portfolio methodsFor: 'operations' stamp: 'PhG 10/16/2021 11:30:51'!
balance

	^holdings sum: [:anAccount | anAccount balance] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'initialization' stamp: 'PhG 10/16/2021 11:30:51'!
initialize

	holdings := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'PhG 10/16/2021 12:31:04'!
initializeWith: anId

	holdings := OrderedCollection new.
	parents := OrderedCollection new.
	id := anId! !


!Portfolio methodsFor: 'assertions' stamp: 'PhG 10/16/2021 15:50:33'!
contains: aHoldingToSearch

	self = aHoldingToSearch ifTrue: [^true].
	^holdings anySatisfy: [:holding | holding contains: aHoldingToSearch].! !

!Portfolio methodsFor: 'assertions' stamp: 'PhG 10/16/2021 15:49:58'!
getHoldings
	^holdings! !

!Portfolio methodsFor: 'assertions' stamp: 'PhG 10/16/2021 15:50:42'!
holdingCanBeAdded: holdingToBeAdded
	
	(self holdingIsSelf: holdingToBeAdded) ifTrue: [^false].
	
	(holdingToBeAdded isKindOf: Portfolio ) ifTrue: [
		((holdingToBeAdded getHoldings) allSatisfy: [:holding | self holdingCanBeAdded: holding]) ifFalse: [^false].
	].
	
	(holdings anySatisfy: [:holding | holding contains: holdingToBeAdded ]) ifTrue: [^false].
	
	^parents allSatisfy: [:holdingParent | holdingParent holdingCanBeAdded: holdingToBeAdded forChild: self].! !

!Portfolio methodsFor: 'assertions' stamp: 'PhG 10/16/2021 15:50:51'!
holdingCanBeAdded: holdingToBeAdded forChild: aChildHolding

	|holdingPresentInParentTree holdingPresentInChildren|
	
	(self holdingIsSelf: holdingToBeAdded) ifTrue: [^false].
	
	holdingPresentInParentTree := (parents allSatisfy: [:holdingParent | holdingParent holdingCanBeAdded: holdingToBeAdded forChild: self]) not.
	holdingPresentInParentTree ifTrue: [^false].

	holdingPresentInChildren := holdings anySatisfy: [:holding | holding contains: holdingToBeAdded ].
	holdingPresentInChildren ifTrue: [^false].
	^true.! !

!Portfolio methodsFor: 'assertions' stamp: 'PhG 10/16/2021 14:53:12'!
holdingIsSelf: holdingToBeAdded
	^self = holdingToBeAdded.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'PhG 10/16/2021 15:27:23'!
printOn: aStream
		
	aStream nextPutAll: self class name withArticle, '-', id! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'PhG 10/16/2021 11:32:16'!
portfolioCanNotAddTheSameHoldingMoreThanOnce
	^'You can not add the same holding more than once'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'PhG 10/14/2021 21:39:25'!
portfolioCanNotBeAddedToItselfDescription
	^'You can not add a portfolio to itself'! !


!Portfolio class methodsFor: 'as yet unclassified' stamp: 'PhG 10/16/2021 12:44:14'!
new

	^Portfolio basicNew initializeWith: Time localMillisecondClock.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'PhG 10/16/2021 12:06:06'!
withId: id

	^Portfolio basicNew initializeWith: id.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Holding subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'PhG 10/16/2021 12:22:13'!
initializeWith: anId

	transactions := OrderedCollection new.
	id := anId.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'PhG 10/7/2021 21:04:56'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'PhG 10/7/2021 20:37:47'!
balance

	|totalDeposited totalWithdrawn|

	totalDeposited := self balanceOf: (self depositTransactions).
	totalWithdrawn := self balanceOf: (self withdrawalTransactions).

	^totalDeposited - totalWithdrawn.! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'PhG 10/7/2021 20:37:28'!
balanceOf: someTransactions

	^ someTransactions sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'PhG 10/7/2021 20:34:20'!
depositTransactions

	^ transactions select: [:aTransaction | aTransaction isDeposit]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'PhG 10/7/2021 20:34:35'!
withdrawalTransactions

	^ transactions select: [:aTransaction | aTransaction isDeposit not]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'PhG 10/16/2021 11:41:16'!
contains: aHolding
	^self = aHolding! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'PhG 10/16/2021 15:27:23'!
printOn: aStream
		
	aStream nextPutAll: self class name withArticle, '-', id! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'PhG 10/16/2021 12:44:33'!
new

	^ReceptiveAccount basicNew initializeWith: Time localMillisecondClock.! !

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'PhG 10/16/2021 12:22:32'!
withId: id

	^ReceptiveAccount basicNew initializeWith: id.! !
