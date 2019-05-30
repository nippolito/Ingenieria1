!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:58:06'!
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

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

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

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:58:20'!
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

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:58:24'!
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

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:58:28'!
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

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 11:58:32'!
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

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 12:01:51'!
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

!PortfolioTest methodsFor: 'tests - portfolio' stamp: 'HAW 5/25/2019 12:12:16'!
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


!classDefinition: #ReceptiveAccountTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'accountWith100Deposit accountWithoutTransactions accountWith100DepositTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 5/29/2019 12:42:22'!
test08WireTransferMustAffectSourceAndDestinyAccountBalance

	| transferTransaction |
	
	transferTransaction := WireTransfer register: 80 from: accountWith100Deposit to: accountWithoutTransactions.
	
	self assert: (accountWith100Deposit balance = (accountWith100DepositTransaction value - transferTransaction value)).
	self assert: (accountWithoutTransactions balance = transferTransaction value).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 5/29/2019 12:40:47'!
test09WireTransferMustAffectSourceAndDestinyAccountsTransactions

	| transferTransaction |
	
	transferTransaction := WireTransfer register: 80 from: accountWith100Deposit to: accountWithoutTransactions.
	
	self assert: (accountWith100Deposit transactions includes: transferTransaction withdrawLeg ).
	self assert: (accountWithoutTransactions transactions includes: transferTransaction depositLeg)! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 5/29/2019 12:45:30'!
test10WireTransferSourceAndDestinyShouldHaveThatTransferRegistered

	| transferTransaction |
	
	transferTransaction := WireTransfer register: 80 from: accountWith100Deposit to: accountWithoutTransactions.
	
	self assert: (accountWith100Deposit hasRegistered: transferTransaction withdrawLeg).
	self assert: (accountWithoutTransactions hasRegistered: transferTransaction depositLeg)! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 5/29/2019 12:50:48'!
test11CantTransferNegativeMoney
	
	self 
		should: [ WireTransfer register: -10 from: accountWith100Deposit to: accountWithoutTransactions ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert:  WireTransfer cannotTransferNegativeMoneyErrorDescription equals: anError messageText.
			]! !


!ReceptiveAccountTest methodsFor: 'setup' stamp: 'NI 5/29/2019 12:30:21'!
setUp
	
	accountWith100Deposit := ReceptiveAccount new.
	accountWithoutTransactions  := ReceptiveAccount new.
	accountWith100DepositTransaction := Deposit register: 100 on: accountWith100Deposit.! !


!classDefinition: #ReportTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReportTest methodsFor: 'transaction strings' stamp: 'NI 5/29/2019 13:26:38'!
balanceStringFor: aValue
	^'Balance = ' , aValue asString , '.'.! !

!ReportTest methodsFor: 'transaction strings' stamp: 'NI 5/29/2019 13:26:47'!
depositStringFor: anAmmount
	^ 'Depósito por ' , anAmmount asString , '.'! !

!ReportTest methodsFor: 'transaction strings' stamp: 'NI 5/29/2019 13:28:05'!
depositTransferStringFor: aValue
	^'Entrada por transferencia de ' , aValue asString , '.'.! !

!ReportTest methodsFor: 'transaction strings' stamp: 'NI 5/29/2019 13:29:15'!
withdrawStringFor: aValue
	^'Extracción por ' , aValue asString , '.'.! !

!ReportTest methodsFor: 'transaction strings' stamp: 'NI 5/29/2019 13:28:28'!
withdrawTransferStringFor: aValue
	^'Salida por transferencia de ' , aValue asString , '.'.! !


!ReportTest methodsFor: 'tests' stamp: 'NI 5/29/2019 14:35:14'!
test00EmptyTransactionsAccountSummaryReportShouldInformOnlyCeroBalance
	
	| anEmptyAccount aReport |
	
	anEmptyAccount := ReceptiveAccount new.
	
	aReport := Report generateAccountSummaryReportOf: anEmptyAccount.
	
	self assert: aReport size equals: 12.
	self assert: aReport equals: (self balanceStringFor: anEmptyAccount balance)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/29/2019 14:34:41'!
