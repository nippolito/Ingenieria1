!classDefinition: #CartTest category: #'TusLibros-Exercise'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/7/2019 15:56:50'!
test09CartWithOneItemTotalPriceEqualsThatItemPrice

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	
	self assert: cart totalPrice = (self defaultCatalog at: self itemSellByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/7/2019 16:02:43'!
test10CartWithManyItemsTotalPriceEqualsToCartItemList

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	cart add: self anotherItemSellByTheStore.  
	
	self assert: cart totalPrice equals: (self defaultCatalog at: self itemSellByTheStore) + (self defaultCatalog at: self anotherItemSellByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/7/2019 16:12:31'!
test11CartWithOneItemGeneratesSaleBodyCorrectly

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	
	self assert: cart generateSaleBody equals: (Dictionary newFromPairs: {self itemSellByTheStore. #(1 200).}).! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/7/2019 16:14:56'!
test12CartWithManyItemsGeneratesSaleBodyCorrectly

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	cart add: self anotherItemSellByTheStore.
	
	self assert: cart generateSaleBody equals: (Dictionary newFromPairs: {self itemSellByTheStore. #(1 200). self anotherItemSellByTheStore. #(1 150).}).! !


!CartTest methodsFor: 'support' stamp: 'JIG 6/7/2019 16:01:31'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'JIG 6/7/2019 16:02:23'!
defaultCatalog
	
	^ Dictionary 
		newFromPairs: {
			self itemSellByTheStore. 200.
			self anotherItemSellByTheStore. 150.
		}! !

!CartTest methodsFor: 'support' stamp: 'JIG 6/7/2019 14:52:21'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'JIG 6/7/2019 14:52:27'!
itemSellByTheStore
	
	^ 'validBook'.! !


!classDefinition: #CashierTest category: #'TusLibros-Exercise'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'aSingleCart aCompoundCart anEmptySalesBook anExpiredCreditCard aValidCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CashierTest methodsFor: 'tests' stamp: 'JIG 6/7/2019 17:55:24'!
test01CashierShouldNotCheckOutEmptyCart
	
	| anEmptyCart saleBookBeforeCheckout |
	
	saleBookBeforeCheckout := anEmptySalesBook copy.
	anEmptyCart := Cart acceptingItemsOf: self defaultCatalog.
	
	self should: [ Cashier checkout: anEmptyCart withSalesBook: anEmptySalesBook andCreditCard: aValidCreditCard ]
	raise: Error 
	withExceptionDo: [ :anError | 
		self assert: anError messageText equals: Cashier cannotAcceptEmptyCartErrorDescription.
		self assert: anEmptySalesBook equals: saleBookBeforeCheckout.
	].! !

!CashierTest methodsFor: 'tests' stamp: 'JIG 6/7/2019 16:43:07'!
test02CashierForANonEmptyCartChargesCartItems
	
	| cashier |
	
	cashier := Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook andCreditCard: aValidCreditCard.
	
	self assert: cashier totalPrice = (self defaultCatalog at: self itemSellByTheStore).
	! !

!CashierTest methodsFor: 'tests' stamp: 'JIG 6/7/2019 16:43:13'!
test03CashierForANonEmptyCartAddsANewSaleEntryCorrectly
	
	Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook andCreditCard: aValidCreditCard.
	
	self assert: anEmptySalesBook size = 1.
	self assert: (anEmptySalesBook at: 1) equals: (OrderedCollection with: Date today with: aSingleCart generateSaleBody with: aSingleCart totalPrice).
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'JIG 6/7/2019 17:54:54'!
test04CannotMakePaymentWithAnExpiredCreditCard
	| salesBookBeforeSale |
	
	salesBookBeforeSale := anEmptySalesBook copy.
	
	self should: [Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook andCreditCard: anExpiredCreditCard ]
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: Cashier cannotMakePaymentWithExpiredCreditCard.
		self assert: anEmptySalesBook equals: salesBookBeforeSale.
	].
	
	! !


!CashierTest methodsFor: 'support' stamp: 'JIG 6/6/2019 11:37:41'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!CashierTest methodsFor: 'support' stamp: 'JIG 6/7/2019 15:02:52'!
defaultCatalog
	
	^ Dictionary newFromPairs: {self itemSellByTheStore. 200. self anotherItemSellByTheStore. 150.}! !

!CashierTest methodsFor: 'support' stamp: 'JIG 6/6/2019 11:41:27'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!CashierTest methodsFor: 'support' stamp: 'JIG 6/6/2019 11:37:57'!
itemPriceListFromTheStore
	^Dictionary 
		newFromPairs: {
			self itemSellByTheStore. 300.
			self anotherItemSellByTheStore. 400.
		}.! !

!CashierTest methodsFor: 'support' stamp: 'JIG 6/6/2019 11:08:23'!
itemSellByTheStore
	
	^ 'validBook'! !


!CashierTest methodsFor: 'setup' stamp: 'JIG 6/7/2019 16:58:45'!
aValidExpirationDate
	^June ofYear: (Date today + (Duration days: 365)) yearNumber.! !

!CashierTest methodsFor: 'setup' stamp: 'JIG 6/7/2019 16:28:22'!
anExpiredDate
	^May ofYear: 2019.! !

!CashierTest methodsFor: 'setup' stamp: 'JIG 6/7/2019 16:29:13'!
anIDForExpiredCreditCard
	^'4700000034541234'! !

!CashierTest methodsFor: 'setup' stamp: 'JIG 6/7/2019 17:53:15'!
anIDForValidCreditCard
	^'1234678934210007'! !

!CashierTest methodsFor: 'setup' stamp: 'JIG 6/7/2019 15:27:24'!
createEmptySalesBook
	"0 -> fecha
	1 -> diccionario de item producto Libro A ->  #(2    36)
		LibroA: {
			precio : 36
			cantidad: 2
		}
	2 -> total
	"
	^OrderedCollection new.
	"
	
	saleBody := Dictionary new.
	
	items do: [:anItem | saleBody add: {anItem. items quantityOf: anItem.}]
	
	^saleBody.
	
	saleBodyEntry := cart generateSaleBody.
	
	saleBookEntry = OrderedCollection new.
	saleBookEntry add: Date today.
	
	saleBookEntry add: saleBody
	salesBook add: cart totalPrice.
	
	"! !

!CashierTest methodsFor: 'setup' stamp: 'JIG 6/7/2019 16:29:25'!
ownerOfExpiredCreditCard
	^'Jose'.! !

!CashierTest methodsFor: 'setup' stamp: 'JIG 6/7/2019 16:32:53'!
ownerOfValidCreditCard
	^'Nico'.! !

!CashierTest methodsFor: 'setup' stamp: 'JIG 6/7/2019 17:53:08'!
setUp

	aSingleCart := Cart acceptingItemsOf: self defaultCatalog.
	aSingleCart add: self itemSellByTheStore.
	
	aCompoundCart := Cart acceptingItemsOf: self defaultCatalog.
	aCompoundCart add: self itemSellByTheStore.
	aCompoundCart add: self anotherItemSellByTheStore.
	
	anEmptySalesBook := OrderedCollection new.
	
	anExpiredCreditCard := CreditCard for: self ownerOfExpiredCreditCard expiringOn: self anExpiredDate anIDNumber: self anIDForExpiredCreditCard.
	aValidCreditCard := CreditCard for: self ownerOfValidCreditCard expiringOn: self aValidExpirationDate anIDNumber: self anIDForValidCreditCard.! !


!classDefinition: #CreditCardTest category: #'TusLibros-Exercise'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'anExpiredCreditCard aValidCreditCard currentMonthOfYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 17:03:05'!
aValidExpirationDate
	^June ofYear: (Date today + (Duration days: 365)) yearNumber.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 17:03:13'!
anExpiredDate
	^May ofYear: 2019.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 17:03:22'!
anIDForExpiredCreditCard
	^'4700000034541234'! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 17:24:55'!
anIDForValidCreditCard
	^'4700000034540007'! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 17:24:23'!
ownerOfExpiredCreditCard
	^'Jose'.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 17:24:38'!
ownerOfValidCreditCard
	^'Nico'.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 18:04:12'!
setUp

	anExpiredCreditCard := CreditCard for: self ownerOfExpiredCreditCard expiringOn: self anExpiredDate anIDNumber: self anIDForExpiredCreditCard.
	aValidCreditCard := CreditCard for: self ownerOfValidCreditCard expiringOn: self aValidExpirationDate anIDNumber: self anIDForValidCreditCard.
	
	currentMonthOfYear := GregorianMonthOfYear year: Date today year yearNumber month: (GregorianMonth named: Date today monthName).! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 17:23:35'!
test01CreditCardShouldHaveAnOwner
	| invalidCreditCard |
	
	self should: [ invalidCreditCard := CreditCard for: '' expiringOn: self aValidExpirationDate anIDNumber: self anIDForValidCreditCard ]
	raise: Error
	withExceptionDo: [ :anError | 
		CreditCard ownerCannotBeEmptyErrorDescription = anError messageText.
		self assert: invalidCreditCard isNil.
	].! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 17:41:38'!
test02IdentificationNumberShouldBeValid
	| invalidCreditCard |
	
	self should: [ invalidCreditCard := CreditCard for: self ownerOfValidCreditCard expiringOn: self aValidExpirationDate anIDNumber: '2423' ]
	raise: Error
	withExceptionDo: [ :anError | 
		CreditCard ownerCannotBeEmptyErrorDescription = anError messageText.
		self assert: invalidCreditCard isNil.
	].! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 18:04:24'!
test03AnCreditCardWithAnOldDateIsExpired
	
	self assert: (anExpiredCreditCard isExpiredOn: currentMonthOfYear).! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 17:45:39'!
test04AnCreditCardWithAFutureDateIsNotExpired
	
	self assert: (aValidCreditCard isExpiredOn: currentMonthOfYear) not.! !


!classDefinition: #Cart category: #'TusLibros-Exercise'!
Object subclass: #Cart
	instanceVariableNames: 'items priceCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'JIG 6/7/2019 14:54:30'!
assertIsValidItem: anItem

	(priceCatalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'JIG 6/7/2019 15:24:15'!
initializeAcceptingItemsOf: aPricedCatalog

	priceCatalog := aPricedCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'operations' stamp: 'JIG 6/7/2019 16:52:04'!
generateSaleBody
	| saleBody |
	
	saleBody := Dictionary new.
	
	items do: [ :anItem | 
		| aBodyEntry | 
		
		aBodyEntry := Array with: (items occurrencesOf: anItem) with: (self priceOf: anItem).
		saleBody at: anItem put: aBodyEntry.
	].
	
	^saleBody.
	 ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'JIG 6/7/2019 15:25:04'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'accessing' stamp: 'JIG 6/7/2019 15:01:51'!
totalPrice
	^items sum: [ :anItem | self priceOf: anItem ].! !


!Cart methodsFor: 'private - accessing' stamp: 'JIG 6/6/2019 11:32:17'!
items
	^items.! !

!Cart methodsFor: 'private - accessing' stamp: 'JIG 6/7/2019 16:04:22'!
priceOf: anItem
	
	^priceCatalog at: anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Exercise'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'JIG 6/7/2019 14:55:08'!
acceptingItemsOf: aPricedCatalog

	^self new initializeAcceptingItemsOf: aPricedCatalog ! !


!classDefinition: #Cashier category: #'TusLibros-Exercise'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!Cashier methodsFor: 'initialization' stamp: 'JIG 6/7/2019 16:47:56'!
initializeFor: aCart withSalesBook: aSalesBook andCreditCard: aCreditCard
	cart := aCart.
	salesBook := aSalesBook.
	creditCard := aCreditCard.
	self doCheckout.! !


!Cashier methodsFor: 'operations' stamp: 'JIG 6/7/2019 18:03:58'!
doCheckout
	| saleBody saleBookEntry currentMonthOfYear |
	cart isEmpty ifTrue: [self error: self class cannotAcceptEmptyCartErrorDescription].
	
	currentMonthOfYear := GregorianMonthOfYear year: Date today year yearNumber month: (GregorianMonth named: Date today monthName).
 	(creditCard isExpiredOn: currentMonthOfYear) ifTrue: [self error: self class cannotMakePaymentWithExpiredCreditCard ].
	
	saleBody := cart generateSaleBody.
	
	saleBookEntry := OrderedCollection new.
	
	saleBookEntry add: Date today.
	saleBookEntry add: saleBody.
	saleBookEntry add: cart totalPrice.
	
	salesBook add: saleBookEntry.! !


!Cashier methodsFor: 'pricing' stamp: 'JIG 6/7/2019 15:00:55'!
totalPrice

	^cart totalPrice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Exercise'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'errors' stamp: 'JIG 6/6/2019 11:08:54'!
cannotAcceptEmptyCartErrorDescription
	^'No se puede hacer checkout de un carrito vacio'.! !

!Cashier class methodsFor: 'errors' stamp: 'JIG 6/7/2019 16:46:15'!
cannotMakePaymentWithExpiredCreditCard
	^'No se puede realizar un pago con una tarjeta de credito expirada'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'JIG 6/7/2019 16:47:27'!
checkout: aCart withSalesBook: aSalesBook andCreditCard: aCreditCard 
	^self new initializeFor: aCart withSalesBook: aSalesBook andCreditCard: aCreditCard.! !


!classDefinition: #CreditCard category: #'TusLibros-Exercise'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner idNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CreditCard methodsFor: 'initialization' stamp: 'JIG 6/7/2019 16:31:25'!
initializeFor: anOwner expiringOn: anExpirationDate anIDNumber: anIdentificationNumber
	owner := anOwner.
	expirationDate := anExpirationDate.
	idNumber := anIdentificationNumber.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'JIG 6/7/2019 16:53:15'!
isExpiredOn: anExpirationDate
	^expirationDate < anExpirationDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Exercise'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JIG 6/7/2019 17:40:01'!
for: anOwner expiringOn: anExpirationDate anIDNumber: anIdentificationNumber 
	(anOwner isEmpty or: [anOwner isString not]) ifTrue: [ self error: self ownerCannotBeEmptyErrorDescription ].
	(anIdentificationNumber isString 
		and: [ (anIdentificationNumber allSatisfy: [:aCharacter | aCharacter isDigit ]) 
		and: [ anIdentificationNumber size = 16 ]]) ifFalse: [ self error: self identificationNumberMustBeValidErrorDescription ].
	
	^self new initializeFor: anOwner expiringOn: anExpirationDate anIDNumber: anIdentificationNumber.
		! !

!CreditCard class methodsFor: 'instance creation' stamp: 'JIG 6/7/2019 17:40:15'!
identificationNumberMustBeValidErrorDescription
	^'El numero de tarjeta de credito debe poseer 16 digitos'.! !

!CreditCard class methodsFor: 'instance creation' stamp: 'JIG 6/7/2019 17:21:22'!
ownerCannotBeEmptyErrorDescription
	^'La tarjeta debe tener propietario'.! !
