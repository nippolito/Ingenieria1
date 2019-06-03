!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:25:15'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: (Portfolio named: 'miPortfolio') balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:25:28'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount named: 'miCuenta'.
	Deposit register: 100 on: account.
	portfolio := Portfolio named: 'miPortfolio' with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:26:12'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount named: 'simplePortfolioAccount'.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'simplePortfolio' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'composedPortfolioAccount'.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio named: 'composedPortfolio' with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:26:31'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: ((Portfolio named: 'miPortfolio') hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:26:46'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount named: 'miCuenta'.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio named: 'miPortfolio' with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:27:20'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount named: 'simplePortfolioAccount'.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'simplePortfolio' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'composedPortfolioAccount'.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio named: 'composedPortfolio' with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:27:54'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: (Portfolio named: 'miCuenta') transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:28:14'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount named: 'account'.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio named: 'portfolio' with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:28:47'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount named: 'simplePortfolioAccount'.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'simplePortfolio' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'composedPortfolioAccount'.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio named: 'composedPortfolio' with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:29:01'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount named: 'account'.
	portfolio := Portfolio named: 'portfolio' with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio financialAssetsSize.
			self assert: (portfolio financialAssetsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:29:27'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount named: 'account'.
	simplePortfolio := Portfolio named: 'simplePortfolio' with: account.
	composedPortfolio := Portfolio named: 'composedPortfolio' with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio financialAssetsSize.
			self assert: (composedPortfolio financialAssetsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:29:39'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount named: 'account'.
	simplePortfolio := Portfolio named: 'simplePortfolio' with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio financialAssetsSize.
			self assert: (simplePortfolio financialAssetsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:30:00'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount named: 'account'.
	simplePortfolio := Portfolio named: 'simplePortfolio'.
	composedPortfolio := Portfolio named: 'composedPortfolio' with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio financialAssetsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:30:43'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount named: 'account'.
	portfolio := Portfolio named: 'portfolio'.
	leftParentPortfolio := Portfolio named: 'leftParentPortfolio' with: portfolio .
	leftRootParentPortfolio := Portfolio named: 'leftRootParentPortfolio' with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio named: 'rightParentPortfolio' with: portfolio .
	rightRootParentPortfolio := Portfolio named: 'rightRootParentPortfolio' with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio financialAssetsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:31:11'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount named: 'sharedAccount'.
	portfolioToModify := Portfolio named: 'portfolioToModify'.
	rootPortfolio := Portfolio named: 'rootPortfolio' with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio named: 'portfolioToAdd' with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify financialAssetsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:23:16'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount named: 'miCuenta'.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:23:25'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount named: 'miCuenta'.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:23:32'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount named: 'miCuenta'.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:23:39'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount named: 'miCuenta'.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:23:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount named: 'miCuenta'.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:23:52'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount named: 'miCuenta'.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NI 6/2/2019 21:23:58'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount named: 'miCuenta'.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'anAccountWithOneDeposit anAccountWithOneWithdraw depositAmount withdrawAmount firstEmptyAccount secondEmptyAccount anAccountWithThreeTransactions anotherDepositAmount anEmptyPortfolio aPortfolioWithTwoAccountsWithTransfers aPortfolioWithTwoEmptyAccounts'
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


!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:04:59'!
test00AccountSummaryReportInformsOnlyCeroBalanceWhenThereAreNotTransactions
	
	| aReport summaryAccountReport |
	
	aReport := Report for: firstEmptyAccount.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 1.
	self assert: (summaryAccountReport includes: (self balanceStringFor: firstEmptyAccount balance))! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:05:03'!
test01AccountSummaryReportInformsDepositProperly
	| aReport summaryAccountReport |
	
	aReport := Report for: anAccountWithOneDeposit.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport at: 1) = (self depositStringFor: depositAmount)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:05:06'!
test02AccountSummaryReportInformsWithdrawProperly
	| aReport summaryAccountReport |
	
	aReport := Report for: anAccountWithOneWithdraw.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport at: 1) = (self withdrawStringFor: withdrawAmount)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:05:10'!
test03AccountSummaryReportInformsWireWithdrawProperly
	| aReport summaryAccountReport |
	
	WireTransfer register: depositAmount from: firstEmptyAccount to: secondEmptyAccount.
	
	aReport := Report for: firstEmptyAccount .
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport at: 1) = (self withdrawTransferStringFor: depositAmount)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:05:14'!
test04AccountSummaryReportInformsWireDepositProperly
	| aReport summaryAccountReport |
	
	WireTransfer register: depositAmount from: firstEmptyAccount to: secondEmptyAccount .
	
	aReport := Report for: secondEmptyAccount .
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport includes: (self depositTransferStringFor: depositAmount ))! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:05:22'!
test05OneTransactionAccountSummaryReportInformsBalanceProperly
	| aReport summaryAccountReport |
	
	aReport := Report for: anAccountWithOneDeposit.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 2.
	self assert: (summaryAccountReport at: 2) equals: (self balanceStringFor: anAccountWithOneDeposit balance).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:05:32'!
