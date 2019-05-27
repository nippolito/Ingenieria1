!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'transactions accountWith100Deposit accountWith25Withdraw accountWith100DepositTransaction accountWith25WithdrawTransaction portfolioWithAcc100Deposit portfolioWithAcc100DepositAndAcc25Withdraw'
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

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:36:17'!
test04APortfolioWithOnlyOneAccountHasRegisteredTransactionsOfThatAccount
	| anotherTransaction |
	
	anotherTransaction := Deposit register: 120 on: accountWith100Deposit.
	
	self assert: (portfolioWithAcc100Deposit hasRegistered: anotherTransaction) = (accountWith100Deposit hasRegistered: anotherTransaction).! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:36:39'!
test05APortfolioWithManyAccountsHasTheBalanceOfTheirAccountsSummed
	
	self assert: portfolioWithAcc100DepositAndAcc25Withdraw balance = (accountWith100Deposit balance + accountWith25Withdraw balance).! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:36:51'!
test06APortfolioWithManyAccountsKeepAllTheTransactions
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: accountWith100Deposit transactions).
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: (accountWith25Withdraw transactions)).
	self assert: portfolioWithAcc100DepositAndAcc25Withdraw transactions size = 2.! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:37:00'!
test07APortfolioWithManyAccountsHasRegisteredTransactionsOfThoseAccounts
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: accountWith100DepositTransaction ) = (accountWith100Deposit hasRegistered: accountWith100DepositTransaction ).
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: accountWith25WithdrawTransaction ) = (accountWith25Withdraw hasRegistered: accountWith25WithdrawTransaction ).! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:37:16'!
test08APortfolioCanAddANewAccount
	| aNewAccount |
	
	aNewAccount := ReceptiveAccount new.
	
	portfolioWithAcc100DepositAndAcc25Withdraw add: aNewAccount.

	self assert: portfolioWithAcc100DepositAndAcc25Withdraw accountAmounts = 3.! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:30'!
test09APortfolioCreatedWithOnePortfolioHasThatPortfolioAccountsAndTransactions
	|ourPortfolio |
	
	ourPortfolio := Portfolio for: (OrderedCollection with: portfolioWithAcc100DepositAndAcc25Withdraw).

	self assert: ourPortfolio accountAmounts = portfolioWithAcc100DepositAndAcc25Withdraw accountAmounts.
	self assert: (ourPortfolio transactions includesAllOf: portfolioWithAcc100DepositAndAcc25Withdraw transactions).
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: ourPortfolio transactions).! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:26'!
test10APortfolioWithManyAccountsCannotContainDuplicates
	
	self should: [portfolioWithAcc100DepositAndAcc25Withdraw add: accountWith25Withdraw] 
	raise: Error  
	withExceptionDo: [:anError|
		Portfolio cannotContainDuplicatesErrorDescription = anError messageText ].
	

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:23'!
test11AddingANewPortfolioToAnExistingPortfolioShouldKeepTheTotalBalance
	| aThirdAccount ourAnotherPortfolio portfolioCurrentBalance |
	
	portfolioCurrentBalance := portfolioWithAcc100DepositAndAcc25Withdraw balance.
	
	aThirdAccount := ReceptiveAccount new.
	Deposit register: 100 on: aThirdAccount.
	ourAnotherPortfolio := Portfolio for: (OrderedCollection with: aThirdAccount).
	
	portfolioWithAcc100DepositAndAcc25Withdraw add: ourAnotherPortfolio.
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw balance = (portfolioCurrentBalance + ourAnotherPortfolio balance)).
	

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:20'!
test12AddingANewPortfolioToAnExistingPortfolioShouldKeepTheTotalTransactions
	| aThirdAccount ourAnotherPortfolio portfolioCurrentTransactions |
	
	portfolioCurrentTransactions := portfolioWithAcc100DepositAndAcc25Withdraw transactions.
	
	aThirdAccount := ReceptiveAccount new.
	Deposit register: 100 on: aThirdAccount.
	
	ourAnotherPortfolio := Portfolio for: (OrderedCollection with: aThirdAccount).

	portfolioWithAcc100DepositAndAcc25Withdraw add: ourAnotherPortfolio.
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: accountWith100Deposit transactions). 
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: accountWith25Withdraw transactions). 
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions includesAllOf: ourAnotherPortfolio transactions ).
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw transactions size = (portfolioCurrentTransactions size + ourAnotherPortfolio transactions size)).

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:17'!
test13AddingANewPortfolioToAnExistingPortfolioShouldKnowWhatTransactionsWereRegistered
	| aThirdAccount ourAnotherPortfolio thirdTransaction |
	
	aThirdAccount := ReceptiveAccount new.
	thirdTransaction := Deposit register: 100 on: aThirdAccount.
	
	ourAnotherPortfolio := Portfolio for: (OrderedCollection with: aThirdAccount).

	portfolioWithAcc100DepositAndAcc25Withdraw add: ourAnotherPortfolio.
	
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: accountWith100DepositTransaction ). 
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: accountWith25WithdrawTransaction). 
	self assert: (portfolioWithAcc100DepositAndAcc25Withdraw hasRegistered: thirdTransaction).

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:13'!
test14APortfolioWithAccountsAndPortfolioCannotContainDuplicates
	|ourPortfolio |
	
	ourPortfolio := Portfolio for: (OrderedCollection with: accountWith100Deposit).

	self should: [portfolioWithAcc100DepositAndAcc25Withdraw add: ourPortfolio] 
	raise: Error  
	withExceptionDo: [:anError |
		self assert: (anError messageText = Portfolio cannotContainDuplicatesErrorDescription)].
	
	"
		- ourPortfolio
			- anAccount
			- anotherAccount
		- ourAnotherPortfolio
			- anAccount
		ourPortfolio add: ourAnotherPortfolio
	"
	
	
		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:10'!
