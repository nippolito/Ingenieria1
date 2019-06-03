!classDefinition: #CartTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalogueWithOneItem anItemFromCatalogue aSingleCart firstItemOnMultipleCatalogue secondItemOnMultipleCatalogue aMultipleCatalog mixedCart'
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

!CartTest methodsFor: 'tests' stamp: 'JIG 6/3/2019 11:28:07'!
test01cartIsNotEmptyAfterAddingAnItem
	
	aSingleCart addItem: anItemFromCatalogue.
	
	self deny: aSingleCart isEmpty.
	self assert: aSingleCart itemCount equals: 1.
	
	! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/3/2019 11:29:11'!
test02anAddedItemMustBeOnCartList
	
	
	aSingleCart addItem: anItemFromCatalogue .
	
	self assert: (aSingleCart hasItem: anItemFromCatalogue).
	
	! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/3/2019 11:30:27'!
test03anAddedItemToCartBelongsToCatalogue
	
	aSingleCart addItem: anItemFromCatalogue.
	
	self assert: (catalogueWithOneItem hasItem: anItemFromCatalogue).
	self assert: (aSingleCart hasItem: anItemFromCatalogue ).
	self assert: aSingleCart itemCount = 1.	
	
		
	
! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/3/2019 11:31:39'!
test04AddedItemsShouldBeInCatalogue
	| itemOutsideCatalogue |
	
	itemOutsideCatalogue := Item new.
	
	aSingleCart addItem: anItemFromCatalogue.
	
	self should: [aSingleCart addItem: itemOutsideCatalogue]
	raise: Error 
	withExceptionDo: [:anError |
		Cart cannotAddItemThatDoesNotBelongToCatalogueErrorDescription = anError messageText.
	]! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/3/2019 11:34:28'!
test05DifferentItemsCanBeAddedToCart
	
	mixedCart addItem: firstItemOnMultipleCatalogue.
	mixedCart addItem: secondItemOnMultipleCatalogue .
	
	self assert: ((mixedCart hasItem: firstItemOnMultipleCatalogue) and: (mixedCart hasItem: secondItemOnMultipleCatalogue)).
	self assert: mixedCart itemCount = 2.! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/3/2019 11:41:37'!
test06AnItemCanBeAddedSeveralTimes
	mixedCart addItem: firstItemOnMultipleCatalogue withQuantity: 3.
	
	self assert: (mixedCart hasItem: firstItemOnMultipleCatalogue).
	self assert: (mixedCart itemCount = 3).
	self assert: (mixedCart itemQuantity: firstItemOnMultipleCatalogue) = 3.! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/3/2019 11:55:30'!
test07AnItemCannotBeAddedIfQuantityIsNegative

	self should: [ mixedCart addItem: firstItemOnMultipleCatalogue withQuantity: -1]
	raise: Error
	withExceptionDo: [:anError | anError messageText = Cart cannotAddItemIfQuantityIsNotNaturalNumberErrorDescription ].! !

!CartTest methodsFor: 'tests' stamp: 'JIG 6/3/2019 11:55:43'!
test08AnItemCannotBeAddedIfQuantityIsNotAnInteger

	self should: [ mixedCart addItem: firstItemOnMultipleCatalogue withQuantity: 1.5]
	raise: Error
	withExceptionDo: [:anError | anError messageText = Cart cannotAddItemIfQuantityIsNotNaturalNumberErrorDescription ].! !


!CartTest methodsFor: 'setup' stamp: 'JIG 6/3/2019 11:33:38'!
setUp

	anItemFromCatalogue := Item new.
	catalogueWithOneItem := Catalogue with: (OrderedCollection with: anItemFromCatalogue).

	aSingleCart := Cart withCatalogue: catalogueWithOneItem.
	
	firstItemOnMultipleCatalogue := Item new.
	secondItemOnMultipleCatalogue := Item new.
	
	aMultipleCatalog := Catalogue with: (OrderedCollection with: firstItemOnMultipleCatalogue with: secondItemOnMultipleCatalogue).
	mixedCart := Cart withCatalogue: aMultipleCatalog.
	! !


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

!Cart methodsFor: 'operations' stamp: 'JIG 6/3/2019 11:51:43'!
addItem: anItem withQuantity: anItemQuantity
	self assertItemIsInCatalogue: anItem.
	self assertItemQuantityIsNaturalNumber: anItemQuantity.
	items add: anItem withOccurrences: anItemQuantity.! !


!Cart methodsFor: 'private - errors' stamp: 'JIG 5/31/2019 15:15:49'!
assertItemIsInCatalogue: anItem
	(self isInCatalogue: anItem) ifFalse: [ self error: self class cannotAddItemThatDoesNotBelongToCatalogueErrorDescription ].! !

!Cart methodsFor: 'private - errors' stamp: 'JIG 6/3/2019 12:46:57'!
assertItemQuantityIsNaturalNumber: anItemQuantity
	(anItemQuantity > 0 and: [ anItemQuantity isInteger]) 
		ifFalse: [ self error: self class cannotAddItemIfQuantityIsNotNaturalNumberErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'errors' stamp: 'JIG 6/3/2019 11:54:48'!
cannotAddItemIfQuantityIsNotNaturalNumberErrorDescription
	^'Se debe escoger una cantidad entera y positiva de items'.! !

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
