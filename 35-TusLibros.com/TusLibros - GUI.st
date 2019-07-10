!classDefinition: #TusLibrosWindow category: #'TusLibros - GUI'!
Panel subclass: #TusLibrosWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - GUI'!

!TusLibrosWindow methodsFor: 'initialization' stamp: 'Nico 7/9/2019 12:44:40'!
initializeWith: aTitle andModel: aModel

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.! !


!TusLibrosWindow methodsFor: 'setting properties' stamp: 'Nico 7/9/2019 12:27:03'!
setKeyStrokePropertyTo: aTextBox
	aTextBox textMorph setProperty: #keyStroke: toValue: [ :key | aTextBox textMorph acceptContents ].! !

!TusLibrosWindow methodsFor: 'setting properties' stamp: 'Nico 7/9/2019 12:30:03'!
setTextBoxDesignTo: aTextBox
	aTextBox borderWidth: 1; 
		borderColor: Color skyBlue;
	 	morphExtent: (200@30).! !


!classDefinition: #TusLibrosBuyWindow category: #'TusLibros - GUI'!
TusLibrosWindow subclass: #TusLibrosBuyWindow
	instanceVariableNames: 'catalogueList cartList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - GUI'!

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

!TusLibrosBuyWindow methodsFor: 'GUI building' stamp: 'Nico 7/9/2019 12:30:40'!
build2ndColumn2ndRow
	| checkoutButton cardNumberTextBox cardCcedTextBox cardOwnerTextBox secondColumnLayoutOfSecondRow |
	
	checkoutButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendCheckoutRequest  label: 'Make Checkout'.
	
	cardNumberTextBox := TextModelMorph textProvider: self model textGetter: #cardNumberText textSetter: #cardNumberText:. 
	self setKeyStrokePropertyTo: cardNumberTextBox.
	self setTextBoxDesignTo: cardNumberTextBox.
		
	cardCcedTextBox := TextModelMorph textProvider: self model textGetter: #cardCcedText textSetter: #cardCcedText:. 
	self setKeyStrokePropertyTo: cardCcedTextBox.
	self setTextBoxDesignTo: cardCcedTextBox.
		
	cardOwnerTextBox := TextModelMorph textProvider: self model textGetter: #cardOwnerText textSetter: #cardOwnerText:. 
	self setKeyStrokePropertyTo: cardOwnerTextBox.
	self setTextBoxDesignTo: cardOwnerTextBox.	
		
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

!TusLibrosBuyWindow methodsFor: 'GUI building' stamp: 'Nico 7/9/2019 12:31:19'!
build2ndRow
	| secondRowLayout  |
	
	cartList := PluggableListMorph model: self model listGetter: #cartListItems indexGetter: #cartListItemsIndex indexSetter: #cartListItemsIndex:.
	cartList  borderColor: Color skyBlue.
	cartList  borderWidth: 1.
		
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


!TusLibrosBuyWindow methodsFor: 'access' stamp: 'JIG 7/8/2019 16:51:28'!
createCheckoutErrorWindow
	TusLibrosInvalidCheckoutWindow openWith: model.! !

!TusLibrosBuyWindow methodsFor: 'access' stamp: 'Nico 7/10/2019 15:52:20'!
deleteAndOpenCartCreationWindow
	TusLibrosClientWindow open.
	self delete.
! !

!TusLibrosBuyWindow methodsFor: 'access' stamp: 'Nico 7/7/2019 16:01:05'!
refreshCatalogueListIndex
	
	catalogueList setSelectionIndex: 0.
	cartList updateList.! !


!TusLibrosBuyWindow methodsFor: 'initialization' stamp: 'Nico 7/8/2019 12:10:34'!
defaultExtent

	^ 800@600
	! !

!TusLibrosBuyWindow methodsFor: 'initialization' stamp: 'Nico 7/9/2019 12:48:50'!
initializeWith: aTitle andModel: aModel
	
	super initializeWith: aTitle andModel: aModel. 
			
	self model when: #addingItemSuccessfull send: #refreshCatalogueListIndex to: self.
	self model when: #checkoutSuccessful send: #deleteAndOpenCartCreationWindow to: self.
	self model when: #checkoutError send: #createCheckoutErrorWindow to: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosBuyWindow class' category: #'TusLibros - GUI'!
