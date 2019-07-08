!classDefinition: #TusLibrosWindow category: #TusLibros!
Panel subclass: #TusLibrosWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #TusLibrosBuyWindow category: #TusLibros!
TusLibrosWindow subclass: #TusLibrosBuyWindow
	instanceVariableNames: 'catalogueList cartList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosBuyWindow methodsFor: 'initialization' stamp: 'Nico 7/8/2019 12:10:34'!
defaultExtent

	^ 800@600
	! !

!TusLibrosBuyWindow methodsFor: 'initialization' stamp: 'Nico 7/8/2019 15:57:42'!
initializeWith: aTitle andModel: aModel

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
			
	self model when: #addingItemSuccessfull send: #refreshCatalogueListIndex to: self.
	self model when: #checkoutSuccessful send: #deleteAndOpenCartCreationWindow to: self.! !


!TusLibrosBuyWindow methodsFor: 'access' stamp: 'Nico 7/8/2019 16:01:54'!
deleteAndOpenCartCreationWindow
	TusLibrosClientWindow open.
	self delete.
! !

!TusLibrosBuyWindow methodsFor: 'access' stamp: 'Nico 7/7/2019 16:01:05'!
refreshCatalogueListIndex
	
	catalogueList setSelectionIndex: 0.
	cartList updateList.! !


!TusLibrosBuyWindow methodsFor: 'GUI building' stamp: 'Nico 7/8/2019 12:19:23'!
build1stRow
	| addToCartButton firstRowLayout  |
	
	catalogueList := PluggableListMorph model: self model listGetter: #catalogue indexGetter: #catalogueListIndex indexSetter: #catalogueListIndex:.
	catalogueList  borderColor: Color skyBlue.
	catalogueList  borderWidth: 1.
	
	addToCartButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendCartAddingItemRequest  label: 'Add product to cart'.
		
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'Catálogo');
	addMorph: catalogueList;
 	addMorph: addToCartButton.
	
	^firstRowLayout.! !

!TusLibrosBuyWindow methodsFor: 'GUI building' stamp: 'Nico 7/8/2019 12:20:08'!
build2ndColumn2ndRow
	| checkoutButton cardNumberTextBox cardCcedTextBox cardOwnerTextBox secondColumnLayoutOfSecondRow |
	
	checkoutButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendCheckoutRequest  label: 'Make Checkout'.
	
	cardNumberTextBox := TextModelMorph textProvider: self model textGetter: #cardNumberText textSetter: #cardNumberText:. 
	cardNumberTextBox textMorph setProperty: #keyStroke: toValue: [ :key | cardNumberTextBox textMorph acceptContents ].
	cardNumberTextBox	
		borderWidth: 1; borderColor: Color skyBlue;
	 	morphExtent: (200@30).
		
	cardCcedTextBox := TextModelMorph textProvider: self model textGetter: #cardCcedText textSetter: #cardCcedText:. 
	cardCcedTextBox textMorph setProperty: #keyStroke: toValue: [ :key | cardCcedTextBox textMorph acceptContents ].
	cardCcedTextBox	
		borderWidth: 1; borderColor: Color skyBlue;
	 	morphExtent: (200@30).
		
	cardOwnerTextBox := TextModelMorph textProvider: self model textGetter: #cardOwnerText textSetter: #cardOwnerText:. 
	cardOwnerTextBox textMorph setProperty: #keyStroke: toValue: [ :key | cardOwnerTextBox textMorph acceptContents ].
	cardOwnerTextBox	
		borderWidth: 1; borderColor: Color skyBlue;
	 	morphExtent: (200@30).	
		
	secondColumnLayoutOfSecondRow := LayoutMorph newColumn.
	secondColumnLayoutOfSecondRow separation: 5;
	padding: #left;
	addMorph: (StringMorph contents: 'Card Number');
	addMorph: cardNumberTextBox;
	addMorph: (StringMorph contents: 'Card Cced');
	addMorph: cardCcedTextBox;
	addMorph: (StringMorph contents: 'Card Owner');
	addMorph: cardOwnerTextBox;
	addMorph: checkoutButton.
	
	^secondColumnLayoutOfSecondRow! !

!TusLibrosBuyWindow methodsFor: 'GUI building' stamp: 'Nico 7/8/2019 12:16:23'!
build2ndRow
	| secondRowLayout  |
	
	cartList := PluggableListMorph model: self model listGetter: #cartListItems indexGetter: #cartListItemsIndex indexSetter: #cartListItemsIndex:.
	cartList  borderColor: Color skyBlue.
	cartList  borderWidth: 1.
	"cartList morphPosition: (81@90)."
	
	"checkoutButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendCheckoutRequest  label: 'Make Checkout'."
		
	secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'Carrito');
	addMorph: cartList;
 	addMorph: self build2ndColumn2ndRow.
	
	^secondRowLayout.! !

!TusLibrosBuyWindow methodsFor: 'GUI building' stamp: 'Nico 7/8/2019 16:12:16'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 5;
	padding: #left;
	addMorph: self build1stRow;
	addMorph: self build2ndRow.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosBuyWindow class' category: #TusLibros!
TusLibrosBuyWindow class
	instanceVariableNames: ''!

!TusLibrosBuyWindow class methodsFor: 'instance creation' stamp: 'Nico 7/7/2019 15:22:38'!
openWith: aModel
	
	^self new initializeWith: 'TusLibros - Ventana de compra' andModel: aModel.! !


!classDefinition: #TusLibrosClientWindow category: #TusLibros!
TusLibrosWindow subclass: #TusLibrosClientWindow
	instanceVariableNames: 'substringsList usernameTextBox passwordTextBox'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'JIG 7/6/2019 15:46:46'!
build1stRow
	| firstRowLayout |
	
	"sendRequestButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendSubtringsRequest  label: 'Send Request To Server'."
	
	usernameTextBox := TextModelMorph textProvider: self model textGetter: #usernameText textSetter: #usernameText:. 
	usernameTextBox textMorph setProperty: #keyStroke: toValue: [ :key | usernameTextBox textMorph acceptContents ].
	usernameTextBox	
		borderWidth: 1; borderColor: Color skyBlue;
	 	morphExtent: (200@30).
	
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 15;
	padding: #left;
	addMorph: (StringMorph contents:'Usuario: ');
	addMorph: usernameTextBox.
	
	^firstRowLayout.! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'JIG 7/6/2019 15:47:01'!
build2ndRow
	| secondRowLayout |
	
	passwordTextBox := TextModelMorph textProvider: self model textGetter: #passwordText textSetter: #passwordText:. 
	passwordTextBox textMorph setProperty: #keyStroke: toValue: [ :key | passwordTextBox textMorph acceptContents ] .
	passwordTextBox	
		borderWidth: 1; borderColor: Color skyBlue;
	 	morphExtent: (200@30).
			
	secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 15;
	padding: #left;
	addMorph: (StringMorph contents:'Password:');
	addMorph: passwordTextBox.
	
	^secondRowLayout.
	
	"showInTranscriptButton := PluggableButtonMorph model: self model stateGetter: nil  action: #showWordInTranscript label: 'Show Selected Word In Transcript'."	
	
	"secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 25;
	padding: #left;
	addMorph: self build1stColumn2ndRow;
	addMorph: showInTranscriptButton."
	
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'JIG 7/6/2019 15:56:06'!
build3rdRow
	| thirdRowLayout createCartRequest |
	
	createCartRequest := PluggableButtonMorph model: self model stateGetter: nil  action: #sendCreateCartRequest  label: 'Crear carrito'.
		
	thirdRowLayout := LayoutMorph newRow.
	thirdRowLayout separation: 25;
	padding: #left;
	addMorph: createCartRequest.
	
	^thirdRowLayout.
	
	"showInTranscriptButton := PluggableButtonMorph model: self model stateGetter: nil  action: #showWordInTranscript label: 'Show Selected Word In Transcript'."	
	
	"secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 25;
	padding: #left;
	addMorph: self build1stColumn2ndRow;
	addMorph: showInTranscriptButton."
	
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'JIG 7/6/2019 15:53:20'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 5;
	padding: #left;
	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow.
	! !