test06AccountSummaryReportInformsMultipleTransactionsProperly
	| aReport summaryAccountReport |
	
	Withdraw register: withdrawAmount on: anAccountWithOneDeposit .
	
	aReport := Report for: anAccountWithOneDeposit .
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 3.
	self assert: (summaryAccountReport includes: (self withdrawStringFor: withdrawAmount )).
	self assert: (summaryAccountReport includes: (self depositStringFor: depositAmount )).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:05:41'!
test07AccountSummaryReportMantainsTransactionOrder
	| aReport summaryAccountReport |
	
	aReport := Report for: anAccountWithThreeTransactions.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 4.
	self assert: (summaryAccountReport at: 1) equals: (self depositStringFor: depositAmount ).
	self assert: (summaryAccountReport at: 2) equals: (self withdrawStringFor: withdrawAmount ).
	self assert: (summaryAccountReport at: 3) equals: (self depositStringFor: anotherDepositAmount ).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:05:54'!
test08ManyTransactionsAccountSummaryReportInformsBalanceProperly
	| aReport summaryAccountReport |
	
	aReport := Report for: anAccountWithThreeTransactions.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 4.
	self assert: (summaryAccountReport at: 4) equals: (self balanceStringFor: anAccountWithThreeTransactions balance).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 15:09:12'!
test09EmptyTransactionsFinancialAssetTransferNetShouldBeCero
	| aReport trasnferNetReport |
	
	aReport := Report for: firstEmptyAccount.
	trasnferNetReport := aReport generateAccountTransferNet.
	
	self assert: trasnferNetReport isZero.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:12:42'!
test10PortfolioSummaryReportInformsAllTheirAccountTransactionsProperly
	| aReport summaryAccountReport |
	
	aReport := Report for: aPortfolioWithTwoAccountsWithTransfers.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 3.
	self assert: (summaryAccountReport at: 1) equals: (self withdrawStringFor: withdrawAmount).
	self assert: (summaryAccountReport at: 2) equals: (self depositStringFor: depositAmount).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:13:41'!
test11PortfolioSummaryReportSumsTheirAccountTransactionsBalance
	| aReport summaryAccountReport |
	
	aReport := Report for: aPortfolioWithTwoAccountsWithTransfers.
	summaryAccountReport := aReport generateAccountSummary.
	
	self assert: summaryAccountReport size equals: 3.
	self assert: (summaryAccountReport at: 3) equals: (self balanceStringFor: aPortfolioWithTwoAccountsWithTransfers balance).! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:21:09'!
test12AccountTransferNetSumsWireDeposit	
	| aReport trasnferNetReport |
	
	WireTransfer register: depositAmount from: firstEmptyAccount to: secondEmptyAccount .
	
	aReport := Report for: secondEmptyAccount .
	trasnferNetReport := aReport generateAccountTransferNet.
	
	self assert: trasnferNetReport equals: depositAmount.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:21:14'!
test13AccountTransferNetSubstractsWireWithdraw	
	| aReport trasnferNetReport |

	WireTransfer register: depositAmount from: firstEmptyAccount to: secondEmptyAccount .
	
	aReport := Report for: firstEmptyAccount .
	trasnferNetReport := aReport generateAccountTransferNet.
	
	self assert: trasnferNetReport equals: (-1) * depositAmount .! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:21:16'!