TusLibrosBuyWindow class
	instanceVariableNames: ''!

!TusLibrosBuyWindow class methodsFor: 'instance creation' stamp: 'Nico 7/7/2019 15:22:38'!
openWith: aModel
	
	^self new initializeWith: 'TusLibros - Ventana de compra' andModel: aModel.! !


!classDefinition: #TusLibrosClientWindow category: #'TusLibros - GUI'!
TusLibrosWindow subclass: #TusLibrosClientWindow
	instanceVariableNames: 'substringsList usernameTextBox passwordTextBox'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - GUI'!

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'Nico 7/9/2019 12:31:56'!
build1stRow
	| firstRowLayout |
	
	usernameTextBox := TextModelMorph textProvider: self model textGetter: #usernameText textSetter: #usernameText:. 
	self setKeyStrokePropertyTo: usernameTextBox.
	self setTextBoxDesignTo: usernameTextBox.
	
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 15;
	padding: #left;
	addMorph: (StringMorph contents:'Usuario: ');
	addMorph: usernameTextBox.
	
	^firstRowLayout.! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'Nico 7/9/2019 12:32:25'!
build2ndRow
	| secondRowLayout |
	
	passwordTextBox := TextModelMorph textProvider: self model textGetter: #passwordText textSetter: #passwordText:. 
	self setKeyStrokePropertyTo: passwordTextBox.
	self setTextBoxDesignTo: passwordTextBox.
			
	secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 15;
	padding: #left;
	addMorph: (StringMorph contents:'Password:');
	addMorph: passwordTextBox.
	
	^secondRowLayout.
	
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

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'Nico 7/9/2019 12:49:17'!
initializeWith: aTitle andModel: aModel
	
	super initializeWith: aTitle andModel: aModel. 
			
	self model when: #cartCreationSuccessful send: #createSecondWindow to: self.
	self model when: #invalidAuthentication send: #createInvalidAuthenticationWindow to: self.! !


!TusLibrosClientWindow methodsFor: 'panels-add/remove' stamp: 'JIG 7/8/2019 16:51:55'!
createInvalidAuthenticationWindow
	TusLibrosInvalidAuthenticationWindow open.! !

!TusLibrosClientWindow methodsFor: 'panels-add/remove' stamp: 'Nico 7/8/2019 15:55:14'!
createSecondWindow
	TusLibrosBuyWindow openWith: model.
	self delete.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: #'TusLibros - GUI'!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'instance creation' stamp: 'Nico 7/9/2019 12:40:07'!
open
	
	^self new initializeWith: 'TusLibros - Creacion de carrito' andModel: TusLibrosClientWindowModel new.! !


!classDefinition: #TusLibrosInvalidAuthenticationWindow category: #'TusLibros - GUI'!
TusLibrosWindow subclass: #TusLibrosInvalidAuthenticationWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - GUI'!

!TusLibrosInvalidAuthenticationWindow methodsFor: 'GUI building' stamp: 'asd 7/9/2019 18:49:53'!
build1stRow
	| firstRowLayout |
	
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 15;
	padding: #center;
	addMorph: (StringMorph contents:' Usuario y/o contraseña incorrectos.').
	
	^firstRowLayout.! !

!TusLibrosInvalidAuthenticationWindow methodsFor: 'GUI building' stamp: 'JIG 7/8/2019 16:35:26'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 5;
	addMorph: self build1stRow.
	
	! !


!TusLibrosInvalidAuthenticationWindow methodsFor: 'initialization' stamp: 'JIG 7/8/2019 16:40:39'!
defaultExtent

	^400@300
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInvalidAuthenticationWindow class' category: #'TusLibros - GUI'!
TusLibrosInvalidAuthenticationWindow class
	instanceVariableNames: ''!

!TusLibrosInvalidAuthenticationWindow class methodsFor: 'instance creation' stamp: 'Nico 7/9/2019 12:41:32'!
open
	
	^self new initializeWith: 'Autentificacion invalida' andModel: nil.! !