!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'JIG 7/6/2019 15:54:47'!
defaultExtent

	^ 500@330
	! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'JIG 7/6/2019 16:13:12'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
			
	self model when: #cartCreationSuccessful send: #createSecondWindow to: self.! !


!TusLibrosClientWindow methodsFor: 'panels-add/remove' stamp: 'Nico 7/8/2019 15:55:14'!
createSecondWindow
	TusLibrosBuyWindow openWith: model.
	self delete.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: #TusLibros!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'instance creation' stamp: 'JIG 7/6/2019 15:29:28'!
open
	
	^self new initializeWith: 'TusLibros - Creacion de carrito'.! !


!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/22/2019 21:02:16'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorDescription.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/22/2019 21:02:28'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorDescription.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/22/2019 21:02:37'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorDescription.
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

!CashierTest methodsFor: 'tests' stamp: 'NI 6/22/2019 20:11:50'!
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
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorDescription.
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

!CashierTest methodsFor: 'tests' stamp: 'NI 6/22/2019 20:11:42'!
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
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorDescription.
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

!CashierTest methodsFor: 'tests' stamp: 'NI 6/22/2019 20:11:56'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorDescription].
	
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
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorDescription.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'NI 6/22/2019 20:12:00'!
test07CashierDoesNotSaleIfTheCreditCardIsStolen

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardIsStolenErrorDescription].
	
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
			self assert: anError messageText = Cashier creditCardIsStolenErrorDescription.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'NI 6/22/2019 20:12:06'!
test08CashierDoesNotSaleIfCreditCardOwnerIsMoreThan30CharactersLong

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := CreditCard for: 'juan ignazakipati grandosinhoskitamo' expiringOn: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) withIDNumber: testObjectsFactory anIDForExpiredCreditCard .
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | 
		aCreditCard owner size > 30 ifTrue: [self error: Cashier creditCardOwnerShouldHaveLessThan30CharactersErrorDescription]].
	
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
			self assert: anError messageText = Cashier creditCardOwnerShouldHaveLessThan30CharactersErrorDescription.
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
	instanceVariableNames: 'testFactory tusLibrosController anAuthenticator debitBehavior clock expirationTime validClient validPassword'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestSystemTest methodsFor: 'setup' stamp: 'Nico 7/8/2019 11:18:00'!
setUp
	clock := Clock on: DateAndTime now.
	testFactory := StoreTestObjectsFactory new.
	anAuthenticator := TusLibrosAuthenticator withUserDatabase: (testFactory aGenericUserDatabase).
	tusLibrosController := TusLibrosRestSystem 
								throught: self
								authenticatingWith: anAuthenticator
								acceptingItemsOf: (testFactory fullCatalog)
								withClock: clock.
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	expirationTime := 30 minutes.
	
	validClient := testFactory aFirstClientValidUserID.
	validPassword := testFactory aFirstClientValidPassword.! !


!TusLibrosRestSystemTest methodsFor: 'merchant processor protocol' stamp: 'JIG 6/20/2019 17:50:10'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!TusLibrosRestSystemTest methodsFor: 'tests - cart creation' stamp: 'NI 6/22/2019 19:45:53'!
test01CannotCreateCartWhenInvalidAuthentication

	self should: [ tusLibrosController createCartFor: testFactory anInvalidClientUserID authenticatedWith: testFactory anInvalidPassword ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: 
			(anError messageText = TusLibrosAuthenticator invalidPasswordErrorDescription or: [anError messageText = TusLibrosAuthenticator unknownUserErrorDescription ]).
	]! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart creation' stamp: 'NI 6/22/2019 20:57:55'!
test02ValidClientCanCreateACart
	| aCartID |
	aCartID := tusLibrosController createCartFor: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	self assert: (tusLibrosController listCart: aCartID) isEmpty.! !


!TusLibrosRestSystemTest methodsFor: 'tests - cart listing' stamp: 'NI 6/22/2019 20:07:52'!
test03CannotListAnInvalidCart
	| aCartID |
	aCartID := 'InvalidCartID'.
	
	self should: [ tusLibrosController listCart: aCartID ] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription
	].! !


!TusLibrosRestSystemTest methodsFor: 'tests - adding items' stamp: 'JIG 6/21/2019 16:27:48'!
test04ValidCartCanAddItemsFromCatalogue
	| aCartID cartItems |
	aCartID := tusLibrosController createCartFor: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: aCartID.
	
	cartItems := tusLibrosController listCart: aCartID.
	
	self assert: cartItems size = 1.
	self assert: (cartItems includes: testFactory itemSellByTheStore).
	self assert: (cartItems occurrencesOf: testFactory itemSellByTheStore) = 1.! !

!TusLibrosRestSystemTest methodsFor: 'tests - adding items' stamp: 'NI 6/22/2019 21:04:11'!
test05CannotAddItemsToCartThatDoNotBelongToStore
	| aCartID |
	aCartID := tusLibrosController createCartFor: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	self should: [ tusLibrosController add: 1 of: testFactory itemNotSellByTheStore toCart: aCartID ] 
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText = Cart invalidItemErrorDescription.
		self assert: (tusLibrosController listCart: aCartID) isEmpty
	].! !

!TusLibrosRestSystemTest methodsFor: 'tests - adding items' stamp: 'NI 6/22/2019 21:05:13'!
test06CannotAddToCartNonPositiveNumberOfItems
	| aCartID |
	aCartID := tusLibrosController createCartFor: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	self should: [ tusLibrosController add: -1 of: testFactory itemSellByTheStore toCart: aCartID ] 
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText = Cart invalidQuantityErrorDescription.
		self assert: (tusLibrosController listCart: aCartID) isEmpty
	].! !

!TusLibrosRestSystemTest methodsFor: 'tests - adding items' stamp: 'NI 6/22/2019 21:06:21'!
test07CannotAddItemsToInvalidCart
	| aCartID |
	aCartID := 'anInvalidCartID'.
	
	self should: [ tusLibrosController add: 2 of: testFactory itemSellByTheStore toCart: aCartID] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription
	].! !


!TusLibrosRestSystemTest methodsFor: 'tests - purchase listing' stamp: 'NI 6/22/2019 21:06:17'!
test08ClientWithoutTransactionsHasNoPurchases
	| purchasesContent |
	
	purchasesContent := tusLibrosController listPurchasesOf: testFactory aFirstClientValidUserID authenticatedWith: testFactory aFirstClientValidPassword.
	
	self assert: purchasesContent isEmpty.
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - purchase listing' stamp: 'NI 6/22/2019 21:06:14'!
test09CannotListPurchasesWhenInvalidAuthentication
	
	self should: [ tusLibrosController listPurchasesOf: testFactory anInvalidClientUserID authenticatedWith: testFactory aFirstClientValidPassword. ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: (anError messageText = TusLibrosAuthenticator invalidPasswordErrorDescription or: [anError messageText = TusLibrosAuthenticator unknownUserErrorDescription ]).
	]. 
	
	
	
	
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - purchase listing' stamp: 'NI 6/22/2019 21:05:36'!
test20SystemAddsPurchaseOnlyToClientPurchaseList
	| newCartID listPurchaseOfOtherClient listPurchasesAfter secondClient successfulSale secondPassword |
		
	secondClient := testFactory aSecondClientValidUserID.
	secondPassword := testFactory aSecondClientValidPassword.
		
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	successfulSale := tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard.
	
	listPurchasesAfter := tusLibrosController listPurchasesOf: validClient  authenticatedWith: validPassword .
	listPurchaseOfOtherClient := tusLibrosController listPurchasesOf: secondClient authenticatedWith: secondPassword.
	
	self assert: listPurchasesAfter last equals: successfulSale.
	self assert: listPurchasesAfter size = 1.
	self assert: listPurchaseOfOtherClient size = 0.! !