test14AccountTransferNetCanHandleMultipleTransfers	
	| firstReport secondReport firstTransferNetReport secondTransferNetReport |
	
	WireTransfer register: depositAmount from: firstEmptyAccount to: secondEmptyAccount .
	WireTransfer register: withdrawAmount from: secondEmptyAccount to: firstEmptyAccount .
	
	firstReport := Report for: firstEmptyAccount .
	secondReport := Report for: secondEmptyAccount .
	firstTransferNetReport := firstReport generateAccountTransferNet.
	secondTransferNetReport := secondReport generateAccountTransferNet.
	
	self assert: firstTransferNetReport equals: withdrawAmount - depositAmount .
	self assert: secondTransferNetReport equals: depositAmount - withdrawAmount ! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:21:19'!
test15AccountTransferNetIgnoresNotWiredTransfers	
	| aReport transferNetReport |
	
	Withdraw register: withdrawAmount on: anAccountWithOneDeposit .
	
	aReport := Report for: anAccountWithOneDeposit.
	transferNetReport := aReport generateAccountTransferNet.
	
	self assert: transferNetReport isZero.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/2/2019 23:29:12'!
test16PortfolioTransferNetSumsAllOfTheirAccountsWireTransfers
	| aReport transferNetReport aPortfolio thirdEmptyAccount |
	
	thirdEmptyAccount := ReceptiveAccount named: 'thirdEmptyAccount'.
	WireTransfer register: depositAmount from: firstEmptyAccount to: secondEmptyAccount.
	WireTransfer register: withdrawAmount from: firstEmptyAccount to: thirdEmptyAccount.
	
	aPortfolio := Portfolio named: 'miPortfolio' with: firstEmptyAccount with: thirdEmptyAccount.
	
	aReport := Report for: aPortfolio.
	transferNetReport := aReport generateAccountTransferNet.
	
	self assert: transferNetReport equals: (-1) * (depositAmount + withdrawAmount) + withdrawAmount.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/3/2019 10:26:37'!
test17TreeStructureDoesntIndentSimplePortfolio
	| aReport treeStructureReport |
	
	aReport := Report for: anEmptyPortfolio.
	treeStructureReport := aReport generateTreeStructureReport.
	
	treeStructureReport reset.
	self assert: treeStructureReport nextLine equals: ''.
	self assert: treeStructureReport nextLine equals: 'anEmptyPortfolio'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/3/2019 10:26:48'!
test18TreeStructureIndentsOncePortfoliosAccounts
	| aReport treeStructureReport |
	
	aReport := Report for: aPortfolioWithTwoEmptyAccounts.
	treeStructureReport := aReport generateTreeStructureReport.
	
	treeStructureReport reset.
	self assert: treeStructureReport nextLine equals: ''.
	self assert: treeStructureReport nextLine equals: 'aPortfolioWithTwoEmptyAccounts'.
	self assert: treeStructureReport nextLine equals: '    firstEmptyAccount'.
	self assert: treeStructureReport nextLine equals: '    secondEmptyAccount'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/3/2019 10:26:53'!
test19TreeStructurePortfolioIndentsGrandchildrenTwice
	| aReport treeStructureReport fatherPortfolio |
	
	fatherPortfolio := Portfolio named: 'fatherPortfolio' with: aPortfolioWithTwoAccountsWithTransfers with: firstEmptyAccount.
	
	aReport := Report for: fatherPortfolio.
	treeStructureReport := aReport generateTreeStructureReport.
	
	treeStructureReport reset.
	self assert: treeStructureReport nextLine equals: ''.
	self assert: treeStructureReport nextLine equals: 'fatherPortfolio'.
	self assert: treeStructureReport nextLine equals: '    aPortfolioWithTwoAccountsWithTransfers'.
	self assert: treeStructureReport nextLine equals: '        anAccountWithOneWithdraw'.
	self assert: treeStructureReport nextLine equals: '        anAccountWithOneDeposit'.
	self assert: treeStructureReport nextLine equals: '    firstEmptyAccount'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/3/2019 10:26:56'!
