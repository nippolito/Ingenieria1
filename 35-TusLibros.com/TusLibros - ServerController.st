!classDefinition: #TusLibrosServerControllerTest category: #'TusLibros - ServerController'!
TestCase subclass: #TusLibrosServerControllerTest
	instanceVariableNames: 'testFactory tusLibrosController anAuthenticator clock server debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - ServerController'!

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

!TusLibrosServerControllerTest methodsFor: 'tests' stamp: 'JIG 7/8/2019 16:23:56'!
test12ValidCheckoutAddsANewSale
	| responseCheckout aCartID checkoutHttpRequest createCartHttpRequest responseCreateCart listPurchasesHttpRequest responseListPurchases addToCartHttpRequest |

	createCartHttpRequest := self createCartHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.		
	responseCreateCart := WebClient httpGet: createCartHttpRequest.
	
	aCartID := self extractCartIDFrom: responseCreateCart content.

	addToCartHttpRequest := self createAddToCartHttpRequestFor: aCartID book: testFactory itemSellByTheStore quantity: 1.
	WebClient httpGet: addToCartHttpRequest.	

	checkoutHttpRequest :=  self checkoutCartHttpRequestFor: aCartID card: testFactory anIDForValidCreditCard expDate: testFactory aValidExpirationDate owner: testFactory ownerOfValidCreditCard.	
	responseCheckout := WebClient httpGet: checkoutHttpRequest.
	
	listPurchasesHttpRequest := self listPurchasesHttpRequestFor: testFactory aFirstClientValidUserID authenticatingWith: testFactory aFirstClientValidPassword.
	responseListPurchases := WebClient httpGet: listPurchasesHttpRequest.
	
	self assert: responseCheckout content equals: '0|'.
	self assert: responseListPurchases content equals: '0|', testFactory itemSellByTheStore , '|1|', testFactory itemSellByTheStorePrice asString.
	
	! !


!classDefinition: #TusLibrosServerController category: #'TusLibros - ServerController'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'webServer port internalSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - ServerController'!

!TusLibrosServerController methodsFor: 'adding services' stamp: 'Nico 7/9/2019 13:09:20'!
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
				
				request send200Response: '0|'.
			]
			on: Error
			do: [:anError | 
					self from: request sendErrorResponse: anError messageText.
			]
		] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) 
		]
	].
	
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'Nico 7/9/2019 13:10:56'!
addCartCreationService

	webServer addService: '/createCart' action:[:request | |clientId password cartID |	
		[
			password := request fields at: self passwordField.
			clientId := request fields at: self clientIdField.
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
			request send404Response: (anError messageText) ]
	].
	
	
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'Nico 7/9/2019 13:10:20'!
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
			request send404Response: (anError messageText) ]
	].

	
	
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'Nico 7/9/2019 13:10:29'!
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
			request send404Response: (anError messageText) ]
	].
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'Nico 7/9/2019 13:10:38'!
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
			request send404Response: (anError messageText) ]
	].
! !

!TusLibrosServerController methodsFor: 'adding services' stamp: 'Nico 7/9/2019 13:10:50'!
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
			request send404Response: (anError messageText) ]
	].

	
	
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


!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'Nico 7/9/2019 13:24:34'!
addTotalAmountOf: somePurchases to: aString
	| totalAmount |

	totalAmount := somePurchases inject: 0 into: [:acum :aSale | acum + aSale total].
	^aString,totalAmount asString.

! !

!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'Nico 7/9/2019 13:19:56'!
allItemsFrom: somePurchases
	| allSalesItems |
	
	allSalesItems := Bag new.
	somePurchases do: [:aSale |
		aSale items contents keysDo: [:anItemAssociation |
			allSalesItems add: anItemAssociation withOccurrences: (aSale items contents at: anItemAssociation).
		]
	].

	^allSalesItems

! !

!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'Nico 7/9/2019 13:22:34'!
convertAllItemsToString: aBagOfItems
	| finalParsedPurchases |
	
	finalParsedPurchases := ''.
	
	aBagOfItems contents keysDo: [ :anItemAssociation |
		finalParsedPurchases := finalParsedPurchases , anItemAssociation asString , '|' , (aBagOfItems contents at: anItemAssociation) asString , '|'.
	].

	^finalParsedPurchases

! !

!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'Nico 7/9/2019 13:16:18'!
parseCatalogueItems: items
	| parsedItemsResult |
	
	parsedItemsResult := '0'.
	items keysDo: [:item | parsedItemsResult := parsedItemsResult, '|', item ].
	
	^parsedItemsResult, '|'.

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

!TusLibrosServerController methodsFor: 'private - parsing' stamp: 'Nico 7/9/2019 13:24:57'!
parsePurchases: allPurchases
	| finalParsedPurchases allSalesItems |
	
	allSalesItems := self allItemsFrom: allPurchases.
	
	finalParsedPurchases := self convertAllItemsToString: allSalesItems.
	
	allPurchases isEmpty ifFalse: [ 
		finalParsedPurchases := self addTotalAmountOf: allPurchases to: finalParsedPurchases.
		^finalParsedPurchases.
	].

	^finalParsedPurchases.

! !


!TusLibrosServerController methodsFor: 'private - error response' stamp: 'JIG 7/6/2019 16:37:38'!
from: request sendErrorResponse: anErrorResponse
	request send200Response: '1|', anErrorResponse
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros - ServerController'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'errors' stamp: 'JIG 6/30/2019 13:53:56'!
cannotCheckoutInvalidCartErrorDescription
	^TusLibrosRestSystem cannotCheckoutInvalidCartErrorDescription.! !

!TusLibrosServerController class methodsFor: 'errors' stamp: 'JIG 6/30/2019 17:07:58'!
invalidAuthenticationErrorDescription
	^'Usuario y/o password invalido.'! !
