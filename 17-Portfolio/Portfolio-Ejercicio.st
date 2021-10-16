!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/7/2021 20:41:57'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/14/2021 21:37:54'!
test09PortfolioCanNotBeAddedToItself
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	self should: [portfolio add: portfolio]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotBeAddedToItselfDescription ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 09:52:10'!
test10PortfolioCanNotAddTheSameAccountMoreThanOnce
	
	|portfolio anAccount|
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	portfolio add: anAccount .
	
	self should: [portfolio add: anAccount]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSamePositionMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 09:51:10'!
test11PortfolioCanNotAddTheSamePortfolioMoreThanOnce
	
	|portfolio anAccount innerPortfolio| 
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	innerPortfolio := Portfolio new.
	
	innerPortfolio add: anAccount.
	portfolio add: innerPortfolio.
		
	self should: [portfolio add: innerPortfolio]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSamePositionMoreThanOnce ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 09:53:35'!
test12PortfolioCanNotAddAccountPresentInAListedPortfolio
	
	|portfolio anAccount innerPortfolio| 
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	innerPortfolio := Portfolio new.
	
	innerPortfolio add: anAccount.
	portfolio add: innerPortfolio.
		
	self should: [portfolio add: innerPortfolio]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSamePositionMoreThanOnce ].! !



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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'positions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'PhG 10/7/2021 21:16:25'!
isEmpty
	^positions isEmpty.! !

!Portfolio methodsFor: 'testing' stamp: 'PhG 10/15/2021 18:57:49'!
isEqualTo: anAccount
	^self = anAccount.! !


!Portfolio methodsFor: 'operations' stamp: 'PhG 10/15/2021 19:40:48'!
add: positionToBeAdded
	
	self assertPositionCanBeAdded: positionToBeAdded .
	
	positions add: positionToBeAdded .! !

!Portfolio methodsFor: 'operations' stamp: 'PhG 10/7/2021 21:23:25'!
balance

	^positions sum: [:anAccount | anAccount balance] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'initialization' stamp: 'PhG 10/7/2021 21:21:21'!
initialize

	positions := OrderedCollection new.! !


!Portfolio methodsFor: 'assertions' stamp: 'PhG 10/15/2021 19:55:27'!
assertDoesNotContainPosition: positionToBeAdded

	self assertPositionCanBeAdded: positionToBeAdded.! !

!Portfolio methodsFor: 'assertions' stamp: 'PhG 10/16/2021 09:51:33'!
assertPositionCanBeAdded: positionToBeAdded
	
	self assertPositionIsNotSelf: positionToBeAdded.
	self assertPositionHasNotYetBeenAdded: positionToBeAdded.
	
	"assert position is not present in any subtree"
	"(positions do: [:position| position assertDoesNotContainPosition: positionToBeAdded]) ifTrue: [self error: Portfolio portfolioCanNotAddTheSameAccountMoreThanOnce ]"! !

!Portfolio methodsFor: 'assertions' stamp: 'PhG 10/16/2021 09:52:10'!
assertPositionHasNotYetBeenAdded: positionToBeAdded

	(positions anySatisfy: [:position| position = positionToBeAdded]) ifTrue: [self error: Portfolio portfolioCanNotAddTheSamePositionMoreThanOnce ]! !

!Portfolio methodsFor: 'assertions' stamp: 'PhG 10/15/2021 19:39:36'!
assertPositionIsNotSelf: positionToBeAdded
	self = positionToBeAdded ifTrue: [self error: Portfolio portfolioCanNotBeAddedToItselfDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'PhG 10/16/2021 09:52:14'!
portfolioCanNotAddTheSamePositionMoreThanOnce
	^'You can not add the same position more than once'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'PhG 10/14/2021 21:39:25'!
portfolioCanNotBeAddedToItselfDescription
	^'You can not add a portfolio to itself'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


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


!ReceptiveAccount methodsFor: 'testing' stamp: 'PhG 10/15/2021 19:54:25'!
assertDoesNotContainPosition: positionToBeAdded
	^true! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'PhG 10/15/2021 15:57:47'!
isEqualTo: anAccount
	^self = anAccount.! !