test20TreeStructureIndentsRecursivelyBasedOnDepth
	| aReport treeStructureReport aPortfolio secondFatherPortfolio grandFatherPortfolio |
	
	aPortfolio := Portfolio named: 'aPortfolio' with: anAccountWithOneDeposit .
	secondFatherPortfolio := Portfolio named: 'secondFatherPortfolio' with: aPortfolio with: anAccountWithOneWithdraw .
	grandFatherPortfolio := Portfolio named: 'grandFatherPortfolio' with: aPortfolioWithTwoEmptyAccounts with: secondFatherPortfolio.

	aReport := Report for: grandFatherPortfolio.
	treeStructureReport := aReport generateTreeStructureReport.
	
	treeStructureReport reset.
	self assert: treeStructureReport nextLine equals: ''.
	self assert: treeStructureReport nextLine equals: 'grandFatherPortfolio'.
	self assert: treeStructureReport nextLine equals: '    aPortfolioWithTwoEmptyAccounts'.
	self assert: treeStructureReport nextLine equals: '        firstEmptyAccount'.
	self assert: treeStructureReport nextLine equals: '        secondEmptyAccount'.
	self assert: treeStructureReport nextLine equals: '    secondFatherPortfolio'.
	self assert: treeStructureReport nextLine equals: '        aPortfolio'.
	self assert: treeStructureReport nextLine equals: '            anAccountWithOneDeposit'.
	self assert: treeStructureReport nextLine equals: '        anAccountWithOneWithdraw'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/3/2019 10:24:09'!
test21SpecialSummaryIndentsOnlyBalanceOnSimplePortfolio
	| aReport aSpecialSummaryReport |
	
	aReport := Report for: anEmptyPortfolio .
	aSpecialSummaryReport := aReport generateSpecialSummaryReport.
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: ''.
	self assert: aSpecialSummaryReport nextLine equals: 'anEmptyPortfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '    Balance = 0.'.! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/3/2019 10:24:21'!
test22SpecialSummaryWorksCorrectlyOnAPortfolioWithAccountsWithoutTransactions
	| aReport aSpecialSummaryReport |
	
	aReport := Report for: aPortfolioWithTwoEmptyAccounts.
	aSpecialSummaryReport := aReport generateSpecialSummaryReport .
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: ''.
	self assert: aSpecialSummaryReport nextLine equals: 'aPortfolioWithTwoEmptyAccounts'.
	self assert: aSpecialSummaryReport nextLine equals: '    firstEmptyAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        Balance = 0.'.
	self assert: aSpecialSummaryReport nextLine equals: '    secondEmptyAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        Balance = 0.'.
	self assert: aSpecialSummaryReport nextLine equals: '    Balance = 0.'! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/3/2019 10:24:26'!
test23SpecialSummaryWorksCorrectlyOnAPortfolioWithAccountsWithTransactions
	| aReport aSpecialSummaryReport |
	
	aReport := Report for: aPortfolioWithTwoAccountsWithTransfers.
	aSpecialSummaryReport := aReport generateSpecialSummaryReport . 
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: ''.
	self assert: aSpecialSummaryReport nextLine equals: 'aPortfolioWithTwoAccountsWithTransfers'.
	self assert: aSpecialSummaryReport nextLine equals: '    anAccountWithOneWithdraw'.
	self assert: aSpecialSummaryReport nextLine equals: '        ' , (self withdrawStringFor: withdrawAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '        ' , (self balanceStringFor: anAccountWithOneWithdraw balance).
	self assert: aSpecialSummaryReport nextLine equals: '    anAccountWithOneDeposit'.
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self depositStringFor: depositAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: anAccountWithOneDeposit balance).
	self assert: aSpecialSummaryReport nextLine equals: '    ', (self balanceStringFor: aPortfolioWithTwoAccountsWithTransfers balance)! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/3/2019 10:24:30'!
test24SpecialSummaryWorksCorrectlyOnAPortfolioWithPortfolioAndAccounts
	| aReport aSpecialSummaryReport aPortfolio fatherPortfolio |
	
	WireTransfer register: anotherDepositAmount from: anAccountWithOneWithdraw to: firstEmptyAccount. 
	
	aPortfolio := Portfolio named: 'aPortfolio' with: anAccountWithOneWithdraw with: anAccountWithOneDeposit .
	fatherPortfolio := Portfolio named: 'fatherPortfolio' with: aPortfolio with: firstEmptyAccount .
	
	aReport := Report for: fatherPortfolio.
	aSpecialSummaryReport := aReport generateSpecialSummaryReport .
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: ''.
	self assert: aSpecialSummaryReport nextLine equals: 'fatherPortfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '    aPortfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '        anAccountWithOneWithdraw'.
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self withdrawStringFor: withdrawAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self withdrawTransferStringFor: anotherDepositAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self balanceStringFor: anAccountWithOneWithdraw balance).
	self assert: aSpecialSummaryReport nextLine equals: '        anAccountWithOneDeposit'.
	self assert: aSpecialSummaryReport nextLine equals: '            ', (self depositStringFor: depositAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self balanceStringFor: anAccountWithOneDeposit balance).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: aPortfolio balance).
	self assert: aSpecialSummaryReport nextLine equals: '    firstEmptyAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self depositTransferStringFor: anotherDepositAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: firstEmptyAccount balance).
	self assert: aSpecialSummaryReport nextLine equals: '    ', (self balanceStringFor: fatherPortfolio balance).
	
	
	! !

