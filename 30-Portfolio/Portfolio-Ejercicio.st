!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'transactions accountWith100Deposit accountWith25Withdraw accountWith100DepositTransaction accountWith25WithdrawTransaction portfolioWithAcc100Deposit portfolioWithAcc100DepositAndAcc25Withdraw portfolioWithAcc25Withdraw portfolioWithPortfolioWithAcc100Deposit accountWithoutTransactions portfolioWith25WithdrawAndWithoutTransactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:15:47'!
test00CannotCreateEmptyPortfolio	
	
	self should: [Portfolio for: nil.] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: Portfolio cannotCreateEmptyPortfolioErrorDescription = anError messageText].
! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:35:23'!
test01PortfolioCreatedWithOneAccountHasExactlyOneAccount
	
	self assert: portfolioWithAcc100Deposit accountAmounts = 1.! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:35:32'!
test02BalanceOfAPortfolioWithOnlyOneAccountEqualsToBalanceOfThatAccount
	
	self assert: portfolioWithAcc100Deposit balance = accountWith100Deposit balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:35:43'!
test03TransactionsOfAPortfolioWithOnlyOneAccountEqualsToTransactionsOfThatAccount
	
	self assert: (portfolioWithAcc100Deposit transactions includesAllOf: accountWith100Deposit transactions).
	self assert: portfolioWithAcc100Deposit transactions size = 1.! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 14:29:43'!
test04APortfolioWithOnlyOneAccountHasRegisteredAllTransactionsOfThatAccount
	| anotherTransaction |
	
	anotherTransaction := Deposit register: 120 on: accountWith100Deposit.
	
	self assert: (portfolioWithAcc100Deposit hasRegistered: anotherTransaction) = (accountWith100Deposit hasRegistered: anotherTransaction).! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:36:39'!
test05APortfolioWithManyAccountsHasTheBalanceOfTheirAccountsSummed
	
	self assert: portfolioWithAcc100DepositAndAcc25Withdraw balance = (accountWith100Deposit balance + accountWith25Withdraw balance).! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 14:30:16'!
test06APortfolioWithManyAccountsHasAllOfTheirAccountsTransactions
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: accountWith100Deposit transactions).
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: (accountWith25Withdraw transactions)).
	self assert: portfolioWithAcc100DepositAndAcc25Withdraw transactions size = 2.! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 14:30:34'!
test07APortfolioWithManyAccountsHasRegisteredAllTransactionsOfHisAccounts
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: accountWith100DepositTransaction ) = (accountWith100Deposit hasRegistered: accountWith100DepositTransaction ).
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: accountWith25WithdrawTransaction ) = (accountWith25Withdraw hasRegistered: accountWith25WithdrawTransaction ).! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 15:24:30'!
test08APortfolioCanAddANewAccount
	| aNewAccount |
	
	aNewAccount := ReceptiveAccount new.
	
	portfolioWithAcc100DepositAndAcc25Withdraw addFinancialAsset: aNewAccount.

	self assert: portfolioWithAcc100DepositAndAcc25Withdraw accountAmounts = 3.! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:30'!
