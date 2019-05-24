!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 13:50:34'!
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

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 13:52:27'!
test06CannotInitializeGamePlacingACrossOnAnInvalidPosition
	self should: [TerniLapilli startWithCrossOn: (10@-10).] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPlacePieceOnAnInvalidPositionErrorDescription = anError messageText].! !

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

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 14:17:01'!
test18CanWinAfterSliding
	"Una vez colocadas las piezas, probamos que se pueda deslizar DIAGONALMENTE una pieza hacia una posicion correcta"
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@3).
	miTerniLapilli putCrossOn: (2@3).
	miTerniLapilli putCircleOn: (3@1).
	
	miTerniLapilli slideCrossFrom: (2@3) towards: (3@3).
	
	self assert: miTerniLapilli isOver.
	self assert: miTerniLapilli winner = #Cross.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 15:00:50'!
test19CannotSlideOnAnInvalidPosition
	"Una vez colocadas las piezas, probamos que no se pueda deslizar una pieza a una posicion incorrecta"
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@3).
	miTerniLapilli putCrossOn: (2@3).
	miTerniLapilli putCircleOn: (3@1).
	
	
	self should: [miTerniLapilli slideCrossFrom: (2@3) towards: (2@4).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceOnAnInvalidPositionErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 14:23:44'!
test20CannotSlideOnAnOccupiedPosition
	"Una vez colocadas las piezas, probamos que no se pueda deslizar una pieza a una posicion que esta siendo ocupada"
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@3).
	miTerniLapilli putCrossOn: (2@3).
	miTerniLapilli putCircleOn: (3@1).
	
	
	self should: [miTerniLapilli slideCrossFrom: (2@3) towards: (2@2).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceOnAnOcuppiedPositionErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 14:28:21'!
test21CannotSlideAPieceThatIsNotYours
	"Una vez colocadas las piezas, probamos que no se pueda deslizar una pieza a una posicion que esta siendo ocupada"
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@3).
	miTerniLapilli putCrossOn: (2@3).
	miTerniLapilli putCircleOn: (3@1).
	
	
	self should: [miTerniLapilli slideCrossFrom: (3@1) towards: (3@2).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceThatIsNotYoursErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 14:34:37'!
test22CannotSlideToALocationThatNeedsToGoThroughMoreThanOnePosition
	"Una vez colocadas las piezas, probamos que no se pueda deslizar una pieza a una posicion que esta siendo ocupada"
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@3).
	miTerniLapilli putCrossOn: (2@3).
	miTerniLapilli putCircleOn: (3@2).
	
	self should: [miTerniLapilli slideCrossFrom: (1@1) towards: (3@1).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlideToAnUnreachablePositionErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 14:46:45'!
test23CannotSlideIfGameIsFinished
	"Una vez colocadas las piezas, probamos que no se pueda deslizar una pieza tras haber finalizado el juego."
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@3).
	miTerniLapilli putCrossOn: (2@3).
	miTerniLapilli putCircleOn: (3@1).
	
	miTerniLapilli slideCrossFrom: (1@1) towards: (2@1).
	
	self should: [miTerniLapilli slideCircleFrom: (3@1) towards: (3@2)]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceWhenGameIsFinishedErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 15:01:22'!
test24CannotSlideWhenStillPlacingPieces
	"Una vez colocadas las piezas, probamos que no se pueda deslizar "
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@3).
	miTerniLapilli putCrossOn: (2@3).
	
	self should: [miTerniLapilli slideCircleFrom: (1@2) towards: (2@1).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceWhenStillPlacingPiecesErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 14:58:11'!
test25CannotSlideCrossWhenItIsNotCrossTurn
	"Una vez colocadas las piezas, probamos que no se pueda deslizar una pieza tras haber finalizado el juego."
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@3).
	miTerniLapilli putCrossOn: (2@3).
	miTerniLapilli putCircleOn: (3@1).
	
	miTerniLapilli slideCrossFrom: (2@3) towards: (3@2).
	
	self should: [miTerniLapilli slideCrossFrom: (1@1) towards: (2@1).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceWhenIsNotYourTurnErrorDescription = anError messageText 
	].
	! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board numberOfPieces turn lastPieceTurn phase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'operations' stamp: 'JIG 5/21/2019 15:00:07'!
changeGameStateIfFinished
	self changeGameStateIfFinishedByHorizontalLine.
	self changeGameStateIfFinishedByVerticalLine.
	self changeGameStateIfFinishedByDiagonalLine.
! !