!classDefinition: #TusLibrosInvalidCheckoutWindow category: #'TusLibros - GUI'!
TusLibrosWindow subclass: #TusLibrosInvalidCheckoutWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - GUI'!

!TusLibrosInvalidCheckoutWindow methodsFor: 'GUI building' stamp: 'asd 7/9/2019 18:50:10'!
build1stRow
	| firstRowLayout |
	
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 15;
	padding: #center;
	addMorph: (StringMorph contents: model checkOutErrorContent ).
	
	^firstRowLayout.! !

!TusLibrosInvalidCheckoutWindow methodsFor: 'GUI building' stamp: 'JIG 7/8/2019 16:53:06'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 5;
	padding: #left;
	addMorph: self build1stRow.
	! !


!TusLibrosInvalidCheckoutWindow methodsFor: 'initialization' stamp: 'JIG 7/10/2019 18:38:06'!
defaultExtent

	^ 500@300
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInvalidCheckoutWindow class' category: #'TusLibros - GUI'!
TusLibrosInvalidCheckoutWindow class
	instanceVariableNames: ''!

!TusLibrosInvalidCheckoutWindow class methodsFor: 'instance creation' stamp: 'JIG 7/8/2019 16:52:21'!
openWith: aModel
	
	^self new initializeWith: 'Checkout invalido' andModel: aModel.! !


!classDefinition: #TusLibrosClientWindowModel category: #'TusLibros - GUI'!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'webClient idCart username password catalogueSelectedIndex catalogueList cartList cartListSelectedIndex cardNumber cardCced cardOwner checkoutErrorContent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - GUI'!

!TusLibrosClientWindowModel methodsFor: 'Cart Creation Window - TextModelMorphSelectors' stamp: 'JIG 7/6/2019 15:58:22'!
passwordText
	
	^password.! !

!TusLibrosClientWindowModel methodsFor: 'Cart Creation Window - TextModelMorphSelectors' stamp: 'JIG 7/6/2019 15:58:18'!
passwordText: aPassword

	password :=aPassword.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'Cart Creation Window - TextModelMorphSelectors' stamp: 'JIG 7/6/2019 15:57:56'!
usernameText
	
	^username.! !

!TusLibrosClientWindowModel methodsFor: 'Cart Creation Window - TextModelMorphSelectors' stamp: 'JIG 7/6/2019 15:58:07'!
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

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'JIG 7/8/2019 16:56:38'!
sendCheckoutRequest
	| transactionID |
	transactionID := webClient sendCheckoutCartRequest: idCart withCardNumber: cardNumber cced: cardCced andOwner: cardOwner ifErrorTo: self.
	
	(self checkIfValidCheckout: transactionID) ifTrue: [
		[self openTranscriptWithClientPurchases] fork.
		self triggerEvent: #checkoutSuccessful with: self.
	].
	
	
! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'JIG 7/8/2019 16:39:03'!
sendCreateCartRequest
		
	idCart := webClient sendCreateCartRequestWithUser: username authenticatedWith: password to: self.
	
	(self wasValidID: idCart) ifTrue: [ self triggerEvent: #cartCreationSuccessful with: self ].
	! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'JIG 7/8/2019 16:58:18'!
sendErrorCheckout: aResponseCheckoutError
	
	checkoutErrorContent := aResponseCheckoutError asString.
	checkoutErrorContent := checkoutErrorContent withoutPrefix: '1|'.
	
	self triggerEvent: #checkoutError with: self.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'JIG 7/8/2019 16:30:37'!
sendEventForIncorrectAuthentication
	self triggerEvent: #invalidAuthentication with: self.! !


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


!TusLibrosClientWindowModel methodsFor: 'Buy Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:04:09'!
cardCcedText
	
	^cardCced
! !

!TusLibrosClientWindowModel methodsFor: 'Buy Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:04:01'!
cardCcedText: aCardCced
	
	cardCced := aCardCced.
	^true! !

!TusLibrosClientWindowModel methodsFor: 'Buy Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:03:09'!
cardNumberText
	
	^cardNumber.! !

!TusLibrosClientWindowModel methodsFor: 'Buy Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:03:47'!
cardNumberText: aCardNumber
	
	cardNumber := aCardNumber.
	^true! !

!TusLibrosClientWindowModel methodsFor: 'Buy Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:04:38'!
cardOwnerText
	
	^ cardOwner
	! !

!TusLibrosClientWindowModel methodsFor: 'Buy Window - TextModelMorphSelectors' stamp: 'Nico 7/8/2019 12:04:44'!
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


!TusLibrosClientWindowModel methodsFor: 'private' stamp: 'JIG 7/8/2019 16:56:56'!
checkIfValidCheckout: transactionID
	^(transactionID = -1) not. ! !

!TusLibrosClientWindowModel methodsFor: 'private' stamp: 'JIG 7/8/2019 16:49:21'!
checkOutErrorContent
	^checkoutErrorContent.! !

!TusLibrosClientWindowModel methodsFor: 'private' stamp: 'JIG 7/8/2019 16:39:23'!
wasValidID: aCartID
	^(aCartID = -1) not! !


!classDefinition: #TusLibrosWebClient category: #'TusLibros - GUI'!
Object subclass: #TusLibrosWebClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - GUI'!

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/9/2019 11:42:01'!
checkoutCartHttpRequestFor: aCartID card: aCreditCardNumber expDate: anExpirationDate owner: anOwner
	^self url, '/checkOutCart?cartId=', aCartID, '&cnn=',  aCreditCardNumber, '&cced=', anExpirationDate, '&cco=', anOwner! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/9/2019 11:45:08'!
createAddToCartHttpRequestFor: aCartID book: anItem quantity: anAmount
	^ self url, '/addToCart?cartId=', aCartID, '&bookIsbn=', anItem ,'&bookQuantity=', anAmount asString! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/9/2019 11:45:17'!
createCartHttpRequestFor: anUserID authenticatingWith: aPassword
	^ self url, '/createCart?clientId=', anUserID ,'&password=', aPassword.
	! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/9/2019 11:45:23'!
listCartHttpRequestFor: aCartID
	^ self url, '/listCart?cartId=', aCartID! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/9/2019 11:45:28'!
listCatalogueHttpRequest
	^ self url, '/listCatalogue'! !

!TusLibrosWebClient methodsFor: 'http request' stamp: 'Nico 7/9/2019 11:45:33'!
listPurchasesHttpRequestFor: anUserID authenticatingWith: aPassword
	^self url, '/listPurchases?clientId=', anUserID, '&password=', aPassword
	
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

!TusLibrosWebClient methodsFor: 'parsing' stamp: 'Nico 7/9/2019 11:47:53'!
parseCartListingToOrderedCollection: aListCartResponseContent
	| collection |
	
	collection := self convertCartResponseToOrderedCollection: aListCartResponseContent. 
	
	^ collection select: [:anElement | anElement first digitValue = -1]! !

!TusLibrosWebClient methodsFor: 'parsing' stamp: 'Nico 7/9/2019 11:48:03'!
parseCatalogueToOrderedCollection: aCatalogueResponseContent
	| collection |
	
	collection := self removeBarsAndConvertToOrderedCollection: aCatalogueResponseContent.
	
	collection removeFirst.
	
	^collection.! !


!TusLibrosWebClient methodsFor: 'parsing - private' stamp: 'Nico 7/9/2019 12:17:28'!
convertCartResponseToOrderedCollection: aListCartResponseContent
	| collection listCartResponseString firstBar |
	
	collection := OrderedCollection new.
	listCartResponseString := aListCartResponseContent asString.
	listCartResponseString := listCartResponseString withoutPrefix: '0|'.
	
	"firstBar := listCartResponseString ifNotNil: [listCartResponseString findFirst: [:aChar | aChar = $|]]."
	firstBar := listCartResponseString findFirst: [:aChar | aChar = $|].
	[firstBar > 0] whileTrue: 
	[ 
		listCartResponseString := self parsedStringAfterAddingWordAmountTimesFrom: listCartResponseString thatEndsOn: firstBar to: collection.
		firstBar := listCartResponseString findFirst: [:aChar | aChar = $|].	
	].
	
	^collection.! !

!TusLibrosWebClient methodsFor: 'parsing - private' stamp: 'Nico 7/9/2019 12:17:28'!
parsedStringAfterAddingWordAmountTimesFrom: aResponseString thatEndsOn: aPositionToEnd to: aCollectionToAdd

	| wordToAdd finalResponseString nextBar amountToAdd |
	
	wordToAdd := aResponseString copyFrom: 1 to: aPositionToEnd - 1.
	finalResponseString := aResponseString withoutPrefix: (aResponseString copyFrom: 1 to: aPositionToEnd).
	nextBar := finalResponseString findFirst: [:aChar | aChar = $|].
	amountToAdd := (finalResponseString copyFrom: 1 to: nextBar - 1) asNumber.
	amountToAdd timesRepeat: [
		aCollectionToAdd add: wordToAdd.	
	].
	finalResponseString := finalResponseString withoutPrefix: (finalResponseString copyFrom: 1 to: nextBar).
	
	^finalResponseString.! !

!TusLibrosWebClient methodsFor: 'parsing - private' stamp: 'Nico 7/9/2019 12:20:35'!
parsedStringAfterAddingWordFrom: aResponseString thatEndsOn: aPositionToEnd to: aCollection
	| wordToAdd finalString |
	
	wordToAdd := aResponseString copyFrom: 1 to: aPositionToEnd - 1.
	aCollection add: wordToAdd.
	finalString := aResponseString withoutPrefix: (aResponseString copyFrom: 1 to: aPositionToEnd).
	
	^ finalString
	
	! !

!TusLibrosWebClient methodsFor: 'parsing - private' stamp: 'Nico 7/9/2019 12:20:24'!
removeBarsAndConvertToOrderedCollection: aCatalogueResponseContent
	| collection catalogueResponseString firstBar |
	
	collection := OrderedCollection new.
	catalogueResponseString := aCatalogueResponseContent asString.
	
	firstBar := catalogueResponseString findFirst: [:aChar | aChar = $|].
	[firstBar > 0] whileTrue: 
	[
		catalogueResponseString := self parsedStringAfterAddingWordFrom: catalogueResponseString thatEndsOn: firstBar to: collection.
		firstBar := catalogueResponseString findFirst: [:aChar | aChar = $|].	
	].
	
	^collection.! !


!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/10/2019 15:55:41'!
sendCartAddingRequestToCart: aCartID WithItem: anItem
	| responseAddItem addItemRequest |
	
	addItemRequest := self createAddToCartHttpRequestFor: aCartID book: anItem quantity: 1.
	
	responseAddItem := PolymorphicFuture of: [WebClient httpGet: addItemRequest].

	(self isSuccess: responseAddItem content)
		ifTrue:[^responseAddItem content] 
		ifFalse:[^self error: responseAddItem content].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/10/2019 15:55:59'!
sendCheckoutCartRequest: aCartID withCardNumber: cardNumber cced: cardCced andOwner: cardOwner 
	ifErrorTo: aWindowModel
	| cartIDEncodedString cardNumberEncodedString checkoutCartRequest responseCheckoutCart cardCcedEncodedString cardOwnerEncodedString |
	
	cartIDEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: aCartID) asString.
	cardNumberEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: cardNumber) asString .
	cardCcedEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: cardCced) asString.
	cardOwnerEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: cardOwner) asString.
	
	checkoutCartRequest := self checkoutCartHttpRequestFor: cartIDEncodedString card: cardNumberEncodedString expDate: cardCcedEncodedString owner: cardOwnerEncodedString.
	
	responseCheckoutCart := PolymorphicFuture of: [WebClient httpGet: checkoutCartRequest].

	(self isSuccess: responseCheckoutCart content)
		ifTrue:[^responseCheckoutCart content] 
		ifFalse:[aWindowModel sendErrorCheckout: (responseCheckoutCart content) .^-1].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/10/2019 15:56:14'!
