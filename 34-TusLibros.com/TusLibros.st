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

!CashierTest methodsFor: 'tests' stamp: 'asd 6/14/2019 12:53:01'!
test07CashierDoesNotSaleIfTheCreditCardIsStolen

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardIsStolenErrorMessage].
	
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
			self assert: anError messageText = Cashier creditCardIsStolenErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'asd 6/14/2019 13:03:09'!
test08CashierDoesNotSaleIfCreditCardOwnerIsMoreThan30CharactersLong

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := CreditCard for: 'juan ignazakipati grandosinhoskitamo' expiringOn: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) withIDNumber: testObjectsFactory anIDForExpiredCreditCard .
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | 
		aCreditCard owner size > 30 ifTrue: [self error: Cashier creditCardOwnerShouldHaveLessThan30CharactersErrorMessage]].
	
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
			self assert: anError messageText = Cashier creditCardOwnerShouldHaveLessThan30CharactersErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testFactory validExpirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'setup' stamp: 'asd 6/14/2019 12:45:57'!
setUp
	testFactory := StoreTestObjectsFactory new.
	validExpirationDate := Month month: testFactory today monthIndex year: testFactory today yearNumber + 1.! !


!CreditCardTest methodsFor: 'tests' stamp: 'asd 6/14/2019 12:45:40'!
test01CreditCardShouldHaveAnOwner
	| invalidCreditCard |
	
	self should: [ invalidCreditCard := CreditCard for: '' expiringOn: validExpirationDate withIDNumber: testFactory anIDForValidCreditCard ]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: CreditCard ownerCannotBeEmptyErrorDescription = anError messageText.
		self assert: invalidCreditCard isNil.
	].! !

!CreditCardTest methodsFor: 'tests' stamp: 'asd 6/14/2019 12:45:49'!
test02IdentificationNumberShouldBeValid
	| invalidCreditCard |
	
	self should: [ invalidCreditCard := CreditCard for: testFactory ownerOfValidCreditCard expiringOn: validExpirationDate withIDNumber: '2423' ]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: CreditCard identificationNumberMustBeValidErrorDescription = anError messageText.
		self assert: invalidCreditCard isNil.
	].! !


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
	instanceVariableNames: 'testFactory tusLibrosController anAuthenticator debitBehavior clock expirationTime'
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

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/20/2019 17:02:52'!
test03CannotListAnInvalidCartID
	| aCartID |
	aCartID := 'InvalidCartID'.
	
	self should: [ tusLibrosController listCart: aCartID ] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription
	].! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 16:27:48'!
test04ValidCartCanAddItemsFromCatalogue
	| aCartID cartItems |
	aCartID := tusLibrosController createCartFor: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: aCartID.
	
	cartItems := tusLibrosController listCart: aCartID.
	
	self assert: cartItems size = 1.
	self assert: (cartItems includes: testFactory itemSellByTheStore).
	self assert: (cartItems occurrencesOf: testFactory itemSellByTheStore) = 1.! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/20/2019 17:03:00'!
test05CannotAddItemsToInvalidCart
	| aCartID |
	aCartID := 'anInvalidCartID'.
	
	self should: [ tusLibrosController add: 2 of: testFactory itemSellByTheStore toCart: aCartID] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription
	].! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/20/2019 17:24:46'!