test01AccountSummaryReportInformsDepositProperly
	| anEmptyAccount aReport anAmmount |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	Deposit register: anAmmount on: anEmptyAccount.
	
	aReport := Report generateAccountSummaryReportOf: anEmptyAccount.
	
	self assert: aReport size equals: 2.
	self assert: (aReport at: 1) = (self depositStringFor: anAmmount)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/29/2019 14:34:46'!
test02AccountSummaryReportInformsWithdrawProperly
	| anEmptyAccount aReport aWithdraw anAmmount |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	aWithdraw := Withdraw register: anAmmount on: anEmptyAccount.
	
	aReport := Report generateAccountSummaryReportOf: anEmptyAccount.
	
	self assert: aReport size equals: 2.
	self assert: (aReport at: 1) = (self withdrawStringFor: anAmmount)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/29/2019 14:34:49'!
test03AccountSummaryReportInformsWireWithdrawProperly
	| anEmptyAccount aReport aWithdraw anAmmount anotherEmptyAccount |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	anotherEmptyAccount := ReceptiveAccount new.
	aWithdraw := WireTransfer register: anAmmount from: anEmptyAccount to: anotherEmptyAccount.
	
	aReport := Report generateAccountSummaryReportOf: anEmptyAccount.
	
	self assert: aReport size equals: 2.
	self assert: (aReport at: 1) = (self withdrawTransferStringFor: anAmmount)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/29/2019 15:20:08'!
test04AccountSummaryReportInformsWireDepositProperly
	| anEmptyAccount aReport aWithdraw anAmmount anotherEmptyAccount |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	anotherEmptyAccount := ReceptiveAccount new.
	aWithdraw := WireTransfer register: anAmmount from: anEmptyAccount to: anotherEmptyAccount.
	
	aReport := Report generateAccountSummaryReportOf: anotherEmptyAccount .
	
	"Para pasar este test tuve que agregarle el mensaje value a WireTransferDeposit que haga ^wireTransfer value"
	
	self assert: aReport size equals: 2.
	self assert: (aReport includes: (self depositTransferStringFor: anAmmount))! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/29/2019 14:35:35'!
test05OneTransactionAccountSummaryReportInformsBalanceProperly
	| anEmptyAccount aReport aDeposit anAmmount |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	aDeposit := Deposit register: anAmmount on: anEmptyAccount.
	
	aReport := Report generateAccountSummaryReportOf: anEmptyAccount.
	
	self assert: aReport size equals: 2.
	self assert: (aReport at: 2) equals: (self balanceStringFor: anEmptyAccount balance).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/29/2019 14:37:27'!
test06AccountSummaryReportInformsMultipleTransactionsProperly
	| anEmptyAccount aReport anAmmount anotherAmmount |
	
	anAmmount := 25.
	anotherAmmount := 50.
	anEmptyAccount := ReceptiveAccount new.
	Withdraw register: anAmmount on: anEmptyAccount.
	Deposit register: anotherAmmount on: anEmptyAccount.
	
	aReport := Report generateAccountSummaryReportOf: anEmptyAccount.
	
	self assert: aReport size equals: 3.
	self assert: (aReport includes: (self withdrawStringFor: anAmmount)).
	self assert: (aReport includes: (self depositStringFor: anotherAmmount)).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/29/2019 15:03:22'!
