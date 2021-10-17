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

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:26:34'!
test02PortfolioWithAnAccountAddedIsNotEmtpy
	
	|portfolio|
	
	portfolio := self createPortfolioWith: ReceptiveAccount new.
	
	self assert: false equals: portfolio isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:27:10'!
test03PortfolioWithAPortfolioAddedIsNotEmtpy
	
	|portfolio|
	
	portfolio := self createPortfolioWith: Portfolio new.
	
	self assert: false equals: portfolio isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/7/2021 20:59:45'!
test04BalanceOfNewPortfolioIsZero
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:27:41'!
test05BalanceOfPortfolioWithAccountIsAccountBalance
	
	|portfolio account|
	
	account := self createAccountWith: Deposit of: 100.
	portfolio := self createPortfolioWith: account.
	
	self assert: (account balance) equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:28:30'!
test06BalanceOfPortfolioWithPortfolioIsPortfolioBalance
	
	|portfolio childPortfolio|
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 100).
	portfolio := self createPortfolioWith: childPortfolio.
	
	self assert: (childPortfolio balance) equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:20:18'!
test07BalanceOfPortfolioWithManyAccountsIsAddedBalance
	
	|portfolio childPortfolio|
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 100) with: (self createAccountWith: Deposit of: 200).
	portfolio := self createPortfolioWith: childPortfolio.
	
	self assert: 300 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:19:43'!
test08BalanceOfPortfolioWithManyPortfoliosIsAddedBalance
	
	|portfolio childPortfolio|
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 100).
	portfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 200) with: childPortfolio.
	
	self assert: 300 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:05:07'!
test09PortfolioCanNotBeAddedToItself
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	self assertAddSameHoldingFailureOnAdding: portfolio to: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:05:22'!
test10PortfolioCanNotAddTheSameAccountMoreThanOnce
	
	|portfolio anAccount|
	
	anAccount := ReceptiveAccount new.
	portfolio := self createPortfolioWith: anAccount.
	
	self assertAddSameHoldingFailureOnAdding: anAccount to: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:05:35'!
test11PortfolioCanNotAddTheSamePortfolioMoreThanOnce
	
	|portfolio childPortfolio| 
	
	portfolio := Portfolio new.
	childPortfolio := self createPortfolioWith: ReceptiveAccount new.
	
	portfolio add: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: childPortfolio to: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:05:46'!
test12PortfolioCanNotAddAccountPresentInAnInnerPortfolio
	
	|portfolio anAccount childPortfolio| 
	
	anAccount := ReceptiveAccount new.
	childPortfolio := Portfolio new.
	childPortfolio add: anAccount.
	portfolio := self createPortfolioWith: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: anAccount to: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:05:56'!
test13AccountPresentInAListedPortfolioCanNotBeAdded
	
	|rootPortfolio anAccount childPortfolio portfolioWithAccountToBeRejected| 
	
	anAccount := ReceptiveAccount withId: 'a1'.
	childPortfolio := self createPortfolioWith: anAccount.
	portfolioWithAccountToBeRejected := self createPortfolioWith: anAccount.
	
	rootPortfolio := self createPortfolioWith: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: portfolioWithAccountToBeRejected to: rootPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:06:03'!
test14PortfolioCanNotBeAddedMoreThanOnce
	
	|rootPortfolio childPortfolio portfolioToBeAddedTwice| 
	
	portfolioToBeAddedTwice := Portfolio withId: 'p3'.
	
	childPortfolio := self createPortfolioWith: ReceptiveAccount new with: portfolioToBeAddedTwice.
	rootPortfolio := self createPortfolioWith: childPortfolio.
		
	self assertAddSameHoldingFailureOnAdding: portfolioToBeAddedTwice to: rootPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:06:09'!
test15ExistingAccountInRootPortfolioCanNotBeAddedToChildPortfolio
	
	|anAccount childPortfolio| 
	
	childPortfolio := Portfolio withId: 'p2'.
	anAccount := ReceptiveAccount withId: 'a1'.
	
	self createPortfolioWith: anAccount with: childPortfolio.
		
	self assertAddSameHoldingFailureOnAdding: anAccount to: childPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:06:17'!
