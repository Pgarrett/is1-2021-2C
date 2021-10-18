!classDefinition: #AccountTests category: 'Portfolio-Ejercicio'!
TestCase subclass: #AccountTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTests methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := Account new.

	self assert: 0 equals: account balance.
! !

!AccountTests methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := Account  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!AccountTests methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := Account new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!AccountTests methodsFor: 'tests' stamp: 'wb 10/17/2021 22:27:12'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := Account new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value.
! !

!AccountTests methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := Account new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!AccountTests methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := Account new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!AccountTests methodsFor: 'tests' stamp: 'wb 10/17/2021 14:55:03'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := Account new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!AccountTests methodsFor: 'tests' stamp: 'wb 10/17/2021 22:31:28'!
test08AccountKnowsItsTransactions 

	| account1 |
	
	account1 := Account new.
	
	Deposit register: 50 on: account1.
	Withdraw register: 100 on: account1.
		
	self assert: 2 equals: account1 numberOfTransactions .
	self assert: -50 equals: account1 balance.
! !


!classDefinition: #PortfolioTests category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTests methodsFor: 'assertions' stamp: 'wb 10/17/2021 22:07:38'!
assertAddSameHoldingFailureOnAdding: aHolding to: aPortfolio

	self should: [aPortfolio add: aHolding]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio repeatedHoldingError ].! !


!PortfolioTests methodsFor: 'creation helpers' stamp: 'PhG 10/17/2021 19:37:44'!
createAccountWith: aTransaction of: anAmount
	|account|
	
	account := Account new.
	aTransaction register: anAmount on: account.
	
	^account! !

!PortfolioTests methodsFor: 'creation helpers' stamp: 'PhG 10/17/2021 19:38:58'!
createEmptyAccount
	
	^Account new.! !

!PortfolioTests methodsFor: 'creation helpers' stamp: 'PhG 10/17/2021 19:38:43'!
createEmptyPortfolio
	
	^Portfolio new.! !

!PortfolioTests methodsFor: 'creation helpers' stamp: 'PhG 10/17/2021 19:37:26'!
createPortfolioWith: aHolding
	
	|portfolio|
	
	portfolio := Portfolio new.
	portfolio add: aHolding.

	^portfolio.! !

!PortfolioTests methodsFor: 'creation helpers' stamp: 'PhG 10/17/2021 19:38:05'!
createPortfolioWith: aHolding with: anotherHolding
	
	|portfolio|
	
	portfolio := Portfolio new.
	portfolio add: aHolding.
	portfolio add: anotherHolding.

	^portfolio.! !


!PortfolioTests methodsFor: 'transactions helpers' stamp: 'PhG 10/17/2021 19:38:10'!
deposit100On: anAccount
	^Deposit register: 100 on: anAccount.! !

!PortfolioTests methodsFor: 'transactions helpers' stamp: 'PhG 10/17/2021 19:38:14'!
withdraw50From: anAccount
	^Withdraw register: 50 on: anAccount.! !


!PortfolioTests methodsFor: 'creation tests' stamp: 'PhG 10/17/2021 19:39:12'!
test01NewPortfolioIsEmtpy

	|portfolio|
	
	portfolio := self createEmptyPortfolio.
	
	self assert: true equals: portfolio isEmpty.! !

!PortfolioTests methodsFor: 'creation tests' stamp: 'PhG 10/17/2021 19:39:28'!
test02PortfolioWithAnAccountAddedIsNotEmtpy
	
	|portfolio|
	
	portfolio := self createPortfolioWith: (self createEmptyAccount).
	
	self assert: false equals: portfolio isEmpty.! !

!PortfolioTests methodsFor: 'creation tests' stamp: 'PhG 10/17/2021 19:39:38'!
test03PortfolioWithAPortfolioAddedIsNotEmtpy
	
	|portfolio|
	
	portfolio := self createPortfolioWith: (self createEmptyPortfolio).
	
	self assert: false equals: portfolio isEmpty.! !


!PortfolioTests methodsFor: 'balance tests' stamp: 'PhG 10/17/2021 19:39:44'!
test04BalanceOfNewPortfolioIsZero
	
	|portfolio|
	
	portfolio := self createEmptyPortfolio.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTests methodsFor: 'balance tests' stamp: 'PhG 10/17/2021 18:35:08'!