test06ClientWithoutTransactionsHasNoPurchases
	| purchasesContent |
	
	purchasesContent := tusLibrosController listPurchasesOf: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	self assert: purchasesContent isEmpty.
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/20/2019 17:42:05'!
test07CannotListPurchasesWhenInvalidAuthentication
	
	self should: [ tusLibrosController listPurchasesOf: testFactory anInvalidClientUserID authenticatedWith: testFactory aFirstClientValidPassword. ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: (anError messageText = TusLibrosAuthenticator invalidPasswordErrorDescription or: [anError messageText = TusLibrosAuthenticator unknownUserErrorDescription ]).
	]. 
	
	
	
	
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test08CannotCheckoutWhenCartIsEmpty
	| client listPurchasesBefore newCartID password |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.
	listPurchasesBefore := (tusLibrosController listPurchasesOf: client authenticatedWith: password) copy.
	
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: (anError messageText = Cashier cartCanNotBeEmptyErrorMessage).
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: client authenticatedWith: password).
	]. 
	
	
	
	
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test09CannotCheckoutAnInvalidCart
	| invalidCart |
	
	invalidCart := 'Not valid cart'.
	
	self should: [ tusLibrosController checkoutFor: invalidCart payingWith: testFactory notExpiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: (anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription).
	]. 
		
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test10CannotCheckoutWithExpiredCreditCard
	| client listPurchasesBefore newCartID password |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.
	listPurchasesBefore := (tusLibrosController listPurchasesOf: client authenticatedWith: password) copy.
	
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
		
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: testFactory expiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: (anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage).
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: client authenticatedWith: password).
	]. 
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test11CannotCheckoutWhenTheCreditCardHasNoFunds
	| client listPurchasesBefore newCartID password |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.
	listPurchasesBefore := (tusLibrosController listPurchasesOf: client authenticatedWith: password) copy.
	
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: (anError messageText = Cashier creditCardHasNoCreditErrorMessage).
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: client authenticatedWith: password).
	]. 
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test12CannotCheckoutWhenTheCreditCardIsStolen
	| client listPurchasesBefore newCartID password |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.
	listPurchasesBefore := (tusLibrosController listPurchasesOf: client authenticatedWith: password) copy.
	
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardIsStolenErrorMessage ].
	
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: (anError messageText = Cashier creditCardIsStolenErrorMessage).
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: client authenticatedWith: password).
	]. 
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test13CannotCheckoutIfCreditCardOwnerIsMoreThan30CharactersLong
	| client listPurchasesBefore newCartID password aCreditCardWithInvalidOwner |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.
	listPurchasesBefore := (tusLibrosController listPurchasesOf: client authenticatedWith: password) copy.
	
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardOwnerShouldHaveLessThan30CharactersErrorMessage ].
	aCreditCardWithInvalidOwner := CreditCard for: 'juan ignazakipati grandosinhoskitamo' expiringOn: (Month month: testFactory today monthIndex year: testFactory today yearNumber + 1) withIDNumber: testFactory anIDForValidCreditCard.
	
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: aCreditCardWithInvalidOwner ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: (anError messageText = Cashier creditCardOwnerShouldHaveLessThan30CharactersErrorMessage).
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: client authenticatedWith: password).
	]. 
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test14CheckoutChargesCreditCardUsingMerchantProcessor
	| client newCartID password debitedAmout debitedCreditCard creditCard sale |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.
	
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	debitBehavior := [ :anAmount :aCreditCard |
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].

	creditCard := testFactory notExpiredCreditCard.
	
	sale := tusLibrosController checkoutFor: newCartID payingWith: creditCard.
	
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = sale total.! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test15AfterCheckoutSystemAddsANewPurchase
	| client listPurchasesBefore newCartID password listPurchasesAfter successfulSale |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.
	listPurchasesBefore := (tusLibrosController listPurchasesOf: client authenticatedWith: password) copy.
	
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	successfulSale := tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard.
	
	listPurchasesAfter := tusLibrosController listPurchasesOf: client  authenticatedWith: password .
	
	self assert: listPurchasesAfter last equals: successfulSale.
	self assert: listPurchasesBefore size equals: listPurchasesAfter size - 1.
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test16CheckoutRemovesCart
	| client newCartID password |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.
	
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard.
	
	self should: [ tusLibrosController listCart: newCartID ]  
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription ].! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test17CheckoutAddedSalePersistsWithCartContent
	| client newCartID password sale cartItems |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.
	
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	cartItems := (tusLibrosController listCart: newCartID) copy.
	sale := tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard.
	
	self assert: sale items = cartItems.
	self assert: sale owner = client.! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 19:07:25'!
test18SystemAddsAPurchaseOnlyToClientPurchaseList
	| client newCartID password listPurchaseOfOtherClient listPurchasesAfter secondClient successfulSale secondPassword |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.	
	secondClient := testFactory aSecondClientValidUserID.
	secondPassword := testFactory aSecondClientValidPassword.
		
	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	successfulSale := tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard.
	
	listPurchasesAfter := tusLibrosController listPurchasesOf: client  authenticatedWith: password .
	listPurchaseOfOtherClient := tusLibrosController listPurchasesOf: secondClient authenticatedWith: secondPassword.
	
	self assert: listPurchasesAfter last equals: successfulSale.
	self assert: listPurchasesAfter size = 1.
	self assert: listPurchaseOfOtherClient size = 0.! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 18:50:42'!