sendCreateCartRequestWithUser: username authenticatedWith: password to: aWindowModel
	| usernameEncodedString passwordEncodedString createCartRequest responseCreateCart |
	
	usernameEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: username) asString.
	passwordEncodedString := (self correctlyEncodeSpacesForUrlRequestParameter: password) asString .
	
	createCartRequest := self createCartHttpRequestFor: usernameEncodedString authenticatingWith: passwordEncodedString.
	
	responseCreateCart := PolymorphicFuture of: [WebClient httpGet: createCartRequest].

	(self isSuccess: responseCreateCart content)
		ifTrue:[^self getCartIdOfResponse: responseCreateCart content] 
		ifFalse:[aWindowModel sendEventForIncorrectAuthentication. ^-1].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/10/2019 15:56:22'!
sendListCartRequest: aCartID
	| responseListCart listCartRequest |
	
	listCartRequest := self listCartHttpRequestFor: aCartID.
	
	responseListCart := PolymorphicFuture of: [WebClient httpGet: listCartRequest].
	
	(self isSuccess: responseListCart content)
		ifTrue:[^self parseCartListingToOrderedCollection: responseListCart content] 
		ifFalse:[^self error: responseListCart content].! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'Nico 7/10/2019 15:56:33'!
sendListCatalogueRequest
	| listCatalogueRequest responseListCatalogue |
	
	listCatalogueRequest := self listCatalogueHttpRequest.
	
	responseListCatalogue := PolymorphicFuture of: [WebClient httpGet: listCatalogueRequest].

	(self isSuccess: responseListCatalogue content)
		ifTrue:[^self parseCatalogueToOrderedCollection: responseListCatalogue content] 
		ifFalse:[^self error: responseListCatalogue content].! !


