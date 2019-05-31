!classDefinition: #CartTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 14:50:19'!
test00newCartCreatesEmpty
	
	| cart aCatalogue |

	aCatalogue := Catalogue with: (OrderedCollection new).
	cart := Cart withCatalogue: aCatalogue.
	
	self assert: cart isEmpty.
	
	! !

!CartTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 14:50:52'!
test01cartIsNotEmptyAfterAddingAnItem
	
	| cart anItem aCatalogue |
		
	anItem := Item new.	
	aCatalogue := Catalogue with: (OrderedCollection with: anItem).
	cart := Cart withCatalogue: aCatalogue.
	
	cart addItem: anItem.
	
	self deny: cart isEmpty.
	self assert: cart itemCount equals: 1.
	
	! !

!CartTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 14:51:23'!
test02anAddedItemMustBeOnCartList
	
	| cart anItem aCatalogue |

	anItem := Item new.	
	aCatalogue := Catalogue with: (OrderedCollection with: anItem).
	cart := Cart withCatalogue: aCatalogue.
	
	cart addItem: anItem.
	
	self assert: (cart hasItem: anItem).
	
	! !

!CartTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 14:51:49'!
test03anAddedItemToCartBelongsToCatalogue
	
	| cart firstItemOnCatalogue aCatalogue |

	
	firstItemOnCatalogue := Item new.
	aCatalogue := Catalogue with: (OrderedCollection with: firstItemOnCatalogue).
	cart := Cart withCatalogue: aCatalogue.
	
	cart addItem: firstItemOnCatalogue.
	
	self assert: (aCatalogue hasItem: firstItemOnCatalogue).
	self assert: (cart hasItem: firstItemOnCatalogue).
	self assert: cart itemCount = 1.	
	
		
	
! !

!CartTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 14:48:14'!
test04AddedItemsShouldBeInCatalogue
	
	| cart firstItemOnCatalogue aCatalogue itemOutsideCatalogue|
	firstItemOnCatalogue := Item new.
	itemOutsideCatalogue := Item new.
	
	aCatalogue := Catalogue with: (OrderedCollection with: firstItemOnCatalogue).
	cart := Cart withCatalogue: aCatalogue.
	
	cart addItem: firstItemOnCatalogue.
	
	self should: [cart addItem: itemOutsideCatalogue]
	raise: Error 
	withExceptionDo: [:anError |
		Cart cannotAddItemThatDoesNotBelongToCatalogueErrorDescription = anError messageText.
	]! !

!CartTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 14:56:00'!
test05DifferentItemsCanBeAddedToCart
	
	| cart firstItemOnCatalogue secondItemOnCatalogue aCatalogue|
	
	firstItemOnCatalogue := Item new.
	secondItemOnCatalogue := Item new.
	
	aCatalogue := Catalogue with: (OrderedCollection with: firstItemOnCatalogue with: secondItemOnCatalogue).
	cart := Cart withCatalogue: aCatalogue.
	
	cart addItem: firstItemOnCatalogue.
	cart addItem: secondItemOnCatalogue.
	
	self assert: ((cart hasItem: firstItemOnCatalogue) and: (cart hasItem:secondItemOnCatalogue)).
	self assert: cart itemCount = 2.! !

!CartTest methodsFor: 'tests' stamp: 'JIG 5/31/2019 14:57:26'!
test06AnItemCanBeAddedTwice
	
	| cart firstItemOnCatalogue aCatalogue|
	
	firstItemOnCatalogue := Item new.
	
	aCatalogue := Catalogue with: (OrderedCollection with: firstItemOnCatalogue).
	cart := Cart withCatalogue: aCatalogue.
	
	cart addItem: firstItemOnCatalogue.
	cart addItem: firstItemOnCatalogue.
	
	self assert: (cart hasItem: firstItemOnCatalogue).
	self assert: (cart itemQuantity: firstItemOnCatalogue) = 2.! !


!classDefinition: #Cart category: #'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'initialization' stamp: 'JIG 5/31/2019 15:01:45'!
initializeWithCatalogue: aCatalogue
	items := Bag new.
	catalogue := aCatalogue.! !


!Cart methodsFor: 'testing' stamp: 'JIG 5/31/2019 14:18:10'!
hasItem: anItem
	^items includes: anItem.! !

!Cart methodsFor: 'testing' stamp: 'JIG 5/31/2019 14:15:24'!
isEmpty
	^self itemCount = 0.! !

!Cart methodsFor: 'testing' stamp: 'JIG 5/31/2019 14:45:58'!
isInCatalogue: anItem
	^catalogue hasItem: anItem.! !


!Cart methodsFor: 'accessing' stamp: 'JIG 5/31/2019 14:15:43'!
itemCount
	^items size.! !

!Cart methodsFor: 'accessing' stamp: 'JIG 5/31/2019 15:01:36'!
itemQuantity: anItem
	^items occurrencesOf: anItem
	
	! !


!Cart methodsFor: 'operations' stamp: 'JIG 5/31/2019 15:15:49'!
addItem: anItem
	self assertItemIsInCatalogue: anItem.
	items add: anItem.! !


!Cart methodsFor: 'private - errors' stamp: 'JIG 5/31/2019 15:15:49'!
assertItemIsInCatalogue: anItem
	(self isInCatalogue: anItem) ifFalse: [ self error: self class cannotAddItemThatDoesNotBelongToCatalogueErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'errors' stamp: 'JIG 5/31/2019 14:42:40'!
cannotAddItemThatDoesNotBelongToCatalogueErrorDescription
	^'No se puede agregar un item que no pertenece al catalogo!!'.	! !


!Cart class methodsFor: 'instance creation' stamp: 'JIG 5/31/2019 14:48:34'!
withCatalogue: aCatalogue
	^self new initializeWithCatalogue: aCatalogue.! !


!classDefinition: #Catalogue category: #'TusLibros-Ejercicio'!
Object subclass: #Catalogue
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Catalogue methodsFor: 'testing' stamp: 'JIG 5/31/2019 14:36:24'!
hasItem: anItem 
	^items includes: anItem.! !


!Catalogue methodsFor: 'initialization' stamp: 'JIG 5/31/2019 14:35:53'!
initializeWith: anItemList
	items := anItemList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogue class' category: #'TusLibros-Ejercicio'!
Catalogue class
	instanceVariableNames: ''!

!Catalogue class methodsFor: 'instance creation' stamp: 'JIG 5/31/2019 14:35:21'!
with: anItemList 
	^self new initializeWith: anItemList.! !


!classDefinition: #Item category: #'TusLibros-Ejercicio'!
Object subclass: #Item
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!