!TerniLapilli methodsFor: 'operations' stamp: 'JIG 5/24/2019 16:16:49'!
changeGameStateIfPlacingIsOver
	((numberOfPieces at: #Cross) = 3 and: (numberOfPieces at: #Circle) = 3) ifTrue: [
		phase := SlidingTerniLapilliPhase for: self.
	].
	"Si if, pero no state"
! !

!TerniLapilli methodsFor: 'operations' stamp: 'JIG 5/24/2019 16:16:49'!
changeStateToFinishedWithWinner: aPlayer
	phase := FinishedTerniLapilliPhase for: self andWinner: aPlayer.
	! !

!TerniLapilli methodsFor: 'operations' stamp: 'JIG 5/24/2019 16:19:31'!
putCircleOn: aPosition
	turn errorIfACircleIsPlacedTwiceInARow.
	self putPiece: #Circle on: aPosition.
	turn := CrossTurn for: self.

	! !

!TerniLapilli methodsFor: 'operations' stamp: 'JIG 5/24/2019 16:21:08'!
putCrossOn: aPosition
	turn errorIfACrossIsPlacedTwiceInARow.
	self putPiece: #Cross on: aPosition.
	turn := CircleTurn for: self.

	! !

!TerniLapilli methodsFor: 'operations' stamp: 'JIG 5/24/2019 16:33:31'!
slideCircleFrom: aPosition towards: anotherPosition
	turn errorIfSlidingCircleWhenIsNotYourTurn.
	self slidePiece: #Circle from: aPosition towards: anotherPosition.
	turn := CrossTurn for: self.

! !

!TerniLapilli methodsFor: 'operations' stamp: 'JIG 5/24/2019 16:33:37'!
slideCrossFrom: aPosition towards: anotherPosition
	turn errorIfSlidingCrossWhenIsNotYourTurn.
	self slidePiece: #Cross from: aPosition towards: anotherPosition.
	turn := CircleTurn for: self.

! !


!TerniLapilli methodsFor: 'initialization' stamp: 'Nipo 5/20/2019 20:53:54'!
createBoard
	board := OrderedCollection new. 
	board addAll: #(#Empty #Empty #Empty #Empty #Empty #Empty #Empty #Empty #Empty).! !

!TerniLapilli methodsFor: 'initialization' stamp: 'JIG 5/24/2019 16:24:40'!
initializeWithCrossOn: aPosition
	self initializePieceCount.
	phase := PlacingTerniLapilliPhase for: self.
	self createBoard.
	turn := CrossTurn for: self.
	self putCrossOn: aPosition.! !


!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 14:04:33'!
errorIfAPieceIsPlacedTwiceInARow: aPiece.
	lastPieceTurn = aPiece ifTrue: [^self error: self class cannotPutTheSamePieceTwiceErrorDescription].
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 13:48:44'!
errorIfMoreThanThreeOfTheSamePieceArePlaced: aPiece
	(numberOfPieces at: aPiece) = 3 ifTrue: [^self error: self class cannotPutMoreThanThreeOfTheSamePieceErrorDescription ].
	numberOfPieces at: aPiece put: ((numberOfPieces at: aPiece) + 1).
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 13:48:53'!
errorIfPlacingAPieceOnAnInvalidPosition: aPosition
	((aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3)) ifFalse: [self error: self class cannotPlacePieceOnAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 16:16:49'!
errorIfPlacingAPieceWhenGameIsOver
	^phase errorIfPlacingWhenIsOver.
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 14:25:26'!
errorIfPlacingOnAnOccupiedPosition: aPosition
	((self at: aPosition) = #Empty) ifFalse: [^self error: self class cannotPutPieceOnAnOcuppiedPositionErrorDescription].
	
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 15:06:11'!
errorIfSlidingAPieceFromAnInvalidPosition: aPosition
	((aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3)) ifFalse: [self error: self class cannotSlideFromAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 15:04:08'!
errorIfSlidingAPieceTowardsAnInvalidPosition: aPosition
	((aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3)) ifFalse: [self error: self class cannotSlidePieceOnAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 14:43:54'!
errorIfSlidingFrom: aPosition ToAnUnreachablePosition: anotherPosition
	((((aPosition x) - (anotherPosition x)) abs > 1) or: [((aPosition y) - (anotherPosition y)) abs > 1])  ifTrue: [^self error: self class cannotSlideToAnUnreachablePositionErrorDescription ].
	
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 14:31:36'!
errorIfSlidingFromAPositionThatIsNotYours: aPosition playingAs: aPiece.
	((self at: aPosition) = aPiece) ifFalse: [^self error: self class cannotSlidePieceThatIsNotYoursErrorDescription ].
	
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 14:26:11'!
errorIfSlidingOnAnOccupiedPosition: aPosition
	((self at: aPosition) = #Empty) ifFalse: [^self error: self class cannotSlidePieceOnAnOcuppiedPositionErrorDescription ].
	
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 16:16:49'!
errorIfSlidingWhenGameIsFinished
	phase errorIfSlidingWhenGameIsFinished.
	
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 16:26:25'!
errorIfSlidingWhenIsNotYourTurn: aPiece
	lastPieceTurn = aPiece ifTrue: [self error: self class cannotSlidePieceWhenIsNotYourTurnErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private-errors' stamp: 'JIG 5/24/2019 16:16:49'!
errorIfSlidingWhenNotAllPiecesArePlaced
	phase errorIfSlidingWhenNotAllPiecesArePlaced.
	
	
	! !


!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/24/2019 16:37:26'!
changeGameStateIfFinishedByDiagonalForPiece: aPlayer	
	| diagonalFirstColumn diagonalSecondColumn|
	
	diagonalFirstColumn := OrderedCollection new.
	diagonalSecondColumn := OrderedCollection new.
	
	diagonalFirstColumn 
		add: (board at: 1);
		add: (board at: 5);
 		add: (board at: 9).
	diagonalSecondColumn 
		add: (board at: 3);
		add: (board at: 5);
		add: (board at: 7).
	
	(diagonalFirstColumn occurrencesOf: aPlayer) = 3 ifTrue: [self changeStateToFinishedWithWinner: aPlayer. ^true].
	(diagonalSecondColumn occurrencesOf: aPlayer) = 3 ifTrue: [self changeStateToFinishedWithWinner: aPlayer. ^true].
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:02:32'!
changeGameStateIfFinishedByDiagonalLine	
	
	self changeGameStateIfFinishedByDiagonalForPiece: #Cross.
	self changeGameStateIfFinishedByDiagonalForPiece: #Circle.
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/24/2019 15:25:20'!
changeGameStateIfFinishedByHorizontalForPiece: aPlayer
	((board copyFrom: 1 to: 3) occurrencesOf: aPlayer) = 3 ifTrue: [self changeStateToFinishedWithWinner: aPlayer. ^true].
	((board copyFrom: 4 to: 6) occurrencesOf: aPlayer) = 3 ifTrue: [self changeStateToFinishedWithWinner: aPlayer. ^true].
	((board copyFrom: 7 to: 9) occurrencesOf: aPlayer) = 3 ifTrue: [self changeStateToFinishedWithWinner: aPlayer. ^true].
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:02:54'!
changeGameStateIfFinishedByHorizontalLine
	self changeGameStateIfFinishedByHorizontalForPiece: #Cross.
	self changeGameStateIfFinishedByHorizontalForPiece: #Circle.	
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/24/2019 16:36:41'!
changeGameStateIfFinishedByVerticalForPiece: aPlayer	
	| verticalFirstColumn verticalSecondColumn verticalThirdColumn|
	
	verticalFirstColumn := OrderedCollection new.
	verticalSecondColumn := OrderedCollection new.
	verticalThirdColumn := OrderedCollection new.
	verticalFirstColumn 
		add: (board at: 1); 
		add: (board at: 4); 
		add: (board at: 7). 
	verticalSecondColumn 
		add: (board at: 2); 
		add: (board at: 5); 
		add: (board at: 8).
	verticalThirdColumn 
		add: (board at: 3); 
		add: (board at: 6); 
		add: (board at: 9).
	
	(verticalFirstColumn occurrencesOf: aPlayer) = 3 ifTrue: [self changeStateToFinishedWithWinner: aPlayer. ^true].
	(verticalSecondColumn occurrencesOf: aPlayer) = 3 ifTrue: [self changeStateToFinishedWithWinner: aPlayer. ^true].
	(verticalThirdColumn occurrencesOf: aPlayer) = 3 ifTrue: [self changeStateToFinishedWithWinner: aPlayer. ^true].
! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/21/2019 15:03:19'!
changeGameStateIfFinishedByVerticalLine	
	
	self changeGameStateIfFinishedByVerticalForPiece: #Cross.
	self changeGameStateIfFinishedByVerticalForPiece: #Circle.
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

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/24/2019 16:25:39'!
putPiece: aPiece on: aPosition
	self errorIfPlacingAPieceOnAnInvalidPosition: aPosition.
	self errorIfPlacingAPieceWhenGameIsOver.
	self errorIfPlacingOnAnOccupiedPosition: aPosition.
	self errorIfMoreThanThreeOfTheSamePieceArePlaced: aPiece. "Si if, pero no State"
	
	self placePieceOnBoard: aPiece at: aPosition.
	self changeGameStateIfPlacingIsOver.
	self changeGameStateIfFinished.

	! !

!TerniLapilli methodsFor: 'private' stamp: 'JIG 5/24/2019 16:30:14'!
slidePiece: aPiece from: aPosition towards: anotherPosition
	self errorIfSlidingWhenGameIsFinished.
	self errorIfSlidingWhenNotAllPiecesArePlaced.
	self errorIfSlidingAPieceFromAnInvalidPosition: aPosition.
	self errorIfSlidingAPieceTowardsAnInvalidPosition: anotherPosition.
	self errorIfSlidingOnAnOccupiedPosition: anotherPosition.
	self errorIfSlidingFromAPositionThatIsNotYours: aPosition playingAs: aPiece.
	self errorIfSlidingFrom: aPosition ToAnUnreachablePosition: anotherPosition.
	
	self placePieceOnBoard: aPiece at: anotherPosition.
	board at: (aPosition x - 1 * 3 + aPosition y) put: #Empty.
	self changeGameStateIfFinished.
! !


!TerniLapilli methodsFor: 'accessing' stamp: 'Nipo 5/20/2019 20:56:41'!
at: aPosition
	|positionOnBoard|
	
	positionOnBoard := (aPosition x - 1 * 3) + aPosition y.
	^ board at: positionOnBoard.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'JIG 5/24/2019 16:16:49'!
winner
	^phase winner.! !


!TerniLapilli methodsFor: 'testing' stamp: 'JIG 5/24/2019 16:31:32'!
nextPieceToBePlaced
	^turn piece.
! !


!TerniLapilli methodsFor: 'assertions' stamp: 'JIG 5/24/2019 16:16:49'!
isOver
	^phase isOver.! !

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

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 15:05:45'!
cannotSlideFromAnInvalidPositionErrorDescription
	^'No se puede deslizar una pieza desde una posicion invalida'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 14:19:15'!
cannotSlidePieceOnAnInvalidPositionErrorDescription
	^'No se puede deslizar una pieza a una posicion invalida.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 14:24:04'!
cannotSlidePieceOnAnOcuppiedPositionErrorDescription
	^'No se puede deslizar una pieza hacia una posición ocupada'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 14:28:57'!
cannotSlidePieceThatIsNotYoursErrorDescription
	^'No se puede deslizar una pieza que pertenece al otro jugador o esta vacia'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 14:47:03'!
cannotSlidePieceWhenGameIsFinishedErrorDescription
	^'No se puede deslizar una pieza si el juego esta terminado'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 14:58:34'!
cannotSlidePieceWhenIsNotYourTurnErrorDescription
	^'No se puede deslizar una pieza cuando no es tu turno'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 14:50:27'!
cannotSlidePieceWhenStillPlacingPiecesErrorDescription
	^'No se puede deslizar una pieza hasta que se coloquen todas las piezas correspondientes'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 14:35:42'!
cannotSlideToAnUnreachablePositionErrorDescription
	^'No se puede deslizar una pieza hacia una posicion que no es lindante a tu posicion'.! !


!classDefinition: #TerniLapilliPhase category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliPhase
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPhase methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:20:13'!
errorIfPlacingWhenIsOver
	^self subclassResponsibility .! !

!TerniLapilliPhase methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:36:01'!
errorIfSlidingWhenGameIsFinished
	^self subclassResponsibility .! !

!TerniLapilliPhase methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:38:38'!
errorIfSlidingWhenNotAllPiecesArePlaced
	^self subclassResponsibility .! !

!TerniLapilliPhase methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:11:08'!
initializeFor: aTerniLapilli
	terniLapilli := aTerniLapilli.! !

!TerniLapilliPhase methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:22:20'!
isOver
	^self subclassResponsibility .! !

!TerniLapilliPhase methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:41:31'!
winner
	^self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPhase class' category: #'TerniLapilli-Exercise'!
TerniLapilliPhase class
	instanceVariableNames: ''!

!TerniLapilliPhase class methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:10:45'!
for: aTerniLapilli
	^self new initializeFor: aTerniLapilli.! !


!classDefinition: #FinishedTerniLapilliPhase category: #'TerniLapilli-Exercise'!
TerniLapilliPhase subclass: #FinishedTerniLapilliPhase
	instanceVariableNames: 'winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!FinishedTerniLapilliPhase methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:29:11'!
initializeFor: aTerniLapilli andWinner: aPlayer
	terniLapilli := aTerniLapilli.
	winner := aPlayer.! !

!FinishedTerniLapilliPhase methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:41:44'!
winner
	^winner.! !


!FinishedTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:39:52'!
errorIfPlacingWhenIsOver
	self error: terniLapilli class cannotPlacePieceWhenTheGameIsOverErrorDescription.! !

!FinishedTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:39:59'!
errorIfSlidingWhenGameIsFinished
	self error: terniLapilli class cannotSlidePieceWhenGameIsFinishedErrorDescription.! !

!FinishedTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:38:51'!
errorIfSlidingWhenNotAllPiecesArePlaced
! !

!FinishedTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:22:28'!
isOver
	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinishedTerniLapilliPhase class' category: #'TerniLapilli-Exercise'!
FinishedTerniLapilliPhase class
	instanceVariableNames: ''!

!FinishedTerniLapilliPhase class methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:28:45'!
for: aTerniLapilli andWinner: aPlayer
	^self new initializeFor: aTerniLapilli andWinner: aPlayer.! !


!classDefinition: #PlacingTerniLapilliPhase category: #'TerniLapilli-Exercise'!
TerniLapilliPhase subclass: #PlacingTerniLapilliPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!PlacingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:21:35'!
errorIfPlacingWhenIsOver
	! !

!PlacingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:36:23'!
errorIfSlidingWhenGameIsFinished
	! !

!PlacingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:42:31'!
errorIfSlidingWhenNotAllPiecesArePlaced
	self error: terniLapilli class cannotSlidePieceWhenStillPlacingPiecesErrorDescription.! !

!PlacingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:22:36'!
isOver
	^false. 
	! !

!PlacingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:41:56'!
winner
	^#Empty. 
	! !


!classDefinition: #SlidingTerniLapilliPhase category: #'TerniLapilli-Exercise'!
TerniLapilliPhase subclass: #SlidingTerniLapilliPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!SlidingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:21:40'!
errorIfPlacingWhenIsOver! !

!SlidingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:36:25'!
errorIfSlidingWhenGameIsFinished! !

!SlidingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:39:05'!
errorIfSlidingWhenNotAllPiecesArePlaced! !

!SlidingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:22:44'!
isOver
	^false.! !

!SlidingTerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 15:42:01'!
winner
	^#Empty.! !


!classDefinition: #TerniLapilliTurn category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliTurn
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:19:46'!
errorIfACircleIsPlacedTwiceInARow
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:21:17'!
errorIfACrossIsPlacedTwiceInARow
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:29:44'!
errorIfSlidingCircleWhenIsNotYourTurn
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:29:33'!
errorIfSlidingCrossWhenIsNotYourTurn
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:16:17'!
initializeFor: aTerniLapilli
	terniLapilli := aTerniLapilli.! !

!TerniLapilliTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:31:46'!
piece
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliTurn class' category: #'TerniLapilli-Exercise'!
TerniLapilliTurn class
	instanceVariableNames: ''!

!TerniLapilliTurn class methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:16:06'!
for: aTerniLapilli
	^self new initializeFor: aTerniLapilli.! !


!classDefinition: #CircleTurn category: #'TerniLapilli-Exercise'!
TerniLapilliTurn subclass: #CircleTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!CircleTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:22:39'!
errorIfACircleIsPlacedTwiceInARow! !

!CircleTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:22:42'!
errorIfACrossIsPlacedTwiceInARow
	self error: terniLapilli class cannotPutTheSamePieceTwiceErrorDescription.! !

!CircleTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:28:31'!
errorIfSlidingCircleWhenIsNotYourTurn! !

!CircleTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:28:04'!
errorIfSlidingCrossWhenIsNotYourTurn
	self error: terniLapilli class cannotSlidePieceWhenIsNotYourTurnErrorDescription.! !

!CircleTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:32:02'!
piece
	^#Circle.! !


!classDefinition: #CrossTurn category: #'TerniLapilli-Exercise'!
TerniLapilliTurn subclass: #CrossTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!CrossTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:22:32'!
errorIfACircleIsPlacedTwiceInARow
	self error: terniLapilli class cannotPutTheSamePieceTwiceErrorDescription.! !

!CrossTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:22:29'!
errorIfACrossIsPlacedTwiceInARow! !

!CrossTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:29:16'!
errorIfSlidingCircleWhenIsNotYourTurn
	self error: terniLapilli class cannotSlidePieceWhenIsNotYourTurnErrorDescription.! !

!CrossTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:28:14'!
errorIfSlidingCrossWhenIsNotYourTurn
	! !

!CrossTurn methodsFor: 'as yet unclassified' stamp: 'JIG 5/24/2019 16:32:10'!
piece
	^#Cross.! !