test19CannotAddItemsIfCartIsExpired
	| client newCartID password |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.	

	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	
	tusLibrosController clock advanceTime: 31 minutes.
		
	self should: [ tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID ]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = TusLibrosRestSystem cartIsExpiredErrorDescription
	]
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 18:50:27'!
test20CannotListCartIfCartIsExpired
	| client newCartID password |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.	

	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	
	tusLibrosController clock advanceTime: 31 minutes.
		
	self should: [ tusLibrosController listCart: newCartID ]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = TusLibrosRestSystem cartIsExpiredErrorDescription
	]
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 18:50:21'!
test21CannotCheckoutCartIfCartIsExpired
	| client newCartID password |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.	

	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	
	tusLibrosController clock advanceTime: 31 minutes.
		
	self should: [ tusLibrosController listCart: newCartID ]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = TusLibrosRestSystem cartIsExpiredErrorDescription
	]
	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 18:50:16'!
test22CartSessionTimeRenovatesAfterAdding
	| client newCartID password cartItems |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.	

	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	
	tusLibrosController clock advanceTime: 28 minutes.
		
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	tusLibrosController clock advanceTime: 28 minutes.
	
	cartItems := tusLibrosController listCart: newCartID.
	
	self assert: cartItems size = 1.
	

	! !

!TusLibrosRestSystemTest methodsFor: 'tests' stamp: 'JIG 6/21/2019 18:50:04'!
test23CartSessionTimeRenovatesAfterListing
	| client newCartID password cartItems |
	
	client := testFactory aFirstClientValidUserID.
	password := testFactory aFirstClientValidPassword.	

	newCartID := tusLibrosController createCartFor: client authenticatedWith: password.
	
	tusLibrosController clock advanceTime: 28 minutes.
		
	tusLibrosController listCart: newCartID.
	
	tusLibrosController clock advanceTime: 28 minutes.
	
	cartItems := tusLibrosController listCart: newCartID.
	
	self assert: cartItems isEmpty.
	

	! !


!TusLibrosRestSystemTest methodsFor: 'setup' stamp: 'JIG 6/21/2019 17:02:01'!
setUp
	clock := Clock on: DateAndTime now.
	testFactory := StoreTestObjectsFactory new.
	anAuthenticator := TusLibrosAuthenticator withUserDatabase: (testFactory aGenericUserDatabase).
	tusLibrosController := TusLibrosRestSystem 
								withAuthenticator: anAuthenticator
								throught: self 
								andCatalogue: (testFactory defaultCatalog)
								andClock: clock.
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	expirationTime := 30 minutes.! !


!TusLibrosRestSystemTest methodsFor: 'merchant processor protocol' stamp: 'JIG 6/20/2019 17:50:10'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


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
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total client'
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

!Cashier methodsFor: 'checkout - private' stamp: 'JIG 6/21/2019 15:57:21'!
createSaleForClient
	^Sale of: total containing: cart items boughtBy: client.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'JIG 6/21/2019 16:29:46'!
registerSaleForClient

	salesBook add: self createSaleForClient.! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !

!Cashier methodsFor: 'checkout' stamp: 'JIG 6/21/2019 15:54:57'!
checkOutForClient

	self calculateTotal.
	self debitTotal.
	self registerSaleForClient.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'JIG 6/21/2019 15:47:18'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor boughtBy: aClient registeringOn: aSalesBook
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	client := aClient.! !

!Cashier methodsFor: 'initialization' stamp: 'JIG 6/21/2019 15:47:00'!
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


!Cashier class methodsFor: 'instance creation' stamp: 'JIG 6/21/2019 15:45:22'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate boughtBy: aClient registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor boughtBy: aClient registeringOn: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'asd 6/14/2019 12:54:50'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'No se puede debitar a una tarjeta expirada'! !

!Cashier class methodsFor: 'error messages' stamp: 'asd 6/14/2019 12:54:30'!
cartCanNotBeEmptyErrorMessage
	
	^'No se puede hacer checkout de un carrito vacío'! !

!Cashier class methodsFor: 'error messages' stamp: 'asd 6/14/2019 12:54:20'!
creditCardHasNoCreditErrorMessage
	
	^'La tarjeta de crédito no tiene fondos'! !

