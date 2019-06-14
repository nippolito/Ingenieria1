!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosAuthenticatorTest category: #TusLibros!
TestCase subclass: #TusLibrosAuthenticatorTest
	instanceVariableNames: 'tusLibrosAuthenticator testFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosAuthenticatorTest methodsFor: 'tests' stamp: 'Nico 6/13/2019 16:30:43'!
test01CannotAuthenticateWithUnknownClientID
	self should: [ tusLibrosAuthenticator authenticateClient: testFactory anInvalidClientUserID withPassword: testFactory aFirstClientValidPassword ] 
	raise: Error 
	withExceptionDo: [:anError |
		anError messageText = TusLibrosAuthenticator unknownUserErrorDescription ].
	
	! !

!TusLibrosAuthenticatorTest methodsFor: 'tests' stamp: 'Nico 6/13/2019 16:30:47'!
test02CannotAuthenticateWithInvalidPassword
	self should: [ tusLibrosAuthenticator authenticateClient: testFactory aFirstClientValidUserID withPassword: testFactory anInvalidPassword ] 
	raise: Error 
	withExceptionDo: [:anError |
		anError messageText = TusLibrosAuthenticator invalidPasswordErrorDescription ].
	
	! !

!TusLibrosAuthenticatorTest methodsFor: 'tests' stamp: 'Nico 6/13/2019 16:30:47'!
test03ShouldAuthenticateWhenClientIDAndPasswordsMatches
	| validClientID |
	
	validClientID := tusLibrosAuthenticator authenticateClient: testFactory aFirstClientValidUserID withPassword: testFactory aFirstClientValidPassword.
	
	self assert: validClientID equals: testFactory aFirstClientValidUserID.! !


!TusLibrosAuthenticatorTest methodsFor: 'setup' stamp: 'Nico 6/13/2019 14:49:00'!
setUp

	testFactory := StoreTestObjectsFactory new.
	tusLibrosAuthenticator := TusLibrosAuthenticator withUserDatabase: (testFactory aGenericUserDatabase).

	! !


!classDefinition: #TusLibrosRestSystemTest category: #TusLibros!
TestCase subclass: #TusLibrosRestSystemTest
	instanceVariableNames: 'testFactory tusLibrosController anAuthenticator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'Nico 6/13/2019 19:41:38'!
test01CannotCreateCartWhenInvalidAuthentication

	self should: [ tusLibrosController createCartFor: testFactory anInvalidClientUserID authenticatedWith: testFactory anInvalidPassword ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: 
			(anError messageText = TusLibrosAuthenticator invalidPasswordErrorDescription or: [anError messageText = TusLibrosAuthenticator unknownUserErrorDescription ]).
		"self deny: (tusLibrosController isClientIDWithActiveCart: testFactory anInvalidClientUser)."
		"OJO, creería que estamos violando encapsulamiento si nos metemos en la interfaz REST para preguntarle esto, que es lo que precisamente dijo Wilkinson que no había que hacer. En el caso positivo es fácil, pero acá cómo assertamos que el carrito no se creó? Testeamos que lo que devolvió el createCart sea nil?"
	]! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'Nico 6/13/2019 19:41:38'!
test02ValidClientShouldCreateACart
	| aCartID |
	aCartID := tusLibrosController createCartFor: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	self assert: (tusLibrosController listCart: aCartID) isEmpty.! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'Nico 6/13/2019 19:41:38'!
test03CreatedCartShouldBeEmpty
	| aCartID cartContent |
	aCartID := tusLibrosController createCartFor: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	cartContent := tusLibrosController listCart: aCartID.
	
	self assert: cartContent isEmpty.
	
	"Quizás está al pedo si tenemos que assertar que el listCart esté vacío en el test anterior"! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'Nico 6/13/2019 16:10:12'!
test04CannotListAnInvalidCartID
	| aCartID |
	aCartID := 'InvalidCartID'.
	
	self should: [ tusLibrosController listCart: aCartID ] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription
	].! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'Nico 6/13/2019 19:41:38'!
test05ValidCartCanAddItemsFromCatalogue
	| aCartID cartContent |
	aCartID := tusLibrosController createCartFor: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: aCartID.
	
	cartContent := tusLibrosController listCart: aCartID.
	
	self assert: cartContent size = 1.
	self assert: (cartContent includes: testFactory itemSellByTheStore).
	self assert: (cartContent occurrencesOf: testFactory itemSellByTheStore) = 1.! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'Nico 6/13/2019 16:12:57'!
test06CannotAddItemsToInvalidCart
	| aCartID |
	aCartID := 'anInvalidCartID'.
	
	self should: [ tusLibrosController add: 2 of: testFactory itemSellByTheStore toCart: aCartID] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription
	].! !


