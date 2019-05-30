!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

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

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'Nipo 5/30/2019 15:49:19'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio financialAssetsSize.
			self assert: (portfolio financialAssetsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Nipo 5/30/2019 15:49:19'!
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
			self assert: 1 equals: composedPortfolio financialAssetsSize.
			self assert: (composedPortfolio financialAssetsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Nipo 5/30/2019 15:49:19'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio financialAssetsSize.
			self assert: (simplePortfolio financialAssetsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Nipo 5/30/2019 15:49:06'!
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
			self assert: simplePortfolio financialAssetsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Nipo 5/30/2019 15:49:06'!
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
			self assert: portfolio financialAssetsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Nipo 5/30/2019 15:49:06'!
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
			self assert: portfolioToModify financialAssetsIsEmpty ]! !


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


!classDefinition: #WireTransferTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #WireTransferTest
	instanceVariableNames: 'myAccount otherAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WireTransferTest methodsFor: 'test' stamp: 'Nipo 5/30/2019 19:35:31'!
test01WireTransferMustAffectSourceAndDestinyAccountBalance

	| transferTransaction |
	
	transferTransaction := WireTransfer register: 80 from: myAccount to: otherAccount.
	
	self assert: (myAccount balance = (transferTransaction value * (-1))).
	self assert: (otherAccount balance = transferTransaction value).! !

!WireTransferTest methodsFor: 'test' stamp: 'Nipo 5/30/2019 19:37:24'!
test02WireTransferMustAffectSourceAndDestinyAccountsTransactions

	| transferTransaction |
	
	transferTransaction := WireTransfer register: 80 from: myAccount to: otherAccount.
	
	self assert: (myAccount transactions includes: transferTransaction withdrawLeg ).
	self assert: (otherAccount transactions includes: transferTransaction depositLeg)! !

!WireTransferTest methodsFor: 'test' stamp: 'Nipo 5/30/2019 19:38:45'!
test03WireTransferSourceAndDestinyShouldHaveThatTransferRegistered

	| transferTransaction |
	
	transferTransaction := WireTransfer register: 80 from: myAccount to: otherAccount .
	
	self assert: (myAccount hasRegistered: transferTransaction withdrawLeg).
	self assert: (otherAccount hasRegistered: transferTransaction depositLeg)! !

!WireTransferTest methodsFor: 'test' stamp: 'Nipo 5/30/2019 19:39:23'!
test04CantTransferNegativeMoney
	
	self 
		should: [ WireTransfer register: -10 from: myAccount to: otherAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert:  WireTransfer cannotTransferNegativeMoneyErrorDescription equals: anError messageText.
			]! !


!WireTransferTest methodsFor: 'setup' stamp: 'Nipo 5/30/2019 19:34:48'!
setUp
	myAccount := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'Nipo 5/30/2019 16:54:51'!
register: aValue on: account

	| accountTransaction |
	
	accountTransaction := self for: aValue.
	account register: accountTransaction.
		
	^ accountTransaction! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WireTransferLegs category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #WireTransferLegs
	instanceVariableNames: 'wireTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WireTransferLegs methodsFor: 'value' stamp: 'Nipo 5/30/2019 19:45:20'!
value
	^wireTransfer value.! !


!WireTransferLegs methodsFor: 'accessing' stamp: 'Nipo 5/30/2019 19:45:06'!
associatedWireTransfer
	^wireTransfer.! !


!WireTransferLegs methodsFor: 'initialization' stamp: 'Nipo 5/30/2019 19:45:13'!
initializeWithWireTransfer: aWireTransferTransaction
	wireTransfer := aWireTransferTransaction.! !


!WireTransferLegs methodsFor: 'balance' stamp: 'Nipo 5/30/2019 19:44:53'!
affectBalance: aBalance
	^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransferLegs class' category: #'PortfolioTreePrinter-Ejercicio'!
WireTransferLegs class
	instanceVariableNames: ''!

!WireTransferLegs class methodsFor: 'initialization' stamp: 'Nipo 5/30/2019 19:44:06'!
comingOf: aWireTransferTransaction
	^self new initializeWithWireTransfer: aWireTransferTransaction.! !


!classDefinition: #WireDepositTransfer category: #'PortfolioTreePrinter-Ejercicio'!
WireTransferLegs subclass: #WireDepositTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WireDepositTransfer methodsFor: 'balance' stamp: 'Nipo 5/30/2019 19:29:45'!
affectBalance: aBalance
	^aBalance + (self value).! !


!classDefinition: #WireWithdrawTransfer category: #'PortfolioTreePrinter-Ejercicio'!
WireTransferLegs subclass: #WireWithdrawTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WireWithdrawTransfer methodsFor: 'balance' stamp: 'Nipo 5/30/2019 19:30:12'!
affectBalance: aBalance
	^aBalance - (self value).! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!FinancialAsset methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'parents financialAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'accounts management' stamp: 'Nipo 5/30/2019 15:49:29'!
add: financialAssetToAdd

	self assertCanAdd: financialAssetToAdd.
		
	financialAssets add: financialAssetToAdd.
	financialAssetToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'Nipo 5/30/2019 15:48:51'!
financialAssetsIncludes: anAccount

	^financialAssets includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'Nipo 5/30/2019 15:49:06'!
financialAssetsIsEmpty
	
	^financialAssets isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'Nipo 5/30/2019 15:49:19'!
financialAssetsSize
	
	^financialAssets size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'Nipo 5/30/2019 15:48:33'!
initialize

	financialAssets := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'Nipo 5/30/2019 15:50:23'!
balance
	
	^financialAssets sum: [ :aFinancialAsset | aFinancialAsset balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'Nipo 5/30/2019 15:48:33'!
addTransactionsTo: aCollectionOfTransactions

	financialAssets do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'Nipo 5/30/2019 15:50:34'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	financialAssets do: [ :aFinancialAsset | aFinancialAsset addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'Nipo 5/30/2019 15:51:55'!
anyRootParentIsComposedBy: aFinancialAssetToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: aFinancialAssetToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'Nipo 5/30/2019 15:52:23'!
hasRegistered: aTransaction

	^financialAssets anySatisfy: [ :aFinancialAsset | aFinancialAsset hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'Nipo 5/30/2019 15:52:33'!
isComposedBy: aFinancialAsset

	^ self = aFinancialAsset or: [ financialAssets anySatisfy: [ :composedAccount | (composedAccount isComposedBy: aFinancialAsset) or: [ aFinancialAsset isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'Nipo 5/30/2019 15:50:04'!
assertCanAdd: financialAssetToAdd

	(self anyRootParentIsComposedBy: financialAssetToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'initialization' stamp: 'Nipo 5/30/2019 15:47:52'!
with: aFinancialAsset

	^self new 
		add: aFinancialAsset;
		yourself! !

!Portfolio class methodsFor: 'initialization' stamp: 'Nipo 5/30/2019 15:48:11'!
with: aFinancialAsset with: anotherFinancialAsset

	^self new 
		add: aFinancialAsset;
		add: anotherFinancialAsset;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'testing' stamp: 'Nipo 5/30/2019 15:54:25'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


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


!Report class methodsFor: 'summary report' stamp: 'Nipo 5/30/2019 19:53:26'!
generateAccountSummaryReportOf: aFinancialAsset
	|report |
	
	report := OrderedCollection new.
	aFinancialAsset transactions size = 0 ifTrue: [^ (report add: (self balanceStringFor: aFinancialAsset balance))].
	
	aFinancialAsset transactions do: [:aTransaction | 
			aTransaction class = Deposit ifTrue: [report add: (self depositStringFor: aTransaction value)].
			aTransaction class = Withdraw ifTrue: [report add: (self withdrawStringFor: aTransaction value)].
			aTransaction class = WireWithdrawTransfer ifTrue: [report add: (self withdrawTransferStringFor: aTransaction value)].
			aTransaction class = WireDepositTransfer ifTrue: [report add: (self depositTransferStringFor: aTransaction value)].
		].
	
	"Me parece que sería más fácil directo hacer un mensaje tipo aTransaction stringForReport"
	
	report add: (self balanceStringFor: aFinancialAsset balance).
	
	^ report! !

!Report class methodsFor: 'summary report' stamp: 'Nipo 5/30/2019 19:59:13'!
generateAccountTransferNetOf: aFinancialAsset
	| finalResult |
	
	finalResult := 0.
	
	aFinancialAsset transactions do: [ :aTransaction |
		aTransaction class = WireDepositTransfer ifTrue: [finalResult := finalResult + aTransaction value].
		aTransaction class = WireWithdrawTransfer ifTrue: [finalResult := finalResult - aTransaction value].
		"aTransaction affectBalanceIfWireDeposit: finalResult "
	].

	^finalResult! !


!classDefinition: #WireTransfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #WireTransfer
	instanceVariableNames: 'depositLeg withdrawLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!


!WireTransfer methodsFor: 'initialization' stamp: 'Nipo 5/30/2019 16:19:24'!
initializeTransfering: aValue from: aSourceAccount to: aDestinationAccount
	|wireTransferDeposit wireTransferWithdraw|

	wireTransferDeposit := WireDepositTransfer comingOf: self.
	wireTransferWithdraw := WireWithdrawTransfer comingOf: self.
	
	aDestinationAccount register: wireTransferDeposit.
	aSourceAccount register: wireTransferWithdraw.	
	
	withdrawLeg := wireTransferWithdraw.
	depositLeg  := wireTransferDeposit.
	value := aValue.! !


!WireTransfer methodsFor: 'value' stamp: 'Nipo 5/30/2019 16:20:36'!
value
	^value.! !


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

!WireTransfer class methodsFor: 'registration' stamp: 'Nipo 5/30/2019 16:12:21'!
register: aValue from: aSourceAccount to: aDestinationAccount
	
	aValue < 0 ifTrue: [self error: self cannotTransferNegativeMoneyErrorDescription].

	^ self new initializeTransfering: aValue from: aSourceAccount to: aDestinationAccount.
	! !


!WireTransfer class methodsFor: 'error descriptions' stamp: 'NI 5/29/2019 12:51:21'!
cannotTransferNegativeMoneyErrorDescription
	^'No se puede transferir un valor negativo'
	! !
