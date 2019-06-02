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


!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 12:19:44'!
test00SummaryReportInformsOnlyCeroBalanceWhenThereAreNotTransactions
	
	| anEmptyAccount aReport summaryAccountReport |
	
	anEmptyAccount := ReceptiveAccount new.
	
	aReport := Report for: anEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 1.
	self assert: (summaryAccountReport includes: (self balanceStringFor: anEmptyAccount balance))! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:04:16'!
test01SummaryReportInformsDepositProperly
	| anEmptyAccount aReport anAmmount summaryAccountReport |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	Deposit register: anAmmount on: anEmptyAccount.
	
	aReport := Report for: anEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport at: 1) = (self depositStringFor: anAmmount)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:04:21'!
test02SummaryReportInformsWithdrawProperly
	| anEmptyAccount aReport anAmount summaryAccountReport |
	
	anAmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	Withdraw register: anAmount on: anEmptyAccount.
	
	aReport := Report for: anEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport at: 1) = (self withdrawStringFor: anAmount)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:04:27'!
test03SummaryReportInformsWireWithdrawProperly
	| anEmptyAccount aReport anAmmount anotherEmptyAccount summaryAccountReport |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	anotherEmptyAccount := ReceptiveAccount new.
	WireTransfer register: anAmmount from: anEmptyAccount to: anotherEmptyAccount.
	
	aReport := Report for: anEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport at: 1) = (self withdrawTransferStringFor: anAmmount)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:04:34'!
test04SummaryReportInformsWireDepositProperly
	| anEmptyAccount aReport anAmmount anotherEmptyAccount summaryAccountReport |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	anotherEmptyAccount := ReceptiveAccount new.
	WireTransfer register: anAmmount from: anEmptyAccount to: anotherEmptyAccount.
	
	aReport := Report for: anotherEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport includes: (self depositTransferStringFor: anAmmount))! !

!ReportTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 16:17:45'!
test05OneTransactionFinancialAssetSummaryReportInformsBalanceProperly
	| anEmptyAccount aReport anAmount summaryAccountReport |
	
	anAmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	Deposit register: anAmount on: anEmptyAccount.
	
	aReport := Report for: anEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport at: 2) equals: (self balanceStringFor: anEmptyAccount balance).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:04:57'!
test06SummaryReportInformsMultipleTransactionsProperly
	| anEmptyAccount aReport anAmount anotherAmount summaryAccountReport |
	
	anAmount := 25.
	anotherAmount := 50.
	anEmptyAccount := ReceptiveAccount new.
	Withdraw register: anAmount on: anEmptyAccount.
	Deposit register: anotherAmount on: anEmptyAccount.
	
	aReport := Report for: anEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 3.
	self assert: (summaryAccountReport includes: (self withdrawStringFor: anAmount)).
	self assert: (summaryAccountReport includes: (self depositStringFor: anotherAmount)).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:05:24'!
test07SummaryReportMantainsTransactionOrder
	| anEmptyAccount aReport firstAmmount secondAmmount thirdAmmount summaryAccountReport |
	
	firstAmmount := 25.
	secondAmmount := 50.
	thirdAmmount := 120.
	
	anEmptyAccount := ReceptiveAccount new.
	
	Deposit register: firstAmmount on: anEmptyAccount.
	Withdraw register: secondAmmount on: anEmptyAccount.
	Deposit register: thirdAmmount on: anEmptyAccount.
	
	aReport := Report for: anEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 4.
	self assert: (summaryAccountReport at: 1) equals: (self depositStringFor: firstAmmount).
	self assert: (summaryAccountReport at: 2) equals: (self withdrawStringFor: secondAmmount).
	self assert: (summaryAccountReport at: 3) equals: (self depositStringFor: thirdAmmount).! !

!ReportTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 16:18:03'!
test08ManyTransactionsFinancialAssetSummaryReportInformsBalanceProperly
	| anEmptyAccount aReport firstAmmount secondAmmount thirdAmmount summaryAccountReport |
	
	firstAmmount := 25.
	secondAmmount := 50.
	thirdAmmount := 120.
	
	anEmptyAccount := ReceptiveAccount new.
	
	Deposit register: firstAmmount on: anEmptyAccount.
	Withdraw register: secondAmmount on: anEmptyAccount.
	Deposit register: thirdAmmount on: anEmptyAccount.
	
	aReport := Report for: anEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 4.
	self assert: (summaryAccountReport at: 4) equals: (self balanceStringFor: anEmptyAccount balance).! !

!ReportTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 16:18:10'!
test09EmptyTransactionsFinancialAssetTransferNetShouldBeCero
	| anEmptyAccount aReport trasnferNetReport |
	
	anEmptyAccount := ReceptiveAccount new.
	
	aReport := Report for: anEmptyAccount.
	trasnferNetReport := aReport generateAccountTransferNet.
	
	self assert: trasnferNetReport isZero.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:05:44'!
test10TransferNetSumsWireDeposit	
	| anEmptyAccount aReport anAmount anotherEmptyAccount trasnferNetReport |
	
	anAmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	anotherEmptyAccount := ReceptiveAccount new.
	WireTransfer register: anAmount from: anEmptyAccount to: anotherEmptyAccount.
	
	aReport := Report for: anotherEmptyAccount.
	trasnferNetReport := aReport generateAccountTransferNet.
	
	self assert: trasnferNetReport equals: anAmount.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:05:50'!
test11TransferNetSubstractsWireWithdraw	
	| anEmptyAccount aReport anAmmount anotherEmptyAccount trasnferNetReport |
	
	anAmmount := 25.
	anEmptyAccount := ReceptiveAccount new.
	anotherEmptyAccount := ReceptiveAccount new.
	WireTransfer register: anAmmount from: anEmptyAccount to: anotherEmptyAccount.
	
	aReport := Report for: anEmptyAccount.
	trasnferNetReport := aReport generateAccountTransferNet.
	
	self assert: trasnferNetReport equals: (-1) * anAmmount.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:06:19'!
test12TransferNetCanHandleMultipleTransfers	
	| firstAccount firstReport anAmmount anotherAmmount secondAccount secondReport firstTransferNetReport secondTransferNetReport |
	
	anAmmount := 25.
	anotherAmmount := 50.
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	WireTransfer register: anAmmount from: firstAccount to: secondAccount.
	WireTransfer register: anotherAmmount from: secondAccount to: firstAccount.
	
	firstReport := Report for: firstAccount.
	secondReport := Report for: secondAccount.
	firstTransferNetReport := firstReport generateAccountTransferNet.
	secondTransferNetReport := secondReport generateAccountTransferNet.
	
	self assert: firstTransferNetReport equals: anotherAmmount - anAmmount.
	self assert: secondTransferNetReport equals: anAmmount - anotherAmmount! !

!ReportTest methodsFor: 'tests' stamp: 'NI 5/31/2019 19:06:22'!
test13TransferNetIgnoresNotWiredTransfers	
	| anEmptyAccount aReport anAmmount anotherAmmount transferNetReport |
	
	anAmmount := 25.
	anotherAmmount := 50.
	anEmptyAccount := ReceptiveAccount new.
	Withdraw register: anAmmount on: anEmptyAccount.
	Deposit register: anotherAmmount on: anEmptyAccount.
	
	aReport := Report for: anEmptyAccount.
	transferNetReport := aReport generateAccountTransferNet.
	
	self assert: transferNetReport isZero.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 11:27:12'!
test14TreeStructureDoesntIndentSimplePortfolio
	| aReport treeStructureReport aPortfolio |
	
	aPortfolio := Portfolio new.
	
	aReport := Report for: aPortfolio.
	treeStructureReport := aReport generateTreeStructureReport.
	
	treeStructureReport reset.
	self assert: treeStructureReport nextLine equals: 'Portfolio'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 11:27:12'!
test15TreeStructureIndentsOncePortfoliosAccounts
	| aReport treeStructureReport aPortfolio anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	
	aReport := Report for: aPortfolio.
	treeStructureReport := aReport generateTreeStructureReport.
	
	treeStructureReport reset.
	self assert: treeStructureReport nextLine equals: 'Portfolio'.
	self assert: treeStructureReport nextLine equals: '    ReceptiveAccount'.
	self assert: treeStructureReport nextLine equals: '    ReceptiveAccount'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 11:27:12'!
