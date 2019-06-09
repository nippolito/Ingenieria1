!classDefinition: #CartTest category: #'TusLibros-Exercise'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testFacility'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:26:30'!
test01NewCartsAreCreatedEmpty

	self assert: testFacility createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:26:48'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testFacility createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:27:02'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testFacility createCart.
	
	cart add: testFacility itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:27:12'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testFacility createCart.
	
	self 
		should: [cart add: 0 of: testFacility itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:27:22'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testFacility createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:27:42'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testFacility createCart.
	
	cart add: testFacility itemSellByTheStore.
	self assert: (cart includes: testFacility itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:27:50'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testFacility createCart.
	
	self deny: (cart includes: testFacility itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:28:05'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testFacility createCart.
	
	cart add: 2 of: testFacility itemSellByTheStore.
	self assert: (cart occurrencesOf: testFacility itemSellByTheStore) equals: 2! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:28:20'!
test09CartWithOneItemTotalPriceEqualsThatItemPrice

	| cart |
	
	cart := testFacility createCart.
	
	cart add: testFacility itemSellByTheStore.
	
	self assert: cart totalPrice = (testFacility defaultCatalog at: testFacility itemSellByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:28:42'!
test10CartWithManyItemsTotalPriceEqualsToCartItemListPricesSummed

	| cart |
	
	cart := testFacility createCart.
	
	cart add: testFacility itemSellByTheStore.
	cart add: testFacility anotherItemSellByTheStore.  
	
	self assert: cart totalPrice equals: (testFacility defaultCatalog at: testFacility itemSellByTheStore) + (testFacility defaultCatalog at: testFacility anotherItemSellByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:28:57'!
test11CartWithOneItemGeneratesSaleBodyCorrectly

	| cart |
	
	cart := testFacility createCart.
	
	cart add: testFacility itemSellByTheStore.
	
	self assert: cart generateSaleBody equals: (Dictionary newFromPairs: {testFacility itemSellByTheStore. #(1 200).}).! !

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:29:15'!
test12CartWithManyItemsGeneratesSaleBodyCorrectly

	| cart |
	
	cart := testFacility createCart.
	
	cart add: testFacility itemSellByTheStore.
	cart add: testFacility anotherItemSellByTheStore.
	
	self assert: cart generateSaleBody equals: (Dictionary newFromPairs: {testFacility itemSellByTheStore. #(1 200). testFacility anotherItemSellByTheStore. #(1 150).}).! !


!CartTest methodsFor: 'support' stamp: 'JIG 6/7/2019 14:52:21'!
itemNotSellByTheStore
	
	^'invalidBook'! !


!CartTest methodsFor: 'setup' stamp: 'NI 6/9/2019 15:31:55'!
setUp
	testFacility := TestFacility new.! !


!classDefinition: #CashierTest category: #'TusLibros-Exercise'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'aSingleCart aCompoundCart anEmptySalesBook anExpiredCreditCard aValidCreditCard aMerchantProcessor testFacility'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CashierTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:32:56'!
test01CashierShouldNotCheckOutEmptyCart
	
	| anEmptyCart saleBookBeforeCheckout merchantProcessorChargesAmount |
	
	saleBookBeforeCheckout := anEmptySalesBook copy.
	anEmptyCart := Cart acceptingItemsOf: testFacility defaultCatalog.
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self should: [ Cashier checkout: anEmptyCart withSalesBook: anEmptySalesBook andMakePaymentWith: aValidCreditCard andProcessWith: aMerchantProcessor]
	raise: Error 
	withExceptionDo: [ :anError | 
		self assert: anError messageText equals: Cashier cannotAcceptEmptyCartErrorDescription.
		self assert: anEmptySalesBook equals: saleBookBeforeCheckout.
		self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	].! !

!CashierTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:33:04'!
test02CashierForANonEmptyCartCalculatesCartTotalPriceCorrectly
	
	| cashier |
	
	cashier := Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook andMakePaymentWith: aValidCreditCard andProcessWith: aMerchantProcessor.
	
	self assert: cashier totalPrice equals: (testFacility defaultCatalog at: testFacility itemSellByTheStore).
	! !

!CashierTest methodsFor: 'tests' stamp: 'NI 6/9/2019 14:33:41'!
test03CashierForANonEmptyCartAddsANewSaleEntryCorrectly
	
	Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook andMakePaymentWith: aValidCreditCard andProcessWith: aMerchantProcessor.
	
	self assert: anEmptySalesBook size equals: 1.
	self assert: (anEmptySalesBook at: 1) equals: (OrderedCollection with: Date today with: aSingleCart generateSaleBody with: aSingleCart totalPrice).
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'NI 6/9/2019 14:33:33'!
test04CannotMakePaymentWithAnExpiredCreditCard
	| salesBookBeforeSale merchantProcessorChargesAmount |
	
	salesBookBeforeSale := anEmptySalesBook copy.
	
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self should: [Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook andMakePaymentWith: anExpiredCreditCard andProcessWith: aMerchantProcessor]
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: Cashier cannotMakePaymentWithExpiredCreditCardErrorDescription.
		self assert: anEmptySalesBook equals: salesBookBeforeSale.
		self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	].
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:33:17'!
test05CannotMakePaymentWithStolenCreditCard
	| salesBookBeforeSale aStolenCreditCard merchantProcessorChargesAmount |
	
	salesBookBeforeSale := anEmptySalesBook copy.
	
	aStolenCreditCard := CreditCard for: 'Juan Carlos' expiringOn: testFacility aValidExpirationDate anIDNumber: self anIDForStolenCreditCard.
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self should: [Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook andMakePaymentWith: aStolenCreditCard andProcessWith: aMerchantProcessor]
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: InternMerchantProcessorSimulator stolenCreditCardErrorDescription.
		self assert: anEmptySalesBook equals: salesBookBeforeSale.
		self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	].
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:54:43'!
test06CannotMakePaymentWithCardWithNoCredit
	| salesBookBeforeSale aLowFundsCreditCard merchantProcessorChargesAmount |
	
	salesBookBeforeSale := anEmptySalesBook copy.
	
	aLowFundsCreditCard := CreditCard for: 'Juan Carlos' expiringOn: testFacility aValidExpirationDate anIDNumber: self anIDForALowFundsCreditCard.
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self should: [Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook andMakePaymentWith: aLowFundsCreditCard andProcessWith: aMerchantProcessor]
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: InternMerchantProcessorSimulator creditCardHasNoCreditErrorDescription.
		self assert: anEmptySalesBook equals: salesBookBeforeSale.
		self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	].
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'NI 6/9/2019 14:23:23'!
test07CashierForANonEmptyCartChargesTotalPriceToCreditCard
	
	| cashier merchantProcessorChargesAmount |
	
	cashier := Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook andMakePaymentWith: aValidCreditCard andProcessWith: aMerchantProcessor.
	
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	self assert: aMerchantProcessor lastCharge equals: cashier totalPrice.
	! !


!CashierTest methodsFor: 'support' stamp: 'NI 6/9/2019 15:51:50'!
anIDForALowFundsCreditCard
	^'0000111100001111'! !

!CashierTest methodsFor: 'support' stamp: 'NI 6/9/2019 13:34:06'!
anIDForStolenCreditCard
	^'1234123412341234'! !

!CashierTest methodsFor: 'support' stamp: 'NI 6/8/2019 19:29:47'!
createEmptySalesBook
	^OrderedCollection new.! !

!CashierTest methodsFor: 'support' stamp: 'NI 6/9/2019 14:03:30'!
newMerchantProcessor
	^ InternMerchantProcessorSimulator new.! !


!CashierTest methodsFor: 'setup' stamp: 'NI 6/9/2019 15:32:36'!
setUp

	testFacility := TestFacility new.

	aSingleCart := Cart acceptingItemsOf: testFacility defaultCatalog.
	aSingleCart add: testFacility itemSellByTheStore.
	
	aCompoundCart := Cart acceptingItemsOf: testFacility defaultCatalog.
	aCompoundCart add: testFacility itemSellByTheStore.
	aCompoundCart add: testFacility anotherItemSellByTheStore.
	
	anEmptySalesBook := self createEmptySalesBook.
	
	anExpiredCreditCard := CreditCard for: testFacility ownerOfExpiredCreditCard expiringOn: testFacility anExpiredDate anIDNumber: testFacility anIDForExpiredCreditCard.
	aValidCreditCard := CreditCard for: testFacility ownerOfValidCreditCard expiringOn: testFacility aValidExpirationDate anIDNumber: testFacility anIDForValidCreditCard.
	
	aMerchantProcessor := self newMerchantProcessor.! !


!classDefinition: #CreditCardTest category: #'TusLibros-Exercise'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'anExpiredCreditCard aValidCreditCard currentMonthOfYear testFacility'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CreditCardTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:34:54'!
test01CreditCardShouldHaveAnOwner
	| invalidCreditCard |
	
	self should: [ invalidCreditCard := CreditCard for: '' expiringOn: testFacility aValidExpirationDate anIDNumber: testFacility anIDForValidCreditCard ]
	raise: Error
	withExceptionDo: [ :anError | 
		CreditCard ownerCannotBeEmptyErrorDescription = anError messageText.
		self assert: invalidCreditCard isNil.
	].! !

!CreditCardTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:34:59'!
test02CreditCardOwnerShouldHaveNoMoreThan30Characters
	| invalidCreditCard |
	
	self should: [ invalidCreditCard := CreditCard for: 'juan ignacio grandoso nicolas ippolito' expiringOn: testFacility aValidExpirationDate anIDNumber: testFacility anIDForValidCreditCard ]
	raise: Error
	withExceptionDo: [ :anError | 
		CreditCard ownerShouldHaveLessThan30CharactersErrorDescription = anError messageText.
		self assert: invalidCreditCard isNil.
	].! !

!CreditCardTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:35:13'!
test03IdentificationNumberShouldBeValid
	| invalidCreditCard |
	
	self should: [ invalidCreditCard := CreditCard for: testFacility ownerOfValidCreditCard expiringOn: testFacility aValidExpirationDate anIDNumber: '2423' ]
	raise: Error
	withExceptionDo: [ :anError | 
		CreditCard ownerCannotBeEmptyErrorDescription = anError messageText.
		self assert: invalidCreditCard isNil.
	].! !

!CreditCardTest methodsFor: 'tests' stamp: 'NI 6/9/2019 13:46:14'!
test04AnCreditCardWithAnOldDateIsExpired
	
	self assert: (anExpiredCreditCard isExpiredOn: currentMonthOfYear).! !

!CreditCardTest methodsFor: 'tests' stamp: 'NI 6/9/2019 13:46:11'!
test05AnCreditCardWithAFutureDateIsNotExpired
	
	self assert: (aValidCreditCard isExpiredOn: currentMonthOfYear) not.! !


!CreditCardTest methodsFor: 'setup' stamp: 'NI 6/9/2019 15:34:27'!
setUp

	testFacility := TestFacility new.

	anExpiredCreditCard := CreditCard for: testFacility ownerOfExpiredCreditCard expiringOn: testFacility anExpiredDate anIDNumber: testFacility anIDForExpiredCreditCard.
	aValidCreditCard := CreditCard for: testFacility ownerOfValidCreditCard expiringOn: testFacility aValidExpirationDate anIDNumber: testFacility anIDForValidCreditCard.
	
	currentMonthOfYear := self currentMonthOfYear.! !


!CreditCardTest methodsFor: 'support' stamp: 'NI 6/8/2019 19:38:06'!
currentMonthOfYear
	^GregorianMonthOfYear year: Date today year yearNumber month: (GregorianMonth named: Date today monthName).! !


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


!Cart methodsFor: 'operations' stamp: 'NI 6/8/2019 19:20:23'!
generateSaleBody
	| saleBody |
	
	saleBody := Dictionary new.
	
	items do: [ :anItem | 
		| aBodyEntry | 
		
		aBodyEntry := self generateBodyEntryOf: anItem.
		
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


!Cart methodsFor: 'accessing' stamp: 'JIG 6/6/2019 11:32:17'!
items
	^items.! !

!Cart methodsFor: 'accessing' stamp: 'JIG 6/7/2019 15:01:51'!
totalPrice
	^items sum: [ :anItem | self priceOf: anItem ].! !


!Cart methodsFor: 'private - accessing' stamp: 'JIG 6/7/2019 16:04:22'!
priceOf: anItem
	
	^priceCatalog at: anItem.! !


!Cart methodsFor: 'private - operations' stamp: 'NI 6/8/2019 19:19:03'!
generateBodyEntryOf: anItem
	^Array with: (items occurrencesOf: anItem) with: (self priceOf: anItem)
	 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Exercise'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'JIG 6/7/2019 14:55:08'!
acceptingItemsOf: aPricedCatalog

	^self new initializeAcceptingItemsOf: aPricedCatalog ! !


!classDefinition: #Cashier category: #'TusLibros-Exercise'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook creditCard merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!Cashier methodsFor: 'initialization' stamp: 'NI 6/9/2019 13:28:33'!
initializeFor: aCart withSalesBook: aSalesBook CreditCard: aCreditCard andMerchantProcessor: aMerchantProcessor 
	cart := aCart.
	salesBook := aSalesBook.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	self doCheckout.! !


!Cashier methodsFor: 'operations' stamp: 'NI 6/9/2019 13:39:30'!
doCheckout
	| saleBookEntry |
	
	self assertCartIsNotEmpty.	
	self assertCardIsNotExpired.
	
	"Acá debiera comunicarse con el MP para que debite, ya que sino, no agregás la venta"
	"Igual habría que testear que no agregue la venta si el MP devuelve excepción, obvio"
	
	merchantProcessor debit: self totalPrice to: creditCard.
	
	saleBookEntry := self createSaleBookEntry.
	
	salesBook add: saleBookEntry.! !


!Cashier methodsFor: 'pricing' stamp: 'JIG 6/7/2019 15:00:55'!
totalPrice

	^cart totalPrice.! !


!Cashier methodsFor: 'private' stamp: 'NI 6/8/2019 19:27:44'!
createSaleBookEntry
	| saleBody saleBookEntry |
	
	saleBody := cart generateSaleBody.
	
	saleBookEntry := OrderedCollection new.
	
	saleBookEntry add: Date today.
	saleBookEntry add: saleBody.
	saleBookEntry add: cart totalPrice.
	
	^saleBookEntry! !

!Cashier methodsFor: 'private' stamp: 'NI 6/8/2019 19:22:59'!
currentMonthOfYear
	^GregorianMonthOfYear year: Date today year yearNumber month: (GregorianMonth named: Date today monthName)! !


!Cashier methodsFor: 'assertions' stamp: 'NI 6/8/2019 19:24:17'!
assertCardIsNotExpired
	| currentMonthOfYear |
	
	currentMonthOfYear := self currentMonthOfYear.
 	(creditCard isExpiredOn: currentMonthOfYear) ifTrue: [self error: self class cannotMakePaymentWithExpiredCreditCardErrorDescription ].! !

!Cashier methodsFor: 'assertions' stamp: 'NI 6/9/2019 13:39:30'!
assertCartIsNotEmpty
	cart isEmpty ifTrue: [self error: self class cannotAcceptEmptyCartErrorDescription].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Exercise'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'NI 6/8/2019 19:37:02'!
cannotAcceptEmptyCartErrorDescription
	^'No se puede hacer checkout de un carrito vacío'.! !

!Cashier class methodsFor: 'error descriptions' stamp: 'NI 6/8/2019 19:37:11'!
cannotMakePaymentWithExpiredCreditCardErrorDescription
	^'No se puede realizar un pago con una tarjeta de crédito vencida'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'NI 6/9/2019 13:28:33'!
checkout: aCart withSalesBook: aSalesBook andMakePaymentWith: aCreditCard andProcessWith: aMerchantProcessor  
	^self new initializeFor: aCart withSalesBook: aSalesBook CreditCard: aCreditCard andMerchantProcessor: aMerchantProcessor.! !


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


!CreditCard methodsFor: 'testing' stamp: 'JIG 6/7/2019 16:53:15'!
isExpiredOn: anExpirationDate
	^expirationDate < anExpirationDate.! !


!CreditCard methodsFor: 'accessing' stamp: 'NI 6/9/2019 13:37:43'!
idNumber
	^idNumber! !

!CreditCard methodsFor: 'accessing' stamp: 'NI 6/9/2019 13:32:48'!
owner
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Exercise'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'NI 6/8/2019 19:35:50'!
for: anOwner expiringOn: anExpirationDate anIDNumber: anIdentificationNumber 
	self assertOwnerIsValid: anOwner.
	self assertIdentificationNumberIsValid: anIdentificationNumber.
	
	^self new initializeFor: anOwner expiringOn: anExpirationDate anIDNumber: anIdentificationNumber.
		! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'NI 6/8/2019 19:36:27'!
identificationNumberMustBeValidErrorDescription
	^'El número de la tarjeta de crédito debe poseer 16 digitos'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JIG 6/7/2019 17:21:22'!
ownerCannotBeEmptyErrorDescription
	^'La tarjeta debe tener propietario'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'NI 6/9/2019 13:44:39'!
ownerShouldHaveLessThan30CharactersErrorDescription
	^'El nombre del propietario debe tener menos de 30 caracteres'.! !


!CreditCard class methodsFor: 'assertions' stamp: 'NI 6/8/2019 19:35:44'!
assertIdentificationNumberIsValid: anIdentificationNumber.
	(anIdentificationNumber isString 
		and: [ (anIdentificationNumber allSatisfy: [:aCharacter | aCharacter isDigit ]) 
		and: [ anIdentificationNumber size = 16 ]]) ifFalse: [ self error: self identificationNumberMustBeValidErrorDescription ].
		! !

!CreditCard class methodsFor: 'assertions' stamp: 'NI 6/9/2019 13:45:35'!
assertOwnerIsValid: anOwner.
	(anOwner isEmpty or: [anOwner isString not] or: [anOwner size > 30]) ifTrue: [ self error: self ownerCannotBeEmptyErrorDescription ].
		! !


!classDefinition: #InternMerchantProcessorSimulator category: #'TusLibros-Exercise'!
Object subclass: #InternMerchantProcessorSimulator
	instanceVariableNames: 'charges'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!InternMerchantProcessorSimulator methodsFor: 'assertions' stamp: 'NI 6/9/2019 15:58:50'!
assertCreditCardHasFunds: aCreditCard toPay: anAmount.
	(self class lowFundsCreditCards at: aCreditCard idNumber ifAbsent: [^ nil]) < anAmount ifTrue: [self error: self class creditCardHasNoCreditErrorDescription].! !

!InternMerchantProcessorSimulator methodsFor: 'assertions' stamp: 'NI 6/9/2019 13:37:54'!
assertCreditCardIsNotStolen: aCreditCard
	(self class stolenCreditCards includes: aCreditCard idNumber) ifTrue: [self error: self class stolenCreditCardErrorDescription].! !


!InternMerchantProcessorSimulator methodsFor: 'debit' stamp: 'NI 6/9/2019 15:52:24'!
debit: anAmount to: aCreditCard
	self assertCreditCardIsNotStolen: aCreditCard.
	self assertCreditCardHasFunds: aCreditCard toPay: anAmount.
	
	self addChargeFor: anAmount.! !


!InternMerchantProcessorSimulator methodsFor: 'charging' stamp: 'NI 6/9/2019 14:00:20'!
addChargeFor: anAmount.
	charges add: anAmount.! !


!InternMerchantProcessorSimulator methodsFor: 'accessing' stamp: 'NI 6/9/2019 14:11:19'!
chargesAmount
	^charges size.! !

!InternMerchantProcessorSimulator methodsFor: 'accessing' stamp: 'NI 6/9/2019 14:15:36'!
lastCharge
	^ charges last.! !


!InternMerchantProcessorSimulator methodsFor: 'initialization' stamp: 'NI 6/9/2019 14:00:57'!
initialize
	super initialize.
	charges := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternMerchantProcessorSimulator class' category: #'TusLibros-Exercise'!
InternMerchantProcessorSimulator class
	instanceVariableNames: ''!

!InternMerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'NI 6/9/2019 15:50:52'!
creditCardHasNoCreditErrorDescription
	^'Pago inválido: la tarjeta de crédito no tiene suficiente dinero como para pagar ese monto'! !

!InternMerchantProcessorSimulator class methodsFor: 'error descriptions' stamp: 'NI 6/9/2019 12:36:54'!
stolenCreditCardErrorDescription
	^'Pago inválido: la tarjeta de crédito es robada'! !


!InternMerchantProcessorSimulator class methodsFor: 'stolen credit cards' stamp: 'NI 6/9/2019 13:24:16'!
stolenCreditCards
	^ OrderedCollection with: '1234123412341234' with: '1111000011110000'.! !


!InternMerchantProcessorSimulator class methodsFor: 'low funds credit cards' stamp: 'NI 6/9/2019 15:58:50'!
lowFundsCreditCards
	| aDictionary |
	aDictionary := Dictionary new.
	aDictionary add: '0000111100001111'->1. 
	^aDictionary! !


!classDefinition: #TestFacility category: #'TusLibros-Exercise'!
Object subclass: #TestFacility
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!TestFacility methodsFor: 'cart creation' stamp: 'NI 6/9/2019 15:23:41'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !


!TestFacility methodsFor: 'catalog' stamp: 'NI 6/9/2019 15:23:30'!
defaultCatalog
	
	^ Dictionary 
		newFromPairs: {
			self itemSellByTheStore. 200.
			self anotherItemSellByTheStore. 150.
		}! !


!TestFacility methodsFor: 'credit card dates' stamp: 'NI 6/9/2019 15:29:53'!
aValidExpirationDate
	^June ofYear: (Date today + (Duration days: 365)) yearNumber.! !

!TestFacility methodsFor: 'credit card dates' stamp: 'NI 6/9/2019 15:30:00'!
anExpiredDate
	^May ofYear: 2019.! !


!TestFacility methodsFor: 'credit card ids' stamp: 'NI 6/9/2019 15:30:07'!
anIDForExpiredCreditCard
	^'4700000034541234'! !

!TestFacility methodsFor: 'credit card ids' stamp: 'NI 6/9/2019 15:30:13'!
anIDForValidCreditCard
	^'4700000034540007'! !


!TestFacility methodsFor: 'credit card owners' stamp: 'NI 6/9/2019 15:30:39'!
ownerOfExpiredCreditCard
	^'Jose'.! !

!TestFacility methodsFor: 'credit card owners' stamp: 'NI 6/9/2019 15:30:46'!
ownerOfValidCreditCard
	^'Nico'.! !


!TestFacility methodsFor: 'store items' stamp: 'NI 6/9/2019 15:23:51'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!TestFacility methodsFor: 'store items' stamp: 'NI 6/9/2019 15:23:04'!
itemSellByTheStore
	
	^ 'validBook'.! !