test09APortfolioCreatedWithOnePortfolioHasThatPortfolioAccountsAndTransactions
	|ourPortfolio |
	
	ourPortfolio := Portfolio for: (OrderedCollection with: portfolioWithAcc100DepositAndAcc25Withdraw).

	self assert: ourPortfolio accountAmounts = portfolioWithAcc100DepositAndAcc25Withdraw accountAmounts.
	self assert: (ourPortfolio transactions includesAllOf: portfolioWithAcc100DepositAndAcc25Withdraw transactions).
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: ourPortfolio transactions).! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 15:24:30'!
test10APortfolioWithManyAccountsCannotContainDuplicates
	
	self should: [portfolioWithAcc100DepositAndAcc25Withdraw addFinancialAsset: accountWith25Withdraw] 
	raise: Error  
	withExceptionDo: [:anError|
		Portfolio cannotContainDuplicatesErrorDescription = anError messageText ].
	

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 15:24:30'!
test11AddingANewPortfolioToAnExistingPortfolioAltersPortfolioBalanceCorrectly
	| aThirdAccount ourAnotherPortfolio portfolioCurrentBalance |
	
	portfolioCurrentBalance := portfolioWithAcc100DepositAndAcc25Withdraw balance.
	
	aThirdAccount := ReceptiveAccount new.
	Deposit register: 100 on: aThirdAccount.
	ourAnotherPortfolio := Portfolio for: (OrderedCollection with: aThirdAccount).
	
	portfolioWithAcc100DepositAndAcc25Withdraw addFinancialAsset: ourAnotherPortfolio.
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw balance = (portfolioCurrentBalance + ourAnotherPortfolio balance)).
	

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 15:24:30'!
test12AddingANewPortfolioToAnExistingPortfolioAltersTransactionsCorrectly
	| aThirdAccount ourAnotherPortfolio portfolioCurrentTransactions |
	
	portfolioCurrentTransactions := portfolioWithAcc100DepositAndAcc25Withdraw transactions.
	
	aThirdAccount := ReceptiveAccount new.
	Deposit register: 100 on: aThirdAccount.
	
	ourAnotherPortfolio := Portfolio for: (OrderedCollection with: aThirdAccount).

	portfolioWithAcc100DepositAndAcc25Withdraw addFinancialAsset: ourAnotherPortfolio.
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: accountWith100Deposit transactions). 
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: accountWith25Withdraw transactions). 
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: ourAnotherPortfolio transactions ).
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions size = (portfolioCurrentTransactions size + ourAnotherPortfolio transactions size)).

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 15:24:30'!
test13AddingANewPortfolioToAnExistingPortfolioShouldKnowThatTheNewPortfolioTransactionsAreNowRegistered
	| aThirdAccount ourAnotherPortfolio thirdTransaction |
	
	aThirdAccount := ReceptiveAccount new.
	thirdTransaction := Deposit register: 100 on: aThirdAccount.
	
	ourAnotherPortfolio := Portfolio for: (OrderedCollection with: aThirdAccount).

	portfolioWithAcc100DepositAndAcc25Withdraw addFinancialAsset: ourAnotherPortfolio.
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: accountWith100DepositTransaction ). 
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: accountWith25WithdrawTransaction). 
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: thirdTransaction).

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 15:41:46'!
test14APortfolioWithAccountsAndPortfolioCannotContainDuplicates

	self should: [portfolioWithAcc100DepositAndAcc25Withdraw addFinancialAsset: portfolioWithAcc100Deposit ] 
	raise: Error  
	withExceptionDo: [:anError |
		self assert: (anError messageText = Portfolio cannotContainDuplicatesErrorDescription)].
	
	
		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 15:41:53'!
test15APortfolioWithAccountsAndPortfolioCannotContainDuplicatesWhenAddingAccountToInnerPortfolio
	|ourPortfolio accountCarlos |
	
	accountCarlos := ReceptiveAccount new.
	ourPortfolio := Portfolio for: (OrderedCollection with: accountCarlos).
	
	portfolioWithAcc100DepositAndAcc25Withdraw addFinancialAsset: ourPortfolio.

	self should: [portfolioWithAcc100DepositAndAcc25Withdraw addFinancialAsset: accountCarlos] 
	raise: Error  
	withExceptionDo: [:anError |
		self assert: (anError messageText = Portfolio cannotContainDuplicatesErrorDescription)].
	
		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 15:41:59'!
test16APortfolioCannotMakeAnyPortfolioThatContainsHimDirectlyHaveDuplicateInformation
	| portfolioA |
	
	portfolioA := Portfolio for: (OrderedCollection with: portfolioWithAcc100Deposit with: portfolioWith25WithdrawAndWithoutTransactions).
	
	self should: [portfolioWithAcc100Deposit addFinancialAsset: accountWithoutTransactions] 
	raise: Error  
	withExceptionDo: [:anError |
		self assert: (anError messageText = Portfolio cannotContainDuplicatesErrorDescription)].
		! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/27/2019 15:42:12'!
