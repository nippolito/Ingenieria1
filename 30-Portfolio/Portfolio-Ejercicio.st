!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 21:06:26'!
test00CannotCreateEmptyPortfolio	
	"Más adelante chequear que no se pueda crear con boludeces adentro (o sea, solo accounts y portfolios)"
	
	self should: [Portfolio for: nil.] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: Portfolio cannotCreateEmptyPortfolioErrorDescription = anError messageText].
! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/26/2019 19:54:59'!
test01PortfolioCreatedWithOneAccountHasExactlyOneAccount
	|ourPortfolio ourAccount ourAccountList|
	
	ourAccount := ReceptiveAccount new.
	Deposit register: 100 on: ourAccount.
	
	ourAccountList := OrderedCollection new.
	ourAccountList add: ourAccount.
	
	ourPortfolio := Portfolio for: ourAccountList.
	
	self assert: ourPortfolio accountAmounts = 1.! !

!PortfolioTest methodsFor: 'test' stamp: 'JIG 5/24/2019 16:59:38'!
test02BalanceOfAPortfolioWithOnlyOneAccountEqualsToBalanceOfThatAccount
	|ourPortfolio ourAccount ourAccountList|
	
	ourAccount := ReceptiveAccount new.
	Deposit register: 100 on: ourAccount.
	
	ourAccountList := OrderedCollection new.
	ourAccountList add: ourAccount.
	
	ourPortfolio := Portfolio for: ourAccountList.
	
	self assert: ourPortfolio balance = ourAccount balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/26/2019 20:01:18'!
test03TransactionsOfAPortfolioWithOnlyOneAccountEqualsToTransactionsOfThatAccount
	|ourPortfolio ourAccount ourAccountList |
	
	ourAccount := ReceptiveAccount new.
	Deposit register: 100 on: ourAccount.
	
	ourAccountList := OrderedCollection new.
	ourAccountList add: ourAccount.
	
	ourPortfolio := Portfolio for: ourAccountList.
	
	self assert: (ourPortfolio transactions includesAllOf: ourAccount transactions).
	self assert: ourPortfolio transactions size = 1.! !

!PortfolioTest methodsFor: 'test' stamp: 'JIG 5/24/2019 17:02:05'!
test04APortfolioWithOnlyOneAccountHasRegisteredTransactionsOfThatAccount
	|ourPortfolio ourAccount anotherTransaction ourAccountList |
	
	ourAccount := ReceptiveAccount new.
	Deposit register: 100 on: ourAccount.
	
	anotherTransaction := Deposit register: 120 on: ourAccount.
	
	ourAccountList := OrderedCollection new.
	ourAccountList add: ourAccount.
	
	ourPortfolio := Portfolio for: ourAccountList.
	
	self assert: (ourPortfolio hasRegistered: anotherTransaction) = (ourAccount hasRegistered: anotherTransaction).! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 21:38:30'!
test05APortfolioWithManyAccountsHasTheBalanceOfTheirAccountsSummed
	|ourPortfolio anAccount anotherAccount someAccounts|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 25 on: anotherAccount.
	
	someAccounts := OrderedCollection with: anAccount with: anotherAccount.
	
	ourPortfolio := Portfolio for: someAccounts.
	
	self assert: ourPortfolio balance = (anAccount balance + anotherAccount balance).! !

!PortfolioTest methodsFor: 'test' stamp: 'JIG 5/26/2019 19:07:32'!
test06APortfolioWithManyAccountsKeepAllTheTransactions
	|ourPortfolio anAccount anotherAccount someAccounts|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 25 on: anotherAccount.
	
	someAccounts := OrderedCollection with: anAccount with: anotherAccount.
	
	ourPortfolio := Portfolio for: someAccounts.
	
	self assert: (ourPortfolio transactions includesAllOf: anAccount transactions).
	self assert: (ourPortfolio transactions includesAllOf: (anotherAccount transactions)).
	self assert: ourPortfolio transactions size = 2.! !

!PortfolioTest methodsFor: 'test' stamp: 'JIG 5/26/2019 18:18:09'!
test07APortfolioWithManyAccountsHasRegisteredTransactionsOfThoseAccounts
	|ourPortfolio anAccount anotherAccount someAccounts aDepositTransaction aWithdrawTransaction|
	
	anAccount := ReceptiveAccount new.
	aDepositTransaction := Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	aWithdrawTransaction := Withdraw register: 25 on: anotherAccount.
	
	someAccounts := OrderedCollection with: anAccount with: anotherAccount.
	
	ourPortfolio := Portfolio for: someAccounts.
	
	self assert: (ourPortfolio hasRegistered: aDepositTransaction ) = (anAccount hasRegistered: aDepositTransaction ).
	self assert: (ourPortfolio hasRegistered: aWithdrawTransaction ) = (anotherAccount hasRegistered: aWithdrawTransaction ).! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/26/2019 20:54:49'!