test16TreeStructurePortfolioIndentsGrandchildrenTwice
	| aReport treeStructureReport aPortfolio anAccount anotherAccount fatherPortfolio thirdAccount depth |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	fatherPortfolio := Portfolio with: aPortfolio with: thirdAccount.
	
	aReport := Report for: fatherPortfolio.
	treeStructureReport := aReport generateTreeStructureReport.
	
	treeStructureReport reset.
	self assert: treeStructureReport nextLine equals: 'Portfolio'.
	self assert: treeStructureReport nextLine equals: '    Portfolio'.
	self assert: treeStructureReport nextLine equals: '        ReceptiveAccount'.
	self assert: treeStructureReport nextLine equals: '        ReceptiveAccount'.
	self assert: treeStructureReport nextLine equals: '    ReceptiveAccount'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 11:27:12'!
test17TreeStructureIndentsRecursivelyBasedOnDepth
	| aReport treeStructureReport aPortfolio anAccount anotherAccount firstFatherPortfolio thirdAccount fourthAccount secondFatherPortfolio grandFatherPortfolio |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	fourthAccount := ReceptiveAccount new.
	
	aPortfolio := Portfolio with: anAccount.
	firstFatherPortfolio := Portfolio with: anotherAccount with: thirdAccount.
	secondFatherPortfolio := Portfolio with: aPortfolio with: fourthAccount.
	grandFatherPortfolio := Portfolio with: firstFatherPortfolio with: secondFatherPortfolio.
	
	aReport := Report for: grandFatherPortfolio.
	treeStructureReport := aReport generateTreeStructureReport.
	
	treeStructureReport reset.
	self assert: treeStructureReport nextLine equals: 'Portfolio'.
	self assert: treeStructureReport nextLine equals: '    Portfolio'.
	self assert: treeStructureReport nextLine equals: '        ReceptiveAccount'.
	self assert: treeStructureReport nextLine equals: '        ReceptiveAccount'.
	self assert: treeStructureReport nextLine equals: '    Portfolio'.
	self assert: treeStructureReport nextLine equals: '        Portfolio'.
	self assert: treeStructureReport nextLine equals: '            ReceptiveAccount'.
	self assert: treeStructureReport nextLine equals: '        ReceptiveAccount'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 11:34:35'!
test18SpecialSummarySimplePortfolio
	| aReport aSpecialSummaryReport aPortfolio |
	
	aPortfolio := Portfolio new.
	
	aReport := Report for: aPortfolio.
	aSpecialSummaryReport := aReport generateSpecialSummaryReport.
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: 'Portfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '    Balance = 0.'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 11:40:04'!
test19SpecialSummaryPortfolioWithAccountsWithoutTransactions
	| aReport aSpecialSummaryReport aPortfolio anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	
	aReport := Report for: aPortfolio.
	aSpecialSummaryReport := aReport generateSpecialSummaryReport .
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: 'Portfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '    ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        Balance = 0.'.
	self assert: aSpecialSummaryReport nextLine equals: '    ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        Balance = 0.'.
	self assert: aSpecialSummaryReport nextLine equals: '    Balance = 0.'! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 11:54:07'!
test20SpecialSummaryPortfolioWithAccountsWithTransactions
	| aReport aSpecialSummaryReport aPortfolio anAccount anotherAccount anAmount anotherAmount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	anAmount := 25.
	anotherAmount := 50.
	Withdraw register: anAmount on: anAccount.
	Deposit register: anotherAmount on: anotherAccount.
	
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	
	aReport := Report for: aPortfolio.
	aSpecialSummaryReport := aReport generateSpecialSummaryReport .
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: 'Portfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '    ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        ' , (self withdrawStringFor: anAmount).
	self assert: aSpecialSummaryReport nextLine equals: '        ' , (self balanceStringFor: 0 - anAmount).
	self assert: aSpecialSummaryReport nextLine equals: '    ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self depositStringFor: anotherAmount).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: 0 + anotherAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '    ', (self balanceStringFor: anAccount balance + anotherAccount balance)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 12:51:24'!