test16CheckAccountNotPresentInParentsTree
	
	|firstChildPortfolio nestedPortfolio childPortfolioWhereAccountAddingShouldFail anAccount| 
	
	firstChildPortfolio := Portfolio withId: 'p2'.
	nestedPortfolio := Portfolio withId: 'p3'.
	childPortfolioWhereAccountAddingShouldFail := Portfolio withId: 'p4'.
	anAccount := ReceptiveAccount withId: 'a2'.
	
	firstChildPortfolio := self createPortfolioWith: nestedPortfolio.
	nestedPortfolio add: anAccount.
	self createPortfolioWith: firstChildPortfolio with: childPortfolioWhereAccountAddingShouldFail.
		
	self assertAddSameHoldingFailureOnAdding: anAccount to: childPortfolioWhereAccountAddingShouldFail.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:06:29'!
test17ParentPortfolioCanNotBeChildOfAnotherPortfolio
	
	|rootPortfolio childPortfolio| 
	
	childPortfolio := Portfolio withId: 'p2'.
	
	rootPortfolio := self createPortfolioWith: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: rootPortfolio to: childPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:09:23'!
test18CheckPortfolioNotPresentInParentsTree
	
	|childPortfolio portfolioToBeAddedTwice childPortfolioWhereAddingShouldBeRejected| 
	
	childPortfolio := Portfolio withId: 'p2'.
	portfolioToBeAddedTwice := Portfolio withId: 'p3'.
	childPortfolioWhereAddingShouldBeRejected := Portfolio withId: 'p4'.
	
	childPortfolio add: portfolioToBeAddedTwice.
	self createPortfolioWith: childPortfolio with: childPortfolioWhereAddingShouldBeRejected.
	
	self assertAddSameHoldingFailureOnAdding: portfolioToBeAddedTwice to: childPortfolioWhereAddingShouldBeRejected.! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:16:47'!
test19CheckAccountIsNotPresentInHigherParentTree
	
	|portfolioContaingAccount childPortfolioWhereAddingShouldBeRejected anAccountToBeAddedTwice| 
	
	childPortfolioWhereAddingShouldBeRejected := Portfolio withId: 'p5'.
	anAccountToBeAddedTwice := ReceptiveAccount withId: 'a1'.
	
	portfolioContaingAccount := self createPortfolioWith: anAccountToBeAddedTwice.
	self createPortfolioWith: (self createPortfolioWith: portfolioContaingAccount) 
		with: (self createPortfolioWith: childPortfolioWhereAddingShouldBeRejected).
	
	self assertAddSameHoldingFailureOnAdding: anAccountToBeAddedTwice to: childPortfolioWhereAddingShouldBeRejected.! !

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

!PortfolioTest methodsFor: 'tests' stamp: 'wb 10/16/2021 21:07:13'!
test22AccountWithDepositShouldHaveDepositRegistered
	
	|p1 a1 deposit| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := ReceptiveAccount withId: 'a1'.
	p1 add: a1.

	deposit _ self deposit100On: a1.

	self assert: (p1 hasRegistered: deposit) equals: true.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'wb 10/16/2021 21:07:40'!
test23AccountWithouADepositShouldNotHaveItRegistered
	
	|p1 a1 p2 a2 deposit1 deposit2| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := ReceptiveAccount withId: 'a1'.
	p1 add: a1.

	p2 := Portfolio withId: 'p2'.
	a2 := ReceptiveAccount withId: 'a2'.
	p2 add: a2. 	
	deposit1 _ self deposit100On: a1.
	deposit2 _ self deposit100On: a2.

	self assert: (p1 hasRegistered: deposit2) equals: false.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'wb 10/16/2021 21:08:42'!
test24AccountShouldGiveTransactions
	
	|p1 a1| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := ReceptiveAccount withId: 'a1'.
	p1 add: a1.


	self deposit100On: a1.

	self assert: (a1 transactions size ) equals: 1.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 23:44:49'!
test25xxx
	
	|p1 a1 p2 a2 deposit1| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := ReceptiveAccount withId: 'a1'.
	p1 add: a1.

	p2 := Portfolio withId: 'p2'.
	a2 := ReceptiveAccount withId: 'a2'.
	p2 add: a2. 	
	
	p1 add: p2.
	
	deposit1 _ self deposit100On: a2.

	self assert: (p1 hasRegistered: deposit1) equals: true.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 21:39:54'!
test26NewPortfolioDoesNotContainTransactions
	
	|p1| 
	
	p1 := Portfolio withId: 'p1'.

	self assert: OrderedCollection new equals: (p1 transactions).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 22:47:50'!
