!classDefinition: #AccountsTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #AccountsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountsTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := Account new.

	self assert: 0 equals: account balance.
! !

!AccountsTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := Account  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!AccountsTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := Account new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!AccountsTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := Account new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!AccountsTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := Account new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!AccountsTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := Account new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!AccountsTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := Account new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #PortfoliosTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfoliosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/16/2021 12:37:14'!
test01NewPortfolioIsEmtpy
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: true equals: portfolio isEmpty.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test02PortfolioWithAnAccountAddedIsNotEmtpy
	
	|portfolio|
	
	portfolio := self createPortfolioWith: Account new.
	
	self assert: false equals: portfolio isEmpty.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:27:10'!
test03PortfolioWithAPortfolioAddedIsNotEmtpy
	
	|portfolio|
	
	portfolio := self createPortfolioWith: Portfolio new.
	
	self assert: false equals: portfolio isEmpty.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/7/2021 20:59:45'!
test04BalanceOfNewPortfolioIsZero
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:27:41'!
test05BalanceOfPortfolioWithAccountIsAccountBalance
	
	|portfolio account|
	
	account := self createAccountWith: Deposit of: 100.
	portfolio := self createPortfolioWith: account.
	
	self assert: (account balance) equals: portfolio balance.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:28:30'!
test06BalanceOfPortfolioWithPortfolioIsPortfolioBalance
	
	|portfolio childPortfolio|
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 100).
	portfolio := self createPortfolioWith: childPortfolio.
	
	self assert: (childPortfolio balance) equals: portfolio balance.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:20:18'!
test07BalanceOfPortfolioWithManyAccountsIsAddedBalance
	
	|portfolio childPortfolio|
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 100) with: (self createAccountWith: Deposit of: 200).
	portfolio := self createPortfolioWith: childPortfolio.
	
	self assert: 300 equals: portfolio balance.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:19:43'!
test08BalanceOfPortfolioWithManyPortfoliosIsAddedBalance
	
	|portfolio childPortfolio|
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 100).
	portfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 200) with: childPortfolio.
	
	self assert: 300 equals: portfolio balance.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:05:07'!
test09PortfolioCanNotBeAddedToItself
	
	|portfolio|
	
	portfolio := Portfolio new.
	
	self assertAddSameHoldingFailureOnAdding: portfolio to: portfolio.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test10PortfolioCanNotAddTheSameAccountMoreThanOnce
	
	|portfolio anAccount|
	
	anAccount := Account new.
	portfolio := self createPortfolioWith: anAccount.
	
	self assertAddSameHoldingFailureOnAdding: anAccount to: portfolio.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test11PortfolioCanNotAddTheSamePortfolioMoreThanOnce
	
	|portfolio childPortfolio| 
	
	portfolio := Portfolio new.
	childPortfolio := self createPortfolioWith: Account new.
	
	portfolio add: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: childPortfolio to: portfolio.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test12PortfolioCanNotAddAccountPresentInAnInnerPortfolio
	
	|portfolio anAccount childPortfolio| 
	
	anAccount := Account new.
	childPortfolio := Portfolio new.
	childPortfolio add: anAccount.
	portfolio := self createPortfolioWith: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: anAccount to: portfolio.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test13AccountPresentInAListedPortfolioCanNotBeAdded
	
	|rootPortfolio anAccount childPortfolio portfolioWithAccountToBeRejected| 
	
	anAccount := Account withId: 'a1'.
	childPortfolio := self createPortfolioWith: anAccount.
	portfolioWithAccountToBeRejected := self createPortfolioWith: anAccount.
	
	rootPortfolio := self createPortfolioWith: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: portfolioWithAccountToBeRejected to: rootPortfolio.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test14PortfolioCanNotBeAddedMoreThanOnce
	
	|rootPortfolio childPortfolio portfolioToBeAddedTwice| 
	
	portfolioToBeAddedTwice := Portfolio withId: 'p3'.
	
	childPortfolio := self createPortfolioWith: Account new with: portfolioToBeAddedTwice.
	rootPortfolio := self createPortfolioWith: childPortfolio.
		
	self assertAddSameHoldingFailureOnAdding: portfolioToBeAddedTwice to: rootPortfolio.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test15ExistingAccountInRootPortfolioCanNotBeAddedToChildPortfolio
	
	|anAccount childPortfolio| 
	
	childPortfolio := Portfolio withId: 'p2'.
	anAccount := Account withId: 'a1'.
	
	self createPortfolioWith: anAccount with: childPortfolio.
		
	self assertAddSameHoldingFailureOnAdding: anAccount to: childPortfolio.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test16CheckAccountNotPresentInParentsTree
	
	|firstChildPortfolio nestedPortfolio childPortfolioWhereAccountAddingShouldFail anAccount| 
	
	firstChildPortfolio := Portfolio withId: 'p2'.
	nestedPortfolio := Portfolio withId: 'p3'.
	childPortfolioWhereAccountAddingShouldFail := Portfolio withId: 'p4'.
	anAccount := Account withId: 'a2'.
	
	firstChildPortfolio := self createPortfolioWith: nestedPortfolio.
	nestedPortfolio add: anAccount.
	self createPortfolioWith: firstChildPortfolio with: childPortfolioWhereAccountAddingShouldFail.
		
	self assertAddSameHoldingFailureOnAdding: anAccount to: childPortfolioWhereAccountAddingShouldFail.
! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:06:29'!
test17ParentPortfolioCanNotBeChildOfAnotherPortfolio
	
	|rootPortfolio childPortfolio| 
	
	childPortfolio := Portfolio withId: 'p2'.
	
	rootPortfolio := self createPortfolioWith: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: rootPortfolio to: childPortfolio.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 01:09:23'!
test18CheckPortfolioNotPresentInParentsTree
	
	|childPortfolio portfolioToBeAddedTwice childPortfolioWhereAddingShouldBeRejected| 
	
	childPortfolio := Portfolio withId: 'p2'.
	portfolioToBeAddedTwice := Portfolio withId: 'p3'.
	childPortfolioWhereAddingShouldBeRejected := Portfolio withId: 'p4'.
	
	childPortfolio add: portfolioToBeAddedTwice.
	self createPortfolioWith: childPortfolio with: childPortfolioWhereAddingShouldBeRejected.
	
	self assertAddSameHoldingFailureOnAdding: portfolioToBeAddedTwice to: childPortfolioWhereAddingShouldBeRejected.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test19CheckAccountIsNotPresentInHigherParentTree
	
	|portfolioContaingAccount childPortfolioWhereAddingShouldBeRejected anAccountToBeAddedTwice| 
	
	childPortfolioWhereAddingShouldBeRejected := Portfolio withId: 'p5'.
	anAccountToBeAddedTwice := Account withId: 'a1'.
	
	portfolioContaingAccount := self createPortfolioWith: anAccountToBeAddedTwice.
	self createPortfolioWith: (self createPortfolioWith: portfolioContaingAccount) 
		with: (self createPortfolioWith: childPortfolioWhereAddingShouldBeRejected).
	
	self assertAddSameHoldingFailureOnAdding: anAccountToBeAddedTwice to: childPortfolioWhereAddingShouldBeRejected.! !