!ReportTest methodsFor: 'tests' stamp: 'NI 6/3/2019 10:24:33'!
test25SpecialSummaryIndentsRecursivelyBasedOnDepth
	| aReport aSpecialSummaryReport parentPortfolio grandFatherPortfolio aPortfolio |
	
	WireTransfer register: anotherDepositAmount from: anAccountWithOneWithdraw to: firstEmptyAccount. 
	
	aPortfolio := Portfolio named: 'aPortfolio' with: anAccountWithOneDeposit.
	parentPortfolio := Portfolio named: 'parentPortfolio' with: anAccountWithOneWithdraw with: aPortfolio.
	grandFatherPortfolio := Portfolio named: 'grandFatherPortfolio' with: parentPortfolio with: firstEmptyAccount .
	
	aReport := Report for: grandFatherPortfolio.
	aSpecialSummaryReport := aReport generateSpecialSummaryReport .
	
	aSpecialSummaryReport reset.
	self assert: aSpecialSummaryReport nextLine equals: ''.
	self assert: aSpecialSummaryReport nextLine equals: 'grandFatherPortfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '    parentPortfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '        anAccountWithOneWithdraw'.
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self withdrawStringFor: withdrawAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self withdrawTransferStringFor: anotherDepositAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '            ' , (self balanceStringFor: anAccountWithOneWithdraw balance).
	self assert: aSpecialSummaryReport nextLine equals: '        aPortfolio'.
	self assert: aSpecialSummaryReport nextLine equals: '            anAccountWithOneDeposit'.
	self assert: aSpecialSummaryReport nextLine equals: '                ', (self depositStringFor: depositAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '                ' , (self balanceStringFor: anAccountWithOneDeposit balance).
	self assert: aSpecialSummaryReport nextLine equals: '            ', (self balanceStringFor: aPortfolio balance).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: parentPortfolio balance).
	self assert: aSpecialSummaryReport nextLine equals: '    firstEmptyAccount'.
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self depositTransferStringFor: anotherDepositAmount ).
	self assert: aSpecialSummaryReport nextLine equals: '        ', (self balanceStringFor: firstEmptyAccount balance).
	self assert: aSpecialSummaryReport nextLine equals: '    ', (self balanceStringFor: grandFatherPortfolio balance).
	
	
	! !


!ReportTest methodsFor: 'setup' stamp: 'NI 6/2/2019 21:40:45'!
setUp
	firstEmptyAccount := ReceptiveAccount named: 'firstEmptyAccount'.
	secondEmptyAccount := ReceptiveAccount named: 'secondEmptyAccount'.
	anAccountWithOneDeposit := ReceptiveAccount named: 'anAccountWithOneDeposit'.
	anAccountWithOneWithdraw := ReceptiveAccount named: 'anAccountWithOneWithdraw'.
	anAccountWithThreeTransactions := ReceptiveAccount named: 'anAccountWithThreeTransactions'.
	
	depositAmount := 25.
	Deposit register: depositAmount on: anAccountWithOneDeposit.
	
	withdrawAmount := 50.
	Withdraw register: withdrawAmount on: anAccountWithOneWithdraw.
	
	anotherDepositAmount := 120.
	Deposit register: depositAmount on: anAccountWithThreeTransactions.
	Withdraw register: withdrawAmount on: anAccountWithThreeTransactions.
	Deposit register: anotherDepositAmount on: anAccountWithThreeTransactions.
	
	anEmptyPortfolio := Portfolio named: 'anEmptyPortfolio'.
	aPortfolioWithTwoAccountsWithTransfers := Portfolio named: 'aPortfolioWithTwoAccountsWithTransfers' with: anAccountWithOneWithdraw with: anAccountWithOneDeposit.
	aPortfolioWithTwoEmptyAccounts := Portfolio named: 'aPortfolioWithTwoEmptyAccounts' with: firstEmptyAccount with: secondEmptyAccount.! !


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