test05BalanceOfPortfolioWithAccountIsAccountBalance
	
	|portfolio account|
	
	account := self createAccountWith: Deposit of: 100.
	portfolio := self createPortfolioWith: account.
	
	self assert: (account balance) equals: portfolio balance.! !

!PortfolioTests methodsFor: 'balance tests' stamp: 'PhG 10/17/2021 18:35:20'!
test06BalanceOfPortfolioWithPortfolioIsPortfolioBalance
	
	|portfolio childPortfolio|
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 100).
	portfolio := self createPortfolioWith: childPortfolio.
	
	self assert: (childPortfolio balance) equals: portfolio balance.! !

!PortfolioTests methodsFor: 'balance tests' stamp: 'PhG 10/17/2021 18:35:31'!
test07BalanceOfPortfolioWithManyAccountsIsAddedBalance
	
	|portfolio childPortfolio|
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 100) with: (self createAccountWith: Deposit of: 200).
	portfolio := self createPortfolioWith: childPortfolio.
	
	self assert: 300 equals: portfolio balance.! !

!PortfolioTests methodsFor: 'balance tests' stamp: 'PhG 10/17/2021 18:35:42'!
test08BalanceOfPortfolioWithManyPortfoliosIsAddedBalance
	
	|portfolio childPortfolio|
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 100).
	portfolio := self createPortfolioWith: (self createAccountWith: Deposit of: 200) with: childPortfolio.
	
	self assert: 300 equals: portfolio balance.! !

!PortfolioTests methodsFor: 'balance tests' stamp: 'PhG 10/17/2021 19:43:41'!
test20DepositsMadeToSharedAccountsShouldCountTowardsEveryParentPortfolioBalance

	|treeARootPortfolio treeBRootPortfolio sharedAccount| 

	sharedAccount := self createEmptyAccount.

	treeARootPortfolio := self createPortfolioWith: (self createPortfolioWith: sharedAccount).
	
	treeBRootPortfolio := self createPortfolioWith: sharedAccount.
	self deposit100On: sharedAccount.

	self assert: (sharedAccount balance) equals: treeBRootPortfolio balance.
	self assert: (sharedAccount balance) equals: treeARootPortfolio balance.		
	! !

!PortfolioTests methodsFor: 'balance tests' stamp: 'PhG 10/17/2021 19:43:37'!
test21DepositsMadeToSharedPortfoliosShouldCountTowardsEveryParentPortfolioBalance
	
	|treeARootPortfolio sharedPortfolio treeBRootPortfolio sharedAccount| 
	
	sharedPortfolio := self createEmptyPortfolio.
	sharedAccount := self createEmptyAccount.
	
	treeARootPortfolio := self createPortfolioWith: sharedPortfolio.
	treeBRootPortfolio := self createPortfolioWith: sharedPortfolio.
	sharedPortfolio add: sharedAccount.

	self deposit100On: sharedAccount.
	self assert: (sharedAccount balance) equals: treeBRootPortfolio balance.
	self assert: (sharedAccount balance) equals: treeARootPortfolio balance.		
	! !


!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:39:59'!
test09PortfolioCanNotBeAddedToItself
	
	|portfolio|
	
	portfolio := self createEmptyPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: portfolio to: portfolio.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:40:08'!
test10PortfolioCanNotAddTheSameAccountMoreThanOnce
	
	|portfolio anAccount|
	
	anAccount := self createEmptyAccount.
	portfolio := self createPortfolioWith: anAccount.
	
	self assertAddSameHoldingFailureOnAdding: anAccount to: portfolio.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:40:23'!
test11PortfolioCanNotAddTheSamePortfolioMoreThanOnce
	
	|portfolio childPortfolio| 
	
	portfolio := self createEmptyPortfolio.
	childPortfolio := self createPortfolioWith: self createEmptyAccount.
	
	portfolio add: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: childPortfolio to: portfolio.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:40:35'!
test12PortfolioCanNotAddAccountPresentInAnInnerPortfolio
	
	|portfolio anAccount childPortfolio| 
	
	anAccount := self createEmptyAccount.
	childPortfolio := self createEmptyPortfolio.
	childPortfolio add: anAccount.
	portfolio := self createPortfolioWith: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: anAccount to: portfolio.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:40:45'!
test13AccountPresentInAListedPortfolioCanNotBeAdded
	
	|rootPortfolio anAccount childPortfolio portfolioWithAccountToBeRejected| 
	
	anAccount := self createEmptyAccount.
	childPortfolio := self createPortfolioWith: anAccount.
	portfolioWithAccountToBeRejected := self createPortfolioWith: anAccount.
	
	rootPortfolio := self createPortfolioWith: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: portfolioWithAccountToBeRejected to: rootPortfolio.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:41:04'!