test07AccountSummaryReportMantainsTransactionOrder
	| anEmptyAccount aReport firstAmmount secondAmmount thirdAmmount |
	
	firstAmmount := 25.
	secondAmmount := 50.
	thirdAmmount := 120.
	
	anEmptyAccount := ReceptiveAccount new.
	
	Deposit register: firstAmmount on: anEmptyAccount.
	Withdraw register: secondAmmount on: anEmptyAccount.
	Deposit register: thirdAmmount on: anEmptyAccount.
	
	aReport := Report generateAccountSummaryReportOf: anEmptyAccount.
	
	self assert: aReport size equals: 4.
	self assert: (aReport at: 1) equals: (self depositStringFor: firstAmmount).
	self assert: (aReport at: 2) equals: (self withdrawStringFor: secondAmmount).
	self assert: (aReport at: 3) equals: (self depositStringFor: thirdAmmount).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/29/2019 15:04:48'!
test08ManyTransactionsAccountSummaryReportInformsBalanceProperly
	| anEmptyAccount aReport firstAmmount secondAmmount thirdAmmount |
	
	firstAmmount := 25.
	secondAmmount := 50.
	thirdAmmount := 120.
	
	anEmptyAccount := ReceptiveAccount new.
	
	Deposit register: firstAmmount on: anEmptyAccount.
	Withdraw register: secondAmmount on: anEmptyAccount.
	Deposit register: thirdAmmount on: anEmptyAccount.
	
	aReport := Report generateAccountSummaryReportOf: anEmptyAccount.
	
	self assert: aReport size equals: 4.
	self assert: (aReport at: 4) equals: (self balanceStringFor: anEmptyAccount balance).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/30/2019 11:44:46'!
test09EmptyTransactionsAccountTransferNetShouldBeCero
	| anEmptyAccount aReport |
	
	anEmptyAccount := ReceptiveAccount new.
	
	aReport := Report generateAccountTransferNetOf: anEmptyAccount.
	
	self assert: aReport isZero.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/30/2019 11:51:34'!
test10AccountTransferNetSumsWireDeposit	
	| anEmptyAccount aReport aWithdraw anAmmount anotherEmptyAccount |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	anotherEmptyAccount := ReceptiveAccount new.
	aWithdraw := WireTransfer register: anAmmount from: anEmptyAccount to: anotherEmptyAccount.
	
	aReport := Report generateAccountTransferNetOf: anotherEmptyAccount.
	
	self assert: aReport equals: anAmmount.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/30/2019 11:52:35'!
test11AccountTransferNetSubstractsWireWithdraw	
	| anEmptyAccount aReport anAmmount anotherEmptyAccount |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	anotherEmptyAccount := ReceptiveAccount new.
	WireTransfer register: anAmmount from: anEmptyAccount to: anotherEmptyAccount.
	
	aReport := Report generateAccountTransferNetOf: anEmptyAccount.
	
	self assert: aReport equals: (-1) * anAmmount.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/30/2019 11:58:46'!
test12AccountTransferNetCanHandleMultipleTransfers	
	| firstAccount firstReport anAmmount anotherAmmount secondAccount secondReport |
	
	anAmmount := 25.
	anotherAmmount := 50.
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	WireTransfer register: anAmmount from: firstAccount to: secondAccount.
	WireTransfer register: anotherAmmount from: secondAccount to: firstAccount.
	
	firstReport := Report generateAccountTransferNetOf: firstAccount.
	secondReport := Report generateAccountTransferNetOf: secondAccount.
	
	self assert: firstReport equals: anotherAmmount - anAmmount.
	self assert: secondReport equals: anAmmount - anotherAmmount! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/30/2019 12:17:54'!
test13AccountTransferNetIgnoresNotWiredTransfers	
	| anEmptyAccount aReport anAmmount anotherAmmount |
	
	anAmmount := 25.
	anotherAmmount := 50.
	anEmptyAccount := ReceptiveAccount new.
	Withdraw register: anAmmount on: anEmptyAccount.
	Deposit register: anotherAmmount on: anEmptyAccount.
	
	aReport := Report generateAccountTransferNetOf: anEmptyAccount.
	
	self assert: aReport isZero.! !


!classDefinition: #Account category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

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


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

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

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:57:20'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | composedAccount isComposedBy: anAccount ]]! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

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


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


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


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'testing' stamp: 'NI 5/30/2019 12:20:32'!
isDeposit
	^false.! !

