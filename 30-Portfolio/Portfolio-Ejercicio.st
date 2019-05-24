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

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 21:22:58'!
test01PortfolioCreatedWithOneAccountHasExactlyOneAccount
	|ourPortfolio ourAccount|
	
	ourAccount := ReceptiveAccount new.
	Deposit register: 100 on: ourAccount.
	
	ourPortfolio := Portfolio for: ourAccount.
	
	self assert: ourPortfolio accountsAmount = 1.! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 21:23:45'!
test02BalanceOfAPortfolioWithOnlyOneAccountEqualsToBalanceOfThatAccount
	|ourPortfolio ourAccount|
	
	ourAccount := ReceptiveAccount new.
	Deposit register: 100 on: ourAccount.
	
	ourPortfolio := Portfolio for: ourAccount.
	
	self assert: ourPortfolio balance = ourAccount balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 21:26:26'!
test03TransactionsOfAPortfolioWithOnlyOneAccountEqualsToTransactionsOfThatAccount
	|ourPortfolio ourAccount|
	
	ourAccount := ReceptiveAccount new.
	Deposit register: 100 on: ourAccount.
	
	ourPortfolio := Portfolio for: ourAccount.
	
	self assert: ourPortfolio transactions = ourAccount transactions.! !

!PortfolioTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 21:30:22'!
test04APortfolioWithOnlyOneAccountHasRegisteredTransactionsOfThatAccount
	|ourPortfolio ourAccount aTransaction anotherTransaction|
	
	ourAccount := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: ourAccount.
	
	anotherTransaction := Deposit register: 120 on: ourAccount.
	
	ourPortfolio := Portfolio for: ourAccount.
	
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
	instanceVariableNames: 'transactions accountsAmount account accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'Nipo 5/23/2019 21:39:32'!
initializeFor: someAccounts
	someAccounts = nil ifTrue: [self error: self class cannotCreateEmptyPortfolioErrorDescription].
	accountsAmount := 1.
	account := someAccounts.
	accounts := someAccounts.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'Nipo 5/23/2019 20:58:11'!
accountsAmount
	^accountsAmount! !


!Portfolio methodsFor: 'balance' stamp: 'Nipo 5/23/2019 21:40:02'!
balance
	^ accounts sum: [:anAccount | anAccount balance].! !

!Portfolio methodsFor: 'balance' stamp: 'Nipo 5/23/2019 21:30:06'!
hasRegistered: aTransaction
	^ account hasRegistered: aTransaction.! !


!Portfolio methodsFor: 'transactions' stamp: 'Nipo 5/23/2019 21:26:04'!
transactions
	^ account transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'initialization' stamp: 'Nipo 5/23/2019 20:56:52'!
for: someAccounts
	^ self new initializeFor: someAccounts! !


!Portfolio class methodsFor: 'error descriptions' stamp: 'Nipo 5/23/2019 21:12:10'!
cannotCreateAPortfolioWithInvalidEntriesErrorDescription
	^'No se puede crear un portfolio con entradas inválidas'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'Nipo 5/23/2019 21:07:38'!
cannotCreateEmptyPortfolioErrorDescription
	^'No se puede crear un portfolio vacío'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


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