test14PortfolioCanNotBeAddedMoreThanOnce
	
	|rootPortfolio childPortfolio portfolioToBeAddedTwice| 
	
	portfolioToBeAddedTwice := self createEmptyPortfolio.
	
	childPortfolio := self createPortfolioWith: (self createEmptyAccount) with: portfolioToBeAddedTwice.
	rootPortfolio := self createPortfolioWith: childPortfolio.
		
	self assertAddSameHoldingFailureOnAdding: portfolioToBeAddedTwice to: rootPortfolio.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:44:00'!
test15ExistingAccountInRootPortfolioCanNotBeAddedToChildPortfolio
	
	|anAccount childPortfolio| 
	
	childPortfolio := self createEmptyPortfolio.
	anAccount := self createEmptyAccount.
	
	self createPortfolioWith: anAccount with: childPortfolio.
		
	self assertAddSameHoldingFailureOnAdding: anAccount to: childPortfolio.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:43:55'!
test16CheckAccountNotPresentInParentsTree
	
	|firstChildPortfolio nestedPortfolio childPortfolioWhereAccountAddingShouldFail anAccount| 
	
	firstChildPortfolio := self createEmptyPortfolio.
	nestedPortfolio := self createEmptyPortfolio.
	childPortfolioWhereAccountAddingShouldFail := self createEmptyPortfolio.
	anAccount := self createEmptyAccount.
	
	firstChildPortfolio := self createPortfolioWith: nestedPortfolio.
	nestedPortfolio add: anAccount.
	self createPortfolioWith: firstChildPortfolio with: childPortfolioWhereAccountAddingShouldFail.
		
	self assertAddSameHoldingFailureOnAdding: anAccount to: childPortfolioWhereAccountAddingShouldFail.
! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:41:29'!
test17ParentPortfolioCanNotBeChildOfAnotherPortfolio
	
	|rootPortfolio childPortfolio| 
	
	childPortfolio := self createEmptyPortfolio.
	rootPortfolio := self createPortfolioWith: childPortfolio.
	
	self assertAddSameHoldingFailureOnAdding: rootPortfolio to: childPortfolio.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:41:41'!
test18CheckPortfolioNotPresentInParentsTree
	
	|childPortfolio portfolioToBeAddedTwice childPortfolioWhereAddingShouldBeRejected| 
	
	childPortfolio := self createEmptyPortfolio.
	portfolioToBeAddedTwice := self createEmptyPortfolio.
	childPortfolioWhereAddingShouldBeRejected := self createEmptyPortfolio.
	
	childPortfolio add: portfolioToBeAddedTwice.
	self createPortfolioWith: childPortfolio with: childPortfolioWhereAddingShouldBeRejected.
	
	self assertAddSameHoldingFailureOnAdding: portfolioToBeAddedTwice to: childPortfolioWhereAddingShouldBeRejected.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:43:46'!
test19CheckAccountIsNotPresentInHigherParentTree
	
	|portfolioContaingAccount childPortfolioWhereAddingShouldBeRejected anAccountToBeAddedTwice| 
	
	childPortfolioWhereAddingShouldBeRejected := self createEmptyPortfolio.
	anAccountToBeAddedTwice := self createEmptyAccount.
	
	portfolioContaingAccount := self createPortfolioWith: anAccountToBeAddedTwice.
	self createPortfolioWith: (self createPortfolioWith: portfolioContaingAccount) 
		with: (self createPortfolioWith: childPortfolioWhereAddingShouldBeRejected).
	
	self assertAddSameHoldingFailureOnAdding: anAccountToBeAddedTwice to: childPortfolioWhereAddingShouldBeRejected.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 19:52:04'!
test32AddingAnAccountFromADifferentTreeShouldNotThrowError
	|treeARootPortfolio treeAChildPortfolio treeBRootPortfolio accountToBeShared|

	treeAChildPortfolio := self createEmptyPortfolio.
	accountToBeShared _ self createEmptyAccount.
	
	treeBRootPortfolio := self createPortfolioWith: accountToBeShared.
	treeARootPortfolio := self createPortfolioWith: treeAChildPortfolio.
	
	self shouldnt: [treeAChildPortfolio add: accountToBeShared]		raise: Error.! !