!AccountTransaction methodsFor: 'testing' stamp: 'NI 5/30/2019 12:20:54'!
isWireDeposit
	^false.! !

!AccountTransaction methodsFor: 'testing' stamp: 'NI 5/30/2019 12:20:51'!
isWireWithdraw
	^false.! !

!AccountTransaction methodsFor: 'testing' stamp: 'NI 5/30/2019 12:21:02'!
isWithdraw
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'JIG 5/29/2019 02:17:14'!
register: aValue from: aSourceAccount to: aDestinationAccount
	^self subclassResponsibility.! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'testing' stamp: 'NI 5/30/2019 12:21:21'!
isDeposit
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WireTransfer category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #WireTransfer
	instanceVariableNames: 'depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WireTransfer methodsFor: 'balance' stamp: 'NI 5/29/2019 12:42:40'!
affectBalance: aBalance
	self subclassResponsibility! !


!WireTransfer methodsFor: 'initialization' stamp: 'NI 5/29/2019 15:17:55'!
initializeWithWithdraw: aWireTransferWithdraw destinatedTo: aDestinationAccount
	|wireTransferDeposit|

	wireTransferDeposit := WireTransferDeposit comingOf: self.
	"Le tuve que agregar el mensaje value a WireTransferDeposit para que responda wireTransfer value. Sin esto, lo que hacía era usar el del padre que retorna withdrawLeg value, pero withdrawLeg es nil"
	
	aDestinationAccount register: wireTransferDeposit.	
	
	withdrawLeg := aWireTransferWithdraw.
	depositLeg  := wireTransferDeposit.! !


!WireTransfer methodsFor: 'value' stamp: 'JIG 5/29/2019 02:35:13'!
value
	^withdrawLeg value.! !


!WireTransfer methodsFor: 'accessing' stamp: 'NI 5/29/2019 12:39:45'!
depositLeg
	^ depositLeg.! !

!WireTransfer methodsFor: 'accessing' stamp: 'NI 5/29/2019 12:40:17'!
withdrawLeg
	^ withdrawLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransfer class' category: #'PortfolioTreePrinter-Ejercicio'!
WireTransfer class
	instanceVariableNames: ''!

!WireTransfer class methodsFor: 'registration' stamp: 'NI 5/29/2019 12:52:05'!
register: aValue from: aSourceAccount to: aDestinationAccount
	|aWireTransferWithdraw|
	
	aValue < 0 ifTrue: [self error: self cannotTransferNegativeMoneyErrorDescription].

	aWireTransferWithdraw := WireTransferWithdraw for: aValue.
	
	aSourceAccount register: aWireTransferWithdraw.

	^ self new initializeWithWithdraw: aWireTransferWithdraw destinatedTo: aDestinationAccount.
	! !


!WireTransfer class methodsFor: 'error descriptions' stamp: 'NI 5/29/2019 12:51:21'!
cannotTransferNegativeMoneyErrorDescription
	^'No se puede transferir un valor negativo'
	! !


!classDefinition: #WireTransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
WireTransfer subclass: #WireTransferDeposit
	instanceVariableNames: 'wireTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WireTransferDeposit methodsFor: 'balance' stamp: 'JIG 5/29/2019 02:39:00'!
affectBalance: aBalance
	^aBalance + (wireTransfer value).! !

!WireTransferDeposit methodsFor: 'balance' stamp: 'NI 5/29/2019 15:15:14'!
value
	^wireTransfer value.! !


!WireTransferDeposit methodsFor: 'initialization' stamp: 'JIG 5/29/2019 02:29:03'!
initializeWithWireTransfer: aWireTransferTransaction
	wireTransfer := aWireTransferTransaction.! !


!WireTransferDeposit methodsFor: 'accessing' stamp: 'JIG 5/29/2019 02:32:43'!
associatedWireTransfer
	^wireTransfer.! !


