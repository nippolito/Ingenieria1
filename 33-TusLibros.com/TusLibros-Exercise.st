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


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #'TusLibros-Exercise'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'aSingleCart aCompoundCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CashierTest methodsFor: 'tests' stamp: 'Nip 6/7/2019 14:12:43'!
test01CashierShouldNotCheckOutEmptyCart
	
	| anEmptyCart |
	
	anEmptyCart := Cart acceptingItemsOf: self defaultCatalog.
	
	self should: [ Cashier checkoutFor: anEmptyCart withItemPriceList: self itemPriceListFromTheStore ] 
	raise: Error 
	withExceptionDo: [ :anError | anError messageText = Cashier cannotAcceptEmptyCartErrorDescription ].! !

!CashierTest methodsFor: 'tests' stamp: 'Nip 6/7/2019 14:13:02'!
test02CashierForACartWithOneItemChargesThatItemPrice
	
	| cashier |
	
	cashier := Cashier checkoutFor: aSingleCart withItemPriceList: self itemPriceListFromTheStore.
	
	self assert: cashier totalPrice = (self itemPriceListFromTheStore at: self itemSellByTheStore).
	"self assert: (cashier priceOf: self itemSellByTheStore) = (self itemPriceListFromTheStore at: self itemSellByTheStore)."
	! !

!CashierTest methodsFor: 'tests' stamp: 'Nip 6/7/2019 14:13:40'!
test03CashierForACartWithManyItemsChargesThatItemsPriceSum
	
	|  cashier |
	
	cashier := Cashier checkoutFor: aCompoundCart withItemPriceList: self itemPriceListFromTheStore.
	
	self assert: cashier totalPrice = ((self itemPriceListFromTheStore at: self itemSellByTheStore) + (self itemPriceListFromTheStore at: self anotherItemSellByTheStore)).
	"self assert: (cashier priceOf: self itemSellByTheStore) = (self itemPriceListFromTheStore at: self itemSellByTheStore).
	self assert: (cashier priceOf: self anotherItemSellByTheStore) = (self itemPriceListFromTheStore at: self anotherItemSellByTheStore)."! !

!CashierTest methodsFor: 'tests' stamp: 'Nip 6/7/2019 14:13:48'!
test04CashierCannotTellPriceOfUnknownItemOnPriceList
	
	| cashier |
	
	cashier := Cashier checkoutFor: aCompoundCart withItemPriceList: self itemPriceListFromTheStore.
	
	self should: [cashier priceOf: self itemNotSellByTheStore ]  
	raise: Error
	withExceptionDo: [:anError | anError messageText = Cashier cannotTellPriceOfUnknownItemErrorDescription ].! !

!CashierTest methodsFor: 'tests' stamp: 'Nip 6/7/2019 14:07:52'!
test05CashierMayRemoveSomeItemFromCart
	
	"| aCompoundCart cashier |
	
	aCompoundCart := Cart acceptingItemsOf: self defaultCatalog.
	aCompoundCart add: self itemSellByTheStore.
	aCompoundCart add: self anotherItemSellByTheStore.
	
	cashier := Cashier checkoutFor: aCompoundCart withItemPriceList: self itemPriceListFromTheStore.
	
	cashier removeFromCart: self itemSellByTheStore.
	
	self assert: cashier totalPrice = (self itemPriceListFromTheStore at: self anotherItemSellByTheStore)."! !

!CashierTest methodsFor: 'tests' stamp: 'Nip 6/7/2019 14:07:58'!
test06CashierCannotRemoveItemThatIsNotOnCart
	
	"| aSingleCart cashier |
	
	aSingleCart := Cart acceptingItemsOf: self defaultCatalog.
	aSingleCart add: self itemSellByTheStore.
	
	cashier := Cashier checkoutFor: aSingleCart withItemPriceList: self itemPriceListFromTheStore.
	
	self should: [ cashier removeFromCart: self anotherItemSellByTheStore ]  
	raise: Error 
	withExceptionDo: [ :anError | anError messageText = Cashier cannotRemoveItemThatIsNotOnCartErrorDescription ].
	"! !


!CashierTest methodsFor: 'support' stamp: 'JIG 6/6/2019 11:37:41'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!CashierTest methodsFor: 'support' stamp: 'JIG 6/6/2019 11:39:18'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore with: self anotherItemSellByTheStore.! !

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


!CashierTest methodsFor: 'setup' stamp: 'Nip 6/7/2019 14:13:34'!
setUp
	aSingleCart := Cart acceptingItemsOf: self defaultCatalog.
	aSingleCart add: self itemSellByTheStore.
	
	aCompoundCart := Cart acceptingItemsOf: self defaultCatalog.
	aCompoundCart add: self itemSellByTheStore.
	aCompoundCart add: self anotherItemSellByTheStore.! !


!classDefinition: #Cart category: #'TusLibros-Exercise'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


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


!Cart methodsFor: 'accessing' stamp: 'JIG 6/6/2019 11:32:17'!
items
	^items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Exercise'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #'TusLibros-Exercise'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList cartItemList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'JIG 6/6/2019 12:03:48'!
removeFromCart: anItem
	cartItemList remove: anItem ifAbsent: [ self error: self class cannotRemoveItemThatIsNotOnCartErrorDescription ].
 ! !


!Cashier methodsFor: 'initialization' stamp: 'JIG 6/6/2019 12:02:12'!
initializeFor: aCart withItemPriceList: aPriceList 
	cartItemList := aCart items.
	priceList := aPriceList.! !


!Cashier methodsFor: 'private - pricing' stamp: 'JIG 6/6/2019 11:58:44'!
priceOf: anItem
	| finalPrice |
	finalPrice := priceList at: anItem ifAbsent: [ self error : self class cannotTellPriceOfUnknownItemErrorDescription ] .
	
	^finalPrice! !

!Cashier methodsFor: 'private - pricing' stamp: 'JIG 6/6/2019 12:02:20'!
totalPrice
	| accumulatedPrice |

	accumulatedPrice := 0.

	cartItemList do: [ :aCartItem | accumulatedPrice := accumulatedPrice + (priceList at: aCartItem) ].
	^accumulatedPrice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Exercise'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'errors' stamp: 'JIG 6/6/2019 11:08:54'!
cannotAcceptEmptyCartErrorDescription
	^'No se puede hacer checkout de un carrito vacio'.! !

!Cashier class methodsFor: 'errors' stamp: 'JIG 6/6/2019 12:04:11'!
cannotRemoveItemThatIsNotOnCartErrorDescription
	^'No existe dicho item en el actual carrito'.! !

!Cashier class methodsFor: 'errors' stamp: 'JIG 6/6/2019 11:57:00'!
cannotTellPriceOfUnknownItemErrorDescription
	^'Item desconocido por lista de precio'! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'JIG 6/6/2019 11:27:15'!
checkoutFor: aCart withItemPriceList: aPriceList 
	aCart isEmpty ifTrue: [ self error: self cannotAcceptEmptyCartErrorDescription ].
	^self new initializeFor: aCart withItemPriceList: aPriceList.! !