!PortfolioTests methodsFor: 'invalid addition tests' stamp: 'PhG 10/17/2021 20:17:15'!
test33AddingAnAccountInAHigherParentShouldThrowError
	|rootPortfolio childPortfolioA childPortfolioB portfolioWhereAccountAddingShouldFail accountToAttemptAddTwice |

	rootPortfolio := self createEmptyPortfolio.
	childPortfolioB := self createEmptyPortfolio.
	portfolioWhereAccountAddingShouldFail := self createEmptyPortfolio.
	accountToAttemptAddTwice := self createEmptyAccount.
	
	childPortfolioA := self createPortfolioWith: (self createEmptyAccount).
	
	childPortfolioA add: (self createPortfolioWith: accountToAttemptAddTwice).
	childPortfolioB add: (self createPortfolioWith: self createEmptyAccount).
	childPortfolioB add: portfolioWhereAccountAddingShouldFail.
	
	rootPortfolio add: childPortfolioA.
	rootPortfolio add: childPortfolioB.
	
	self assertAddSameHoldingFailureOnAdding: accountToAttemptAddTwice to: portfolioWhereAccountAddingShouldFail. 
	! !


!PortfolioTests methodsFor: 'transactions tests' stamp: 'PhG 10/17/2021 19:43:31'!
test22AccountWithDepositShouldHaveDepositRegistered
	
	|portfolio accountToRegisterDeposit deposit| 
	
	accountToRegisterDeposit := self createEmptyAccount.
	portfolio := self createPortfolioWith: accountToRegisterDeposit.

	deposit _ self deposit100On: accountToRegisterDeposit.

	self assert: (portfolio hasRegistered: deposit) equals: true.
	! !

!PortfolioTests methodsFor: 'transactions tests' stamp: 'PhG 10/17/2021 19:43:24'!
test23AccountWithouADepositShouldNotHaveItRegistered
	
	|treeAPortfolio treeAAccount treeBPortfolio treeBAccount deposit1 deposit2| 
	
	treeAAccount := self createEmptyAccount.
	treeAPortfolio := self createPortfolioWith: treeAAccount.
	treeBAccount := self createEmptyAccount.
	treeBPortfolio := self createPortfolioWith: treeBAccount. 	

	deposit1 _ self deposit100On: treeAAccount.
	deposit2 _ self deposit100On: treeBAccount.

	self assert: (treeAPortfolio hasRegistered: deposit2) equals: false.
	self assert: (treeBPortfolio hasRegistered: deposit1) equals: false.
	! !

!PortfolioTests methodsFor: 'transactions tests' stamp: 'PhG 10/17/2021 19:43:14'!
test24DepositsMadeToNestedAccountsShouldBeRegisteredForTheRootPortfolio
	
	|rootPortfolio childPortfolio account deposit| 
	
	account := self createEmptyAccount.
	childPortfolio := self createPortfolioWith: account. 	
	
	rootPortfolio := self createPortfolioWith: childPortfolio.
	
	deposit _ self deposit100On: account.

	self assert: (rootPortfolio hasRegistered: deposit) equals: true.
	! !

!PortfolioTests methodsFor: 'transactions tests' stamp: 'wb 10/17/2021 22:26:38'!
test25NewPortfolioDoesNotContainTransactions
	
	|portfolio| 
	
	portfolio := self createEmptyPortfolio.

	self assert: 0 equals: (portfolio numberOfTransactions).
	! !

!PortfolioTests methodsFor: 'transactions tests' stamp: 'wb 10/17/2021 22:26:38'!
test26PortfolioWithNewAccountDoesNotContainTransactions
	
	|portfolio| 
	
	portfolio := self createPortfolioWith: (self createEmptyAccount).

	self assert: 0 equals: (portfolio numberOfTransactions).
	! !

!PortfolioTests methodsFor: 'transactions tests' stamp: 'wb 10/17/2021 22:26:38'!
test27PortfolioAccountWithTransactionsAreRegistered
	
	|portfolio account| 
	
	portfolio := self createEmptyPortfolio.
	account := self createAccountWith: Deposit of: 100.

	self withdraw50From: account.
	portfolio add: account.

	self assert: account numberOfTransactions equals: portfolio numberOfTransactions.	! !