test21SpecialSummaryPortfolioWithPortfolioAndAccounts
	| aReport aSpecialSummaryReport aPortfolio anAccount anotherAccount anAmount anotherAmount fatherPortfolio thirdAccount wireAmount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	
	anAmount := 25.
	anotherAmount := 50.
	wireAmount := 100.
	Withdraw register: anAmount on: anAccount.
	Deposit register: anotherAmount on: anotherAccount.
	WireTransfer register: wireAmount from: anAccount to: thirdAccount. 
	
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	fatherPortfolio := Portfolio with: aPortfolio with: thirdAccount.
	
	aReport := Report for: fatherPortfolio.
	aSpecialSummaryReport := aReport generateSpecialSummaryReport .
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: 'Portfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '    Portfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '        ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self withdrawStringFor: anAmount).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self withdrawTransferStringFor: wireAmount).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self balanceStringFor: anAccount balance).
	self assert: aSpecialSummaryReport nextLine equals: '        ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '            ', (self depositStringFor: anotherAmount).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self balanceStringFor: anotherAccount balance).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: aPortfolio balance).
	self assert: aSpecialSummaryReport nextLine equals: '    ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self depositTransferStringFor: wireAmount).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: thirdAccount balance).
	self assert: aSpecialSummaryReport nextLine equals: '    ', (self balanceStringFor: aPortfolio balance + thirdAccount balance).
	
	
	! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 12:49:31'!
test22SpecialSummaryPortfolioThreeLevels
	| aReport aSpecialSummaryReport parentPortfolio anAccount anotherAccount anAmount anotherAmount grandFatherPortfolio thirdAccount wireAmount aPortfolio |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	
	anAmount := 25.
	anotherAmount := 50.
	wireAmount := 100.
	Withdraw register: anAmount on: anAccount.
	Deposit register: anotherAmount on: anotherAccount.
	WireTransfer register: wireAmount from: anAccount to: thirdAccount. 
	
	aPortfolio := Portfolio with: anotherAccount.
	parentPortfolio := Portfolio with: anAccount with: aPortfolio.
	grandFatherPortfolio := Portfolio with: parentPortfolio with: thirdAccount.
	
	aReport := Report for: grandFatherPortfolio.
	aSpecialSummaryReport := aReport generateSpecialSummaryReport .
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: 'Portfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '    Portfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '        ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self withdrawStringFor: anAmount).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self withdrawTransferStringFor: wireAmount).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self balanceStringFor: anAccount balance).
	self assert: aSpecialSummaryReport nextLine equals: '        Portfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '            ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '                ', (self depositStringFor: anotherAmount).
	self assert: aSpecialSummaryReport nextLine equals: '                ' , (self balanceStringFor: anotherAccount balance).
	self assert: aSpecialSummaryReport nextLine equals: '            ', (self balanceStringFor: aPortfolio balance).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: parentPortfolio balance).
	self assert: aSpecialSummaryReport nextLine equals: '    ReceptiveAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self depositTransferStringFor: wireAmount).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: thirdAccount balance).
	self assert: aSpecialSummaryReport nextLine equals: '    ', (self balanceStringFor: grandFatherPortfolio balance).
	
	
	! !


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


!AccountTransaction methodsFor: 'private - report' stamp: 'NI 5/31/2019 18:58:42'!
handleReport: aReport
	self subclassResponsibility.! !

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


!Deposit methodsFor: 'private - report' stamp: 'JIG 5/31/2019 16:59:04'!
handleReport: aReport
	aReport handleDepositTransaction: self.! !

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


!WireDepositTransfer methodsFor: 'private - report' stamp: 'JIG 5/31/2019 16:59:13'!
handleReport: aReport
	aReport handleDepositTransferTransaction: self.! !


!classDefinition: #WireWithdrawTransfer category: #'PortfolioTreePrinter-Ejercicio'!
WireTransferLegs subclass: #WireWithdrawTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WireWithdrawTransfer methodsFor: 'balance' stamp: 'Nipo 5/30/2019 19:30:12'!
affectBalance: aBalance
	^aBalance - (self value).! !


!WireWithdrawTransfer methodsFor: 'private - report' stamp: 'JIG 5/31/2019 16:59:18'!
handleReport: aReport
	aReport handleWithdrawTransferTransaction: self.! !


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


!Withdraw methodsFor: 'private - report' stamp: 'JIG 5/31/2019 16:59:33'!
handleReport: aReport
	aReport handleWithdrawTransaction: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: 'parents'
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


!FinancialAsset methodsFor: 'private - report' stamp: 'NI 6/2/2019 11:14:33'!
handleReport: aReport
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'financialAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'NI 5/31/2019 19:35:47'!
financialAssets
	^financialAssets! !


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