!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:06:11'!
test10CannotCheckoutAnEmptyCart
	| listPurchasesBefore newCartID |
	
	listPurchasesBefore := (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword) copy.
	
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier cartCanNotBeEmptyErrorDescription.
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword).
	]. 
	
	
	
	
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:06:06'!
test11CannotCheckoutAnInvalidCart
	| invalidCart |
	
	invalidCart := 'Not valid cart'.
	
	self should: [ tusLibrosController checkoutFor: invalidCart payingWith: testFactory notExpiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription.
	]. 
		
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:06:01'!
test12CannotCheckoutWithExpiredCreditCard
	| listPurchasesBefore newCartID |
	
	listPurchasesBefore := (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword) copy.
	
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
		
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: testFactory expiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorDescription.
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword).
	]. 
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:05:58'!
test13CannotCheckoutWhenTheCreditCardHasNoFunds
	| listPurchasesBefore newCartID |
	
	listPurchasesBefore := (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword) copy.
	
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorDescription].
	
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier creditCardHasNoCreditErrorDescription.
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword).
	]. 
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:05:56'!
test14CannotCheckoutWhenTheCreditCardIsStolen
	| listPurchasesBefore newCartID |
	
	listPurchasesBefore := (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword) copy.
	
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardIsStolenErrorDescription ].
	
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier creditCardIsStolenErrorDescription.
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword).
	]. 
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:05:52'!
test15CannotCheckoutIfCreditCardOwnerIsMoreThan30CharactersLong
	| listPurchasesBefore newCartID aCreditCardWithInvalidOwner |
	
	listPurchasesBefore := (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword) copy.
	
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardOwnerShouldHaveLessThan30CharactersErrorDescription ].
	aCreditCardWithInvalidOwner := CreditCard for: 'juan ignazakipati grandosinhoskitamo' expiringOn: (Month month: testFactory today monthIndex year: testFactory today yearNumber + 1) withIDNumber: testFactory anIDForValidCreditCard.
	
	self should: [ tusLibrosController checkoutFor: newCartID payingWith: aCreditCardWithInvalidOwner ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier creditCardOwnerShouldHaveLessThan30CharactersErrorDescription.
		self assert: listPurchasesBefore equals: (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword).
	]. 
	
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:05:49'!
test16CheckoutChargesCreditCardUsingMerchantProcessor
	| newCartID debitedAmout debitedCreditCard creditCard sale |
	
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	debitBehavior := [ :anAmount :aCreditCard |
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].

	creditCard := testFactory notExpiredCreditCard.
	
	sale := tusLibrosController checkoutFor: newCartID payingWith: creditCard.
	
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = sale total.! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:05:45'!
test17SystemAddsANewPurchaseAfterCheckout
	| listPurchasesBefore newCartID listPurchasesAfter successfulSale |
	
	listPurchasesBefore := (tusLibrosController listPurchasesOf: validClient authenticatedWith: validPassword) copy.
	
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	successfulSale := tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard.
	
	listPurchasesAfter := tusLibrosController listPurchasesOf: validClient  authenticatedWith: validPassword .
	
	self assert: listPurchasesAfter last equals: successfulSale.
	self assert: listPurchasesBefore size equals: listPurchasesAfter size - 1.
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:05:42'!
test18CheckoutRemovesCart
	| newCartID |
	
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard.
	
	self should: [ tusLibrosController listCart: newCartID ]  
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = TusLibrosRestSystem invalidCartIDErrorDescription ].! !

!TusLibrosRestSystemTest methodsFor: 'tests - cart checkout' stamp: 'NI 6/22/2019 21:05:39'!
test19CheckoutAddedSalePersistsWithCartContent
	| newCartID sale cartItems |
	
	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	cartItems := (tusLibrosController listCart: newCartID) copy.
	sale := tusLibrosController checkoutFor: newCartID payingWith: testFactory notExpiredCreditCard.
	
	self assert: sale items = cartItems.
	self assert: sale owner = validClient.! !


!TusLibrosRestSystemTest methodsFor: 'tests - session time' stamp: 'NI 6/22/2019 21:05:33'!
test21CannotAddItemsToExpiredCart
	| newCartID |	

	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	
	tusLibrosController clock advanceTime: 31 minutes.
		
	self should: [ tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID ]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = TusLibrosRestSystem cartIsExpiredErrorDescription
	]
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - session time' stamp: 'NI 6/22/2019 21:05:30'!
test22CannotListAnExpiredCart
	| newCartID |	

	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	
	tusLibrosController clock advanceTime: 31 minutes.
		
	self should: [ tusLibrosController listCart: newCartID ]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = TusLibrosRestSystem cartIsExpiredErrorDescription
	]
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - session time' stamp: 'NI 6/22/2019 21:05:28'!
test23CannotCheckoutAnExpiredCart
	| newCartID |	

	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	
	tusLibrosController clock advanceTime: 31 minutes.
		
	self should: [ tusLibrosController listCart: newCartID ]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = TusLibrosRestSystem cartIsExpiredErrorDescription
	]
	! !

!TusLibrosRestSystemTest methodsFor: 'tests - session time' stamp: 'NI 6/22/2019 21:05:24'!
test24CartSessionTimeRenovatesAfterAdding
	| newCartID cartItems |	

	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	
	tusLibrosController clock advanceTime: 28 minutes.
		
	tusLibrosController add: 1 of: testFactory itemSellByTheStore toCart: newCartID.
	
	tusLibrosController clock advanceTime: 28 minutes.
	
	cartItems := tusLibrosController listCart: newCartID.
	
	self assert: cartItems size = 1.
	

	! !

!TusLibrosRestSystemTest methodsFor: 'tests - session time' stamp: 'NI 6/22/2019 21:05:22'!
test25CartSessionTimeRenovatesAfterListing
	| newCartID cartItems |	

	newCartID := tusLibrosController createCartFor: validClient authenticatedWith: validPassword.
	
	tusLibrosController clock advanceTime: 28 minutes.
		
	tusLibrosController listCart: newCartID.
	
	tusLibrosController clock advanceTime: 28 minutes.
	
	cartItems := tusLibrosController listCart: newCartID.
	
	self assert: cartItems isEmpty.
	

	! !


!classDefinition: #TusLibrosServerControllerTest category: #TusLibros!
TestCase subclass: #TusLibrosServerControllerTest
	instanceVariableNames: 'testFactory tusLibrosController anAuthenticator clock server debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosServerControllerTest methodsFor: 'aux' stamp: 'Nico 6/28/2019 20:14:52'!
createServer
	^TusLibrosServerController new initializeWith: tusLibrosController.! !

!TusLibrosServerControllerTest methodsFor: 'aux' stamp: 'nico 6/30/2019 20:04:43'!
stopListeningAndDestroyServer
	TusLibrosServerController allInstances do: [:aServer | aServer stopListening. aServer destroy].! !


!TusLibrosServerControllerTest methodsFor: 'http requests' stamp: 'asd 7/3/2019 15:24:41'!
checkoutCartHttpRequestFor: aCartID card: aCreditCardNumber expDate: anExpirationDate owner: anOwner
	^'http://localhost:8080/checkOutCart?cartId=', aCartID, '&cnn=',  aCreditCardNumber, '&cced=', anExpirationDate, '&cco=', anOwner
	
	! !

!TusLibrosServerControllerTest methodsFor: 'http requests' stamp: 'Nico 7/7/2019 15:42:48'!
createAddToCartHttpRequestFor: aCartID book: anItem quantity: anAmount
	^ 'http://localhost:8080/addToCart?cartId=', aCartID, '&bookIsbn=', anItem ,'&bookQuantity=', anAmount asString! !

!TusLibrosServerControllerTest methodsFor: 'http requests' stamp: 'asd 7/3/2019 14:16:19'!
createCartHttpRequestFor: anUserID authenticatingWith: aPassword

	^ 'http://localhost:8080/createCart?clientId=', anUserID ,'&password=', aPassword.
	! !

!TusLibrosServerControllerTest methodsFor: 'http requests' stamp: 'asd 7/3/2019 14:21:20'!
listCartHttpRequestFor: aCartID

	^ 'http://localhost:8080/listCart?cartId=', aCartID
! !