!Cashier class methodsFor: 'error messages' stamp: 'asd 6/14/2019 12:54:09'!
creditCardIsStolenErrorMessage
	
	^'La tarjeta de crédito es robada'! !

!Cashier class methodsFor: 'error messages' stamp: 'asd 6/14/2019 13:02:27'!
creditCardOwnerShouldHaveLessThan30CharactersErrorMessage
	^'El nombre del propietario de la tarjeta debe tener menos de 30 caracteres'! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: 'current'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'initialization' stamp: 'JIG 6/21/2019 16:51:43'!
initializeOn: aTime
	current := aTime.! !


!Clock methodsFor: 'operations' stamp: 'JIG 6/21/2019 18:48:23'!
advanceTime: aSequenceOfTime
	current := current + aSequenceOfTime.! !


!Clock methodsFor: 'accessing' stamp: 'JIG 6/21/2019 16:53:54'!
now
	^current.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: #TusLibros!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'instance creation' stamp: 'JIG 6/21/2019 16:51:43'!
on: aTime
	^self new initializeOn: aTime.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner idNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'accessing' stamp: 'asd 6/14/2019 12:58:28'!
owner
	^owner.! !


!CreditCard methodsFor: 'initialization' stamp: 'Nico 6/13/2019 16:47:57'!
initializeFor: anOwner expiringOn: aMonth withIDNumber: anIDNumber  
	
	owner := anOwner.
	expiration := aMonth. 
	idNumber := anIDNumber ! !


!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'asd 6/14/2019 12:44:11'!
for: anOwner expiringOn: aMonth withIDNumber: anIDNumber  
	self assertOwnerIsValid: anOwner.
	self assertIdentificationNumberIsValid: anIDNumber.
	
	^self new initializeFor: anOwner expiringOn: aMonth withIDNumber: anIDNumber! !