!WireTransferDeposit methodsFor: 'testing' stamp: 'NI 5/30/2019 12:21:45'!
isWireDeposit
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
WireTransferDeposit class
	instanceVariableNames: ''!

!WireTransferDeposit class methodsFor: 'initialization' stamp: 'JIG 5/29/2019 02:28:46'!
comingOf: aWireTransferTransaction
	^self new initializeWithWireTransfer: aWireTransferTransaction.! !


!classDefinition: #WireTransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
WireTransfer subclass: #WireTransferWithdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WireTransferWithdraw methodsFor: 'balance' stamp: 'NI 5/29/2019 11:55:39'!
affectBalance: aBalance
	^aBalance - value.! !


!WireTransferWithdraw methodsFor: 'value' stamp: 'JIG 5/29/2019 02:30:32'!
value
	^value! !


!WireTransferWithdraw methodsFor: 'initialization' stamp: 'JIG 5/29/2019 02:30:10'!
initializeFor: aValue
	value := aValue.! !


!WireTransferWithdraw methodsFor: 'testing' stamp: 'NI 5/30/2019 12:21:56'!
isWireWithdraw
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
WireTransferWithdraw class
	instanceVariableNames: ''!

!WireTransferWithdraw class methodsFor: 'initialization' stamp: 'JIG 5/29/2019 02:37:29'!
for: aValue
	^self new initializeFor: aValue.! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'testing' stamp: 'NI 5/30/2019 12:22:07'!
isWithdraw
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'PortfolioTreePrinter-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'transactions strings' stamp: 'NI 5/29/2019 13:20:41'!
balanceStringFor: aValue
	^'Balance = ' , aValue asString , '.'.! !

!Report class methodsFor: 'transactions strings' stamp: 'NI 5/29/2019 13:20:34'!
depositStringFor: aValue
	^'Depósito por ' , aValue asString , '.'.! !

!Report class methodsFor: 'transactions strings' stamp: 'NI 5/29/2019 13:20:44'!
depositTransferStringFor: aValue
	^'Entrada por transferencia de ' , aValue asString , '.'.! !

!Report class methodsFor: 'transactions strings' stamp: 'NI 5/29/2019 13:29:15'!
withdrawStringFor: aValue
	^'Extracción por ' , aValue asString , '.'.! !

!Report class methodsFor: 'transactions strings' stamp: 'NI 5/29/2019 13:20:51'!
withdrawTransferStringFor: aValue
	^'Salida por transferencia de ' , aValue asString , '.'.! !


!Report class methodsFor: 'summary report' stamp: 'NI 5/30/2019 12:24:53'!
generateAccountSummaryReportOf: aFinancialAsset
	|report |
	
	report := OrderedCollection new.
	aFinancialAsset transactions size = 0 ifTrue: [^ (report add: (self balanceStringFor: aFinancialAsset balance))].
	
	aFinancialAsset transactions do: [:aTransaction | 
			aTransaction isDeposit ifTrue: [report add: (self depositStringFor: aTransaction value)].
			aTransaction isWithdraw ifTrue: [report add: (self withdrawStringFor: aTransaction value)].
			aTransaction isWireWithdraw ifTrue: [report add: (self withdrawTransferStringFor: aTransaction value)].
			aTransaction isWireDeposit ifTrue: [report add: (self depositTransferStringFor: aTransaction value)].
		].
	
	report add: (self balanceStringFor: aFinancialAsset balance).
	
	^ report! !

!Report class methodsFor: 'summary report' stamp: 'NI 5/30/2019 12:24:30'!
generateAccountTransferNetOf: aFinancialAsset
	| finalResult |
	
	finalResult := 0.
	
	aFinancialAsset transactions do: [ :aTransaction |
		aTransaction isWireDeposit ifTrue: [finalResult := finalResult + aTransaction value].
		aTransaction isWireWithdraw ifTrue: [finalResult := finalResult - aTransaction value].
	].

	^finalResult! !