!PortfoliosTest methodsFor: 'tests' stamp: 'asd 10/17/2021 17:41:56'!
test20DepositsMadeToSharedAccountsShouldCountTowardsEveryParentPortfolioBalance

	|p1 p2 p3 p4 a1| 

	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	p3 := Portfolio withId: 'p3'.
	p4 := Portfolio withId: 'p4'.
	a1 := Account withId: 'a1'.

	p1 add: p2.
	p2 add: a1.
	p1 add: p3.
	
	p4 add: p3.
	p4 add: a1.
	Deposit register: 100 on: a1.

	self assert: (a1 balance) equals: p4 balance.
	self assert: (a1 balance) equals: p1 balance.		
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'asd 10/17/2021 18:10:44'!
test21DepositsMadeToSharedPortfoliosShouldCountTowardsEveryParentPortfolioBalance
	
	|p1 p2 p3 p4 a1| 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	p3 := Portfolio withId: 'p3'.
	p4 := Portfolio withId: 'p4'.
	a1 := Account withId: 'a1'.
	
	p1 add: p2.
	p1 add: p3.
	p4 add: p2.	p4 add: p3.
	p3 add: a1.

	Deposit register: 100 on: a1.		
	self assert: (a1 balance) equals: p4 balance.
	self assert: (a1 balance) equals: p1 balance.		
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test22AccountWithDepositShouldHaveDepositRegistered
	
	|p1 a1 deposit| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := Account withId: 'a1'.
	p1 add: a1.

	deposit _ self deposit100On: a1.

	self assert: (p1 hasRegistered: deposit) equals: true.
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test23AccountWithouADepositShouldNotHaveItRegistered
	
	|p1 a1 p2 a2 deposit1 deposit2| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := Account withId: 'a1'.
	p1 add: a1.

	p2 := Portfolio withId: 'p2'.
	a2 := Account withId: 'a2'.
	p2 add: a2. 	
	deposit1 _ self deposit100On: a1.
	deposit2 _ self deposit100On: a2.

	self assert: (p1 hasRegistered: deposit2) equals: false.
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test24AccountShouldGiveTransactions
	
	|p1 a1| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := Account withId: 'a1'.
	p1 add: a1.


	self deposit100On: a1.

	self assert: (a1 transactions size ) equals: 1.
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'asd 10/17/2021 17:38:14'!
test25DepositsMadeToNestedAccountsShouldBeRegisteredForTheRootPortfolio
	
	|p1 a1 p2 a2 deposit1| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := Account withId: 'a1'.
	p1 add: a1.

	p2 := Portfolio withId: 'p2'.
	a2 := Account withId: 'a2'.
	p2 add: a2. 	
	
	p1 add: p2.
	
	deposit1 _ self deposit100On: a2.

	self assert: (p1 hasRegistered: deposit1) equals: true.
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 10:40:31'!
test26NewPortfolioDoesNotContainTransactions
	
	|p1| 
	
	p1 := Portfolio withId: 'p1'.

	self assert: 0 equals: (p1 numberOfTransactions).
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test27PortfolioWithNewAccountDoesNotContainTransactions
	
	|p1 a1| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := Account withId: 'a1'.
	
	p1 add: a1.

	self assert: 0 equals: (p1 numberOfTransactions ).
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 10:40:53'!
test28PortfolioAccountWithTransactionsAreRegistered
	
	|p1 a1| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := self createAccountWith: Deposit of: 100.
	self withdraw50From: a1.
	p1 add: a1.

	self assert: a1 numberOfTransactions equals: p1 numberOfTransactions.
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 10:41:11'!
test29PortfolioWithTwoAccountsReturnsTransactionsOfBothAccounts
	
	|p1 a1 a2| 
	
	p1 := Portfolio withId: 'p1'.
	a1 := self createAccountWith: Deposit of: 100.
	a2 := self createAccountWith: Withdraw of: 50.
	
	p1 add: a1.
	p1 add: a2.
	self withdraw50From: a1.

	self assert: (a1 numberOfTransactions ) + (a2 numberOfTransactions ) equals: p1 numberOfTransactions .
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 10:41:27'!
test30TransactionsAreCollectedFromAccountsInChildPortfolios
	
	|p1 p2 a1 | 
	
	p1 := Portfolio withId: 'p1'.
	p2 := Portfolio withId: 'p2'.
	a1 := self createAccountWith: Deposit of: 100.
	
	p1 add: a1.
	p2 add: (self createAccountWith: Withdraw of: 50).
	p1 add: p2.
	self withdraw50From: a1.

	self assert: (a1 numberOfTransactions ) + (p2 numberOfTransactions ) equals: p1 numberOfTransactions.
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:21:21'!
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

!PortfoliosTest methodsFor: 'tests' stamp: 'PhG 10/17/2021 00:23:46'!
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

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test33AddingAnAccountFromADifferentTreeShouldNotThrowError
	|p1 p2 p3 p4 a1|
	p1 _ Portfolio withId: 'p1'.
	p2 _ Portfolio withId: 'p2'.
	p3 _ Portfolio withId: 'p3'.
	p4 _ Portfolio withId: 'p4'.
	a1 _ Account withId: 'a1'.
	
	p4 add: a1.
	p4 add: p3.
	p1 add: p3.
	p1 add: p2.
	p2 add: a1.
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test34AddingAnAccountFromADifferentTreeShouldNotThrowError
	|p1 p2 p3 p4 p5 p6 a1 a2 a3|
	p1 _ Portfolio withId: 'p1'.
	p2 _ Portfolio withId: 'p2'.
	p3 _ Portfolio withId: 'p3'.
	p4 _ Portfolio withId: 'p4'.
	p5 _ Portfolio withId: 'p5'.
	p6 _ Portfolio withId: 'p6'.
	a1 _ Account withId: 'a1'.
	a2 _ Account withId: 'a2'.
	a3 _ Account withId: 'a3'.
	
	p3 add: a2.
	p5 add: a3.
	p2 add: a1.
	
	p2 add: p3.
	p4 add: p5.
	p4 add: p6.
	
	p1 add: p2.
	p1 add: p4.
	
	self assertAddSameHoldingFailureOnAdding: a2 to: p6. 
	! !