!CreditCard class methodsFor: 'assertions' stamp: 'asd 6/14/2019 12:44:24'!
assertIdentificationNumberIsValid: anIdentificationNumber.
	(anIdentificationNumber isString 
		and: [ (anIdentificationNumber allSatisfy: [:aCharacter | aCharacter isDigit ]) 
		and: [ anIdentificationNumber size = 16 ]]) ifFalse: [ self error: self identificationNumberMustBeValidErrorDescription ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'asd 6/14/2019 12:38:23'!
assertOwnerIsValid: anOwner
	(anOwner isEmpty or: [anOwner isString not]) ifTrue: [ self error: self ownerCannotBeEmptyErrorDescription ].! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'asd 6/14/2019 12:44:33'!
identificationNumberMustBeValidErrorDescription
	^'El número de la tarjeta de crédito debe poseer 16 digitos'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'asd 6/14/2019 12:38:58'!
ownerCannotBeEmptyErrorDescription
	^'La tarjeta debe tener propietario'.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total items owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

!Sale methodsFor: 'initialization' stamp: 'JIG 6/21/2019 15:39:05'!
initializeTotal: aTotal containing: aGroupOfItems ownedBy: anOwner
	total := aTotal.
	items := aGroupOfItems.
	owner := anOwner.! !


!Sale methodsFor: 'accessing' stamp: 'JIG 6/21/2019 16:29:09'!
items
	^items! !

!Sale methodsFor: 'accessing' stamp: 'JIG 6/21/2019 16:29:05'!
owner
	^owner! !

!Sale methodsFor: 'accessing' stamp: 'JIG 6/21/2019 16:29:02'!
total
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'asd 6/14/2019 13:05:15'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !

!Sale class methodsFor: 'instance creation' stamp: 'JIG 6/21/2019 15:39:05'!
of: aTotal containing: aGroupOfItems boughtBy: aClient  

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal containing: aGroupOfItems ownedBy: aClient.! !


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

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'JIG 6/21/2019 16:39:11'!
aSecondClientValidPassword
	^'SmalltalkCreo'.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'JIG 6/21/2019 16:39:05'!
aSecondClientValidUserID
	^'Nico'.! !

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
	instanceVariableNames: 'authenticator activeCarts catalogue merchantProcessor salesBook clock historicalCartsAmountPerClient'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestSystem methodsFor: 'accessing' stamp: 'JIG 6/21/2019 18:49:40'!
clock
	^clock! !


!TusLibrosRestSystem methodsFor: 'accessing - private' stamp: 'JIG 6/21/2019 16:16:22'!
cartOf: aCartID
	^(activeCarts at: aCartID) first.! !

!TusLibrosRestSystem methodsFor: 'accessing - private' stamp: 'JIG 6/21/2019 18:51:14'!
lastTimeUsedOf: aCartID
	^(activeCarts at: aCartID) last.! !

!TusLibrosRestSystem methodsFor: 'accessing - private' stamp: 'JIG 6/21/2019 16:21:29'!
ownerOf: anActiveCartID
	^(activeCarts at: anActiveCartID) second! !


!TusLibrosRestSystem methodsFor: 'assertions' stamp: 'Nico 6/13/2019 16:10:03'!
assertCartIDIsValid: aCartID.
	activeCarts at: aCartID ifAbsent: [ self error: self class invalidCartIDErrorDescription].! !

!TusLibrosRestSystem methodsFor: 'assertions' stamp: 'JIG 6/21/2019 18:51:14'!
assertCartIsNotExpired: aCartID
	| cartCreationTime |
	cartCreationTime := self lastTimeUsedOf: aCartID.
	(clock now - cartCreationTime > 30 minutes) ifTrue: [
		activeCarts removeKey: aCartID.
		self error: self class cartIsExpiredErrorDescription. 
	]! !


!TusLibrosRestSystem methodsFor: 'initialization' stamp: 'JIG 6/21/2019 18:53:21'!
initializeWithAuthenticator: anAuthenticator processingWith: aMerchantProcessor andCatalogue: aCatalogue andClock: aClock
	authenticator := anAuthenticator.
	catalogue := aCatalogue.
	merchantProcessor := aMerchantProcessor.
	salesBook := OrderedCollection new.
	
	activeCarts := Dictionary new.
	historicalCartsAmountPerClient := Dictionary new.
	
	clock := aClock.! !


!TusLibrosRestSystem methodsFor: 'operations - cart' stamp: 'JIG 6/21/2019 19:05:23'!
add: aBookQuantity of: aBookFromStore toCart: aCartID 
	
	self assertCartIDIsValid: aCartID.
	self assertCartIsNotExpired: aCartID.
	
	self add: aBookQuantity of: aBookFromStore to: aCartID.
	
	self renewCartExpiration: aCartID.! !

!TusLibrosRestSystem methodsFor: 'operations - cart' stamp: 'JIG 6/21/2019 19:08:31'!
checkoutFor: aCartID payingWith: aCreditCart
	self assertCartIDIsValid: aCartID.
	self assertCartIsNotExpired: aCartID.
	
	self renewCartExpiration: aCartID.
	
	self cashierCheckoutFor: aCartID payingWith: aCreditCart. 
	
	self removeFromActiveCarts: aCartID.
	
	^salesBook last.! !

!TusLibrosRestSystem methodsFor: 'operations - cart' stamp: 'JIG 6/21/2019 17:09:35'!
createCartFor: aClientID authenticatedWith: aPassword
	| newCartID newCart |
	
	self authenticateClient: aClientID withPassword: aPassword.
	newCart := self createNewCart.
	newCartID := self createCartIDFor: aClientID.
	self addToActiveCarts: newCart withID: newCartID ownedBy: aClientID on: clock now.
	
	^newCartID.! !

!TusLibrosRestSystem methodsFor: 'operations - cart' stamp: 'JIG 6/21/2019 18:40:22'!
listCart: aCartID
	self assertCartIDIsValid: aCartID.
	self assertCartIsNotExpired: aCartID.
	
	self renewCartExpiration: aCartID.
	
	^(self cartOf: aCartID) items.! !


!TusLibrosRestSystem methodsFor: 'operations - purchases' stamp: 'JIG 6/21/2019 16:41:13'!
listPurchasesOf: aClientID authenticatedWith: aPassword
	self authenticateClient: aClientID withPassword: aPassword.
	
	^salesBook select: [:aSale | aSale owner = aClientID ].! !


!TusLibrosRestSystem methodsFor: 'testing' stamp: 'Nico 6/13/2019 14:50:59'!
isCartIDActive: aCartID
	^activeCarts includesKey: aCartID.! !

!TusLibrosRestSystem methodsFor: 'testing' stamp: 'JIG 6/21/2019 18:53:21'!
isClientIDWithActiveCart: aClientID
	^(historicalCartsAmountPerClient includesKey: aClientID) and: [0 < historicalCartsAmountPerClient at: aClientID].! !


!TusLibrosRestSystem methodsFor: 'cart creation - private' stamp: 'JIG 6/21/2019 19:11:28'!
createCartIDFor: aClientID
	| newAmount newCartID |

	self updateHistoricalClientCartsAmount: aClientID.

	newAmount := historicalCartsAmountPerClient at: aClientID.
	newCartID := aClientID , newAmount asString.
	^newCartID! !

!TusLibrosRestSystem methodsFor: 'cart creation - private' stamp: 'JIG 6/20/2019 16:59:32'!
createNewCart.
	^Cart acceptingItemsOf: catalogue.! !

!TusLibrosRestSystem methodsFor: 'cart creation - private' stamp: 'JIG 6/21/2019 18:53:21'!
updateHistoricalClientCartsAmount: aClientID
	| currentAmountOfCarts |
	
	currentAmountOfCarts := historicalCartsAmountPerClient at: aClientID ifAbsent: [0].
	historicalCartsAmountPerClient at: aClientID put: (currentAmountOfCarts + 1).! !


!TusLibrosRestSystem methodsFor: 'cart session - private' stamp: 'JIG 6/21/2019 18:38:25'!
renewCartExpiration: aCartID
	| cartInfo |
	
	cartInfo := (activeCarts at: aCartID).  
	cartInfo at: 3 put: clock now.! !


!TusLibrosRestSystem methodsFor: 'authentication - private' stamp: 'Nico 6/13/2019 15:19:14'!
authenticateClient: aClientID withPassword: aPassword
	authenticator authenticateClient: aClientID withPassword: aPassword! !


!TusLibrosRestSystem methodsFor: 'cart operations - private' stamp: 'JIG 6/21/2019 19:05:02'!
add: aBookQuantity of: aBookFromStore to: aCartID
	| currentCart |
	currentCart := self cartOf: aCartID.
	currentCart add: aBookQuantity of: aBookFromStore.
	! !

!TusLibrosRestSystem methodsFor: 'cart operations - private' stamp: 'JIG 6/21/2019 17:06:46'!
addToActiveCarts: aCart withID: aCartID ownedBy: aClientID on: aCreationTime 
	 
	activeCarts at: aCartID put: (OrderedCollection with: aCart with: aClientID with: aCreationTime).! !

!TusLibrosRestSystem methodsFor: 'cart operations - private' stamp: 'JIG 6/21/2019 19:08:51'!
removeFromActiveCarts: aCartID
	activeCarts removeKey: aCartID.! !


!TusLibrosRestSystem methodsFor: 'cashier operations - private' stamp: 'JIG 6/21/2019 19:07:49'!
cashierCheckoutFor: aCartID payingWith: aCreditCart
	| cashier owner cart |
	owner := self ownerOf: aCartID.
	cart := self cartOf: aCartID.
	
	cashier := Cashier toCheckout: cart charging: aCreditCart throught: merchantProcessor on: (DateAndTime now) boughtBy: owner registeringOn: salesBook.
	cashier checkOutForClient .
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestSystem class' category: #TusLibros!
TusLibrosRestSystem class
	instanceVariableNames: ''!

!TusLibrosRestSystem class methodsFor: 'initialization' stamp: 'JIG 6/20/2019 18:14:18'!
cannotCheckoutInvalidCart
	^'No se puede realizar checkout con un carrito inexistente.'! !

!TusLibrosRestSystem class methodsFor: 'initialization' stamp: 'JIG 6/21/2019 16:48:32'!
withAuthenticator: anAuthenticator throught: aMerchantProcessor andCatalogue: aCatalogue andClock: aClock
	^self new initializeWithAuthenticator: anAuthenticator processingWith: aMerchantProcessor andCatalogue: aCatalogue andClock: aClock.! !


!TusLibrosRestSystem class methodsFor: 'error descriptions' stamp: 'JIG 6/21/2019 17:00:36'!
cartIsExpiredErrorDescription
	^'El carrito esta expirado'.! !

!TusLibrosRestSystem class methodsFor: 'error descriptions' stamp: 'Nico 6/13/2019 16:10:03'!
invalidCartIDErrorDescription
	^'El ID del carrito es inválido'! !
