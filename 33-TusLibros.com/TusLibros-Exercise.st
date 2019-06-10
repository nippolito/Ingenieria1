!classDefinition: #CartTest category: #'TusLibros-Exercise'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testFacility emptyCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CartTest methodsFor: 'tests' stamp: 'NI 6/9/2019 15:26:30'!
test01NewCartsAreCreatedEmpty

	self assert: testFacility createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:17:37'!
test02CanNotAddItemsThatDoNotBelongToStore
	
	self 
		should: [ emptyCart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = emptyCart invalidItemErrorMessage.
			self assert: emptyCart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:17:37'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore
	
	emptyCart add: testFacility itemSellByTheStore.
	self deny: emptyCart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:18:01'!
test04CanNotAddNonPositiveNumberOfItems
	
	self 
		should: [emptyCart add: 0 of: testFacility itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = emptyCart invalidQuantityErrorMessage.
			self assert: emptyCart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:18:18'!
test05CanNotAddMoreThanOneItemNotSellByTheStore
	
	self 
		should: [emptyCart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = emptyCart invalidItemErrorMessage.
			self assert: emptyCart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:18:33'!
test06CartRemembersAddedItems
	
	emptyCart add: testFacility itemSellByTheStore.
	self assert: (emptyCart includes: testFacility itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:18:44'!
test07CartDoesNotHoldNotAddedItems
	
	self deny: (emptyCart includes: testFacility itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:18:58'!
test08CartRemembersTheNumberOfAddedItems
	
	emptyCart add: 2 of: testFacility itemSellByTheStore.
	self assert: (emptyCart occurrencesOf: testFacility itemSellByTheStore) equals: 2! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:19:20'!
test09CartWithOneItemTotalPriceEqualsThatItemPrice
	
	emptyCart add: testFacility itemSellByTheStore.
	
	self assert: emptyCart totalPrice = (testFacility defaultCatalog at: testFacility itemSellByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:28:28'!
test10CartWithManyItemsTotalPriceEqualsToCartItemListPricesSummed
	
	emptyCart add: testFacility itemSellByTheStore.
	emptyCart add: testFacility anotherItemSellByTheStore.  
	
	self assert: emptyCart totalPrice equals: (testFacility defaultCatalog at: testFacility itemSellByTheStore) + (testFacility defaultCatalog at: testFacility anotherItemSellByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:28:51'!
test11CartWithOneItemGeneratesSaleBodyCorrectly
	
	emptyCart add: testFacility itemSellByTheStore.
	
	self assert: emptyCart generateSaleBody equals: (Dictionary newFromPairs: {testFacility itemSellByTheStore. #(1 200).}).! !

!CartTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 14:29:06'!
test12CartWithManyItemsGeneratesSaleBodyCorrectly
	
	emptyCart add: testFacility itemSellByTheStore.
	emptyCart add: testFacility anotherItemSellByTheStore.
	
	self assert: emptyCart generateSaleBody equals: (Dictionary newFromPairs: {testFacility itemSellByTheStore. #(1 200). testFacility anotherItemSellByTheStore. #(1 150).}).! !


!CartTest methodsFor: 'support' stamp: 'JIG 6/7/2019 14:52:21'!
itemNotSellByTheStore
	
	^'invalidBook'! !


!CartTest methodsFor: 'setup' stamp: 'Nipo 6/10/2019 14:17:37'!
setUp
	testFacility := TestFacility new.
	
	emptyCart := testFacility createCart.! !


!classDefinition: #CashierTest category: #'TusLibros-Exercise'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'aSingleCart aCompoundCart anEmptySalesBook anExpiredCreditCard aValidCreditCard aMerchantProcessor testFacility'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CashierTest methodsFor: 'tests' stamp: 'NI 6/10/2019 10:29:23'!
test01CashierShouldNotCheckOutEmptyCart
	
	| anEmptyCart saleBookBeforeCheckout merchantProcessorChargesAmount |
	
	saleBookBeforeCheckout := anEmptySalesBook copy.
	anEmptyCart := Cart acceptingItemsOf: testFacility defaultCatalog.
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self should: [ Cashier checkout: anEmptyCart withSalesBook: anEmptySalesBook payingWith: aValidCreditCard andProcessingWith: aMerchantProcessor]
	raise: Error 
	withExceptionDo: [ :anError | 
		self assert: anError messageText equals: Cashier cannotAcceptEmptyCartErrorDescription.
		self assert: anEmptySalesBook equals: saleBookBeforeCheckout.
		self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	].! !

!CashierTest methodsFor: 'tests' stamp: 'NI 6/10/2019 10:29:23'!
test02CashierForANonEmptyCartCalculatesCartTotalPriceCorrectly
	
	| cashier |
	
	cashier := Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook payingWith: aValidCreditCard andProcessingWith: aMerchantProcessor.
	
	self assert: cashier totalPrice equals: (testFacility defaultCatalog at: testFacility itemSellByTheStore).
	! !

!CashierTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 15:01:47'!
test03CashierForANonEmptyCartAddsANewSaleEntryOnASuccessfullCheckOut
	
	Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook payingWith: aValidCreditCard andProcessingWith: aMerchantProcessor.
	
	self assert: anEmptySalesBook size equals: 1.
	self assert: (anEmptySalesBook at: 1) equals: (OrderedCollection with: Date today with: aSingleCart generateSaleBody with: aSingleCart totalPrice).
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 15:23:37'!
test04CashierForANonEmptyCartChargesTotalPriceToCreditCard
	
	| cashier merchantProcessorChargesAmount |
	
	cashier := Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook payingWith: aValidCreditCard andProcessingWith: aMerchantProcessor.
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	self assert: aMerchantProcessor lastCharge equals: cashier totalPrice.
	! !

!CashierTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 15:23:54'!
test05CannotMakePaymentWithAnExpiredCreditCard
	| salesBookBeforeSale merchantProcessorChargesAmount |
	
	salesBookBeforeSale := anEmptySalesBook copy.
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self should: [Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook payingWith: anExpiredCreditCard andProcessingWith: aMerchantProcessor]
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: Cashier cannotMakePaymentWithExpiredCreditCardErrorDescription.
		self assert: anEmptySalesBook equals: salesBookBeforeSale.
		self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	].
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 15:23:48'!
test06CannotMakePaymentWithAStolenCreditCard
	| salesBookBeforeSale aStolenCreditCard merchantProcessorChargesAmount |
	
	salesBookBeforeSale := anEmptySalesBook copy.
	aStolenCreditCard := CreditCard for: 'Juan Carlos' expiringOn: testFacility aValidExpirationDate withIDNumber: self anIDForStolenCreditCard.
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self should: [Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook payingWith: aStolenCreditCard andProcessingWith: aMerchantProcessor]
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: MerchantProcessorInternalSimulator stolenCreditCardErrorDescription.
		self assert: anEmptySalesBook equals: salesBookBeforeSale.
		self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	].
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 15:23:45'!
test07CannotMakePaymentWithACardWithNoFunds
	| salesBookBeforeSale aLowFundsCreditCard merchantProcessorChargesAmount |
	
	salesBookBeforeSale := anEmptySalesBook copy.
	aLowFundsCreditCard := CreditCard for: 'Juan Carlos' expiringOn: testFacility aValidExpirationDate withIDNumber: self anIDForALowFundsCreditCard.
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self should: [Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook payingWith: aLowFundsCreditCard andProcessingWith: aMerchantProcessor]
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: MerchantProcessorInternalSimulator creditCardHasNoFundsErrorDescription.
		self assert: anEmptySalesBook equals: salesBookBeforeSale.
		self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	].
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 15:23:41'!
test08CannotMakePaymentIfCardOwnerIsMoreThan30CharactersLong
	| salesBookBeforeSale merchantProcessorChargesAmount aCreditCardWithLongOwnerName |
	
	salesBookBeforeSale := anEmptySalesBook copy.
	aCreditCardWithLongOwnerName := CreditCard for: self aLongOwnerName expiringOn: testFacility aValidExpirationDate withIDNumber: testFacility anIDForValidCreditCard.
	merchantProcessorChargesAmount := aMerchantProcessor chargesAmount copy.
	
	self should: [Cashier checkout: aSingleCart withSalesBook: anEmptySalesBook payingWith: aCreditCardWithLongOwnerName andProcessingWith: aMerchantProcessor]
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: MerchantProcessorInternalSimulator creditCardOwnerShouldHaveLessThan30CharactersErrorDescription.
		self assert: anEmptySalesBook equals: salesBookBeforeSale.
		self assert: merchantProcessorChargesAmount equals: aMerchantProcessor chargesAmount.
	].
	
	! !


!CashierTest methodsFor: 'support' stamp: 'Nipo 6/10/2019 14:56:29'!
aLongOwnerName
	^'Nicolazakimisapetalil Ippolizitakytian'! !

!CashierTest methodsFor: 'support' stamp: 'NI 6/9/2019 15:51:50'!
anIDForALowFundsCreditCard
	^'0000111100001111'! !

!CashierTest methodsFor: 'support' stamp: 'NI 6/9/2019 13:34:06'!
anIDForStolenCreditCard
	^'1234123412341234'! !

!CashierTest methodsFor: 'support' stamp: 'NI 6/8/2019 19:29:47'!
createEmptySalesBook
	^OrderedCollection new.! !

!CashierTest methodsFor: 'support' stamp: 'NI 6/10/2019 10:54:21'!
newMerchantProcessor
	^ MerchantProcessorInternalSimulator new.! !


!CashierTest methodsFor: 'setup' stamp: 'NI 6/10/2019 10:17:00'!
setUp

	testFacility := TestFacility new.

	aSingleCart := Cart acceptingItemsOf: testFacility defaultCatalog.
	aSingleCart add: testFacility itemSellByTheStore.
	
	aCompoundCart := Cart acceptingItemsOf: testFacility defaultCatalog.
	aCompoundCart add: testFacility itemSellByTheStore.
	aCompoundCart add: testFacility anotherItemSellByTheStore.
	
	anEmptySalesBook := self createEmptySalesBook.
	
	anExpiredCreditCard := CreditCard for: testFacility ownerOfExpiredCreditCard expiringOn: testFacility anExpiredDate withIDNumber: testFacility anIDForExpiredCreditCard.
	aValidCreditCard := CreditCard for: testFacility ownerOfValidCreditCard expiringOn: testFacility aValidExpirationDate withIDNumber: testFacility anIDForValidCreditCard.
	
	aMerchantProcessor := self newMerchantProcessor.! !


!classDefinition: #CreditCardTest category: #'TusLibros-Exercise'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'anExpiredCreditCard aValidCreditCard currentMonthOfYear testFacility'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CreditCardTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 15:00:00'!
test02IdentificationNumberShouldBeValid
	| invalidCreditCard |
	
	self should: [ invalidCreditCard := CreditCard for: testFacility ownerOfValidCreditCard expiringOn: testFacility aValidExpirationDate withIDNumber: '2423' ]
	raise: Error
	withExceptionDo: [ :anError | 
		CreditCard ownerCannotBeEmptyErrorDescription = anError messageText.
		self assert: invalidCreditCard isNil.
	].! !

!CreditCardTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 15:00:18'!
test03ACreditCardWithAnOldExpirationDateIsExpired
	
	self assert: (anExpiredCreditCard isExpiredOn: currentMonthOfYear).! !

!CreditCardTest methodsFor: 'tests' stamp: 'Nipo 6/10/2019 15:00:22'!
test04ACreditCardWithAFutureExpirationDateIsNotExpired
	
	self assert: (aValidCreditCard isExpiredOn: currentMonthOfYear) not.! !


!CreditCardTest methodsFor: 'setup' stamp: 'NI 6/10/2019 10:17:00'!
setUp

	testFacility := TestFacility new.

	anExpiredCreditCard := CreditCard for: testFacility ownerOfExpiredCreditCard expiringOn: testFacility anExpiredDate withIDNumber: testFacility anIDForExpiredCreditCard.
	aValidCreditCard := CreditCard for: testFacility ownerOfValidCreditCard expiringOn: testFacility aValidExpirationDate withIDNumber: testFacility anIDForValidCreditCard.
	
	currentMonthOfYear := self currentMonthOfYear.! !


!CreditCardTest methodsFor: 'support' stamp: 'NI 6/8/2019 19:38:06'!
currentMonthOfYear
	^GregorianMonthOfYear year: Date today year yearNumber month: (GregorianMonth named: Date today monthName).! !

!CreditCardTest methodsFor: 'support' stamp: 'NI 6/10/2019 10:17:00'!
test01CreditCardShouldHaveAnOwner
	| invalidCreditCard |
	
	self should: [ invalidCreditCard := CreditCard for: '' expiringOn: testFacility aValidExpirationDate withIDNumber: testFacility anIDForValidCreditCard ]
	raise: Error
	withExceptionDo: [ :anError | 
		CreditCard ownerCannotBeEmptyErrorDescription = anError messageText.
		self assert: invalidCreditCard isNil.
	].! !


!classDefinition: #Cart category: #'TusLibros-Exercise'!
Object subclass: #Cart
	instanceVariableNames: 'items priceCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!Cart methodsFor: 'accessing' stamp: 'JIG 6/6/2019 11:32:17'!
items
	^items.! !

!Cart methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'accessing' stamp: 'JIG 6/7/2019 15:01:51'!
totalPrice
	^items sum: [ :anItem | self priceOf: anItem ].! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'JIG 6/7/2019 15:25:04'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'assertions' stamp: 'JIG 6/7/2019 14:54:30'!
assertIsValidItem: anItem

	(priceCatalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'initialization' stamp: 'JIG 6/7/2019 15:24:15'!
initializeAcceptingItemsOf: aPricedCatalog

	priceCatalog := aPricedCatalog.
	items := Bag new.! !


!Cart methodsFor: 'sale body' stamp: 'NI 6/8/2019 19:20:23'!
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


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'private - accessing' stamp: 'JIG 6/7/2019 16:04:22'!
priceOf: anItem
	
	^priceCatalog at: anItem.! !


!Cart methodsFor: 'private - sale body' stamp: 'NI 6/8/2019 19:19:03'!
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

!Cashier methodsFor: 'initialization' stamp: 'NI 6/10/2019 10:29:47'!
initializeFor: aCart withSalesBook: aSalesBook payingWith: aCreditCard andProcessingWith: aMerchantProcessor 
	cart := aCart.
	salesBook := aSalesBook.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	self doCheckout.! !


!Cashier methodsFor: 'operations' stamp: 'NI 6/10/2019 10:53:01'!
doCheckout
	| saleBookEntry |
	
	self assertCartIsNotEmpty.	
	self assertCardIsNotExpired.
	
	merchantProcessor debit: self totalPrice to: creditCard.
	
	saleBookEntry := self createSalesBookEntry.
	
	salesBook add: saleBookEntry.! !


!Cashier methodsFor: 'pricing' stamp: 'JIG 6/7/2019 15:00:55'!
totalPrice

	^cart totalPrice.! !


!Cashier methodsFor: 'private' stamp: 'NI 6/10/2019 10:53:06'!
createSalesBookEntry
	| saleBody salesBookEntry |
	
	saleBody := cart generateSaleBody.
	
	salesBookEntry := OrderedCollection new.
	
	salesBookEntry add: Date today.
	salesBookEntry add: saleBody.
	salesBookEntry add: cart totalPrice.
	
	^salesBookEntry! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'NI 6/10/2019 10:29:47'!
checkout: aCart withSalesBook: aSalesBook payingWith: aCreditCard andProcessingWith: aMerchantProcessor  
	^self new initializeFor: aCart withSalesBook: aSalesBook payingWith: aCreditCard andProcessingWith: aMerchantProcessor.! !


!classDefinition: #CreditCard category: #'TusLibros-Exercise'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner idNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CreditCard methodsFor: 'initialization' stamp: 'NI 6/10/2019 10:17:10'!
initializeFor: anOwner expiringOn: anExpirationDate withIDNumber: anIdentificationNumber
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

!CreditCard class methodsFor: 'instance creation' stamp: 'NI 6/10/2019 10:17:10'!
for: anOwner expiringOn: anExpirationDate withIDNumber: anIdentificationNumber 
	self assertOwnerIsValid: anOwner.
	self assertIdentificationNumberIsValid: anIdentificationNumber.
	
	^self new initializeFor: anOwner expiringOn: anExpirationDate withIDNumber: anIdentificationNumber.
		! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'NI 6/8/2019 19:36:27'!
identificationNumberMustBeValidErrorDescription
	^'El número de la tarjeta de crédito debe poseer 16 digitos'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JIG 6/7/2019 17:21:22'!
ownerCannotBeEmptyErrorDescription
	^'La tarjeta debe tener propietario'.! !


!CreditCard class methodsFor: 'assertions' stamp: 'NI 6/8/2019 19:35:44'!
assertIdentificationNumberIsValid: anIdentificationNumber.
	(anIdentificationNumber isString 
		and: [ (anIdentificationNumber allSatisfy: [:aCharacter | aCharacter isDigit ]) 
		and: [ anIdentificationNumber size = 16 ]]) ifFalse: [ self error: self identificationNumberMustBeValidErrorDescription ].
		! !

!CreditCard class methodsFor: 'assertions' stamp: 'Nipo 6/10/2019 14:45:14'!
assertOwnerIsValid: anOwner.
	(anOwner isEmpty or: [anOwner isString not]) ifTrue: [ self error: self ownerCannotBeEmptyErrorDescription ].
		! !


!classDefinition: #MerchantProcessorInternalSimulator category: #'TusLibros-Exercise'!
Object subclass: #MerchantProcessorInternalSimulator
	instanceVariableNames: 'charges'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!MerchantProcessorInternalSimulator methodsFor: 'accessing' stamp: 'NI 6/9/2019 14:11:19'!
chargesAmount
	^charges size.! !

!MerchantProcessorInternalSimulator methodsFor: 'accessing' stamp: 'NI 6/9/2019 14:15:36'!
lastCharge
	^ charges last.! !


!MerchantProcessorInternalSimulator methodsFor: 'assertions' stamp: 'NI 6/10/2019 10:19:38'!
assertCreditCard: aCreditCard hasFundsToPay: anAmount.
	(self class lowFundsCreditCards at: aCreditCard idNumber ifAbsent: [^ nil]) < anAmount ifTrue: [self error: self class creditCardHasNoFundsErrorDescription].! !

!MerchantProcessorInternalSimulator methodsFor: 'assertions' stamp: 'NI 6/9/2019 13:37:54'!
assertCreditCardIsNotStolen: aCreditCard
	(self class stolenCreditCards includes: aCreditCard idNumber) ifTrue: [self error: self class stolenCreditCardErrorDescription].! !

!MerchantProcessorInternalSimulator methodsFor: 'assertions' stamp: 'Nipo 6/10/2019 14:44:51'!
assertCreditCardOwnerHasLessThan30Characters: aCreditCard.
	aCreditCard owner size > 30 ifTrue: [ self error: self class creditCardOwnerShouldHaveLessThan30CharactersErrorDescription].! !


!MerchantProcessorInternalSimulator methodsFor: 'charging' stamp: 'NI 6/9/2019 14:00:20'!
addChargeFor: anAmount.
	charges add: anAmount.! !


!MerchantProcessorInternalSimulator methodsFor: 'debit' stamp: 'Nipo 6/10/2019 14:43:04'!
debit: anAmount to: aCreditCard
	self assertCreditCardIsNotStolen: aCreditCard.
	self assertCreditCard: aCreditCard hasFundsToPay: anAmount.
	self assertCreditCardOwnerHasLessThan30Characters: aCreditCard.
	
	self addChargeFor: anAmount.! !


!MerchantProcessorInternalSimulator methodsFor: 'initialization' stamp: 'NI 6/9/2019 14:00:57'!
initialize
	super initialize.
	charges := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorInternalSimulator class' category: #'TusLibros-Exercise'!
MerchantProcessorInternalSimulator class
	instanceVariableNames: ''!

!MerchantProcessorInternalSimulator class methodsFor: 'error descriptions' stamp: 'NI 6/10/2019 10:19:38'!
creditCardHasNoFundsErrorDescription
	^'Pago inválido: la tarjeta de crédito no tiene suficiente dinero como para pagar ese monto'! !

!MerchantProcessorInternalSimulator class methodsFor: 'error descriptions' stamp: 'Nipo 6/10/2019 14:30:32'!
creditCardOwnerShouldHaveLessThan30CharactersErrorDescription
	^'Pago inválido: El nombre del propietario debe tener menos de 30 caracteres'.! !

!MerchantProcessorInternalSimulator class methodsFor: 'error descriptions' stamp: 'NI 6/9/2019 12:36:54'!
stolenCreditCardErrorDescription
	^'Pago inválido: la tarjeta de crédito es robada'! !


!MerchantProcessorInternalSimulator class methodsFor: 'low funds credit cards' stamp: 'NI 6/9/2019 15:58:50'!
lowFundsCreditCards
	| aDictionary |
	aDictionary := Dictionary new.
	aDictionary add: '0000111100001111'->1. 
	^aDictionary! !


!MerchantProcessorInternalSimulator class methodsFor: 'stolen credit cards' stamp: 'NI 6/9/2019 13:24:16'!
stolenCreditCards
	^ OrderedCollection with: '1234123412341234' with: '1111000011110000'.! !


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