!PortfoliosTest methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test34AddingAnAccountInAHigherParentShouldThrowError
	|p1 p2 p3 p4 p5 p6 a1 a2 a3|
	p1 _ Portfolio withId: 'p1'.
	p2 _ Portfolio withId: 'p2'.
	p3 _ Portfolio withId: 'p3'.
	p4 _ Portfolio withId: 'p4'.
	p5 _ Portfolio withId: 'p5'.
	p6 _ Portfolio withId: 'p6'.
	a1 _ Account withId: 'a1'.
	a2 _ Account withId: 'a2'.
	a3 _ Account withId: 'a3'.
	
	p3 add: a2.
	p5 add: a3.
	p2 add: a1.
	
	p2 add: p3.
	p4 add: p5.
	p4 add: p6.
	
	p1 add: p2.
	p1 add: p4.
	
	self assertAddSameHoldingFailureOnAdding: a2 to: p6. 
	! !


!PortfoliosTest methodsFor: 'transactions' stamp: 'PhG 10/16/2021 23:41:49'!
deposit100On: anAccount
	^Deposit register: 100 on: anAccount.! !

!PortfoliosTest methodsFor: 'transactions' stamp: 'PhG 10/16/2021 23:41:55'!
deposit200On: anAccount
	^Deposit register: 200 on: anAccount.! !

!PortfoliosTest methodsFor: 'transactions' stamp: 'PhG 10/16/2021 23:45:38'!
withdraw50From: anAccount
	^Withdraw register: 50 on: anAccount.! !


!PortfoliosTest methodsFor: 'assertions' stamp: 'PhG 10/17/2021 01:04:43'!
assertAddSameHoldingFailureOnAdding: aHolding to: aPortfolio

	self should: [aPortfolio add: aHolding]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce ].! !


!PortfoliosTest methodsFor: 'creation' stamp: 'wb 10/17/2021 14:55:03'!
createAccountWith: aTransaction of: anAmount
	|account|
	
	account := Account new.
	aTransaction register: anAmount on: account.
"	self deposit100On: account."
	^account! !

!PortfoliosTest methodsFor: 'creation' stamp: 'PhG 10/17/2021 00:25:35'!
createPortfolioWith: aHolding
	
	|portfolio|
	
	portfolio := Portfolio new.
	portfolio add: aHolding.

	^portfolio.! !

!PortfoliosTest methodsFor: 'creation' stamp: 'PhG 10/17/2021 00:29:27'!
createPortfolioWith: aHolding with: anotherHolding
	
	|portfolio|
	
	portfolio := Portfolio new.
	portfolio add: aHolding.
	portfolio add: anotherHolding.

	^portfolio.! !


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

!Holding methodsFor: 'testing' stamp: 'PhG 10/16/2021 21:43:32'!
hasRegistered: aTransaction
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


!Holding methodsFor: 'assertions' stamp: 'asd 10/17/2021 17:33:49'!
assertAllChildrenCanBeAddedTo: aHolding
	^self subclassResponsibility.! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Holding subclass: #Account
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !

!Account methodsFor: 'initialization' stamp: 'PhG 10/16/2021 12:22:13'!
initializeWith: anId

	transactions := OrderedCollection new.
	id := anId.! !


!Account methodsFor: 'transactions' stamp: 'wb 10/17/2021 10:43:52'!
numberOfTransactions 

	^ self transactions size.! !

!Account methodsFor: 'transactions' stamp: 'PhG 10/7/2021 21:04:56'!
register: aTransaction

	transactions add: aTransaction 
! !

!Account methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!Account methodsFor: 'balance' stamp: 'PhG 10/7/2021 20:37:47'!
balance

	|totalDeposited totalWithdrawn|

	totalDeposited := self balanceOf: (self depositTransactions).
	totalWithdrawn := self balanceOf: (self withdrawalTransactions).

	^totalDeposited - totalWithdrawn.! !

!Account methodsFor: 'balance' stamp: 'wb 10/16/2021 20:46:23'!
balanceOf: someTransactions

	^ someTransactions sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ].! !