test15APortfolioWithAccountsAndPortfolioCannotContainDuplicatesWhenAddingAccountToInnerPortfolio
	|ourPortfolio accountCarlos |
	
	accountCarlos := ReceptiveAccount new.
	ourPortfolio := Portfolio for: (OrderedCollection with: accountCarlos).
	
	portfolioWithAcc100DepositAndAcc25Withdraw add: ourPortfolio.

	self should: [portfolioWithAcc100DepositAndAcc25Withdraw add: accountCarlos] 
	raise: Error  
	withExceptionDo: [:anError |
		self assert: (anError messageText = Portfolio cannotContainDuplicatesErrorDescription)].
	
	"
	- ourPortfolio
		- anAccount
		- anotherAccount
		- ourAnotherPortfolio
			- accountCarlos
	ourPortfolio add: accountCarlos
"
		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:07'!
test16APortfolioThatIsInsideAnotherPortfolioCannotContainDuplicateInformationFromItsParent
	|portfolioNico accountA accountB accountC portfolioJuanse portfolioCarlos portfolioB portfolioA |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	accountC := ReceptiveAccount new.
	
	portfolioNico := Portfolio for: (OrderedCollection with: accountA).
	portfolioJuanse := Portfolio for: (OrderedCollection with: accountB).	
	portfolioCarlos := Portfolio for: (OrderedCollection with: accountB with: accountC).
	
	portfolioB := Portfolio for: (OrderedCollection with: portfolioNico).
	portfolioA := Portfolio for: (OrderedCollection with: portfolioNico with: portfolioCarlos).


	
	self should: [portfolioNico add: accountC] 
	raise: Error  
	withExceptionDo: [:anError |
		self assert: (anError messageText = Portfolio cannotContainDuplicatesErrorDescription)].
	
	"
		- PortfolioA
			- PortfolioNico
				- AccountA
			- PortfolioCarlos
				- AccountB
				- AccountC
		- PortfolioB
			- PortfolioNico
				- AccountA
		- PortfolioJuanse
			- Account B
		PortfolioNico add: AccountC
	"
		! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/27/2019 12:55:04'!
test17TheImpossibleTest
	|portfolioNico accountA accountB accountC portfolioJuanse portfolioCarlos portfolioB portfolioA accountH portfolioRicardo portfolioMi portfolioMiOtro |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	accountC := ReceptiveAccount new.
	accountH := ReceptiveAccount new.

	portfolioNico := Portfolio for: (OrderedCollection with: accountA).
	portfolioJuanse := Portfolio for: (OrderedCollection with: accountB).	
	portfolioCarlos := Portfolio for: (OrderedCollection with: accountC).
	portfolioRicardo := Portfolio for: (OrderedCollection with: accountB with: accountH).
	
	portfolioB := Portfolio for: (OrderedCollection with: portfolioNico).
	portfolioA := Portfolio for: (OrderedCollection with: portfolioNico with: portfolioCarlos).

	portfolioMi := Portfolio for: (OrderedCollection with: portfolioA with: portfolioRicardo).
	portfolioMiOtro := Portfolio for: (OrderedCollection with: portfolioB with: portfolioRicardo).

	
	self should: [portfolioNico add: portfolioJuanse] 
	raise: Error  
	withExceptionDo: [:anError |
		self assert: (anError messageText = Portfolio cannotContainDuplicatesErrorDescription)].
	
	"
		- PortfolioMi
			- PortfolioA
				- PortfolioNico
					- AccA
				- PortfolioCarlos
					- AccC
			- PortfolioRicardo
				- AccB
				- AccH
		- PortfolioMiOtro
			- PortfolioB
				- PortfolioNico
					- AccA
			- PortfolioRicardo
				- AccB
				- AccH
		- PortfolioJuanse
			- AccB
		PortfolioNico add: PortfolioJuanse
	"
		! !


!PortfolioTest methodsFor: 'setup' stamp: 'NI 5/27/2019 12:34:59'!
setUp
	accountWith100Deposit := ReceptiveAccount new.
	accountWith100DepositTransaction :=  Deposit register: 100 on: accountWith100Deposit.
	
	accountWith25Withdraw := ReceptiveAccount new.
	accountWith25WithdrawTransaction := Withdraw register: 25 on: accountWith25Withdraw.
	
	portfolioWithAcc100Deposit := Portfolio for: (OrderedCollection with: accountWith100Deposit).
	portfolioWithAcc100DepositAndAcc25Withdraw := Portfolio for: (OrderedCollection with: accountWith100Deposit with: accountWith25Withdraw).! !


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
	instanceVariableNames: 'bankingStuff fathers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'NI 5/26/2019 20:20:19'!