!Portfolio methodsFor: 'balance' stamp: 'Nipo 5/30/2019 15:50:23'!
balance
	
	^financialAssets sum: [ :aFinancialAsset | aFinancialAsset balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'initialization' stamp: 'Nipo 5/30/2019 15:48:33'!
initialize

	financialAssets := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'Nipo 5/30/2019 15:51:55'!
anyRootParentIsComposedBy: aFinancialAssetToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: aFinancialAssetToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'Nipo 5/30/2019 15:52:23'!
hasRegistered: aTransaction

	^financialAssets anySatisfy: [ :aFinancialAsset | aFinancialAsset hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'Nipo 5/30/2019 15:52:33'!
isComposedBy: aFinancialAsset

	^ self = aFinancialAsset or: [ financialAssets anySatisfy: [ :composedAccount | (composedAccount isComposedBy: aFinancialAsset) or: [ aFinancialAsset isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'testing' stamp: 'NI 6/2/2019 11:20:00'!
isDescendantFrom: aPortfolio
	parents ifEmpty: [^ self = aPortfolio].
	
	^ self = aPortfolio or: [parents anySatisfy: [:aParent | aParent isDescendantFrom: aPortfolio]].! !


!Portfolio methodsFor: 'transactions' stamp: 'Nipo 5/30/2019 15:48:33'!
addTransactionsTo: aCollectionOfTransactions

	financialAssets do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'Nipo 5/30/2019 15:50:34'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	financialAssets do: [ :aFinancialAsset | aFinancialAsset addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'private - report' stamp: 'JIG 5/31/2019 17:24:03'!
handleReport: aReport
	aReport handlePortfolio: self.! !


!Portfolio methodsFor: 'depth' stamp: 'NI 6/1/2019 12:03:53'!
depthFrom: aPortfolio
	|nextStepToPortfolio|
	
	nextStepToPortfolio := parents detect: [:aParent | aParent isDescendantFrom: aPortfolio] ifNone: [^0].
	^ 1 + (nextStepToPortfolio depthFrom: aPortfolio)! !

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

!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'NI 6/1/2019 12:00:45'!
addedTo: aPortfolio 
	parents add: aPortfolio.
	! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'NI 6/1/2019 12:01:24'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'Nipo 5/30/2019 15:54:25'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NI 6/2/2019 11:21:53'!
isDescendantFrom: aPortfolio
	parents ifEmpty: [^false].

	^ parents anySatisfy: [:aParent | aParent isDescendantFrom: aPortfolio]! !


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


!ReceptiveAccount methodsFor: 'private - report' stamp: 'JIG 5/31/2019 17:24:42'!
handleReport: aReport
	aReport handleReceptiveAccount: self.! !


!ReceptiveAccount methodsFor: 'depth' stamp: 'NI 6/1/2019 12:04:46'!
depthFrom: aPortfolio
	|nextStepToPortfolio|
	
	nextStepToPortfolio := parents detect: [:aParent | aParent isDescendantFrom: aPortfolio] ifNone: [^0].
	^ 1 + (nextStepToPortfolio depthFrom: aPortfolio).! !


!classDefinition: #Report category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'financialAsset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Report methodsFor: 'report generation' stamp: 'JIG 5/31/2019 16:33:10'!
generateAccountSummary
	^(SummaryReport for: financialAsset) generate.! !

!Report methodsFor: 'report generation' stamp: 'JIG 5/31/2019 17:04:05'!
generateAccountTransferNet
	^(TransferNetReport for: financialAsset) generate.
	! !

!Report methodsFor: 'report generation' stamp: 'NI 6/2/2019 11:27:36'!
generateSpecialSummaryReport
	^ (SpecialSummaryReport for: financialAsset) generate.! !

!Report methodsFor: 'report generation' stamp: 'NI 6/2/2019 11:27:12'!
generateTreeStructureReport
	^ (TreeStructureReport for: financialAsset) generate.! !


!Report methodsFor: 'initialization' stamp: 'JIG 5/31/2019 15:51:38'!
initializeFor: aFinancialAsset
	financialAsset := aFinancialAsset.! !


!Report methodsFor: 'private' stamp: 'JIG 5/31/2019 17:16:09'!
handleDepositTransaction: aDepositTransaction
	^self subclassResponsibility.! !

!Report methodsFor: 'private' stamp: 'JIG 5/31/2019 17:21:27'!
handleDepositTransferTransaction: aDepositTransferTransaction
	^self subclassResponsibility.! !

!Report methodsFor: 'private' stamp: 'NI 6/2/2019 11:23:58'!
handlePortfolio: aPortfolio
	^self subclassResponsibility.! !

!Report methodsFor: 'private' stamp: 'NI 6/2/2019 11:24:11'!
handleReceptiveAccount: aReceptiveAccount
	^self subclassResponsibility.! !

!Report methodsFor: 'private' stamp: 'JIG 5/31/2019 17:21:33'!
handleWithdrawTransaction: aWithdrawTransaction
	^self subclassResponsibility.! !

!Report methodsFor: 'private' stamp: 'JIG 5/31/2019 17:21:39'!
handleWithdrawTransferTransaction: aWithdrawTransferTransaction
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'PortfolioTreePrinter-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'JIG 5/31/2019 16:07:25'!
for: aFinancialAsset
	^self new initializeFor: aFinancialAsset.! !


!Report class methodsFor: 'transaction descriptions' stamp: 'NI 6/2/2019 11:32:05'!
balanceStringFor: aValue
	^'Balance = ' , aValue asString , '.'.! !

!Report class methodsFor: 'transaction descriptions' stamp: 'NI 6/2/2019 11:32:14'!
depositStringFor: aValue
	^'Depósito por ' , aValue asString , '.'.! !

!Report class methodsFor: 'transaction descriptions' stamp: 'NI 6/2/2019 11:32:22'!
depositTransferStringFor: aValue
	^'Entrada por transferencia de ' , aValue asString , '.'.! !

!Report class methodsFor: 'transaction descriptions' stamp: 'NI 6/2/2019 11:32:31'!
withdrawStringFor: aValue
	^'Extracción por ' , aValue asString , '.'.! !

!Report class methodsFor: 'transaction descriptions' stamp: 'NI 6/2/2019 11:32:42'!
withdrawTransferStringFor: aValue
	^'Salida por transferencia de ' , aValue asString , '.'.! !


!classDefinition: #SpecialSummaryReport category: #'PortfolioTreePrinter-Ejercicio'!
Report subclass: #SpecialSummaryReport
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SpecialSummaryReport methodsFor: 'report generation' stamp: 'NI 6/2/2019 12:54:12'!
generate
	stream := ReadWriteStream with: financialAsset class asString.
	
	financialAsset financialAssets do: [:aFinancialAsset |
		aFinancialAsset handleReport: self.
	].

	self indentNewLineOf: stream withSpace: 4 andThenWrite: (self class balanceStringFor: financialAsset balance). 	
	
	^stream! !


!SpecialSummaryReport methodsFor: 'private - financial assets handlers' stamp: 'NI 6/2/2019 12:55:15'!
handlePortfolio: aPortfolio
	|depthFromFinancialAsset |
	
	depthFromFinancialAsset := 4 * (aPortfolio depthFrom: financialAsset).

	self indentNewLineOf: stream withSpace: 4 * (aPortfolio depthFrom: financialAsset) andThenWrite: aPortfolio class asString.
	
	aPortfolio financialAssets do: [:aFinancialAsset | 
		aFinancialAsset handleReport: self.	
	].

	self indentNewLineOf: stream withSpace: depthFromFinancialAsset + 4 andThenWrite: (self class balanceStringFor: aPortfolio balance). ! !

!SpecialSummaryReport methodsFor: 'private - financial assets handlers' stamp: 'NI 6/2/2019 12:55:36'!
handleReceptiveAccount: aReceptiveAccount
	|depthFromFinancialAsset |
	
	depthFromFinancialAsset := 4 * (aReceptiveAccount depthFrom: financialAsset).
	
	self indentNewLineOf: stream withSpace: depthFromFinancialAsset andThenWrite: aReceptiveAccount class asString.
	
	self addSummaryFrom: aReceptiveAccount to: stream withIndentation: (4 + depthFromFinancialAsset).! !


!SpecialSummaryReport methodsFor: 'private - stream indentation' stamp: 'NI 6/2/2019 12:53:23'!
indentNewLineOf: aStream withSpace: indentationSpaceAmount andThenWrite: aStringToWrite
	stream newLine; space: indentationSpaceAmount; nextPutAll: aStringToWrite.! !


!SpecialSummaryReport methodsFor: 'private - summary' stamp: 'NI 6/2/2019 12:54:00'!
addSummaryFrom: aReceptiveAccount to: aStream withIndentation: anIndentationAmount
	
	| aReport accountSummaryReport |
	
	aReport := Report for: aReceptiveAccount.
	accountSummaryReport := aReport generateAccountSummary.

	accountSummaryReport do: [:anElement | 
		self indentNewLineOf: stream withSpace: anIndentationAmount andThenWrite: anElement.		
	].! !


!classDefinition: #SummaryReport category: #'PortfolioTreePrinter-Ejercicio'!
Report subclass: #SummaryReport
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummaryReport methodsFor: 'report generation' stamp: 'NI 6/2/2019 12:18:32'!
generate
	
	summary := OrderedCollection new.
	financialAsset transactions size = 0 ifTrue: [summary add: (self class balanceStringFor: financialAsset balance). ^ summary].
	
	financialAsset transactions do: [:aTransaction | 
		aTransaction handleReport: self.
	].
	
	summary add: (self class balanceStringFor: financialAsset balance).
	
	^ summary! !


!SummaryReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 11:36:34'!
handleDepositTransaction: aDepositTransaction
	summary add: (self class depositStringFor: (aDepositTransaction value))! !

!SummaryReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 11:36:39'!
handleDepositTransferTransaction: aDepositTransferTransaction
	summary add: (self class depositTransferStringFor: aDepositTransferTransaction value).! !

!SummaryReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 11:36:44'!
handleWithdrawTransaction: aWithdrawTransaction
	summary add: (self class withdrawStringFor: aWithdrawTransaction value).! !

!SummaryReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 11:36:49'!
handleWithdrawTransferTransaction: aWithdrawTransferTransaction
	summary add: (self class withdrawTransferStringFor: aWithdrawTransferTransaction value).! !


!classDefinition: #TransferNetReport category: #'PortfolioTreePrinter-Ejercicio'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferNetReport methodsFor: 'report generation' stamp: 'NI 5/31/2019 19:02:16'!
generate

	transferNet := 0.	

	financialAsset transactions do: [ :aTransaction |
		aTransaction handleReport: self.
	].

	^transferNet ! !


!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'JIG 5/31/2019 17:15:42'!
handleDepositTransaction: aWithdrawTransaction
	! !

!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'JIG 5/31/2019 17:17:45'!
handleDepositTransferTransaction: aDepositTransferTransaction
	transferNet := transferNet + aDepositTransferTransaction value! !

!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'JIG 5/31/2019 17:15:30'!
handleWithdrawTransaction: aWithdrawTransaction
	! !

!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'JIG 5/31/2019 17:17:48'!
handleWithdrawTransferTransaction: aTransferWithdrawTransaction
	transferNet := transferNet - aTransferWithdrawTransaction value.! !


!classDefinition: #TreeStructureReport category: #'PortfolioTreePrinter-Ejercicio'!
Report subclass: #TreeStructureReport
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TreeStructureReport methodsFor: 'report generation' stamp: 'NI 6/2/2019 11:11:41'!
generate
	stream := ReadWriteStream with: financialAsset class asString.
	
	financialAsset financialAssets do: [:aFinancialAsset |
		aFinancialAsset handleReport: self.
	].
	
	^stream! !


!TreeStructureReport methodsFor: 'private - financial assets handlers' stamp: 'NI 6/2/2019 11:10:41'!
handlePortfolio: aPortfolio
	self indentNewLineOf: stream withSpace: 4 * (aPortfolio depthFrom: financialAsset).
	stream nextPutAll: aPortfolio class asString.
	aPortfolio financialAssets do: [:aFinancialAsset | 
		aFinancialAsset handleReport: self.	
	]! !

!TreeStructureReport methodsFor: 'private - financial assets handlers' stamp: 'NI 6/2/2019 11:11:19'!
handleReceptiveAccount: aReceptiveAccount
	self indentNewLineOf: stream withSpace: 4 * (aReceptiveAccount depthFrom: financialAsset).
	stream nextPutAll: aReceptiveAccount class asString.! !


!TreeStructureReport methodsFor: 'private - stream indentation' stamp: 'NI 6/2/2019 11:10:31'!
indentNewLineOf: aStream withSpace: indentationSpaceAmount
	stream newLine; space: indentationSpaceAmount.
! !


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