!PortfolioTests methodsFor: 'transactions tests' stamp: 'wb 10/17/2021 22:26:38'!
test28PortfolioWithTwoAccountsReturnsTransactionsOfBothAccounts
	
	|portfolio twoTransactionsAccount oneTransactionAccount| 
	
	twoTransactionsAccount := self createAccountWith: Deposit of: 100.
	oneTransactionAccount := self createAccountWith: Withdraw of: 50.
	
	portfolio := self createPortfolioWith: twoTransactionsAccount with: oneTransactionAccount.
	self withdraw50From: twoTransactionsAccount.

	self assert: (twoTransactionsAccount numberOfTransactions) + (oneTransactionAccount numberOfTransactions) equals: portfolio numberOfTransactions.
	! !

!PortfolioTests methodsFor: 'transactions tests' stamp: 'wb 10/17/2021 22:26:38'!
test29TransactionsAreCollectedFromAccountsInChildPortfolios
	
	|rootPortfolio childPortfolio accountWithTwoTransactions | 
	
	childPortfolio := self createEmptyPortfolio.
	accountWithTwoTransactions := self createAccountWith: Deposit of: 100.
	
	rootPortfolio := self createPortfolioWith: accountWithTwoTransactions.
	childPortfolio add: (self createAccountWith: Withdraw of: 50).
	rootPortfolio add: childPortfolio.
	self withdraw50From: accountWithTwoTransactions.

	self assert: (accountWithTwoTransactions numberOfTransactions) + (childPortfolio numberOfTransactions) equals: rootPortfolio numberOfTransactions.
	! !

!PortfolioTests methodsFor: 'transactions tests' stamp: 'wb 10/17/2021 22:26:38'!
test30TransactionsAreCollectedFromManyAccountsInChildPortfolios
	
	|rootPortfolio accountWithTwoTransactions accountWithAWithdraw accountWithOneDeposit| 
	
	accountWithTwoTransactions := self createAccountWith: Deposit of: 100.
	self withdraw50From: accountWithTwoTransactions.
	accountWithAWithdraw := self createAccountWith: Withdraw of: 50.
	accountWithOneDeposit := self createAccountWith: Deposit of: 100.
	
	rootPortfolio := self createPortfolioWith: accountWithTwoTransactions.
	rootPortfolio add: (self createPortfolioWith: accountWithAWithdraw).
	rootPortfolio add: (self createPortfolioWith: accountWithOneDeposit).
	
	self assert: (accountWithTwoTransactions numberOfTransactions) + (accountWithAWithdraw numberOfTransactions) + (accountWithOneDeposit numberOfTransactions) equals: rootPortfolio numberOfTransactions.
	! !

!PortfolioTests methodsFor: 'transactions tests' stamp: 'wb 10/17/2021 22:26:38'!
test31TransactionsOfChildPortfolioDoNotIncludeSiblingTransactions
	
	|rootPortfolio childPortfolio firstLevelAccount| 
	
	firstLevelAccount := self createAccountWith: Deposit of: 100.
	self withdraw50From: firstLevelAccount.
	rootPortfolio := self createPortfolioWith: firstLevelAccount.
	
	childPortfolio := self createPortfolioWith: (self createAccountWith: Withdraw of: 50).
	rootPortfolio add: childPortfolio.
	
	self deny: (rootPortfolio numberOfTransactions = childPortfolio numberOfTransactions).! !


!classDefinition: #Holding category: 'Portfolio-Ejercicio'!
Object subclass: #Holding
	instanceVariableNames: ''
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


!Account methodsFor: 'transactions' stamp: 'wb 10/17/2021 21:53:28'!
depositTransactions

	^ transactions select: [:aTransaction | aTransaction isDeposit].! !

!Account methodsFor: 'transactions' stamp: 'wb 10/17/2021 22:26:38'!
numberOfTransactions 

	^ transactions size.! !

!Account methodsFor: 'transactions' stamp: 'wb 10/17/2021 21:54:01'!
register: aTransaction

	transactions add: aTransaction.! !

!Account methodsFor: 'transactions' stamp: 'wb 10/17/2021 21:54:10'!
transactions 

	^ transactions copy.! !

!Account methodsFor: 'transactions' stamp: 'wb 10/17/2021 21:54:17'!
withdrawalTransactions

	^ transactions select: [:aTransaction | aTransaction isDeposit not].! !


!Account methodsFor: 'balance' stamp: 'wb 10/17/2021 22:43:17'!
balance

	|totalDeposited totalWithdrawn|
	totalDeposited := self balanceOf: (self depositTransactions).
	totalWithdrawn := self balanceOf: (self withdrawalTransactions).

	^totalDeposited - totalWithdrawn.! !