initializeFor: someBankingStuff
	someBankingStuff = nil ifTrue: [self error: self class cannotCreateEmptyPortfolioErrorDescription].
	bankingStuff := someBankingStuff.
	fathers := OrderedCollection with: self.
	someBankingStuff do: [:aBankingStuff | aBankingStuff addFather: self]! !


!Portfolio methodsFor: 'balance' stamp: 'NI 5/26/2019 19:58:00'!
balance
	^ bankingStuff sum: [:aBankingStuff | aBankingStuff balance].! !


!Portfolio methodsFor: 'transactions' stamp: 'NI 5/26/2019 19:59:32'!
transactions
	|transactionAccumulator|
	transactionAccumulator := OrderedCollection new.
	
	bankingStuff do: [:aBankingStuff | transactionAccumulator addAllLast: aBankingStuff transactions ].
	
	^transactionAccumulator.! !


!Portfolio methodsFor: 'accessing' stamp: 'NI 5/26/2019 19:56:49'!
accountAmounts
	^ bankingStuff inject: 0 into: [:accum :aBankingStuff | accum + aBankingStuff accountAmounts].! !


!Portfolio methodsFor: 'testing' stamp: 'NI 5/26/2019 19:59:11'!
hasRegistered: aTransaction
	^bankingStuff anySatisfy: [:aBankingStuff | aBankingStuff hasRegistered: aTransaction ] .
	! !


!Portfolio methodsFor: 'adding' stamp: 'NI 5/26/2019 21:19:07'!
add: aBankingStuff
	(fathers anySatisfy: [:oneBankingStuff | oneBankingStuff checkIfNotDuplicateInformationWith: aBankingStuff]) ifTrue: [ self error: self class cannotContainDuplicatesErrorDescription ].
	bankingStuff add: aBankingStuff.
	aBankingStuff addFather: self.! !


!Portfolio methodsFor: 'private' stamp: 'NI 5/27/2019 12:47:56'!
addFather: aBankingStuff
	(fathers at: 1) = self ifTrue: [fathers removeFirst].
 	fathers add: aBankingStuff.
	! !

!Portfolio methodsFor: 'private' stamp: 'JIG 5/26/2019 19:51:32'!
bankingStuff
	^bankingStuff! !

!Portfolio methodsFor: 'private' stamp: 'NI 5/27/2019 13:02:07'!
checkIfNotDuplicateInformationWith: aBankingStuff
	(fathers = aBankingStuff) ifTrue: [^true].	
	((fathers at: 1) = self) 
		ifTrue: [^self containsBankingStuff: aBankingStuff] 
		ifFalse: [
			^fathers anySatisfy: [:aPortfolio | aPortfolio checkIfNotDuplicateInformationWith: aBankingStuff ]
		].! !

!Portfolio methodsFor: 'private' stamp: 'JIG 5/27/2019 00:14:52'!
containsBankingStuff: aBankingStuff
	^bankingStuff anySatisfy: [:aPersonalBankingStuff | aPersonalBankingStuff hasBankingStuff: aBankingStuff].! !

!Portfolio methodsFor: 'private' stamp: 'NI 5/26/2019 21:18:20'!
hasBankingStuff: anAccount
	^ bankingStuff anySatisfy: [:aBankingStuff | aBankingStuff hasBankingStuff: anAccount].! !

!Portfolio methodsFor: 'private' stamp: 'JIG 5/27/2019 00:17:31'!
includesOrEqualTo: aBankingStuff
	^bankingStuff includesAnyOf: aBankingStuff.! !

!Portfolio methodsFor: 'private' stamp: 'NI 5/27/2019 12:45:23'!
includesOrEqualToAccount: anAccount
	^bankingStuff includes: anAccount.! !

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
	instanceVariableNames: 'transactions fathers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NI 5/26/2019 20:16:10'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	fathers := OrderedCollection with: self.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'NI 5/26/2019 20:18:08'!
addFather: aBankingStuff
	fathers add: aBankingStuff! !

!ReceptiveAccount methodsFor: 'private' stamp: 'JIG 5/26/2019 19:51:32'!
bankingStuff
	^self.! !

!ReceptiveAccount methodsFor: 'private' stamp: 'NI 5/26/2019 21:07:34'!
checkIfNotDuplicateInformationWith: someBankingStuff
	^ someBankingStuff anySatisfy: [:aBankingStuff | aBankingStuff hasBankingStuff: self].! !

!ReceptiveAccount methodsFor: 'private' stamp: 'JIG 5/27/2019 00:17:36'!
hasBankingStuff: aBankingStuff
	^aBankingStuff includesOrEqualToAccount: self.! !

!ReceptiveAccount methodsFor: 'private' stamp: 'JIG 5/27/2019 00:17:56'!
includesOrEqualToAccount: anAccount
	^self = anAccount.! !