!TusLibrosRestSystemTest methodsFor: 'setup' stamp: 'Nico 6/13/2019 14:53:36'!
setUp
	testFactory := StoreTestObjectsFactory new.
	anAuthenticator := TusLibrosAuthenticator withUserDatabase: (testFactory aGenericUserDatabase).
	tusLibrosController := TusLibrosRestSystem withAuthenticator: anAuthenticator andCatalogue: (testFactory defaultCatalog).
	
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'Nico 6/13/2019 14:56:11'!
items
	^items! !

!Cart methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner idNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'Nico 6/13/2019 16:47:57'!
initializeFor: anOwner expiringOn: aMonth withIDNumber: anIDNumber  
	
	owner := anOwner.
	expiration := aMonth. 
	idNumber := anIDNumber ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'Nico 6/13/2019 16:47:37'!
for: anOwner expiringOn: aMonth withIDNumber: anIDNumber  
	
	^self new initializeFor: anOwner expiringOn: aMonth withIDNumber: anIDNumber! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'Nico 6/13/2019 14:45:22'!
aFirstClientValidPassword
	^'Sr. Smalltalk'.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'Nico 6/13/2019 16:30:47'!
aFirstClientValidUserID
	^'Wilkinson'.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'Nico 6/13/2019 14:45:29'!
aGenericUserDatabase
	^Dictionary 
		newFromPairs: { 
			'Juan'. 'CasiSmalltalk'. 
			'Nico'. 'SmalltalkCreo'. 
			'Wilkinson'. 'Sr. Smalltalk'.
		}.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'Nico 6/13/2019 16:30:43'!
anInvalidClientUserID
	^'Juani'! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'Nico 6/13/2019 14:45:41'!
anInvalidPassword
	^'NoSmallTalk'! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'Nico 6/13/2019 16:46:42'!
expiredCreditCard
	
	^CreditCard for: self ownerOfExpiredCreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withIDNumber: self anIDForExpiredCreditCard ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'Nico 6/13/2019 16:46:46'!
notExpiredCreditCard
	
	^CreditCard for: self ownerOfValidCreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withIDNumber: self anIDForValidCreditCard! !


!StoreTestObjectsFactory methodsFor: 'credit card ids' stamp: 'Nico 6/13/2019 16:42:48'!
anIDForExpiredCreditCard
	^'4700000034541234'! !

!StoreTestObjectsFactory methodsFor: 'credit card ids' stamp: 'Nico 6/13/2019 16:42:41'!
anIDForValidCreditCard
	^'4700000034540007'! !


!StoreTestObjectsFactory methodsFor: 'credit card owners' stamp: 'Nico 6/13/2019 16:43:54'!
ownerOfExpiredCreditCard
	^'Jose'.! !

!StoreTestObjectsFactory methodsFor: 'credit card owners' stamp: 'Nico 6/13/2019 16:44:08'!
ownerOfValidCreditCard
	^'Nico'.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!classDefinition: #TusLibrosAuthenticator category: #TusLibros!
Object subclass: #TusLibrosAuthenticator
	instanceVariableNames: 'userDataTable'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosAuthenticator methodsFor: 'initialization' stamp: 'Nico 6/13/2019 14:46:56'!
initializeWithUserDatabase: userEntries
	userDataTable := userEntries.! !


!TusLibrosAuthenticator methodsFor: 'authentication' stamp: 'Nico 6/13/2019 16:02:44'!
authenticateClient: aClientID withPassword: aPassword
	| realPassword |
	
	realPassword := self getPasswordOf: aClientID.
	self assertPassword: aPassword isTheSameAs: realPassword.
	
	^aClientID.! !


!TusLibrosAuthenticator methodsFor: 'private' stamp: 'Nico 6/13/2019 15:48:26'!
getPasswordOf: aClientID.
	^userDataTable at: aClientID ifAbsent: [ self error: self class unknownUserErrorDescription ].! !


