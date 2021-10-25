!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'PhG 10/19/2021 22:30:21'!
test08WiresCanBePerformedBetweenAccounts

	| account1 account2 wire |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	wire := Wire register: 100 from: account1 to: account2.
		
	self assert: (account1 hasRegistered: wire origin).
	self assert: (account2 hasRegistered: wire destination).
	self assert: -100 equals: account1 balance.
	self assert: 100 equals: account2 balance.
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'PhG 10/19/2021 21:42:08'!
test09WireCanNavigateToTheOtherEndOfTheWire

	| account1 account2 wire |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	wire := Wire register: 100 from: account1 to: account2.
		
	self assert: (wire origin otherEndOfWire) equals: wire destination.
	self assert: (wire destination otherEndOfWire) equals: wire origin.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'PhG 10/18/2021 21:40:16'!
test10WireValueCanNotBe0

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self 
		should: [ Wire register: 0 from: account1 to: account2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (Wire wireValueCanNotBeZeroOrNegative) equals: anError messageText. ]
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'PhG 10/18/2021 21:40:19'!
test11WireValueCanNotBeNegative

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self 
		should: [ Wire register: -25 from: account1 to: account2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (Wire wireValueCanNotBeZeroOrNegative) equals: anError messageText. ]
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'PhG 10/18/2021 21:40:22'!
test12WireCanNotBePerformedBetweenTheSameAccount

	| account |
	
	account := ReceptiveAccount new.
	
	self 
		should: [ Wire register: 100 from: account to: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (Wire wireCanNotBePerformedBetweenTheSameAccount) equals: anError messageText. ]
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'PhG 10/19/2021 22:33:16'!
test12WiresKnowTheirValues

	| account1 account2 wire wireValue |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	wireValue := 100.
	
	wire := Wire register: wireValue from: account1 to: account2.
		
	self assert: wireValue equals: wire value.
	self assert: wireValue equals: wire origin value.
	self assert: wireValue equals: wire destination value.
	
! !


!classDefinition: #ReportsTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportsTest methodsFor: 'account summary tests' stamp: 'PhG 10/20/2021 19:47:18'!
test01AccountSummaryOnNewAccountPrintsBalanceZero

	| anAccount |
	
	anAccount := self createEmptyAccount.
	
	self assert: (OrderedCollection with: 'Balance = 0.') equals: (self accountSummaryFor: anAccount).! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'PhG 10/20/2021 20:01:18'!