!TusLibrosServerControllerTest methodsFor: 'http requests' stamp: 'asd 7/3/2019 14:55:50'!
listPurchasesHttpRequestFor: anUserID authenticatingWith: aPassword
	^'http://localhost:8080/listPurchases?clientId=', anUserID, '&password=', aPassword
	
	! !


!TusLibrosServerControllerTest methodsFor: 'merchant processor protocol' stamp: 'Nico 7/8/2019 13:05:38'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard 
	! !


!TusLibrosServerControllerTest methodsFor: 'parsing' stamp: 'JIG 6/30/2019 16:14:44'!
extractCartIDFrom: aCartCreationResponse
	^aCartCreationResponse copyFrom: 3 to: aCartCreationResponse size.! !


!TusLibrosServerControllerTest methodsFor: 'setup' stamp: 'Nico 7/8/2019 13:04:31'!
setUp
	testFactory := StoreTestObjectsFactory new.
	
	clock := Clock on: DateAndTime now.
	anAuthenticator := TusLibrosAuthenticator withUserDatabase: (testFactory aGenericUserDatabase).
	tusLibrosController := TusLibrosRestSystem 
								throught: self
								authenticatingWith: anAuthenticator
								acceptingItemsOf: (testFactory fullCatalog)
								withClock: clock.
								
	server := self createServer.
	
	debitBehavior := [ :anAmount :aCreditCard | ].! !


!TusLibrosServerControllerTest methodsFor: 'tear down' stamp: 'JIG 6/30/2019 13:35:42'!
tearDown
	self stopListeningAndDestroyServer.
! !


!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'JIG 7/6/2019 16:31:06'!
test01CannotCreateCartWhenInvalidAuthentication
	|response createCartHttpRequest |

	createCartHttpRequest := self createCartHttpRequestFor: testFactory anInvalidClientUserID authenticatingWith: testFactory anInvalidPassword.

	response := WebClient httpGet: createCartHttpRequest.
	self assert: response content equals: '1|', TusLibrosServerController invalidAuthenticationErrorDescription .
	! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'asd 7/3/2019 14:19:57'!
test02ValidClientCanCreateACart
	|response createCartHttpRequest |
	
	createCartHttpRequest := self createCartHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.

	response := WebClient httpGet: createCartHttpRequest.
	
	self assert: response content equals: '0|Wilkinson1'.
! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'asd 7/3/2019 14:21:03'!
test03CannotListAnInvalidCart
	| aCartID responseListCart listCartHttpRequest |
	
	aCartID := 'InvalidCartID'.

	listCartHttpRequest := self listCartHttpRequestFor: aCartID.

	responseListCart := WebClient httpGet: listCartHttpRequest.
	
	self assert: responseListCart content equals: '1|', TusLibrosRestSystem invalidCartIDErrorDescription.
! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'Nico 7/8/2019 11:50:12'!
test04ValidCartCanAddItemsFromCatalogue
	| aCartID responseCreateCart responseListCart responseAddToCart createCartHttpRequest addToCartHttpRequest listCartHttpRequest |
	
	createCartHttpRequest := self createCartHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.		
	responseCreateCart := WebClient httpGet: createCartHttpRequest.
	
	aCartID := self extractCartIDFrom: responseCreateCart content.
	addToCartHttpRequest := self createAddToCartHttpRequestFor: aCartID book: testFactory itemSellByTheStore quantity: 1.
	responseAddToCart := WebClient httpGet: addToCartHttpRequest.	
	
	listCartHttpRequest := self listCartHttpRequestFor: aCartID.
	responseListCart := WebClient httpGet: listCartHttpRequest.
	
	self assert: responseAddToCart content equals: '0|OK'.
	self assert: responseListCart content equals: '0|', testFactory itemSellByTheStore, '|1|'.
! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'Nico 7/8/2019 11:50:34'!
test05CannotAddItemsToCartThatDoNotBelongToStore
	| aCartID responseCreateCart responseListCart responseAddToCart createCartHttpRequest addToCartHttpRequest listCartHttpRequest |
		
	createCartHttpRequest := self createCartHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.
	responseCreateCart := WebClient httpGet: createCartHttpRequest.
	
	aCartID := self extractCartIDFrom: responseCreateCart content.
	addToCartHttpRequest := self createAddToCartHttpRequestFor: aCartID book: testFactory itemNotSellByTheStore quantity: 1. 
	responseAddToCart := WebClient httpGet: addToCartHttpRequest. 
	
	listCartHttpRequest := self listCartHttpRequestFor: aCartID.
	responseListCart := WebClient httpGet: listCartHttpRequest.
	
	self assert: responseAddToCart content equals: '1|', Cart invalidItemErrorDescription.
	self assert: responseListCart content equals: '0|'.
! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'Nico 7/8/2019 11:50:37'!
test06CannotAddToCartNonPositiveNumberOfItems
	| aCartID responseCreateCart responseListCart responseAddToCart createCartHttpRequest addToCartHttpRequest listCartHttpRequest |
		
	createCartHttpRequest := self createCartHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.
	responseCreateCart := WebClient httpGet: createCartHttpRequest.
	
	aCartID := self extractCartIDFrom: responseCreateCart content.
	addToCartHttpRequest := self createAddToCartHttpRequestFor: aCartID book: testFactory itemSellByTheStore quantity: -1.
	responseAddToCart := WebClient httpGet: addToCartHttpRequest. 
	
	listCartHttpRequest := self listCartHttpRequestFor: aCartID.
	responseListCart := WebClient httpGet: listCartHttpRequest.
	
	self assert: responseAddToCart content equals: '1|', Cart invalidQuantityErrorDescription.
	self assert: responseListCart content equals: '0|'.
! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'Nico 7/7/2019 15:42:49'!
test07CannotAddItemsToInvalidCart
	| aCartID responseAddToCart addToCartHttpRequest |

	aCartID := 'invalidCart'.
	addToCartHttpRequest := self createAddToCartHttpRequestFor: aCartID book: testFactory itemSellByTheStore quantity: 2. 
	responseAddToCart := WebClient httpGet: addToCartHttpRequest.
	
	self assert: responseAddToCart content equals: '1|', TusLibrosRestSystem invalidCartIDErrorDescription.
! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'JIG 7/8/2019 14:45:32'!
test08ClientWithoutTransactionsHasNoPurchases
	| responseListPurchases listPurchasesHttpRequest |
	
	listPurchasesHttpRequest := self listPurchasesHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.
	responseListPurchases := WebClient httpGet: listPurchasesHttpRequest.
	
	self assert: responseListPurchases content equals: '0|'.
	
	! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'asd 7/3/2019 14:56:57'!
test09CannotListPurchasesWhenInvalidAuthentication
	| responseListPurchases listPurchasesHttpRequest |
	
	listPurchasesHttpRequest := self listPurchasesHttpRequestFor: testFactory anInvalidClientUserID authenticatingWith: testFactory aFirstClientValidPassword.
	responseListPurchases := WebClient httpGet: listPurchasesHttpRequest.
	
	self assert: responseListPurchases content equals: '1|', TusLibrosServerController invalidAuthenticationErrorDescription.
	
	! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'asd 7/3/2019 15:26:12'!