test17APortfolioCannotMakeAnyPortfolioThanContainsHimIndirectlyHaveDuplicateInformation
	| accountA portfolioA portfolioB portfolioC portfolioD |
	
	accountA := ReceptiveAccount new.
	
	portfolioA := Portfolio for: (OrderedCollection with: accountA).
	portfolioB := Portfolio for: (OrderedCollection with: portfolioWithAcc100Deposit with: portfolioA).
	
	portfolioC := Portfolio for: (OrderedCollection with: portfolioB with: portfolioWith25WithdrawAndWithoutTransactions).
	portfolioD := Portfolio for: (OrderedCollection with: portfolioWithPortfolioWithAcc100Deposit with: portfolioWith25WithdrawAndWithoutTransactions).

	self should: [portfolioWithAcc100Deposit addFinancialAsset: portfolioWithAcc25Withdraw] 
	raise: Error  
	withExceptionDo: [:anError |
		self assert: (anError messageText = Portfolio cannotContainDuplicatesErrorDescription)].
		! !


!PortfolioTest methodsFor: 'setup' stamp: 'Nipo 5/27/2019 15:10:33'!
setUp
	accountWith100Deposit := ReceptiveAccount new.
	accountWith100DepositTransaction :=  Deposit register: 100 on: accountWith100Deposit.
	
	accountWith25Withdraw := ReceptiveAccount new.
	accountWith25WithdrawTransaction := Withdraw register: 25 on: accountWith25Withdraw.
	
	accountWithoutTransactions :=  ReceptiveAccount new.
	
	portfolioWithAcc100Deposit := Portfolio for: (OrderedCollection with: accountWith100Deposit).
	portfolioWithAcc25Withdraw := Portfolio for: (OrderedCollection with: accountWith25Withdraw).
	portfolioWithAcc100DepositAndAcc25Withdraw := Portfolio for: (OrderedCollection with: accountWith100Deposit with: accountWith25Withdraw).
	
	portfolioWithPortfolioWithAcc100Deposit := Portfolio for: (OrderedCollection with: portfolioWithAcc100Deposit).
	
	portfolioWith25WithdrawAndWithoutTransactions := Portfolio for: (OrderedCollection with: accountWith25Withdraw with: accountWithoutTransactions).! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private' stamp: 'Nipo 5/23/2019 20:44:56'!
affectBalance: aBalance
	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'private' stamp: 'Nipo 5/23/2019 20:42:04'!
balanceValue

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
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


!Deposit methodsFor: 'private' stamp: 'Nipo 5/23/2019 20:45:23'!
affectBalance: aBalance
	^ aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
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


!Withdraw methodsFor: 'private' stamp: 'Nipo 5/23/2019 20:45:31'!
affectBalance: aBalance
	^ aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'parentFinancialAssets financialAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'Nipo 5/27/2019 15:39:50'!
initializeFor: someFinancialAssets
	someFinancialAssets = nil ifTrue: [self error: self class cannotCreateEmptyPortfolioErrorDescription].
	financialAssets := someFinancialAssets.
	parentFinancialAssets := OrderedCollection with: self.
	someFinancialAssets do: [:aFinancialAsset | aFinancialAsset addFinancialAssetParent: self]! !


!Portfolio methodsFor: 'balance' stamp: 'Nipo 5/27/2019 15:39:50'!
balance
	^ financialAssets sum: [:aFinancialAsset | aFinancialAsset balance].! !


!Portfolio methodsFor: 'transactions' stamp: 'Nipo 5/27/2019 15:39:50'!
transactions
	|transactionAccumulator|
	transactionAccumulator := OrderedCollection new.
	
	financialAssets do: [:aFinancialAsset | transactionAccumulator addAllLast: aFinancialAsset transactions ].
	
	^transactionAccumulator.! !


!Portfolio methodsFor: 'accessing' stamp: 'Nipo 5/27/2019 15:39:50'!
accountAmounts
	^ financialAssets inject: 0 into: [:accum :aFinancialAsset | accum + aFinancialAsset accountAmounts].! !