!WireTransferTest methodsFor: 'setup' stamp: 'NI 6/2/2019 21:39:37'!
setUp
	myAccount := ReceptiveAccount named: 'myAccount'.
	otherAccount := ReceptiveAccount named: 'otherAccount'.! !


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
	instanceVariableNames: 'parents name'
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


!FinancialAsset methodsFor: 'accessing' stamp: 'NI 6/2/2019 22:02:21'!
name
	^name! !


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

!Portfolio methodsFor: 'initialization' stamp: 'NI 6/2/2019 21:22:05'!
initializeWithName: aName

	financialAssets := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName! !


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


!Portfolio class methodsFor: 'initialization' stamp: 'NI 6/2/2019 21:24:49'!
named: aName

	^ (self new initializeWithName: aName).
	"^self new 
		add: aFinancialAsset;
		yourself"! !

!Portfolio class methodsFor: 'initialization' stamp: 'NI 6/2/2019 21:21:50'!
named: aName with: aFinancialAsset

	^ (self new initializeWithName: aName) add: aFinancialAsset; yourself.
	"^self new 
		add: aFinancialAsset;
		yourself"! !

!Portfolio class methodsFor: 'initialization' stamp: 'NI 6/2/2019 21:22:45'!
named: aName with: aFinancialAsset with: anotherFinancialAsset

	^ (self new initializeWithName: aName) add: aFinancialAsset; add: anotherFinancialAsset; yourself.! !

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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NI 6/2/2019 21:19:54'!
initializeWithName: aName

	transactions := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'initialization' stamp: 'NI 6/2/2019 21:19:28'!
named: aName
	^ self new initializeWithName: aName.! !


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

!Report methodsFor: 'private' stamp: 'NI 6/2/2019 23:14:45'!
handleReportForFinancialAssetsOf: aPortfolio
	
	aPortfolio financialAssets do: [:aFinancialAsset |
		aFinancialAsset handleReport: self.
	].! !

!Report methodsFor: 'private' stamp: 'NI 6/2/2019 23:17:03'!
handleReportForTransactionsOf: aReceptiveAccount.
	aReceptiveAccount transactions do: [:aTransaction | 
		aTransaction handleReport: self.
	].! !

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


!classDefinition: #SpecialPortfolioReport category: #'PortfolioTreePrinter-Ejercicio'!
Report subclass: #SpecialPortfolioReport
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SpecialPortfolioReport methodsFor: 'private' stamp: 'NI 6/3/2019 10:28:08'!
createStream
	stream := ReadWriteStream with: ''.! !

!SpecialPortfolioReport methodsFor: 'private' stamp: 'NI 6/2/2019 20:59:26'!
write: aStringToWrite on: aStream withSpaceOnNewLine: indentationSpaceAmount
	aStream newLine; space: indentationSpaceAmount; nextPutAll: aStringToWrite.! !


!classDefinition: #SpecialSummaryReport category: #'PortfolioTreePrinter-Ejercicio'!
SpecialPortfolioReport subclass: #SpecialSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SpecialSummaryReport methodsFor: 'report generation' stamp: 'NI 6/3/2019 10:28:19'!
generate	
	self createStream.
	
	financialAsset handleReport: self.
	
	self write: (self class balanceStringFor: financialAsset balance) on: stream withSpaceOnNewLine: 4 . 	
	
	^stream! !


!SpecialSummaryReport methodsFor: 'private - financial assets handlers' stamp: 'NI 6/3/2019 10:30:33'!
handlePortfolio: aPortfolio
	|indentSpaceAmount |
	
	indentSpaceAmount := 4 * (aPortfolio depthFrom: financialAsset).

	self write: aPortfolio name on: stream withSpaceOnNewLine: indentSpaceAmount.
	
	self handleReportForFinancialAssetsOf: aPortfolio.

	self write: (self class balanceStringFor: aPortfolio balance) on: stream withSpaceOnNewLine: indentSpaceAmount + 4. ! !

!SpecialSummaryReport methodsFor: 'private - financial assets handlers' stamp: 'NI 6/3/2019 10:30:39'!
handleReceptiveAccount: aReceptiveAccount
	|indentSpaceAmount |
	
	indentSpaceAmount := 4 * (aReceptiveAccount depthFrom: financialAsset).
	
	self write: aReceptiveAccount name on: stream  withSpaceOnNewLine: indentSpaceAmount .
	
	self addSummaryFrom: aReceptiveAccount to: stream withIndentation: (4 + indentSpaceAmount).! !