test10CannotCheckoutAnEmptyCart
	| responseCheckout aCartID responseCreateCart responseAfterCheckoutListPurchases responseBeforeCheckoutListPurchases createCartHttpRequest listPurchasesBeforeHttpRequest checkoutHttpRequest listPurchasesAfterHttpRequest |
			
	createCartHttpRequest := self createCartHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.
	responseCreateCart := WebClient httpGet: createCartHttpRequest.
	
	aCartID := self extractCartIDFrom: responseCreateCart content.
	listPurchasesBeforeHttpRequest := self listPurchasesHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.
	responseBeforeCheckoutListPurchases := WebClient httpGet: listPurchasesBeforeHttpRequest.
	
	checkoutHttpRequest := self checkoutCartHttpRequestFor: aCartID card: testFactory anIDForValidCreditCard expDate: testFactory aValidExpirationDate owner: testFactory ownerOfValidCreditCard.
	responseCheckout := WebClient httpGet: checkoutHttpRequest.
	
	listPurchasesAfterHttpRequest := self listPurchasesHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.
	responseAfterCheckoutListPurchases := WebClient httpGet: listPurchasesAfterHttpRequest.
	
	self assert: responseCheckout content equals: '1|', Cashier cartCanNotBeEmptyErrorDescription.
	self assert: responseBeforeCheckoutListPurchases content equals: responseAfterCheckoutListPurchases content.
	
	! !

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'JIG 7/6/2019 15:04:38'!
test11CannotCheckoutAnInvalidCart
	| responseCheckout aCartID checkoutHttpRequest |

	aCartID := 'invalidCart'.
	checkoutHttpRequest :=  self checkoutCartHttpRequestFor: aCartID card: testFactory anIDForValidCreditCard expDate: testFactory aValidExpirationDate owner: testFactory ownerOfValidCreditCard.	
	responseCheckout := WebClient httpGet: checkoutHttpRequest.
	
	self assert: responseCheckout content equals: '1|', TusLibrosRestSystem invalidCartIDErrorDescription.
	
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'NI 6/22/2019 21:03:07'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorDescription ]! !

!Cart methodsFor: 'assertions' stamp: 'NI 6/22/2019 21:03:13'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorDescription]! !


!Cart methodsFor: 'initialization' stamp: 'JIG 6/30/2019 16:08:25'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


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


!Cart class methodsFor: 'error descriptions' stamp: 'NI 6/22/2019 21:01:43'!
invalidItemErrorDescription
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error descriptions' stamp: 'NI 6/22/2019 21:02:04'!
invalidQuantityErrorDescription
	
	^'Invalid number of items'! !


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

!Cashier class methodsFor: 'assertions' stamp: 'NI 6/22/2019 20:11:50'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorDescription ]! !

!Cashier class methodsFor: 'assertions' stamp: 'NI 6/22/2019 20:11:42'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorDescription ]! !


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


!Cashier class methodsFor: 'error descriptions' stamp: 'NI 6/22/2019 20:11:42'!
canNotChargeAnExpiredCreditCardErrorDescription
	
	^'No se puede debitar a una tarjeta expirada'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'JIG 6/30/2019 17:36:31'!
cartCanNotBeEmptyErrorDescription
	
	^'No se puede hacer checkout de un carrito vacio'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'NI 6/22/2019 20:11:56'!
creditCardHasNoCreditErrorDescription
	
	^'La tarjeta de crédito no tiene fondos'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'NI 6/22/2019 20:12:00'!
creditCardIsStolenErrorDescription
	
	^'La tarjeta de crédito es robada'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'NI 6/22/2019 20:12:06'!
creditCardOwnerShouldHaveLessThan30CharactersErrorDescription
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

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'JIG 6/30/2019 13:46:03'!
aFirstClientValidPassword
	^'Sr.Smalltalk'.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'Nico 6/13/2019 16:30:47'!
aFirstClientValidUserID
	^'Wilkinson'.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'JIG 6/30/2019 16:21:25'!