test08APortfolioCanAddANewAccount
	|ourPortfolio anAccount anotherAccount someAccounts aNewAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 25 on: anotherAccount.
	
	someAccounts := OrderedCollection with: anAccount with: anotherAccount.
	aNewAccount := ReceptiveAccount new.
	
	ourPortfolio := Portfolio for: someAccounts.
	ourPortfolio add: aNewAccount.

	self assert: ourPortfolio accountAmounts = 3.
	self assert: (ourPortfolio bankingStuff includes: aNewAccount ).
	
	"
	ourPortfolio
		- anAccount
		- anotherAccount
	ourPortfolio add: aNewAccount
	
	"! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/26/2019 20:07:47'!
test08APortfolioCreatedWithOnePortfolioHasThatPortfolioAccountsAndTransactions
	|ourPortfolio anAccount anotherAccount someAccounts ourNewPortfolio portfolioOC |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 25 on: anotherAccount.
	
	someAccounts := OrderedCollection with: anAccount with: anotherAccount.
	
	ourPortfolio := Portfolio for: someAccounts.

	portfolioOC := OrderedCollection with: ourPortfolio.
	ourNewPortfolio := Portfolio for: portfolioOC.

	self assert: ourNewPortfolio accountAmounts = ourPortfolio accountAmounts.
	self assert: (ourNewPortfolio transactions includesAllOf: ourPortfolio transactions).
	self assert: (ourPortfolio transactions includesAllOf: ourNewPortfolio transactions).! !

!PortfolioTest methodsFor: 'test' stamp: 'JIG 5/26/2019 19:50:42'!
test09APortfolioWithManyAccountsCannotContainDuplicates
	|ourPortfolio anAccount anotherAccount someAccounts |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 25 on: anotherAccount.
	
	someAccounts := OrderedCollection with: anAccount with: anotherAccount.
	
	ourPortfolio := Portfolio for: someAccounts.
	
	self should: [ourPortfolio add: anotherAccount] 
	raise: Error  
	withExceptionDo: [:anError|
		Portfolio cannotContainDuplicatesErrorDescription = anError messageText ].
	

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'JIG 5/26/2019 19:50:42'!
test10AddingANewPortfolioToAnExistingPortfolioShouldKeepTheTotalBalance
	|ourPortfolio anAccount anotherAccount someAccounts aThirdAccount anotherAccounts ourAnotherPortfolio portfolioCurrentBalance |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 25 on: anotherAccount.
	someAccounts := OrderedCollection with: anAccount with: anotherAccount.
	ourPortfolio := Portfolio for: someAccounts.
	portfolioCurrentBalance := ourPortfolio balance.
	
	aThirdAccount := ReceptiveAccount new.
	Deposit register: 100 on: aThirdAccount.
	anotherAccounts := OrderedCollection with: aThirdAccount.
	ourAnotherPortfolio := Portfolio for: anotherAccounts.

	"Exercise"
	
	ourPortfolio add: ourAnotherPortfolio.
	
	self assert: (ourPortfolio balance = (portfolioCurrentBalance + ourAnotherPortfolio balance)).
	

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'JIG 5/26/2019 19:50:42'!
test11AddingANewPortfolioToAnExistingPortfolioShouldKeepTheTotalTransactions
	|ourPortfolio anAccount anotherAccount someAccounts aThirdAccount anotherAccounts ourAnotherPortfolio portfolioCurrentTransactions |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 25 on: anotherAccount.
	someAccounts := OrderedCollection with: anAccount with: anotherAccount.
	
	ourPortfolio := Portfolio for: someAccounts.
	portfolioCurrentTransactions := ourPortfolio transactions.
	
	aThirdAccount := ReceptiveAccount new.
	Deposit register: 100 on: aThirdAccount.
	anotherAccounts := OrderedCollection with: aThirdAccount.
	
	ourAnotherPortfolio := Portfolio for: anotherAccounts.

	"Exercise"
	ourPortfolio add: ourAnotherPortfolio.
	
	self assert: (ourPortfolio transactions includesAllOf: anAccount transactions). 
	self assert: (ourPortfolio transactions includesAllOf: anotherAccount transactions). 
	self assert: (ourPortfolio transactions includesAllOf: ourAnotherPortfolio transactions ).
	self assert: (ourPortfolio transactions size = (portfolioCurrentTransactions size + ourAnotherPortfolio transactions size)).

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'JIG 5/26/2019 19:50:42'!
test12AddingANewPortfolioToAnExistingPortfolioShouldKnowWhatTransactionsWereRegistered
	|ourPortfolio anAccount anotherAccount someAccounts aThirdAccount anotherAccounts ourAnotherPortfolio firstTransaction secondTransaction thirdTransaction |
	
	anAccount := ReceptiveAccount new.
	firstTransaction := Deposit register: 100 on: anAccount.
	anotherAccount := ReceptiveAccount new.
	secondTransaction := Withdraw register: 25 on: anotherAccount.
	someAccounts := OrderedCollection with: anAccount with: anotherAccount.
	
	ourPortfolio := Portfolio for: someAccounts.
	
	aThirdAccount := ReceptiveAccount new.
	thirdTransaction := Deposit register: 100 on: aThirdAccount.
	anotherAccounts := OrderedCollection with: aThirdAccount.
	
	ourAnotherPortfolio := Portfolio for: anotherAccounts.

	"Exercise"
	ourPortfolio add: ourAnotherPortfolio.
	
	self assert: (ourPortfolio hasRegistered: firstTransaction). 
	self assert: (ourPortfolio hasRegistered: secondTransaction). 
	self assert: (ourPortfolio hasRegistered: thirdTransaction).

		
	! !

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/26/2019 20:46:44'!
test13APortfolioWithAccountsAndPortfolioCannotContainDuplicates
	|ourPortfolio anAccount anotherAccount ourAnotherPortfolio |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	ourPortfolio := Portfolio for: (OrderedCollection with: anAccount with: anotherAccount).
	
	ourAnotherPortfolio := Portfolio for: (OrderedCollection with: anAccount).

	self should: [ourPortfolio add: ourAnotherPortfolio] 
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

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/26/2019 20:44:19'!
test14APortfolioWithAccountsAndPortfolioCannotContainDuplicatesWhenAddingAccountToInnerPortfolio
	|ourPortfolio anAccount anotherAccount ourAnotherPortfolio accountCarlos |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 25 on: anotherAccount.
	
	ourPortfolio := Portfolio for: (OrderedCollection with: anAccount with: anotherAccount).
	
	accountCarlos := ReceptiveAccount new.
	ourAnotherPortfolio := Portfolio for: (OrderedCollection with: accountCarlos).
	
	ourPortfolio add: ourAnotherPortfolio.

	self should: [ourPortfolio add: accountCarlos] 
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