!TusLibrosAuthenticator methodsFor: 'assertions' stamp: 'Nico 6/13/2019 16:02:44'!
assertPassword: aPassword isTheSameAs: realPassword.
	realPassword = aPassword ifFalse: [ self error: self class invalidPasswordErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosAuthenticator class' category: #TusLibros!
TusLibrosAuthenticator class
	instanceVariableNames: ''!

!TusLibrosAuthenticator class methodsFor: 'initialization' stamp: 'Nico 6/13/2019 14:47:43'!
withUserDatabase: userEntries
	^self new initializeWithUserDatabase: userEntries.! !


!TusLibrosAuthenticator class methodsFor: 'error descriptions' stamp: 'Nico 6/13/2019 14:52:48'!
invalidPasswordErrorDescription
	^'La contraseña no coincide con el usuario ingresado'.! !

!TusLibrosAuthenticator class methodsFor: 'error descriptions' stamp: 'Nico 6/13/2019 14:58:23'!
unknownUserErrorDescription
	^'El cliente nombrado es inexistente'.! !


!classDefinition: #TusLibrosRestSystem category: #TusLibros!
Object subclass: #TusLibrosRestSystem
	instanceVariableNames: 'authenticator activeCarts amountCartsPerClientID newCart catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestSystem methodsFor: 'assertions' stamp: 'Nico 6/13/2019 16:10:03'!
assertCartIDIsValid: aCartID.
	activeCarts at: aCartID ifAbsent: [ self error: self class invalidCartIDErrorDescription].! !


!TusLibrosRestSystem methodsFor: 'initialization' stamp: 'Nico 6/13/2019 14:50:54'!
initializeWithAuthenticator: anAuthenticator andCatalogue: aCatalogue 
	authenticator := anAuthenticator.
	catalogue := aCatalogue.
	
	activeCarts := Dictionary new.
	amountCartsPerClientID := Dictionary new.! !


!TusLibrosRestSystem methodsFor: 'operations - cart' stamp: 'Nico 6/13/2019 16:13:48'!
add: aBookQuantity of: aBookFromStore toCart: aCartID 
	"Si queres cambia el nombre a item"
	| currentCart |
	
	self assertCartIDIsValid: aCartID.
	
	currentCart := activeCarts at: aCartID.
	currentCart add: aBookQuantity of: aBookFromStore. ! !

!TusLibrosRestSystem methodsFor: 'operations - cart' stamp: 'Nico 6/13/2019 19:41:38'!
createCartFor: aClientID authenticatedWith: aPassword
	| newCartID |
	
	self authenticateClient: aClientID withPassword: aPassword.
	self createNewCart.
	newCartID := self createCartIDFor: aClientID.
	self addToActiveCarts: newCartID.
	
	^newCartID.! !

!TusLibrosRestSystem methodsFor: 'operations - cart' stamp: 'Nico 6/13/2019 16:04:26'!
listCart: aCartID
	self assertCartIDIsValid: aCartID.
	^(activeCarts at: aCartID) items.! !


!TusLibrosRestSystem methodsFor: 'testing' stamp: 'Nico 6/13/2019 14:50:59'!
isCartIDActive: aCartID
	^activeCarts includesKey: aCartID.! !

!TusLibrosRestSystem methodsFor: 'testing' stamp: 'Nico 6/13/2019 14:51:05'!
isClientIDWithActiveCart: aClientID
	^(amountCartsPerClientID includesKey: aClientID) and: [0 < amountCartsPerClientID at: aClientID].! !


!TusLibrosRestSystem methodsFor: 'private' stamp: 'Nico 6/13/2019 15:18:20'!
addToActiveCarts: newCartID.
	activeCarts at: newCartID put: newCart.! !

!TusLibrosRestSystem methodsFor: 'private' stamp: 'Nico 6/13/2019 15:19:14'!
authenticateClient: aClientID withPassword: aPassword
	authenticator authenticateClient: aClientID withPassword: aPassword! !

!TusLibrosRestSystem methodsFor: 'private' stamp: 'Nico 6/13/2019 16:19:20'!
createCartIDFor: aClientID
	| newAmount newCartID |

	"O refactoring o pensar otra manera mas creativa de poner ID (si, puedo poner un contador y chau, sacando el amountCartsPerClientID jaja)"
	self updateClientCartsAmount: aClientID.

	newAmount := amountCartsPerClientID at: aClientID.
	newCartID := aClientID , newAmount asString.
	^newCartID! !

!TusLibrosRestSystem methodsFor: 'private' stamp: 'Nico 6/13/2019 15:10:47'!
createNewCart.
	newCart := Cart acceptingItemsOf: catalogue.! !

!TusLibrosRestSystem methodsFor: 'private' stamp: 'Nico 6/13/2019 16:19:51'!
updateClientCartsAmount: aClientID
	| currentAmountOfCarts |
	
	currentAmountOfCarts := amountCartsPerClientID at: aClientID ifAbsent: [0].
	amountCartsPerClientID at: aClientID put: (currentAmountOfCarts + 1).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestSystem class' category: #TusLibros!
TusLibrosRestSystem class
	instanceVariableNames: ''!

!TusLibrosRestSystem class methodsFor: 'initialization' stamp: 'Nico 6/13/2019 14:52:08'!
withAuthenticator: anAuthenticator andCatalogue: aCatalogue 
	^self new initializeWithAuthenticator: anAuthenticator andCatalogue: aCatalogue.! !


!TusLibrosRestSystem class methodsFor: 'error descriptions' stamp: 'Nico 6/13/2019 15:41:25'!
cannotAddToAnInvalidCartErrorDescription
	^'No se puede agregar libros a un carrito inválido'! !

!TusLibrosRestSystem class methodsFor: 'error descriptions' stamp: 'Nico 6/13/2019 14:52:02'!
cannotListAnInvalidCartErrorDescription
	^'No se puede listar un carrito desconocido'.! !

!TusLibrosRestSystem class methodsFor: 'error descriptions' stamp: 'Nico 6/13/2019 16:10:03'!
invalidCartIDErrorDescription
	^'El ID del carrito es inválido'! !