aGenericUserDatabase
	^Dictionary 
		newFromPairs: { 
			'Juan'. 'CasiSmalltalk'. 
			'Nico'. 'SmalltalkCreo'. 
			'Wilkinson'. 'Sr.Smalltalk'.
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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'JIG 7/6/2019 15:09:53'!
fullCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card expirations' stamp: 'JIG 6/30/2019 17:49:20'!
aValidExpirationDate
	| validDate monthParsed yearParsed |
	
	validDate := (Month month: today monthIndex year: today yearNumber + 1).
	validDate monthIndex < 10 ifTrue: [monthParsed := '0', validDate monthIndex asString] ifFalse: [monthParsed := validDate monthIndex asString].
	yearParsed := validDate yearNumber asString.
	
	^monthParsed , yearParsed.! !

!StoreTestObjectsFactory methodsFor: 'credit card expirations' stamp: 'JIG 6/30/2019 17:25:00'!
anInvalidExpirationDate
	| validDate monthParsed yearParsed |
	
	validDate := (Month month: today monthIndex year: today yearNumber - 1).
	validDate monthIndex < 10 ifFalse: [monthParsed := '0', validDate monthIndex asString] ifTrue: [monthParsed := validDate monthIndex asString].
	yearParsed := validDate yearNumber asString.
	
	^monthParsed , yearParsed.! !


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


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'JIG 7/6/2019 15:10:20'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'JIG 7/6/2019 15:10:03'!
anotherItemSellByTheStorePrice
	^15! !

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

!TusLibrosAuthenticator class methodsFor: 'instance creation' stamp: 'Nico 6/13/2019 14:47:43'!
withUserDatabase: userEntries
	^self new initializeWithUserDatabase: userEntries.! !


!TusLibrosAuthenticator class methodsFor: 'error descriptions' stamp: 'Nico 6/13/2019 14:52:48'!
invalidPasswordErrorDescription
	^'La contraseña no coincide con el usuario ingresado'.! !

!TusLibrosAuthenticator class methodsFor: 'error descriptions' stamp: 'Nico 6/13/2019 14:58:23'!
unknownUserErrorDescription
	^'El cliente nombrado es inexistente'.! !


!classDefinition: #TusLibrosClientWindowModel category: #TusLibros!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'webClient idCart username password catalogueSelectedIndex catalogueList cartList cartListSelectedIndex cardNumber cardCced cardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosClientWindowModel methodsFor: 'First Window - TextModelMorphSelectors' stamp: 'JIG 7/6/2019 15:58:22'!
passwordText
	
	^password.! !

!TusLibrosClientWindowModel methodsFor: 'First Window - TextModelMorphSelectors' stamp: 'JIG 7/6/2019 15:58:18'!
passwordText: aPassword

	password :=aPassword.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'First Window - TextModelMorphSelectors' stamp: 'JIG 7/6/2019 15:57:56'!
usernameText
	
	^username.! !

!TusLibrosClientWindowModel methodsFor: 'First Window - TextModelMorphSelectors' stamp: 'JIG 7/6/2019 15:58:07'!
usernameText: aUsername

	username:=aUsername.
	^true.! !


!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'Nico 7/7/2019 15:25:50'!
sendCartAddingItemRequest
	
	catalogueSelectedIndex = 0 ifFalse: [ | itemSelected |
		itemSelected := catalogueList at: catalogueSelectedIndex.
		webClient sendCartAddingRequestToCart: idCart WithItem: itemSelected.
		self triggerEvent: #addingItemSuccessfull with: self
	].
	! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'Nico 7/8/2019 16:06:57'!
sendCheckoutRequest

	webClient sendCheckoutCartRequest: idCart withCardNumber: cardNumber cced: cardCced andOwner: cardOwner.
	
	[self openTranscriptWithClientPurchases] fork.
	
	self triggerEvent: #checkoutSuccessful with: self.
! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'Nico 7/7/2019 15:24:17'!
sendCreateCartRequest
		
	idCart := webClient sendCreateCartRequestWithUser: username authenticatedWith: password.
	
	self triggerEvent: #cartCreationSuccessful with: self.
	! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'NR 6/25/2019 22:13:32'!
showWordInTranscript
	
	(selectedIndex = 0) ifFalse: 
		[TranscriptWindow openTranscript.
		Transcript clear.
		Transcript show: 'The word selected is: '.
		Transcript show: (listOfWords at: selectedIndex).
		Transcript show: ' '.].
! !


!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'Nico 7/7/2019 15:39:40'!
cartListItems
	cartList := webClient sendListCartRequest: idCart.
	^cartList.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'Nico 7/7/2019 15:38:16'!
cartListItemsIndex
	^cartListSelectedIndex! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'Nico 7/7/2019 15:38:37'!
cartListItemsIndex: anIndex
	cartListSelectedIndex := anIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'Nico 7/7/2019 13:04:39'!
catalogue
	catalogueList := webClient sendListCatalogueRequest.
	^catalogueList! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'Nico 7/7/2019 12:21:23'!
catalogueListIndex
	^catalogueSelectedIndex! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'Nico 7/7/2019 12:21:36'!
catalogueListIndex: anIndex
	catalogueSelectedIndex := anIndex! !


!TusLibrosClientWindowModel methodsFor: 'Second Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:04:09'!
cardCcedText
	
	^cardCced
! !

!TusLibrosClientWindowModel methodsFor: 'Second Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:04:01'!
cardCcedText: aCardCced
	
	cardCced := aCardCced.
	^true! !

!TusLibrosClientWindowModel methodsFor: 'Second Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:03:09'!
cardNumberText
	
	^cardNumber.! !

!TusLibrosClientWindowModel methodsFor: 'Second Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:03:47'!
cardNumberText: aCardNumber
	
	cardNumber := aCardNumber.
	^true! !

!TusLibrosClientWindowModel methodsFor: 'Second Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:04:38'!
cardOwnerText
	
	^ cardOwner
	! !

!TusLibrosClientWindowModel methodsFor: 'Second Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:04:44'!
cardOwnerText: aCardOwner
	
	cardOwner := aCardOwner.
	^true! !


!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'Nico 7/8/2019 16:13:22'!
initialize

	username:=''.
	password := ''.
	idCart := 0.
	webClient := TusLibrosWebClient new.
	catalogueSelectedIndex := 0.
	cartListSelectedIndex := 0.
	
	cardNumber := ''.
	cardCced := ''.
	cardOwner := ''.! !


!TusLibrosClientWindowModel methodsFor: 'transcript' stamp: 'Nico 7/8/2019 16:14:23'!
openTranscriptWithClientPurchases
	TranscriptWindow openTranscript.
	Transcript clear.
	Transcript show: 'La compra se realizó correctamente'; newLine.
	Transcript newLine.
	Transcript show: 'La lista de compras es: '; newLine.
	Transcript show: '    '.
	self showClientHistoricalPurchases.! !


!TusLibrosClientWindowModel methodsFor: 'transcript - private' stamp: 'Nico 7/8/2019 16:07:52'!
showClientHistoricalPurchases
	| listPurchasesHttpRequest responseListPurchases |

	listPurchasesHttpRequest := webClient listPurchasesHttpRequestFor: username authenticatingWith: password.
	responseListPurchases := WebClient httpGet: listPurchasesHttpRequest asString.
	
	Transcript show: (responseListPurchases content asString withoutPrefix: '0|').
	
	! !


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


!TusLibrosRestSystem methodsFor: 'authentication - private' stamp: 'Nico 6/13/2019 15:19:14'!
authenticateClient: aClientID withPassword: aPassword
	authenticator authenticateClient: aClientID withPassword: aPassword! !


!TusLibrosRestSystem methodsFor: 'cart - private' stamp: 'JIG 6/21/2019 19:05:02'!
add: aBookQuantity of: aBookFromStore to: aCartID
	| currentCart |
	currentCart := self cartOf: aCartID.
	currentCart add: aBookQuantity of: aBookFromStore.
	! !

!TusLibrosRestSystem methodsFor: 'cart - private' stamp: 'JIG 6/21/2019 17:06:46'!
addToActiveCarts: aCart withID: aCartID ownedBy: aClientID on: aCreationTime 
	 
	activeCarts at: aCartID put: (OrderedCollection with: aCart with: aClientID with: aCreationTime).! !

!TusLibrosRestSystem methodsFor: 'cart - private' stamp: 'JIG 6/21/2019 19:11:28'!
createCartIDFor: aClientID
	| newAmount newCartID |

	self updateHistoricalClientCartsAmount: aClientID.

	newAmount := historicalCartsAmountPerClient at: aClientID.
	newCartID := aClientID , newAmount asString.
	^newCartID! !

!TusLibrosRestSystem methodsFor: 'cart - private' stamp: 'JIG 6/20/2019 16:59:32'!
createNewCart.
	^Cart acceptingItemsOf: catalogue.! !

!TusLibrosRestSystem methodsFor: 'cart - private' stamp: 'JIG 6/21/2019 19:08:51'!
removeFromActiveCarts: aCartID
	activeCarts removeKey: aCartID.! !

!TusLibrosRestSystem methodsFor: 'cart - private' stamp: 'JIG 6/21/2019 18:38:25'!
renewCartExpiration: aCartID
	| cartInfo |
	
	cartInfo := (activeCarts at: aCartID).  
	cartInfo at: 3 put: clock now.! !

!TusLibrosRestSystem methodsFor: 'cart - private' stamp: 'JIG 6/21/2019 18:53:21'!
updateHistoricalClientCartsAmount: aClientID
	| currentAmountOfCarts |
	
	currentAmountOfCarts := historicalCartsAmountPerClient at: aClientID ifAbsent: [0].
	historicalCartsAmountPerClient at: aClientID put: (currentAmountOfCarts + 1).! !


!TusLibrosRestSystem methodsFor: 'cashier operations - private' stamp: 'JIG 6/21/2019 19:07:49'!
cashierCheckoutFor: aCartID payingWith: aCreditCart
	| cashier owner cart |
	owner := self ownerOf: aCartID.
	cart := self cartOf: aCartID.
	
	cashier := Cashier toCheckout: cart charging: aCreditCart throught: merchantProcessor on: (DateAndTime now) boughtBy: owner registeringOn: salesBook.
	cashier checkOutForClient .
! !


!TusLibrosRestSystem methodsFor: 'initialization' stamp: 'Nipo 6/24/2019 14:59:57'!
initializeProcessingWith: aMerchantProcessor authenticatingWith: anAuthenticator acceptingItemsOf: aCatalogue withClock: aClock
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

!TusLibrosRestSystem methodsFor: 'operations - cart' stamp: 'JIG 7/6/2019 14:59:36'!
listCatalogue
	^catalogue.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestSystem class' category: #TusLibros!
TusLibrosRestSystem class
	instanceVariableNames: ''!

!TusLibrosRestSystem class methodsFor: 'instance creation' stamp: 'Nipo 6/24/2019 14:59:51'!
throught: aMerchantProcessor authenticatingWith: anAuthenticator acceptingItemsOf: aCatalogue withClock: aClock
	^self new initializeProcessingWith: aMerchantProcessor authenticatingWith: anAuthenticator acceptingItemsOf: aCatalogue withClock: aClock.! !


!TusLibrosRestSystem class methodsFor: 'error descriptions' stamp: 'NI 6/22/2019 20:12:38'!
cannotCheckoutInvalidCartErrorDescription
	^'No se puede realizar checkout con un carrito inexistente.'! !

!TusLibrosRestSystem class methodsFor: 'error descriptions' stamp: 'JIG 6/21/2019 17:00:36'!
cartIsExpiredErrorDescription
	^'El carrito esta expirado'.! !

!TusLibrosRestSystem class methodsFor: 'error descriptions' stamp: 'JIG 6/30/2019 16:56:54'!
invalidCartIDErrorDescription
	^'El ID del carrito es invalido'! !


!classDefinition: #TusLibrosServerController category: #TusLibros!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'webServer port internalSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosServerController methodsFor: 'adding services' stamp: 'Nico 7/8/2019 13:14:35'!
addCartCheckOutService

	webServer addService: '/checkOutCart' action:[:request | |cartID transactionID creditExpiration creditNumber creditOwner|
		
	[
		cartID := request fields at: self cartIdField.
		creditNumber := request fields at: self creditNumberField.
		creditExpiration := request fields at: self creditExpirationField.
		creditOwner := request fields at: self creditOwnerField.
		[ | parsedCreditCard |
			
			parsedCreditCard := self parseCreditCard: creditNumber expiringOn: creditExpiration ownedBy: creditOwner.
			
			transactionID := internalSystem checkoutFor: cartID payingWith: parsedCreditCard.
			
			request send200Response: '0'.
		]
		on: Error
		do: [:anError | 
			self from: request sendErrorResponse: anError messageText.
		]
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].
	
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'nico 6/30/2019 19:56:24'!
addCartCreationService

	webServer addService: '/createCart' action:[:request | |clientId password cartID |
		
	[
		password := request fields at: self passwordField.
		clientId := request fields at: self clientIdField.
		"substringsAsJson:= WebUtils jsonEncode: (substrings)."

		[
			cartID := internalSystem createCartFor: clientId authenticatedWith: password.
			request send200Response: '0|', cartID.
		]
		on: Error
		do: [:anError | 
			self from: request sendErrorResponse: self class invalidAuthenticationErrorDescription
			].
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].
	
	
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'Nico 7/8/2019 11:21:03'!
addCartItemAddingService

	webServer addService: '/addToCart' action:[:request | |cartID bookISBN items bookQuantity|
	[
		cartID := request fields at: self cartIdField.
		bookISBN  := request fields at: self bookIsbnField.
		bookQuantity  := (request fields at: self bookQuantityField) asNumber.
		[
			items := internalSystem add: bookQuantity of: bookISBN toCart: cartID.
			request send200Response: '0|OK'
		]
		on: Error
		do: [:anError |
			self from: request sendErrorResponse: anError messageText.
		]
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].

	
	
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'nico 6/30/2019 20:02:18'!
addCartListingService.

	webServer addService: '/listCart' action:[:request | |cartID items|
		
	[
		cartID := request fields at: self cartIdField.
		[ | parsedItems |
			
			items := internalSystem listCart: cartID.
			parsedItems := self parseItemsListed: items.
			request send200Response: parsedItems.
		]
		on: Error
		do: [:anError | 
			self from: request sendErrorResponse: TusLibrosRestSystem invalidCartIDErrorDescription.
		]
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'JIG 7/6/2019 15:09:06'!
addListCatalogue
	webServer addService: '/listCatalogue' action:[:request | |items|
	[
	
		[ | parsedItems |
			
			items := internalSystem listCatalogue.
			parsedItems := self parseCatalogueItems: items.
			request send200Response: parsedItems.
		]
		on: Error
		do: [:anError | 
			self from: request sendErrorResponse: anError messageText.
		]
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'Nico 7/8/2019 15:41:58'!
addPurchasesListingService

	webServer addService: '/listPurchases' action:[:request | |clientId password |
		
	[
		password := request fields at: self passwordField.
		clientId := request fields at: self clientIdField.

		[ | allPurchases parsedPurchases |
			allPurchases := internalSystem listPurchasesOf: clientId authenticatedWith: password.
			parsedPurchases := self parsePurchases: allPurchases.
			request send200Response: '0|', parsedPurchases.
		]
		on: Error
		do: [:anError | 
			self from: request sendErrorResponse: self class invalidAuthenticationErrorDescription
			].
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].

	
	
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'JIG 7/6/2019 15:00:11'!
addServices
	self addCartCreationService.
	self addCartListingService.
	self addCartCheckOutService.
	self addCartItemAddingService.
	self addPurchasesListingService.
	self addListCatalogue.
	
! !


!TusLibrosServerController methodsFor: 'enabling services' stamp: 'Nico 6/28/2019 15:36:16'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'Nico 6/28/2019 15:36:32'!
startListening
	
	webServer startListener ! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'Nico 6/28/2019 15:36:54'!
stopListening
	
	webServer stopListener! !


!TusLibrosServerController methodsFor: 'initialization' stamp: 'nico 6/30/2019 19:36:12'!
initializeWith: anInternalSystem
	
	webServer := WebServer new listenOn: self port.
	
	internalSystem := anInternalSystem.
	
	self addServices.

	
	
! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'Nico 6/28/2019 15:35:22'!
port
	^ port ifNil: [port:=8080].

! !


!TusLibrosServerController methodsFor: 'private - parameter fields' stamp: 'nico 6/30/2019 19:45:13'!
bookIsbnField
	^'bookIsbn'	
! !

!TusLibrosServerController methodsFor: 'private - parameter fields' stamp: 'nico 6/30/2019 19:45:21'!
bookQuantityField
	^'bookQuantity'	
! !

!TusLibrosServerController methodsFor: 'private - parameter fields' stamp: 'nico 6/30/2019 19:42:08'!
cartIdField
	^'cartId'
	
! !

!TusLibrosServerController methodsFor: 'private - parameter fields' stamp: 'nico 6/30/2019 19:43:45'!
clientIdField
	^'clientId'
! !

!TusLibrosServerController methodsFor: 'private - parameter fields' stamp: 'nico 6/30/2019 19:48:02'!
creditExpirationField
	^'cced'! !

!TusLibrosServerController methodsFor: 'private - parameter fields' stamp: 'nico 6/30/2019 19:47:53'!
creditNumberField
	^'cnn'! !

!TusLibrosServerController methodsFor: 'private - parameter fields' stamp: 'nico 6/30/2019 19:48:08'!
creditOwnerField
	^'cco'! !

!TusLibrosServerController methodsFor: 'private - parameter fields' stamp: 'nico 6/30/2019 19:43:15'!
passwordField
	^'password'
	
! !


!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'JIG 7/6/2019 15:11:24'!
parseCatalogueItems: items
	| parsedItemsResult |
	
	parsedItemsResult := '0'.
	items keysDo: [:item | parsedItemsResult := parsedItemsResult, '|', item ].
	parsedItemsResult := parsedItemsResult , '|'.
	
	^parsedItemsResult

! !

!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'nico 6/30/2019 20:04:23'!
parseCreditCard: aCreditNumber expiringOn: aCreditExpiration ownedBy: aCreditOwner
	| parsedExpirationDate |
	
	parsedExpirationDate := self parseExpirationDate: aCreditExpiration.

	^CreditCard for: aCreditOwner expiringOn: parsedExpirationDate withIDNumber: aCreditNumber.! !

!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'nico 6/30/2019 19:38:55'!
parseExpirationDate: aCreditExpiration
	| monthOfCreditExpiration yearOfCreditExpiration |
	
	monthOfCreditExpiration := (aCreditExpiration copyFrom: 1 to: 2) asNumber.
	yearOfCreditExpiration := (aCreditExpiration copyFrom: 3 to: 6) asNumber.
	^ Month month: monthOfCreditExpiration year: yearOfCreditExpiration.! !

!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'Nico 7/8/2019 11:40:26'!
parseItemsListed: items
	| parsedItemsResult |
	
	parsedItemsResult := '0'.
	items contents keysDo: [:item | parsedItemsResult := parsedItemsResult, '|', item, '|', (items occurrencesOf: item) asString ].
	
	^ parsedItemsResult,'|'.

! !

!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'Nico 7/8/2019 15:37:51'!
parsePurchases: allPurchases
	| finalParsedPurchases superBag totalAmount |
	
	finalParsedPurchases := ''.
	superBag := Bag new.
	allPurchases do: [:aSale |
		aSale items contents keysDo: [:anItemAssociation |
			superBag add: anItemAssociation withOccurrences: (aSale items contents at: anItemAssociation).
		]
	].

	superBag contents keysDo: [ :anItemAssociation |
		finalParsedPurchases := finalParsedPurchases , anItemAssociation asString , '|' , (superBag contents at: anItemAssociation) asString , '|'.
	].

	totalAmount := allPurchases inject: 0 into: [:acum :aSale | acum + aSale total]. 

	^finalParsedPurchases,totalAmount asString.

! !


!TusLibrosServerController methodsFor: 'private - error response' stamp: 'JIG 7/6/2019 16:37:38'!
from: request sendErrorResponse: anErrorResponse
	request send200Response: '1|', anErrorResponse
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #TusLibros!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'errors' stamp: 'JIG 6/30/2019 13:53:56'!
cannotCheckoutInvalidCartErrorDescription
	^TusLibrosRestSystem cannotCheckoutInvalidCartErrorDescription.! !

!TusLibrosServerController class methodsFor: 'errors' stamp: 'JIG 6/30/2019 17:07:58'!
invalidAuthenticationErrorDescription
	^'Usuario y/o password invalido.'! !


!classDefinition: #TusLibrosWebClient category: #TusLibros!
Object subclass: #TusLibrosWebClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/8/2019 12:35:33'!
checkoutCartHttpRequestFor: aCartID card: aCreditCardNumber expDate: anExpirationDate owner: anOwner
	^'http://localhost:8080/checkOutCart?cartId=', aCartID, '&cnn=',  aCreditCardNumber, '&cced=', anExpirationDate, '&cco=', anOwner! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/7/2019 15:42:49'!
createAddToCartHttpRequestFor: aCartID book: anItem quantity: anAmount
	^ 'http://localhost:8080/addToCart?cartId=', aCartID, '&bookIsbn=', anItem ,'&bookQuantity=', anAmount asString! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'JIG 7/6/2019 16:02:14'!
createCartHttpRequestFor: anUserID authenticatingWith: aPassword
	^ 'http://localhost:8080/createCart?clientId=', anUserID ,'&password=', aPassword.
	! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/7/2019 15:42:42'!
listCartHttpRequestFor: aCartID
	^ 'http://localhost:8080/listCart?cartId=', aCartID! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/7/2019 12:27:45'!
listCatalogueHttpRequest
	^ 'http://localhost:8080/listCatalogue'! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'JIG 7/8/2019 14:30:35'!
listPurchasesHttpRequestFor: anUserID authenticatingWith: aPassword
	^'http://localhost:8080/listPurchases?clientId=', anUserID, '&password=', aPassword
	
	! !


!TusLibrosWebClient methodsFor: 'initialization' stamp: 'NR 6/25/2019 22:15:16'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosWebClient methodsFor: 'initialization' stamp: 'NR 6/24/2019 06:52:37'!
url
	
	^'http://localhost:', self port asString! !


!TusLibrosWebClient methodsFor: 'parsing' stamp: 'NR 6/25/2019 22:25:36'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!TusLibrosWebClient methodsFor: 'parsing' stamp: 'Nico 7/7/2019 15:14:18'!
getCartIdOfResponse: aCreateCartResponse
	| responseAsString |
	
	responseAsString := aCreateCartResponse asString.
	^ responseAsString copyFrom: 3 to: responseAsString size.! !

!TusLibrosWebClient methodsFor: 'parsing' stamp: 'Nico 7/8/2019 11:36:25'!
parseCartListingToOrderedCollection: aListCartResponse
	| collection |
	
	collection := self convertCartResponseToOrderedCollection: aListCartResponse. 
	
	^ collection select: [:anElement | anElement first digitValue = -1]! !

!TusLibrosWebClient methodsFor: 'parsing' stamp: 'Nico 7/7/2019 15:55:16'!
parseCatalogueToOrderedCollection: aCatalogueResponse
	| collection |
	
	collection := self removeBarsAndConvertToOrderedCollection: aCatalogueResponse.
	
	collection removeFirst.
	
	^collection.! !


!TusLibrosWebClient methodsFor: 'parsing - private' stamp: 'JIG 7/8/2019 14:48:06'!
convertCartResponseToOrderedCollection: aListCartResponse
	| collection catalogueResponseString firstBar |
	
	"If response doesn't end with |, then it doesn't return the last sentence/ammount in the final OC"
	
	collection := OrderedCollection new.
	catalogueResponseString := aListCartResponse asString.
	
	catalogueResponseString := catalogueResponseString withoutPrefix: '0|'.
	
	firstBar := catalogueResponseString ifNotNil: [catalogueResponseString findFirst: [:aChar | aChar = $|]].
	[firstBar > 0] whileTrue: 
	[ | wordToAdd amountToAdd nextBar |
		wordToAdd := (catalogueResponseString copyFrom: 1 to: firstBar - 1).
		catalogueResponseString := catalogueResponseString withoutPrefix: (catalogueResponseString copyFrom: 1 to: firstBar).
		nextBar := catalogueResponseString findFirst: [:aChar | aChar = $|].
		amountToAdd := (catalogueResponseString copyFrom: 1 to: nextBar - 1) asNumber.
		amountToAdd timesRepeat: [
			collection add: wordToAdd.	
		].
		catalogueResponseString := catalogueResponseString withoutPrefix: (catalogueResponseString copyFrom: 1 to: nextBar).
		firstBar := catalogueResponseString findFirst: [:aChar | aChar = $|].	
	].
	
	^collection.! !

!TusLibrosWebClient methodsFor: 'parsing - private' stamp: 'Nico 7/8/2019 11:34:52'!
removeBarsAndConvertToOrderedCollection: aCatalogueResponse
	| collection catalogueResponseString firstBar |
	
	"If response doesn't end with |, then it doesn't return the last sentence/ammount in the final OC"
	
	collection := OrderedCollection new.
	catalogueResponseString := aCatalogueResponse asString.
	
	firstBar := catalogueResponseString findFirst: [:aChar | aChar = $|].
	[firstBar > 0] whileTrue: 
	[ | wordToAdd |
		wordToAdd := (catalogueResponseString copyFrom: 1 to: firstBar - 1).
		collection add: wordToAdd.
		catalogueResponseString := catalogueResponseString withoutPrefix: (catalogueResponseString copyFrom: 1 to: firstBar).
		firstBar := catalogueResponseString findFirst: [:aChar | aChar = $|].	
	].
	
	^collection.! !


!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/7/2019 15:42:49'!
sendCartAddingRequestToCart: aCartID WithItem: anItem
	| responseAddItem addItemRequest |
	
	addItemRequest := self createAddToCartHttpRequestFor: aCartID book: anItem quantity: 1.
	
	responseAddItem := WebClient httpGet: addItemRequest.

	(self isSuccess: responseAddItem content)
		ifTrue:[^responseAddItem content] 
		ifFalse:[^self error: responseAddItem content].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/8/2019 12:36:59'!
sendCheckoutCartRequest: aCartID withCardNumber: cardNumber cced: cardCced andOwner: cardOwner
	| cartIDEncodedString cardNumberEncodedString checkoutCartRequest responseCheckoutCart cardCcedEncodedString cardOwnerEncodedString |
	
	cartIDEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: aCartID) asString.
	cardNumberEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: cardNumber) asString .
	cardCcedEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: cardCced) asString.
	cardOwnerEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: cardOwner) asString.
	
	checkoutCartRequest := self checkoutCartHttpRequestFor: cartIDEncodedString card: cardNumberEncodedString expDate: cardCcedEncodedString owner: cardOwnerEncodedString.
	
	responseCheckoutCart := WebClient httpGet: checkoutCartRequest.

	(self isSuccess: responseCheckoutCart content)
		ifTrue:[^responseCheckoutCart content] 
		ifFalse:[^self error: responseCheckoutCart content].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/7/2019 15:13:05'!
sendCreateCartRequestWithUser: username authenticatedWith: password
	| usernameEncodedString passwordEncodedString createCartRequest responseCreateCart |
	
	usernameEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: username) asString.
	passwordEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: password) asString .
	
	createCartRequest := self createCartHttpRequestFor: usernameEncodedString authenticatingWith: passwordEncodedString.
	
	responseCreateCart := WebClient httpGet: createCartRequest.

	(self isSuccess: responseCreateCart content)
		ifTrue:[^self getCartIdOfResponse: responseCreateCart content] 
		ifFalse:[^self error: responseCreateCart content].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/8/2019 12:06:38'!
sendListCartRequest: aCartID
	| responseListCart listCartRequest |
	
	listCartRequest := self listCartHttpRequestFor: aCartID.
	
	responseListCart := WebClient httpGet: listCartRequest.

	(self isSuccess: responseListCart content)
		ifTrue:[^self parseCartListingToOrderedCollection: responseListCart content] 
		ifFalse:[^self error: responseListCart content].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/7/2019 12:59:02'!
sendListCatalogueRequest
	| listCatalogueRequest responseListCatalogue |
	
	listCatalogueRequest := self listCatalogueHttpRequest.
	
	responseListCatalogue := WebClient httpGet: listCatalogueRequest.

	(self isSuccess: responseListCatalogue content)
		ifTrue:[^self parseCatalogueToOrderedCollection: responseListCatalogue content] 
		ifFalse:[^self error: responseListCatalogue content].! !


!TusLibrosWebClient methodsFor: 'testing responses' stamp: 'JIG 7/6/2019 16:39:33'!
isSuccess: responseContent
	^((responseContent at: 1) = $1) not.! !