!PortfolioTest methodsFor: 'test' stamp: 'NI 5/26/2019 20:49:48'!
test15APortfolioThatIsInsideAnotherPortfolioCannotContainDuplicateInformationFromItsParent
	|portfolioNico accountA accountB accountC portfolioJuanse portfolioCarlos portfolioB portfolioA |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	accountC := ReceptiveAccount new.
	
	portfolioNico := Portfolio for: (OrderedCollection with: accountA).
	portfolioJuanse := Portfolio for: (OrderedCollection with: accountB).	
	portfolioCarlos := Portfolio for: (OrderedCollection with: accountB with: accountC).
	
	portfolioB := Portfolio for: (OrderedCollection with: portfolioNico).
	portfolioA := Portfolio for: (OrderedCollection with: portfolioNico with: portfolioCarlos).

	self should: [portfolioNico add: (OrderedCollection with: accountC)] 
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


!Portfolio methodsFor: 'as yet unclassified' stamp: 'NI 5/26/2019 19:56:49'!
accountAmounts
	^ bankingStuff inject: 0 into: [:accum :aBankingStuff | accum + aBankingStuff accountAmounts].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'NI 5/26/2019 21:19:07'!
add: aBankingStuff
	(fathers anySatisfy: [:oneBankingStuff | oneBankingStuff checkIfNotDuplicateInformationWith: aBankingStuff]) ifTrue: [ self error: self class cannotContainDuplicatesErrorDescription ].
	bankingStuff add: aBankingStuff.
	aBankingStuff addFather: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'NI 5/26/2019 20:17:57'!
addFather: aBankingStuff
	fathers add: aBankingStuff
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JIG 5/26/2019 19:51:32'!
bankingStuff
	^bankingStuff! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'NI 5/26/2019 21:06:56'!
checkIfNotDuplicateInformationWith: aBankingStuff
	"^(aBankingStuff includesAnyOf: bankingStuff)."
	^ self bankingStuff anySatisfy: [:oneBankingStuff | oneBankingStuff hasBankingStuff: aBankingStuff]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'NI 5/26/2019 21:18:20'!
hasBankingStuff: anAccount
	^ bankingStuff anySatisfy: [:aBankingStuff | aBankingStuff hasBankingStuff: anAccount].! !


!Portfolio methodsFor: 'balance' stamp: 'NI 5/26/2019 19:58:00'!
balance
	^ bankingStuff sum: [:aBankingStuff | aBankingStuff balance].! !

!Portfolio methodsFor: 'balance' stamp: 'NI 5/26/2019 19:59:11'!
hasRegistered: aTransaction
	^bankingStuff anySatisfy: [:aBankingStuff | aBankingStuff hasRegistered: aTransaction ] .
	! !


!Portfolio methodsFor: 'transactions' stamp: 'NI 5/26/2019 19:59:32'!
transactions
	|transactionAccumulator|
	transactionAccumulator := OrderedCollection new.
	
	bankingStuff do: [:aBankingStuff | transactionAccumulator addAllLast: aBankingStuff transactions ].
	
	^transactionAccumulator.! !

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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JIG 5/26/2019 19:51:32'!
bankingStuff
	^self.! !

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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'NI 5/26/2019 19:57:28'!
accountAmounts
	^1! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'NI 5/26/2019 20:18:08'!
addFather: aBankingStuff
	fathers add: aBankingStuff! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'NI 5/26/2019 21:07:34'!
checkIfNotDuplicateInformationWith: someBankingStuff
	^ someBankingStuff anySatisfy: [:aBankingStuff | aBankingStuff hasBankingStuff: self].! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'NI 5/26/2019 21:07:34'!
hasBankingStuff: anAccount
	^ self = anAccount! !