!Account methodsFor: 'balance' stamp: 'wb 10/16/2021 20:46:23'!
balanceOf: someTransactions

	^ someTransactions sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ].! !


!Account methodsFor: 'testing' stamp: 'wb 10/17/2021 21:53:44'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction.
! !


!Account methodsFor: 'operations' stamp: 'wb 10/16/2021 20:31:49'!
addParent: aHolding
	^nil.! !


!Account methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:57:31'!
assertAllChildrenCanBeAddedTo: aHolding
	^true.! !


!Account methodsFor: 'private' stamp: 'wb 10/17/2021 21:53:20'!
contains: aHolding
	^self = aHolding.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Holding subclass: #Portfolio
	instanceVariableNames: 'holdings parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'wb 10/17/2021 22:16:50'!
anyChildContains: aHolding
	^(holdings anySatisfy: [:childHolding | childHolding contains: aHolding ]).! !

!Portfolio methodsFor: 'testing' stamp: 'wb 10/17/2021 22:24:17'!
hasRegistered: aTransaction

	^ (holdings anySatisfy: [:aHolding| aHolding hasRegistered: aTransaction]).
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


!Portfolio methodsFor: 'initialization' stamp: 'PhG 10/17/2021 18:24:58'!
initialize

	holdings := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 22:13:47'!
assertAllChildrenCanBeAddedTo: aHolding
	^(holdings allSatisfy: [:childHolding | aHolding assertCanAdd: childHolding]).! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 22:13:55'!
assertAllParentsCanAdd: aHolding
	 ^(parents allSatisfy: [:aParent | aParent assertCanAdd: aHolding]).! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:15:50'!
assertCanAdd: aHolding

	self assertHoldingIsNotSelf: aHolding.
	
	self assertCanAddAllChildrenOf: aHolding.
	
	self assertNoChildrenContains: aHolding.
	
	^self assertAllParentsCanAdd: aHolding.! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 14:57:17'!
assertCanAddAllChildrenOf: aHolding
	(aHolding assertAllChildrenCanBeAddedTo: self) ifFalse: [self signalRepeatedHoldingError].! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 21:51:18'!
assertHoldingIsNotSelf: aHolding

	(self = aHolding) ifTrue: [self signalRepeatedHoldingError ].! !

!Portfolio methodsFor: 'assertions' stamp: 'wb 10/17/2021 22:11:19'!
assertNoChildrenContains: aHolding
	(self anyChildContains: aHolding) ifTrue: [self signalRepeatedHoldingError].! !


!Portfolio methodsFor: 'transactions' stamp: 'wb 10/17/2021 22:26:38'!
numberOfTransactions
	^self transactions size.! !

!Portfolio methodsFor: 'transactions' stamp: 'PhG 10/17/2021 18:32:15'!
transactions
	|collectedTransactions|
	collectedTransactions := OrderedCollection new.
	holdings do: [:holding | collectedTransactions addAll: holding transactions].
	^collectedTransactions.! !


!Portfolio methodsFor: 'balance' stamp: 'asd 10/17/2021 16:43:12'!
balance

	^holdings sum: [:aHolding | aHolding balance] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'error signals' stamp: 'wb 10/17/2021 22:07:38'!
signalRepeatedHoldingError

	^ self error: Portfolio repeatedHoldingError.! !


!Portfolio methodsFor: 'private' stamp: 'wb 10/17/2021 22:12:33'!
contains: aHoldingToSearch

	^(self = aHoldingToSearch) or: [ self anyChildContains: aHoldingToSearch ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'wb 10/17/2021 22:07:38'!
repeatedHoldingError
	^'You can not add the same holding more than once'! !


!classDefinition: #Transaction category: 'Portfolio-Ejercicio'!
Object subclass: #Transaction
	instanceVariableNames: 'balanceValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transaction methodsFor: 'value' stamp: 'wb 10/17/2021 21:54:40'!
value 

	self subclassResponsibility.! !


!Transaction methodsFor: 'testing' stamp: 'wb 10/17/2021 22:50:04'!
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


!Deposit methodsFor: 'testing' stamp: 'wb 10/17/2021 22:49:49'!
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

!Withdraw methodsFor: 'initialization' stamp: 'wb 10/17/2021 21:54:48'!
initializeFor: aValue

	value := aValue.! !


!Withdraw methodsFor: 'value' stamp: 'wb 10/17/2021 21:54:52'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