!Account methodsFor: 'balance' stamp: 'PhG 10/7/2021 20:34:20'!
depositTransactions

	^ transactions select: [:aTransaction | aTransaction isDeposit]! !

!Account methodsFor: 'balance' stamp: 'PhG 10/7/2021 20:34:35'!
withdrawalTransactions

	^ transactions select: [:aTransaction | aTransaction isDeposit not]! !


!Account methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!Account methodsFor: 'operations' stamp: 'wb 10/16/2021 20:31:49'!
addParent: aHolding
	^nil.! !


!Account methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:57:31'!
assertAllChildrenCanBeAddedTo: aHolding
	^true.! !


!Account methodsFor: 'private' stamp: 'PhG 10/16/2021 11:41:16'!
contains: aHolding
	^self = aHolding! !


!Account methodsFor: 'as yet unclassified' stamp: 'wb 10/17/2021 14:06:15'!
getHoldings
	^OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Ejercicio'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'wb 10/17/2021 14:55:03'!
new

	^Account basicNew initializeWith: Time localMillisecondClock.! !

!Account class methodsFor: 'as yet unclassified' stamp: 'wb 10/17/2021 14:55:03'!
withId: id

	^Account basicNew initializeWith: id.! !


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


!Portfolio methodsFor: 'operations' stamp: 'wb 10/17/2021 14:18:22'!
add: aHolding
	
	self assertCanAdd: aHolding.
	
	holdings add: aHolding.
	
	aHolding addParent: self.! !

!Portfolio methodsFor: 'operations' stamp: 'wb 10/17/2021 14:55:54'!
addParent: aParent
	
	parents add: aParent.! !


!Portfolio methodsFor: 'initialization' stamp: 'PhG 10/16/2021 11:30:51'!
initialize

	holdings := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'PhG 10/16/2021 12:31:04'!
initializeWith: anId

	holdings := OrderedCollection new.
	parents := OrderedCollection new.
	id := anId! !


!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:57:25'!
assertAllChildrenCanBeAddedTo: aHolding
	^(holdings allSatisfy: [:holding | aHolding assertCanAdd: holding])! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:30:29'!
assertAllParentsCanAdd: aHolding
	 ^parents allSatisfy: [:aParent | aParent assertCanAdd: aHolding].! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:15:50'!
assertCanAdd: aHolding

	self assertHoldingIsNotSelf: aHolding.
	
	self assertCanAddAllChildrenOf: aHolding.
	
	self assertNoChildrenContains: aHolding.
	
	^self assertAllParentsCanAdd: aHolding.! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:57:17'!
assertCanAddAllChildrenOf: aHolding
	(aHolding assertAllChildrenCanBeAddedTo: self) ifFalse: [self signalRepeatedHoldingError].! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:56:10'!
assertHoldingIsNotSelf: aHolding

	(self = aHolding) ifTrue: [self signalRepeatedHoldingError ]! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:13:34'!
assertNoChildrenContains: aHolding
	(holdings anySatisfy: [:holding | holding contains: aHolding ]) ifTrue: [self signalRepeatedHoldingError].
! !


!Portfolio methodsFor: 'transactions' stamp: 'wb 10/17/2021 10:29:46'!
numberOfTransactions
	^self transactions size.! !

!Portfolio methodsFor: 'transactions' stamp: 'PhG 10/16/2021 23:26:22'!
transactions
	
	|collectedTransactions|

	collectedTransactions := OrderedCollection new.
	holdings do: [:holding | collectedTransactions addAll: holding transactions].
	^collectedTransactions.! !


!Portfolio methodsFor: 'balance' stamp: 'asd 10/17/2021 16:43:12'!
balance

	^holdings sum: [:aHolding | aHolding balance] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'error signals' stamp: 'wb 10/17/2021 12:59:45'!
signalRepeatedHoldingError

	^ self error: Portfolio portfolioCanNotAddTheSameHoldingMoreThanOnce! !


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


!classDefinition: #Transaction category: 'Portfolio-Ejercicio'!
Object subclass: #Transaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!Transaction methodsFor: 'testing' stamp: 'PhG 10/7/2021 20:32:09'!
isDeposit
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transaction class' category: 'Portfolio-Ejercicio'!
Transaction class
	instanceVariableNames: ''!

!Transaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
Transaction subclass: #Deposit
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
Transaction subclass: #Withdraw
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