test02AccountSummaryOnAccountWithDepositPrintsDepositInformation

	| anAccount |
	
	anAccount := self createEmptyAccount.
	Deposit register: 100 on: anAccount.
	
	self assert: (OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100.') equals: (self accountSummaryFor: anAccount).! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'PhG 10/20/2021 20:01:23'!
test03AccountSummaryOnAccountWithWithdrawPrintsWithdrawInformation

	| anAccount |
	
	anAccount := self createEmptyAccount.
	Withdraw register: 100 on: anAccount.
	
	self assert: (OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100.') equals: (self accountSummaryFor: anAccount).! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'PhG 10/21/2021 21:05:18'!
test04AccountSummaryOnAccountWithOriginWirePrintsOriginWireInformation

	| anAccount |
	
	anAccount := self createEmptyAccount.
	Wire register: 100 from: anAccount to: self createEmptyAccount.
	
	self assert: (OrderedCollection with: 'Salida por transferencia de 100.' with: 'Balance = -100.') equals: (self accountSummaryFor: anAccount).! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'PhG 10/20/2021 20:01:31'!
test05AccountSummaryOnAccountWithDestinationWirePrintsDestinationWireInformation

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	Wire register: 100 from: ReceptiveAccount new to: anAccount.
	
	self assert: (OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Balance = 100.') equals: (self accountSummaryFor: anAccount).! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'PhG 10/20/2021 20:01:45'!
test09AccountSummaryOnNewPortfolioPrintsBalanceZero

	| aPortfolio |
	
	aPortfolio := self createEmptyPortfolio.
	
	self assert: (OrderedCollection with: 'Balance = 0.') equals: (self accountSummaryFor: aPortfolio).! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'PhG 10/20/2021 20:02:02'!
test10AccountSummaryOnPortfolioWithAccountIsAccountReport

	| aPortfolio anAccount expectedPortfolioAccountSummary |
	
	aPortfolio := self createEmptyPortfolio.
	anAccount := self createEmptyAccount.
	
	Deposit register: 100 on: anAccount.
	aPortfolio add: anAccount.
	
	expectedPortfolioAccountSummary := (OrderedCollection new) addAll: (self accountSummaryFor: anAccount).
	expectedPortfolioAccountSummary add: 'Balance = 100.'.
	
	self assert: expectedPortfolioAccountSummary equals: (self accountSummaryFor: aPortfolio).! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'PhG 10/20/2021 20:02:47'!
test11AccountSummaryOnPortfolioWithManyAccountsIncludesBothAccountsReport

	| aPortfolio accountWithDeposit accountWithWithdraw expectedPortfolioAccountSummary |
	
	aPortfolio := self createEmptyPortfolio.
	accountWithDeposit := self createEmptyAccount.
	accountWithWithdraw := self createEmptyAccount.
	
	Deposit register: 100 on: accountWithDeposit.
	aPortfolio add: accountWithDeposit.
	Withdraw register: 50 on: accountWithWithdraw.
	aPortfolio add: accountWithWithdraw.
	
	expectedPortfolioAccountSummary := (OrderedCollection new) addAll: (self accountSummaryFor: accountWithDeposit).
	expectedPortfolioAccountSummary addAll: (self accountSummaryFor: accountWithWithdraw).
	expectedPortfolioAccountSummary add: 'Balance = 50.'.
	
	self assert: expectedPortfolioAccountSummary equals: (self accountSummaryFor: aPortfolio).! !

!ReportsTest methodsFor: 'account summary tests' stamp: 'PhG 10/20/2021 20:02:23'!
test12AccountSummaryOnPortfolioWithAccountInNestedPortfolioShowsPortfoliosBalance

	| rootPortfolio nestedPortfolio accountWithWithdraw expectedPortfolioAccountSummary |
	
	rootPortfolio := self createEmptyPortfolio.
	nestedPortfolio := self createEmptyPortfolio.
	accountWithWithdraw := self createEmptyAccount.
	
	Withdraw register: 50 on: accountWithWithdraw.
	nestedPortfolio add: accountWithWithdraw.
	rootPortfolio add: nestedPortfolio.
	
	expectedPortfolioAccountSummary := (OrderedCollection new) addAll: (self accountSummaryFor: nestedPortfolio).
	expectedPortfolioAccountSummary add: 'Balance = -50.'.
	
	self assert: expectedPortfolioAccountSummary equals: (self accountSummaryFor: rootPortfolio).! !


!ReportsTest methodsFor: 'setUp' stamp: 'PhG 10/20/2021 19:47:25'!
accountSummaryFor: anAccount
	^AccountSummary new report: anAccount! !

!ReportsTest methodsFor: 'setUp' stamp: 'PhG 10/20/2021 09:08:46'!
createEmptyAccount
	^ReceptiveAccount new.! !

!ReportsTest methodsFor: 'setUp' stamp: 'PhG 10/20/2021 18:34:45'!
createEmptyPortfolio
	^Portfolio new.! !

!ReportsTest methodsFor: 'setUp' stamp: 'PhG 10/20/2021 20:23:22'!
transferNetFor: anAccount
	^TransferNet new report: anAccount! !

!ReportsTest methodsFor: 'setUp' stamp: 'wb 10/24/2021 20:56:41'!
treeStructureFor: anAccount
	^TreeStructure new report: anAccount! !


!ReportsTest methodsFor: 'tree structure tests' stamp: 'wb 10/24/2021 22:31:12'!
test16TreeStructureEmptyPortfolio

	| aPortfolio |
	
	aPortfolio _ Portfolio named: 'Portfolio de la familia'.
	
	self assert: (OrderedCollection with: 'Portfolio de la familia') equals: (self treeStructureFor: aPortfolio).
! !

!ReportsTest methodsFor: 'tree structure tests' stamp: 'wb 10/25/2021 00:21:06'!
test17TreeStructurePortfolioWithAnAccount

	| aPortfolio anAccount|
	
	aPortfolio _ Portfolio named: 'Portfolio de la familia'.
	anAccount _ ReceptiveAccount named: 'Cuenta mia'.
	aPortfolio add: anAccount.
	
	self assert: (OrderedCollection with: 'Portfolio de la familia'
							   with: '    Cuenta mia') equals: (self treeStructureFor: aPortfolio).
! !

!ReportsTest methodsFor: 'tree structure tests' stamp: 'wb 10/25/2021 00:27:45'!
test18TreeStructurePortfolioWithComplexStructure

	| familyPortfolio myAccount aPortfolioDeHijos juanAccount angelesAccount|
	
	familyPortfolio _ Portfolio named: 'Portfolio de la familia'.
	myAccount _ ReceptiveAccount named: 'Cuenta mia'.
	aPortfolioDeHijos _ Portfolio named: 'Portfolio de hijos'.
	juanAccount _ ReceptiveAccount named: 'Cuenta de Juan'.
	angelesAccount _ ReceptiveAccount named: 'Cuenta de Angeles'.
	familyPortfolio add: myAccount.
	aPortfolioDeHijos add: juanAccount .
	aPortfolioDeHijos add: angelesAccount .
	familyPortfolio add: aPortfolioDeHijos .
	
	self assert: (OrderedCollection with: 'Portfolio de la familia'
							   with: '    Cuenta mia'
							   with: '    Portfolio de hijos'
							   with: '        Cuenta de Juan'
							   with: '        Cuenta de Angeles') equals: (self treeStructureFor: familyPortfolio).
! !


!ReportsTest methodsFor: 'transfer net tests' stamp: 'PhG 10/20/2021 20:23:47'!
test06TransferNetOnNewAccountPrintsZero

	| anAccount |
	
	anAccount := self createEmptyAccount.
	
	self assert: 0 equals: (self transferNetFor: anAccount).! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'PhG 10/20/2021 20:23:58'!
test07TransferNetForAccountWithOriginWirePrintsNegativeNet

	| anAccount |
	
	anAccount := self createEmptyAccount.
	Wire register: 100 from: anAccount to: self createEmptyAccount.
	
	self assert: -100 equals: (self transferNetFor: anAccount).! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'PhG 10/20/2021 20:24:05'!
test08TransferNetForAccountWithDestinationWirePrintsPositiveNet

	| anAccount |
	
	anAccount := self createEmptyAccount.
	Wire register: 100 from: self createEmptyAccount to: anAccount.
	
	self assert: 100 equals: (self transferNetFor: anAccount).! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'PhG 10/20/2021 20:24:15'!
test13TransferNetOnNewPortfolioPrintsZero

	| aPortfolio |
	
	aPortfolio := self createEmptyPortfolio.
	
	self assert: 0 equals: (self transferNetFor: aPortfolio).! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'PhG 10/20/2021 20:25:27'!
test14TransferNetForPortfolioWithAccountWithWiresIsAccountTransferNet

	| anAccount aPortfolio |
	
	aPortfolio := self createEmptyPortfolio.
	anAccount := self createEmptyAccount.
	
	Wire register: 100 from: anAccount to: self createEmptyAccount.
	aPortfolio add: anAccount.
	
	self assert: (self transferNetFor: anAccount) equals: (self transferNetFor: aPortfolio).! !

!ReportsTest methodsFor: 'transfer net tests' stamp: 'PhG 10/20/2021 20:25:00'!
test15TransferNetForPortfolioWithManyAccountsWithWiresIsTotalTransferNet

	| accountWithOriginWire accountWithTwoWires aPortfolio |
	
	aPortfolio := self createEmptyPortfolio.
	accountWithOriginWire := self createEmptyAccount.
	accountWithTwoWires := self createEmptyAccount.
	
	Wire register: 100 from: accountWithOriginWire to: self createEmptyAccount.
	Wire register: 200 from: self createEmptyAccount to: accountWithTwoWires.
	Wire register: 25 from: accountWithTwoWires to: self createEmptyAccount.
	aPortfolio add: accountWithOriginWire.
	aPortfolio add: accountWithTwoWires.
	
	self assert: ((self transferNetFor: accountWithOriginWire) + (self transferNetFor: accountWithTwoWires)) equals: (self transferNetFor: aPortfolio).! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'PhG 10/20/2021 20:26:25'!
report: aReportable
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'wb 10/24/2021 20:58:31'!
named: aName
	self subclassResponsibility .! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'wb 10/24/2021 23:25:57'!
accounts
	^accounts.! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'wb 10/24/2021 21:10:10'!
initializeNamed: aName

	self initialize.
	name _ aName.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'wb 10/24/2021 22:16:43'!
name

	^name.! !

!Portfolio methodsFor: 'report' stamp: 'wb 10/25/2021 00:00:14'!
report: aReport
	^aReport reportPortfolio: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'wb 10/24/2021 21:07:57'!
named: aName
	^self new initializeNamed: aName. ! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'wb 10/24/2021 21:00:56'!
initializeNamed: aName

	self initialize.
	name _ aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'wb 10/24/2021 22:16:37'!
name
	
	^name.! !

!ReceptiveAccount methodsFor: 'report' stamp: 'wb 10/25/2021 00:00:21'!
report: aReport
	^aReport reportReceptiveAccount: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'wb 10/24/2021 21:06:37'!
named: aName
	^self new initializeNamed: aName. ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'PhG 10/20/2021 19:40:22'!
report: aReport
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'PhG 10/21/2021 21:24:46'!
report: aReport
	aReport reportDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DestinationWire category: 'Portfolio-Solucion'!
AccountTransaction subclass: #DestinationWire
	instanceVariableNames: 'wire'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DestinationWire methodsFor: 'balance' stamp: 'PhG 10/18/2021 20:30:16'!
affectBalance: aBalance

	^aBalance + wire value.! !


!DestinationWire methodsFor: 'initialization' stamp: 'PhG 10/18/2021 20:29:33'!
initializeFor: aWire

	wire := aWire.! !


!DestinationWire methodsFor: 'navigation' stamp: 'PhG 10/19/2021 21:34:08'!
otherEndOfWire
	^wire origin.! !


!DestinationWire methodsFor: 'value' stamp: 'PhG 10/19/2021 22:33:53'!
value
	^wire value.! !


!DestinationWire methodsFor: 'reports' stamp: 'PhG 10/21/2021 21:24:40'!
report: aReport
	aReport reportDestinationWire: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DestinationWire class' category: 'Portfolio-Solucion'!
DestinationWire class
	instanceVariableNames: ''!

!DestinationWire class methodsFor: 'instance creation' stamp: 'PhG 10/18/2021 20:27:07'!
for: aWire

	^ self new initializeFor: aWire ! !

!DestinationWire class methodsFor: 'instance creation' stamp: 'PhG 10/19/2021 21:28:51'!
registerTransaction: aTransaction on: account

	| transaction |
	
	transaction := self for: aTransaction.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #OriginWire category: 'Portfolio-Solucion'!
AccountTransaction subclass: #OriginWire
	instanceVariableNames: 'wire'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!OriginWire methodsFor: 'balance' stamp: 'PhG 10/18/2021 20:30:12'!
affectBalance: aBalance

	^aBalance - wire value.! !


!OriginWire methodsFor: 'initialization' stamp: 'PhG 10/18/2021 20:29:42'!
initializeFor: aWire

	wire := aWire.! !


!OriginWire methodsFor: 'navigation' stamp: 'PhG 10/19/2021 21:32:55'!
otherEndOfWire
	^wire destination.! !


!OriginWire methodsFor: 'value' stamp: 'PhG 10/19/2021 22:33:40'!
value
	^wire value.! !


!OriginWire methodsFor: 'reports' stamp: 'PhG 10/21/2021 21:24:36'!
report: aReport
	aReport reportOriginWire: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OriginWire class' category: 'Portfolio-Solucion'!
OriginWire class
	instanceVariableNames: ''!

!OriginWire class methodsFor: 'instance creation' stamp: 'PhG 10/18/2021 20:27:02'!
for: aWire

	^ self new initializeFor: aWire ! !

!OriginWire class methodsFor: 'instance creation' stamp: 'PhG 10/19/2021 21:28:57'!
registerTransaction: aTransaction on: account

	| transaction |
	
	transaction := self for: aTransaction.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'PhG 10/21/2021 21:24:32'!
report: aReport
	aReport reportWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialization' stamp: 'PhG 10/20/2021 20:27:53'!
initialize
	self subclassResponsibility.! !


!Report methodsFor: 'transactions' stamp: 'PhG 10/20/2021 20:28:54'!
reportDeposit: aDeposit
	self subclassResponsibility.! !

!Report methodsFor: 'transactions' stamp: 'PhG 10/20/2021 20:29:29'!
reportDestinationWire: aDestinationWire
	self subclassResponsibility.! !

!Report methodsFor: 'transactions' stamp: 'PhG 10/20/2021 20:29:15'!
reportOriginWire: anOriginWire
	self subclassResponsibility.! !

!Report methodsFor: 'transactions' stamp: 'PhG 10/20/2021 20:29:03'!
reportWithdraw: aWithdraw
	self subclassResponsibility.! !


!Report methodsFor: 'entrypoint' stamp: 'PhG 10/20/2021 20:28:24'!
report: aReportable
	self subclassResponsibility.! !


!Report methodsFor: 'accounts' stamp: 'PhG 10/20/2021 20:28:48'!
reportPortfolio: aPortfolio
	self subclassResponsibility.! !

!Report methodsFor: 'accounts' stamp: 'PhG 10/20/2021 20:28:36'!
reportReceptiveAccount: aReceptiveAccount
	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'PhG 10/20/2021 19:43:40'!
initialize
	accountSummary := OrderedCollection new.! !


!AccountSummary methodsFor: 'accounts' stamp: 'wb 10/24/2021 23:25:41'!
reportPortfolio: aPortfolio
	(aPortfolio accounts) do: [:account| self report: account].
	accountSummary add: 'Balance = ', (aPortfolio balance asString), '.'.! !

!AccountSummary methodsFor: 'accounts' stamp: 'wb 10/24/2021 23:26:33'!
reportReceptiveAccount: aReceptiveAccount
	aReceptiveAccount transactions do: [:transaction| self report: transaction].
	accountSummary add: 'Balance = ', (aReceptiveAccount balance asString), '.'.! !


!AccountSummary methodsFor: 'transactions' stamp: 'PhG 10/21/2021 21:23:05'!
reportDeposit: aDeposit
	accountSummary add: 'Depósito por ', aDeposit value asString, '.'.! !

!AccountSummary methodsFor: 'transactions' stamp: 'PhG 10/21/2021 21:23:13'!
reportDestinationWire: aDestinationWire
	accountSummary add: 'Entrada por transferencia de ', aDestinationWire value asString, '.'.! !

!AccountSummary methodsFor: 'transactions' stamp: 'PhG 10/21/2021 21:23:19'!
reportOriginWire: anOriginWire
	accountSummary add: 'Salida por transferencia de ', anOriginWire value asString, '.'.! !

!AccountSummary methodsFor: 'transactions' stamp: 'PhG 10/21/2021 21:23:27'!
reportWithdraw: aWithdraw
	accountSummary add: 'Extracción por ', aWithdraw value asString, '.'.! !


!AccountSummary methodsFor: 'entrypoint' stamp: 'PhG 10/20/2021 19:32:43'!
report: aReportable
	aReportable report: self.
	^accountSummary.! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'PhG 10/20/2021 20:17:15'!
initialize
	transferNet := 0! !


!TransferNet methodsFor: 'entrypoint' stamp: 'PhG 10/20/2021 20:17:15'!
report: aReportable
	aReportable report: self.
	^transferNet.! !


!TransferNet methodsFor: 'accounts' stamp: 'wb 10/24/2021 23:26:20'!
reportPortfolio: aPortfolio
	(aPortfolio accounts) do: [:account| self report: account].! !

!TransferNet methodsFor: 'accounts' stamp: 'wb 10/24/2021 23:24:50'!
reportReceptiveAccount: aReceptiveAccount
	aReceptiveAccount transactions do: [:transaction| self report: transaction].! !


!TransferNet methodsFor: 'transactions' stamp: 'PhG 10/21/2021 21:23:54'!
reportDeposit: aDeposit! !

!TransferNet methodsFor: 'transactions' stamp: 'PhG 10/21/2021 21:24:06'!
reportDestinationWire: aDestinationWire
	transferNet := transferNet + aDestinationWire value.! !

!TransferNet methodsFor: 'transactions' stamp: 'PhG 10/21/2021 21:24:14'!
reportOriginWire: anOriginWire
	transferNet := transferNet - anOriginWire value.! !

!TransferNet methodsFor: 'transactions' stamp: 'wb 10/24/2021 20:41:43'!
reportWithdraw: aWithdraw! !


!classDefinition: #TreeStructure category: 'Portfolio-Solucion'!
Report subclass: #TreeStructure
	instanceVariableNames: 'treeStructure mapStructure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructure methodsFor: 'styling the report' stamp: 'wb 10/25/2021 00:26:55'!
flattenDictionary: aDictionary
	|aCollection reportInOrderedCollectionForm aHeight|
	aHeight _ 0.
	aCollection  _ OrderedCollection new.
	reportInOrderedCollectionForm _ self flattenDictionary: aDictionary withCollection: aCollection withHeight: aHeight.
	^reportInOrderedCollectionForm. ! !

!TreeStructure methodsFor: 'styling the report' stamp: 'wb 10/25/2021 00:16:14'!
flattenDictionary: aDictionary withCollection: aCollection
	|children|
	aCollection add: ((aDictionary keys) at: 1).
	children _ aDictionary at: ((aDictionary keys) at: 1).
	children do: [:aChild| (self flattenDictionary: aChild withCollection: aCollection )].
	^aCollection 
	! !

!TreeStructure methodsFor: 'styling the report' stamp: 'wb 10/25/2021 00:20:43'!
flattenDictionary: aDictionary withCollection: aCollection withHeight: aHeight
	|children trailingSpace|
	trailingSpace _''.
	1 to: aHeight do:[:i |trailingSpace _ trailingSpace , '    '].
	aCollection add: trailingSpace,((aDictionary keys) at: 1).
	children _ aDictionary at: ((aDictionary keys) at: 1).
	children do: [:aChild| (self flattenDictionary: aChild withCollection: aCollection withHeight:(aHeight +1) )].
	^aCollection 
	! !


!TreeStructure methodsFor: 'transactions' stamp: 'wb 10/24/2021 20:40:41'!
reportDeposit: aDeposit! !

!TreeStructure methodsFor: 'transactions' stamp: 'wb 10/24/2021 20:40:53'!
reportDestinationWire: aDestinationWire! !

!TreeStructure methodsFor: 'transactions' stamp: 'wb 10/24/2021 20:41:04'!
reportOriginWire: anOriginWire! !

!TreeStructure methodsFor: 'transactions' stamp: 'wb 10/24/2021 20:41:48'!
reportWithdraw: aWithdraw! !


!TreeStructure methodsFor: 'accounts' stamp: 'wb 10/25/2021 00:26:08'!
reportPortfolio: aPortfolio
	|accountsTreeForAPortfolio|
	accountsTreeForAPortfolio _ Dictionary new.
	accountsTreeForAPortfolio at: (aPortfolio name asString ) put: (self reportMultiples: (aPortfolio accounts) ).
	^accountsTreeForAPortfolio .! !

!TreeStructure methodsFor: 'accounts' stamp: 'wb 10/25/2021 00:25:47'!
reportReceptiveAccount: aReceptiveAccount
	|accountsTreeForAReceptiveAccount|
	accountsTreeForAReceptiveAccount _ Dictionary new.
	accountsTreeForAReceptiveAccount at: (aReceptiveAccount name asString) put: OrderedCollection new.
	^accountsTreeForAReceptiveAccount.! !


!TreeStructure methodsFor: 'initialization' stamp: 'wb 10/24/2021 23:35:24'!
initialize
	treeStructure := OrderedCollection new.
	mapStructure _ Dictionary new.! !


!TreeStructure methodsFor: 'entry point' stamp: 'wb 10/25/2021 00:02:16'!
report: aReportable
	|dictionary response|
	dictionary _ (aReportable report: self).
	response _ self flattenDictionary: dictionary.
	^response .! !

!TreeStructure methodsFor: 'entry point' stamp: 'wb 10/24/2021 23:34:47'!
reportMultiples: orderedCollectionOfReportables
	|x| 
	x _ OrderedCollection new.
	orderedCollectionOfReportables do: [:aReportable| x add: (aReportable report: self).].
	^x.! !


!classDefinition: #Wire category: 'Portfolio-Solucion'!
Object subclass: #Wire
	instanceVariableNames: 'value originWire destinationWire'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Wire methodsFor: 'initialization' stamp: 'PhG 10/21/2021 21:11:47'!
initializeFor: aValue from: anOriginAccount to: aDestinationAccount
	
	value := aValue.
	originWire := OriginWire registerTransaction: self on: anOriginAccount.
	destinationWire := DestinationWire registerTransaction: self on: aDestinationAccount.! !


!Wire methodsFor: 'value' stamp: 'PhG 10/18/2021 20:30:42'!
value

	^ value! !


!Wire methodsFor: 'origin' stamp: 'PhG 10/19/2021 21:30:13'!
origin
	^originWire! !

!Wire methodsFor: 'origin' stamp: 'PhG 10/19/2021 21:40:48'!
originWire: anOriginWire
	originWire := anOriginWire.! !


!Wire methodsFor: 'destination' stamp: 'PhG 10/19/2021 21:41:36'!
destination
	^destinationWire.! !

!Wire methodsFor: 'destination' stamp: 'PhG 10/19/2021 22:30:01'!
destinationWire: aDestinationWire
	destinationWire := aDestinationWire.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Wire class' category: 'Portfolio-Solucion'!
Wire class
	instanceVariableNames: ''!

!Wire class methodsFor: 'instance creation' stamp: 'PhG 10/21/2021 21:11:24'!
register: aValue from: originAccount to: destinationAccount 
	| wire |
	
	(0 >= aValue) ifTrue: [self error: Wire wireValueCanNotBeZeroOrNegative ].
	(originAccount = destinationAccount) ifTrue: [self error: Wire wireCanNotBePerformedBetweenTheSameAccount].
	
	wire := self new initializeFor: aValue from: originAccount to: destinationAccount.
	
	^wire! !


!Wire class methodsFor: 'error descriptions' stamp: 'PhG 10/18/2021 21:39:06'!
wireCanNotBePerformedBetweenTheSameAccount
	
	^'Wire origin and destination can not be the same account'! !

!Wire class methodsFor: 'error descriptions' stamp: 'PhG 10/18/2021 21:39:28'!
wireValueCanNotBeZeroOrNegative

	^'Wire value can not be Zero or Negative'.! !