!Portfolio methodsFor: 'testing' stamp: 'Nipo 5/27/2019 15:39:50'!
hasRegistered: aTransaction
	^financialAssets anySatisfy: [:aFinancialAsset | aFinancialAsset hasRegistered: aTransaction ] .
	! !


!Portfolio methodsFor: 'adding' stamp: 'Nipo 5/27/2019 15:39:50'!
addFinancialAsset: aFinancialAsset
	(parentFinancialAssets anySatisfy: [:oneFinancialAsset | oneFinancialAsset checkIfNotDuplicateInformationWith: aFinancialAsset]) ifTrue: [ self error: self class cannotContainDuplicatesErrorDescription ].
	financialAssets add: aFinancialAsset.
	aFinancialAsset addFinancialAssetParent: self.! !


!Portfolio methodsFor: 'private' stamp: 'Nipo 5/27/2019 15:39:08'!
addFinancialAssetParent: aFinancialAsset
	(parentFinancialAssets at: 1) = self ifTrue: [parentFinancialAssets removeFirst].
 	parentFinancialAssets add: aFinancialAsset.
	! !

!Portfolio methodsFor: 'private' stamp: 'Nipo 5/27/2019 16:04:16'!
checkIfNotDuplicateInformationWith: aFinancialAsset	
	((parentFinancialAssets at: 1) = self) 
		ifTrue: [^self containsFinancialAsset: aFinancialAsset] 
		ifFalse: [
			^parentFinancialAssets anySatisfy: [:aPortfolio | aPortfolio checkIfNotDuplicateInformationWith: aFinancialAsset ]
		].! !

!Portfolio methodsFor: 'private' stamp: 'Nipo 5/27/2019 15:40:13'!
containsFinancialAsset: aFinancialAsset
	^financialAssets anySatisfy: [:oneFinancialAsset | oneFinancialAsset hasFinancialAsset: aFinancialAsset].! !

!Portfolio methodsFor: 'private' stamp: 'Nipo 5/27/2019 15:39:50'!
hasFinancialAsset: anAccount
	^ financialAssets anySatisfy: [:aFinancialAsset | aFinancialAsset hasFinancialAsset: anAccount].! !

!Portfolio methodsFor: 'private' stamp: 'Nipo 5/27/2019 15:39:50'!
includesAccount: anAccount
	^financialAssets includes: anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'initialization' stamp: 'NI 5/26/2019 20:00:18'!
for: someBankingStuff
	^ self new initializeFor: someBankingStuff! !


!Portfolio class methodsFor: 'error descriptions' stamp: 'NI 5/26/2019 20:00:28'!
cannotContainDuplicatesErrorDescription
	^'El portfolio no puede contener información duplicada.'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'Nipo 5/23/2019 21:12:10'!
cannotCreateAPortfolioWithInvalidEntriesErrorDescription
	^'No se puede crear un portfolio con entradas inválidas'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'Nipo 5/23/2019 21:07:38'!
cannotCreateEmptyPortfolioErrorDescription
	^'No se puede crear un portfolio vacío'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions parentFinancialAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Nipo 5/27/2019 15:22:29'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	parentFinancialAssets := OrderedCollection with: self.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'Nipo 5/27/2019 15:28:21'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'Nipo 5/23/2019 20:46:15'!
balance
	
	^ transactions inject: 0 into: [:currentBalance :aTransaction| aTransaction affectBalance: currentBalance].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'Nipo 5/23/2019 21:26:58'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'NI 5/26/2019 19:57:28'!
accountAmounts
	^1! !


!ReceptiveAccount methodsFor: 'private' stamp: 'Nipo 5/27/2019 15:39:08'!
addFinancialAssetParent: aFinancialAsset
	parentFinancialAssets add: aFinancialAsset! !

!ReceptiveAccount methodsFor: 'private' stamp: 'Nipo 5/27/2019 15:38:43'!
hasFinancialAsset: aFinancialAsset
	^aFinancialAsset includesAccount: self.! !

!ReceptiveAccount methodsFor: 'private' stamp: 'Nipo 5/27/2019 15:38:43'!
includesAccount: anAccount
	^self = anAccount.! !