!SpecialSummaryReport methodsFor: 'private - summary' stamp: 'NI 6/2/2019 14:35:55'!
addSummaryFrom: aReceptiveAccount to: aStream withIndentation: anIndentationAmount
	
	| aReport accountSummaryReport |
	
	aReport := Report for: aReceptiveAccount.
	accountSummaryReport := aReport generateAccountSummary.

	accountSummaryReport do: [:anElement | 
		self write: anElement on: aStream withSpaceOnNewLine: anIndentationAmount .		
	].! !


!classDefinition: #TreeStructureReport category: #'PortfolioTreePrinter-Ejercicio'!
SpecialPortfolioReport subclass: #TreeStructureReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TreeStructureReport methodsFor: 'report generation' stamp: 'NI 6/3/2019 10:28:00'!
generate
	self createStream.
	
	financialAsset handleReport: self.
	
	^stream! !


!TreeStructureReport methodsFor: 'private - financial assets handlers' stamp: 'NI 6/3/2019 10:30:25'!
handlePortfolio: aPortfolio
	|indentSpaceAmount |
	
	indentSpaceAmount := 4 * (aPortfolio depthFrom: financialAsset).
	
	self write: aPortfolio name on: stream withSpaceOnNewLine: indentSpaceAmount.
	
	self handleReportForFinancialAssetsOf: aPortfolio.! !

!TreeStructureReport methodsFor: 'private - financial assets handlers' stamp: 'NI 6/3/2019 10:30:12'!
handleReceptiveAccount: aReceptiveAccount
	|indentSpaceAmount |
	
	indentSpaceAmount := 4 * (aReceptiveAccount depthFrom: financialAsset).
	
	self write: aReceptiveAccount name on: stream withSpaceOnNewLine: indentSpaceAmount.! !


!classDefinition: #SummaryReport category: #'PortfolioTreePrinter-Ejercicio'!
Report subclass: #SummaryReport
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummaryReport methodsFor: 'report generation' stamp: 'NI 6/3/2019 10:15:22'!
generate
	
	summary := OrderedCollection new.
	
	financialAsset handleReport: self.
	
	summary add: (self class balanceStringFor: financialAsset balance).
	
	^ summary! !


!SummaryReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 11:36:34'!
handleDepositTransaction: aDepositTransaction
	summary add: (self class depositStringFor: (aDepositTransaction value))! !

!SummaryReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 11:36:39'!
handleDepositTransferTransaction: aDepositTransferTransaction
	summary add: (self class depositTransferStringFor: aDepositTransferTransaction value).! !

!SummaryReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 23:16:02'!
handlePortfolio: aPortfolio
	self handleReportForFinancialAssetsOf: aPortfolio.! !

!SummaryReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 23:17:11'!
handleReceptiveAccount: aReceptiveAccount
	self handleReportForTransactionsOf: aReceptiveAccount.! !

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

!TransferNetReport methodsFor: 'report generation' stamp: 'NI 6/2/2019 23:04:00'!
generate

	transferNet := 0.	

	financialAsset handleReport: self.

	^transferNet ! !


!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'JIG 5/31/2019 17:15:42'!
handleDepositTransaction: aWithdrawTransaction
	! !

!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'JIG 5/31/2019 17:17:45'!
handleDepositTransferTransaction: aDepositTransferTransaction
	transferNet := transferNet + aDepositTransferTransaction value! !

!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 23:16:07'!
handlePortfolio: aPortfolio
	self handleReportForFinancialAssetsOf: aPortfolio.! !

!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'NI 6/2/2019 23:17:26'!
handleReceptiveAccount: aReceptiveAccount
	self handleReportForTransactionsOf: aReceptiveAccount.! !

!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'JIG 5/31/2019 17:15:30'!
handleWithdrawTransaction: aWithdrawTransaction
	! !

!TransferNetReport methodsFor: 'private - transaction handlers' stamp: 'JIG 5/31/2019 17:17:48'!
handleWithdrawTransferTransaction: aTransferWithdrawTransaction
	transferNet := transferNet - aTransferWithdrawTransaction value.! !


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