!TusLibrosWebClient methodsFor: 'testing responses' stamp: 'JIG 7/6/2019 16:39:33'!
isSuccess: responseContent
	^((responseContent at: 1) = $1) not.! !


!classDefinition: #PolymorphicFuture category: #'TusLibros - GUI'!
ProtoObject subclass: #PolymorphicFuture
	instanceVariableNames: 'readySemaphore value ready'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - GUI'!

!PolymorphicFuture methodsFor: 'initialization' stamp: 'HAW 7/10/2019 15:25:37'!
initializeOf: aBlock

	readySemaphore := Semaphore new.
	ready := false.
	
	[ value := aBlock value.
	ready := true.
	readySemaphore signal ] fork.
	! !


!PolymorphicFuture methodsFor: 'evaluating' stamp: 'HAW 7/10/2019 15:25:49'!
value

	ready ifFalse: [ readySemaphore wait ].
	^value! !


!PolymorphicFuture methodsFor: 'message forwarding' stamp: 'HernanWilkinson 9/13/2016 19:03'!
doesNotUnderstand: aMessage

	^aMessage sendTo: self value ! !


!PolymorphicFuture methodsFor: 'object protocol' stamp: 'HAW 8/13/2017 18:12:56'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!PolymorphicFuture methodsFor: 'object protocol' stamp: 'HAW 5/12/2019 19:41:48'!
instVarAt: index
	"Primitive. Answer a fixed variable in an object. The numbering of the variables
	 corresponds to the named instance variables, followed by the indexed instance
	 variables. Fail if the index is not an Integer or is not the index of a fixed variable.
	 Essential. See Object documentation whatIsAPrimitive."

	<primitive: 173 error: ec>
	"The classic InterpreterVMs don't support primitives 173 and 174.
	See http://forum.world.st/Some-test-where-Spur-more-slow-than-Cog-td4867810.html#a4867888
	Use primitives 73 and 74 in such case."
	Smalltalk isRunningCog ifFalse: [
		^ self instVarAtPrim73: index ].
	self primitiveFailed! !

!PolymorphicFuture methodsFor: 'object protocol' stamp: 'HAW 8/13/2017 18:12:37'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	self primitiveFailed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PolymorphicFuture class' category: #'TusLibros - GUI'!
PolymorphicFuture class
	instanceVariableNames: ''!

!PolymorphicFuture class methodsFor: 'instance creation' stamp: 'HAW 5/12/2019 19:37:15'!
of: aBlock

	 ^self new initializeOf: aBlock! !
