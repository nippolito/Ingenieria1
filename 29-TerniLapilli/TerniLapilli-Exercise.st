!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 18:54:20'!
test01AfterFirstCrossACircleShouldBePlacedNext
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	self assert: (miTerniLapilli at: (2@2)) = #Cross.
	self assert: miTerniLapilli isOver not.
	self assert: miTerniLapilli nextPieceToBePlaced = #Circle.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 18:53:14'!
test02CannotPutCrossesTwiceInARow
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	self assert: miTerniLapilli isOver not.
	self should: [ miTerniLapilli putCrossOn: (2@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutTheSamePieceTwiceErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 18:53:31'!
test03CannotPutCirclesTwiceInARow
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (2@1).
		
	self assert: miTerniLapilli isOver not.
	self should: [ miTerniLapilli putCircleOn: (2@3)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutTheSamePieceTwiceErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 18:54:06'!
test04AfterFirstCircleACrossShouldBePlacedNext
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (1@2).
	
	self assert: miTerniLapilli isOver not.
	self assert: miTerniLapilli nextPieceToBePlaced = #Cross.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 18:55:34'!
test05CannotPutMoreThanThreeCrosses
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (3@2).
	miTerniLapilli putCrossOn: (1@2).
	miTerniLapilli putCircleOn: (3@3).
	miTerniLapilli putCrossOn: (2@3).
	miTerniLapilli putCircleOn: (2@1).
	
	self assert: miTerniLapilli isOver not.
	self should: [ miTerniLapilli putCrossOn: (1@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutMoreThanThreeOfTheSamePieceErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 18:58:08'!
test07CannotPutACircleOnAnOccupiedPosition
	"Arrancamos con el tablero"
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	self should: [ miTerniLapilli putCircleOn: (2@2)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutPieceOnAnOcuppiedPositionErrorDescription = anError messageText].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 18:58:20'!
test08CannotPutACrossOnAnOccupiedPosition
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (2@1).
	
	self should: [ miTerniLapilli putCrossOn: (2@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutPieceOnAnOcuppiedPositionErrorDescription = anError messageText].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 18:59:48'!
test09ComplettingFirstHorizontalLineWithSamePieceFinishesGameWithThatPieceAsWinner
	"Empezamos con cómo ganar, chequeamos horizontal"
	"Debiéramos chequear solo la primer linea, y en realidad en test10 chequear la segunda linea (simulando que después hicimos el refactor y ahí nos dimos cuenta que es el mismo chequeo. Ya para vertical y diagonal nos dimos cuenta, entonces sólo hacemos un test para vertical y un test para diagonal. Tenemos que modificar esto."
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@2).
	
	miTerniLapilli putCircleOn: (2@2).
	miTerniLapilli putCrossOn: (1@1).
	miTerniLapilli putCircleOn: (3@2).
	miTerniLapilli putCrossOn: (1@3).
	
	self assert: miTerniLapilli isOver.
	self assert: miTerniLapilli winner = #Cross.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 19:00:09'!
test10ComplettingOtherHorizontalLineWithSamePieceFinishesGameWithThatPieceAsWinner
	"Empezamos con cómo ganar, chequeamos segunda linea horizontal"
	"Debiéramos chequear solo la primer linea, y en realidad en test10 chequear la segunda linea (simulando que después hicimos el refactor y ahí nos dimos cuenta que es el mismo chequeo. Ya para vertical y diagonal nos dimos cuenta, entonces sólo hacemos un test para vertical y un test para diagonal. Tenemos que modificar esto."
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@1).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@3).
	
	self assert: miTerniLapilli isOver.
	self assert: miTerniLapilli winner = #Cross.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 19:00:23'!
test11ComplettingAVerticalLineWithSamePieceFinishesGameWithThatPieceAsWinner
	"Empezamos con cómo ganar, chequeamos vertical"
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (1@2).
	miTerniLapilli putCircleOn: (3@3).
	miTerniLapilli putCrossOn: (3@2).
	
	self assert: miTerniLapilli isOver.
	self assert: miTerniLapilli winner = #Cross.
	
	"
	slidePiece: towards:
	Hay que testear posteriormente que por ejemplo círculo no puede jugar si cruz ganó.
	Luego de esto, sliding.
	Previo a sliding nos falta chequear que no podamos poner cosas en posiciones inválidas
	Quizás también debiéramos refactorizar los tests para usar el putPiece:on: en lugar de putCircleOn y putCrossOn"
	
	"Entrega es el lunes al final

	Para Sliding:
	> Separar por cosas positivas (primero) y negativas (segundo).
	> Positiva: SlidX --> AllPiecesInBoard (o sea, tienen que estar todas las piezas ocupadas)
		- SlideX --> Win
	> Negativa: 
		- Deslizar a una posición ilegal
		- Deslizar a una posición ya ocupada
		- Deslizar una pieza que no tenés, etc
		
		Y el último tip sobre sliding: en negativa hay que chequear: que no se pueda slidex cuando estás en playing X (error) - no podés slidex cuando haces slideO (o sea, chequear el orden de los slides) - no slide posiciones vacías o tomadas - etc"
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 19:00:35'!
test12ComplettingADiagonalLineWithSamePieceFinishesGameWithThatPieceAsWinner
	"Empezamos con cómo ganar, chequeamos diagonal"
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@2).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (1@3).
	miTerniLapilli putCircleOn: (2@2).
	miTerniLapilli putCrossOn: (3@2).
	miTerniLapilli putCircleOn: (3@3).
	
	self assert: miTerniLapilli isOver.
	self assert: miTerniLapilli winner = #Circle.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 19:01:20'!
test13CannotPlaceAPieceIfGameIsOver
	"Chequeamos que no se puede colocar una pieza cuando el juego esta terminado"
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (1@2).
	miTerniLapilli putCircleOn: (3@3).
	miTerniLapilli putCrossOn: (3@2).
	
	self should: [miTerniLapilli putCircleOn: (2@1).] 
	raise: Error  
	withExceptionDo: [:anError|
			self assert: anError messageText = TerniLapilli cannotPlacePieceWhenTheGameIsOverErrorDescription.
			self assert: miTerniLapilli isOver.
			self assert: miTerniLapilli winner = #Cross.
	].

	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 19:01:12'!
test14CannotPlaceAPieceOutsideOfBoardRange
	"Chequeamos que no se puede colocar una pieza fuera del rango del tablero"
	
	|miTerniLapilli|
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	self should: [miTerniLapilli putCircleOn: (50@50).] 
	raise: Error  
	withExceptionDo: [:anError|
			self assert: anError messageText = TerniLapilli cannotPlacePieceOnAnInvalidPositionErrorDescription.
	].

	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 19:01:38'!
test15CanSlideHorizontally
	"Una vez colocadas las piezas, probamos que se pueda deslizar HORIZONTALMENTE una pieza hacia una posicion correcta"
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@2).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (1@3).
	miTerniLapilli putCircleOn: (2@2).
	miTerniLapilli putCrossOn: (3@2).
	miTerniLapilli putCircleOn: (2@3).
	
	miTerniLapilli slideCrossFrom: (3@2) towards: (3@1).	
	
	self assert: miTerniLapilli isOver not.
	self assert: ((miTerniLapilli at: (3@1)) = #Cross).
	self assert: ((miTerniLapilli at: (3@2)) = #Empty).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 19:01:46'!
test16CanSlideVertically
	"Una vez colocadas las piezas, probamos que se pueda deslizar VERTICALMENTE una pieza hacia una posicion correcta"
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@2).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (1@3).
	miTerniLapilli putCircleOn: (2@2).
	miTerniLapilli putCrossOn: (3@1).
	miTerniLapilli putCircleOn: (2@3).
	
	miTerniLapilli slideCrossFrom: (3@1) towards: (2@1).
	
	self assert: miTerniLapilli isOver not.
	self assert: ((miTerniLapilli at: (2@1)) = #Cross).
	self assert: ((miTerniLapilli at: (3@1)) = #Empty).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/23/2019 19:01:54'!
test17CanSlideDiagonally
	"Una vez colocadas las piezas, probamos que se pueda deslizar DIAGONALMENTE una pieza hacia una posicion correcta"
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@2).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (1@3).
	miTerniLapilli putCircleOn: (2@2).
	miTerniLapilli putCrossOn: (3@1).
	miTerniLapilli putCircleOn: (2@3).
	
	miTerniLapilli slideCrossFrom: (1@2) towards: (2@1).
	
	self assert: miTerniLapilli isOver not.
	self assert: ((miTerniLapilli at: (2@1)) = #Cross).
	self assert: ((miTerniLapilli at: (1@2)) = #Empty).! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board lastPiecePlaced numberOfPieces finished winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'operations' stamp: 'JIG 5/21/2019 15:00:07'!
changeGameStateIfFinished
	self changeGameStateIfFinishedByHorizontalLine.
	self changeGameStateIfFinishedByVerticalLine.
	self changeGameStateIfFinishedByDiagonalLine.
! !

!TerniLapilli methodsFor: 'operations' stamp: 'Nipo 5/23/2019 18:38:51'!
putCircleOn: aPosition
	self putPiece: #Circle on: aPosition.

	! !

!TerniLapilli methodsFor: 'operations' stamp: 'Nipo 5/23/2019 18:37:05'!
putCrossOn: aPosition
	self putPiece: #Cross on: aPosition.

	! !

!TerniLapilli methodsFor: 'operations' stamp: 'Nipo 5/23/2019 18:47:26'!
slideCircleFrom: aPosition towards: anotherPosition
	self slidePiece: #Circle from: aPosition towards: anotherPosition.

! !

!TerniLapilli methodsFor: 'operations' stamp: 'Nipo 5/23/2019 18:47:18'!
slideCrossFrom: aPosition towards: anotherPosition
	self slidePiece: #Cross from: aPosition towards: anotherPosition.

! !


!TerniLapilli methodsFor: 'initialization' stamp: 'Nipo 5/20/2019 20:53:54'!
createBoard
	board := OrderedCollection new. 
	board addAll: #(#Empty #Empty #Empty #Empty #Empty #Empty #Empty #Empty #Empty).! !

!TerniLapilli methodsFor: 'initialization' stamp: 'Nipo 5/23/2019 18:39:40'!
initializeWithCrossOn: aPosition
	self initializePieceCount.
	finished := false.
	self createBoard.
	self putCrossOn: aPosition.! !


!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:02:32'!
changeGameStateIfFinishedByDiagonalForPiece: aPlayer	
	| diagonalFirstColumn diagonalSecondColumn|
	
	diagonalFirstColumn := OrderedCollection new.
	diagonalSecondColumn := OrderedCollection new.
	
	diagonalFirstColumn add: (board at: 1).
	diagonalFirstColumn add: (board at: 5).
	diagonalFirstColumn add: (board at: 9).
	diagonalSecondColumn add: (board at: 3).
	diagonalSecondColumn add: (board at: 5).
	diagonalSecondColumn add: (board at: 7).
	
	(diagonalFirstColumn occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
	(diagonalSecondColumn occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:02:32'!
changeGameStateIfFinishedByDiagonalLine	
	
	self changeGameStateIfFinishedByDiagonalForPiece: #Cross.
	self changeGameStateIfFinishedByDiagonalForPiece: #Circle.
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:02:54'!
changeGameStateIfFinishedByHorizontalForPiece: aPlayer
	((board copyFrom: 1 to: 3) occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
	((board copyFrom: 4 to: 6) occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
	((board copyFrom: 7 to: 9) occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:02:54'!
changeGameStateIfFinishedByHorizontalLine
	self changeGameStateIfFinishedByHorizontalForPiece: #Cross.
	self changeGameStateIfFinishedByHorizontalForPiece: #Circle.	
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:03:19'!
changeGameStateIfFinishedByVerticalForPiece: aPlayer	
	| verticalFirstColumn verticalSecondColumn verticalThirdColumn|
	
	verticalFirstColumn := OrderedCollection new.
	verticalSecondColumn := OrderedCollection new.
	verticalThirdColumn := OrderedCollection new.
	verticalFirstColumn add: (board at: 1).
	verticalFirstColumn add: (board at: 4).
	verticalFirstColumn add: (board at: 7).
	verticalSecondColumn add: (board at: 2).
	verticalSecondColumn add: (board at: 5).
	verticalSecondColumn add: (board at: 8).
	verticalThirdColumn add: (board at: 3).
	verticalThirdColumn add: (board at: 6).
	verticalThirdColumn add: (board at: 9).
	
	(verticalFirstColumn occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
	(verticalSecondColumn occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
	(verticalThirdColumn occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:03:19'!
changeGameStateIfFinishedByVerticalLine	
	
	self changeGameStateIfFinishedByVerticalForPiece: #Cross.
	self changeGameStateIfFinishedByVerticalForPiece: #Circle.
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:28:07'!
errorIfAPieceIsPlacedTwiceInARow: aPiece.
	lastPiecePlaced = aPiece ifTrue: [^self error: TerniLapilli cannotPutTheSamePieceTwiceErrorDescription].
	! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:29:24'!
errorIfMoreThanThreeOfTheSamePieceArePlaced: aPiece
	(numberOfPieces at: aPiece) = 3 ifTrue: [^self error: TerniLapilli cannotPutMoreThanThreeOfTheSamePieceErrorDescription ].
	numberOfPieces at: aPiece put: ((numberOfPieces at: aPiece) + 1).
	! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:54:48'!
errorIfPlacingAPieceOnAnInvalidPosition: aPosition
	((aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3)) ifFalse: [self error: TerniLapilli cannotPlacePieceOnAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:49:01'!
errorIfPlacingAPieceWhenGameIsOver
	self isOver ifTrue: [self error: TerniLapilli cannotPlacePieceWhenTheGameIsOverErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:18:40'!
errorIfPositionIsOccupied: aPosition
	((self at: aPosition) = #Empty) ifFalse: [^self error: TerniLapilli cannotPutPieceOnAnOcuppiedPositionErrorDescription].
	
	! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:37:48'!
initializePieceCount 
	numberOfPieces := Dictionary new.
	numberOfPieces at: #Cross put: 0.
	numberOfPieces at: #Circle put: 0.
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:33:06'!
placePieceOnBoard: aPiece at: aPosition
	board at: (aPosition x - 1 * 3 + aPosition y) put: aPiece. 

	! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:55:29'!
putPiece: aPiece on: aPosition
	self errorIfPlacingAPieceOnAnInvalidPosition: aPosition.
	self errorIfPlacingAPieceWhenGameIsOver.
	self errorIfPositionIsOccupied: aPosition.
	self errorIfAPieceIsPlacedTwiceInARow: aPiece.	
	self errorIfMoreThanThreeOfTheSamePieceArePlaced: aPiece.
	
	lastPiecePlaced := aPiece.
	self placePieceOnBoard: aPiece at: aPosition.
	self changeGameStateIfFinished.

	! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 16:24:27'!
slidePiece: aPiece from: aPosition towards: anotherPosition 
	self placePieceOnBoard: aPiece at: anotherPosition.
	board at: (aPosition x - 1 * 3 + aPosition y) put: #Empty.

! !


!TerniLapilli methodsFor: 'accessing' stamp: 'Nipo 5/20/2019 20:56:41'!
at: aPosition
	|positionOnBoard|
	
	positionOnBoard := (aPosition x - 1 * 3) + aPosition y.
	^ board at: positionOnBoard.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'Nipo 5/20/2019 20:23:30'!
winner
	^winner.! !


!TerniLapilli methodsFor: 'testing' stamp: 'Nipo 5/20/2019 18:34:09'!
nextPieceToBePlaced
	lastPiecePlaced = #Cross ifTrue: [^#Circle].
	^#Cross! !


!TerniLapilli methodsFor: 'assertions' stamp: 'Nipo 5/20/2019 20:21:20'!
isOver
	^finished! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'initialization' stamp: 'Nipo 5/20/2019 19:33:31'!
startWithCrossOn: aPosition
	^ self new initializeWithCrossOn: aPosition.! !


!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/21/2019 15:52:14'!
cannotPlacePieceOnAnInvalidPositionErrorDescription
	^'No se puede colocar una pieza en una posicion invalida.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/21/2019 15:45:52'!
cannotPlacePieceWhenTheGameIsOverErrorDescription
	^'No se puede colocar una pieza si el juego ya termino!!'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'Nipo 5/20/2019 18:44:35'!
cannotPutMoreThanThreeCirclesErrorDescription
	^'No se pueden poner más de tres círculos'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'Nipo 5/20/2019 18:39:04'!
cannotPutMoreThanThreeCrossesErrorDescription
	^'No se pueden poner más de tres cruces'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/21/2019 15:18:18'!
cannotPutMoreThanThreeOfTheSamePieceErrorDescription
	^'No se pueden poner más de tres piezas del mismo tipo.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/21/2019 15:18:40'!
cannotPutPieceOnAnOcuppiedPositionErrorDescription
	^'No se puede colocar una pieza en una posición ocupada'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/21/2019 15:18:50'!
cannotPutTheSamePieceTwiceErrorDescription
	^'No se puede colocar la misma pieza dos veces consecutivas'! !