test27PortfolioWithNewAccountDoesNotContainTransactions
	
	|p1 a1| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := ReceptiveAccount withId: 'a1'.
	
	p1 add: a1.

	self assert: OrderedCollection new equals: (p1 transactions).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:16:56'!
test28PortfolioAccountWithTransactionsAreRegistered
	
	|p1 a1| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := self createAccountWith: Deposit of: 100.
	self withdraw50From: a1.
	p1 add: a1.

	self assert: a1 transactions size equals: p1 transactions size.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:18:26'!
test29PortfolioWithTwoAccountsReturnsTransactionsOfBothAccounts
	
	|p1 a1 a2| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := self createAccountWith: Deposit of: 100.
	a2 := self createAccountWith: Withdraw of: 50.
	
	p1 add: a1.
	p1 add: a2.
	self withdraw50From: a1.

	self assert: (a1 transactions size) + (a2 transactions size) equals: p1 transactions size.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:19:55'!
test30TransactionsAreCollectedFromAccountsInChildPortfolios
	
	|p1 p2 a1 | 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	a1 := self createAccountWith: Deposit of: 100.
	
	p1 add: a1.
	p2 add: (self createAccountWith: Withdraw of: 50).
	p1 add: p2.
	self withdraw50From: a1.

	self assert: (a1 transactions size) + (p2 transactions size) equals: p1 transactions size.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:21:21'!
test31TransactionsAreCollectedFromManyAccountsInChildPortfolios
	
	|p1 p2 p3 a1 a2 a3| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	p3 := Portfolio withId: 'p3'.
	
	a1 := self createAccountWith: Deposit of: 100.
	self withdraw50From: a1.
	a2 := self createAccountWith: Withdraw of: 50.
	a3 := self createAccountWith: Deposit of: 100.
	
	p1 add: a1.
	p2 add: a2.
	p3 add: a3.
	p1 add: p2.
	p1 add: p3.
	
	self assert: (a1 transactions size) + (a2 transactions size) + (a3 transactions size) equals: p1 transactions size.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:23:46'!
test32TransactionsOfChildPortfolioDoNotIncludeSiblingTransactions
	
	|p1 p2 a1| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	a1 := self createAccountWith: Deposit of: 100.
	self withdraw50From: a1.
	
	p1 add: a1.
	p2 add: (self createAccountWith: Withdraw of: 50).
	p1 add: p2.
	
	self deny: (p1 transactions size = p2 transactions size).
	! !


!PortfolioTest methodsFor: 'transactions' stamp: 'PhG 10/16/2021 23:41:49'!
deposit100On: anAccount
	^Deposit register: 100 on: anAccount.! !

!PortfolioTest methodsFor: 'transactions' stamp: 'PhG 10/16/2021 23:41:55'!
deposit200On: anAccount
	^Deposit register: 200 on: anAccount.! !

!PortfolioTest methodsFor: 'transactions' stamp: 'PhG 10/16/2021 23:45:38'!
withdraw50From: anAccount
	^Withdraw register: 50 on: anAccount.! !


!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PhG 10/17/2021 00:11:24'!
createAccountWith: aTransaction of: anAmount
	|account|
	
	account := ReceptiveAccount new.
	aTransaction register: anAmount on: account.
"	self deposit100On: account."
	^account! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PhG 10/17/2021 00:25:35'!
createPortfolioWith: aHolding
	
	|portfolio|
	
	portfolio := Portfolio new.
	portfolio add: aHolding.

	^portfolio.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PhG 10/17/2021 00:29:27'!
createPortfolioWith: aHolding with: anotherHolding
	
	|portfolio|
	
	portfolio := Portfolio new.
	portfolio add: aHolding.
	portfolio add: anotherHolding.

	^portfolio.! !


!PortfolioTest methodsFor: 'assertions' stamp: 'PhG 10/17/2021 01:04:43'!
assertAddSameHoldingFailureOnAdding: aHolding to: aPortfolio

	self should: [aPortfolio add: aHolding]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'assertions' stamp: 'PhG 10/17/2021 00:35:58'!
assertAdding: anAction failsWithDescription: errorDescription

	self should: anAction
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'assertions' stamp: 'PhG 10/17/2021 00:36:31'!
assertAdding: aHolding to: aPortfolio failsWithDescription: errorDescription

	self should: [aPortfolio add: aHolding]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !

!PortfolioTest methodsFor: 'assertions' stamp: 'PhG 10/17/2021 00:34:22'!
assertPortfolio: aPortfolio on: anAction failsWithDescription: errorDescription

	self should: anAction
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !


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
	instanceVariableNames: 'id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Holding methodsFor: 'operations' stamp: 'wb 10/16/2021 20:44:27'!
addParent: aHolding
	self subclassResponsibility .! !


!Holding methodsFor: 'transactions' stamp: 'PhG 10/16/2021 21:41:30'!
transactions
	self subclassResponsibility .! !


!Holding methodsFor: 'balance' stamp: 'PhG 10/16/2021 21:42:46'!
balance
	self subclassResponsibility .! !


!Holding methodsFor: 'testing' stamp: 'wb 10/16/2021 20:49:45'!
contains: aHolding
	self subclassResponsibility .! !


!Holding methodsFor: 'initialization' stamp: 'wb 10/16/2021 20:58:44'!
initialize
	self subclassResponsibility .! !

!Holding methodsFor: 'initialization' stamp: 'wb 10/16/2021 20:59:11'!
initializeWith: anId
	self subclassResponsibility .! !


!Holding methodsFor: 'debugging' stamp: 'wb 10/16/2021 21:02:12'!
printOn: aStream
		
	aStream nextPutAll: self class name withArticle, '-', id.! !


!Holding methodsFor: 'testing' stamp: 'PhG 10/16/2021 21:43:32'!
hasRegistered: aTransaction
	self subclassResponsibility .! !



!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Holding subclass: #Portfolio
	instanceVariableNames: 'holdings parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'wb 10/16/2021 20:34:20'!
hasRegistered: aTransaction

	^ holdings anySatisfy: [:aHolding| aHolding hasRegistered: aTransaction].
! !

!Portfolio methodsFor: 'testing' stamp: 'PhG 10/16/2021 11:30:51'!
isEmpty
	^holdings isEmpty.! !


!Portfolio methodsFor: 'operations' stamp: 'wb 10/16/2021 20:31:19'!
add: holdingToBeAdded
	
	(self holdingCanBeAdded: holdingToBeAdded) 
		ifFalse: [self error: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].
	
	holdings add: holdingToBeAdded.
	
	holdingToBeAdded addParent: self.! !

!Portfolio methodsFor: 'operations' stamp: 'PhG 10/16/2021 12:34:51'!
addParent: parentHolding
	
	parents add: parentHolding.! !


!Portfolio methodsFor: 'initialization' stamp: 'PhG 10/16/2021 11:30:51'!
initialize

	holdings := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'PhG 10/16/2021 12:31:04'!
initializeWith: anId

	holdings := OrderedCollection new.
	parents := OrderedCollection new.
	id := anId! !


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


!Portfolio methodsFor: 'transactions' stamp: 'PhG 10/16/2021 23:26:22'!
transactions
	
	|collectedTransactions|

	collectedTransactions := OrderedCollection new.
	holdings do: [:holding | collectedTransactions addAll: holding transactions].
	^collectedTransactions.! !


!Portfolio methodsFor: 'balance' stamp: 'PhG 10/16/2021 11:30:51'!
balance

	^holdings sum: [:anAccount | anAccount balance] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'private' stamp: 'PhG 10/16/2021 15:50:33'!
contains: aHoldingToSearch

	self = aHoldingToSearch ifTrue: [^true].
	^holdings anySatisfy: [:holding | holding contains: aHoldingToSearch].! !

!Portfolio methodsFor: 'private' stamp: 'PhG 10/16/2021 15:49:58'!
getHoldings
	^holdings! !

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
	instanceVariableNames: 'transactions'
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

!ReceptiveAccount methodsFor: 'balance' stamp: 'wb 10/16/2021 20:46:23'!
balanceOf: someTransactions

	^ someTransactions sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ].! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'PhG 10/7/2021 20:34:20'!
depositTransactions

	^ transactions select: [:aTransaction | aTransaction isDeposit]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'PhG 10/7/2021 20:34:35'!
withdrawalTransactions

	^ transactions select: [:aTransaction | aTransaction isDeposit not]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'PhG 10/16/2021 11:41:16'!
contains: aHolding
	^self = aHolding! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'wb 10/16/2021 20:31:49'!
addParent: aHolding
	^nil.! !


!ReceptiveAccount methodsFor: 'private' stamp: 'PhG 10/16/2021 11:41:16'!
contains: aHolding
	^self = aHolding! !

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
