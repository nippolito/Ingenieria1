!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 19:29:03'!
test01
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	self assert: (miTerniLapilli at: (2@2)) = #Cross.
	self assert: miTerniLapilli isOver not.
	self assert: miTerniLapilli nextPieceToBePlaced = #Circle.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 19:33:55'!
test02
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	self assert: miTerniLapilli isOver not.
	self should: [ miTerniLapilli putCrossOn: (2@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutTheSamePieceTwice = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 19:34:51'!
test03
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (2@1).
		
	self assert: miTerniLapilli isOver not.
	self should: [ miTerniLapilli putCircleOn: (2@3)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutTheSamePieceTwice = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 19:40:18'!
test04
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (1@2).
	
	self assert: miTerniLapilli isOver not.
	self assert: miTerniLapilli nextPieceToBePlaced = #Cross.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 19:42:19'!
test05
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
			self assert: TerniLapilli cannotPutMoreThanThreeCrossesErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 19:46:41'!
test06
	"Creo que esto está mal, ya que este código solo pasa el test el orden en el que ponemos los errores en putCircleOn, sino explotaría porque agregaste dos círculos seguidos"
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (3@2).
	miTerniLapilli putCrossOn: (1@2).
	miTerniLapilli putCircleOn: (3@3).
	miTerniLapilli putCrossOn: (2@3).
	miTerniLapilli putCircleOn: (2@1).
	
	self assert: miTerniLapilli isOver not.
	self should: [ miTerniLapilli putCircleOn: (1@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutMoreThanThreeCirclesErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 19:46:59'!
test07
	"Arrancamos con el tablero"
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	self should: [ miTerniLapilli putCircleOn: (2@2)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutPieceOnAnOcuppiedPosition = anError messageText].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 19:47:38'!
test08
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (2@1).
	
	self should: [ miTerniLapilli putCrossOn: (2@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutPieceOnAnOcuppiedPosition = anError messageText].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 21:01:43'!
test09
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

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 21:08:37'!
test10
	"Empezamos con cómo ganar, chequeamos vertical"
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (1@2).
	miTerniLapilli putCircleOn: (3@3).
	miTerniLapilli putCrossOn: (3@2).
	
	self assert: miTerniLapilli isOver.
	self assert: miTerniLapilli winner = #Cross.
	
	"Hay que testear posteriormente que por ejemplo círculo no puede jugar si cruz ganó.
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
		- Deslizar una pieza que no tenés, etc"
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 20:40:56'!
test11
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

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 18:31:28'!
test15
	"|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: #Center.
	miTerniLapilli putCircleOn: #MiddleLeft.
	
	self assert: (miTerniLapilli at: #Center) equals: #Cross.
	self assert: (miTerniLapilli at: #MiddleLeft) equals: #Circle"! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 18:31:34'!
test16
	"|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli new.
	
	miTerniLapilli putCrossOn: #Center.
	
	self assert: (miTerniLapilli at: #Center) equals: #Cross."! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nipo 5/20/2019 17:47:39'!
test18
	"|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli new.
	
	miTerniLapilli putCircleOn: #Center.
	
	self assert: (miTerniLapilli at: #Center) equals: #Circle."! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board lastPiecePlaced numberOfCrosses numberOfCircles finished winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'Nipo 5/20/2019 18:34:09'!
nextPieceToBePlaced
	lastPiecePlaced = #Cross ifTrue: [^#Circle].
	^#Cross! !


!TerniLapilli methodsFor: 'operations' stamp: 'Nipo 5/20/2019 20:53:06'!
putPiece: aPiece on: aPosition
	board at: (aPosition x - 1 * 3 + aPosition y) put: aPiece. ! !


!TerniLapilli methodsFor: 'initialization' stamp: 'Nipo 5/20/2019 20:53:54'!
createBoard
	board := OrderedCollection new. 
	board addAll: #(#Empty #Empty #Empty #Empty #Empty #Empty #Empty #Empty #Empty).! !

!TerniLapilli methodsFor: 'initialization' stamp: 'Nipo 5/20/2019 20:54:10'!
initializeWithCrossOn: aPosition 
	lastPiecePlaced := #Cross.
	numberOfCrosses := 1.
	numberOfCircles := 0.
	finished := false.
	self createBoard.
	self putPiece: #Cross on: aPosition.! !


!TerniLapilli methodsFor: 'private' stamp: 'Nipo 5/20/2019 21:04:02'!
checkIfDiagonal	
	
	self checkIfDiagonalForPlayer: #Cross.
	self checkIfDiagonalForPlayer: #Circle.
! !

!TerniLapilli methodsFor: 'private' stamp: 'Nipo 5/20/2019 21:02:33'!
checkIfDiagonalForPlayer: aPlayer	
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

!TerniLapilli methodsFor: 'private' stamp: 'Nipo 5/20/2019 21:03:26'!
checkIfHorizontal
	self checkIfHorizontalForPlayer: #Cross.
	self checkIfHorizontalForPlayer: #Circle.	
! !

!TerniLapilli methodsFor: 'private' stamp: 'Nipo 5/20/2019 21:02:19'!
checkIfHorizontalForPlayer: aPlayer
	((board copyFrom: 1 to: 3) occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
	((board copyFrom: 4 to: 6) occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
	((board copyFrom: 7 to: 9) occurrencesOf: aPlayer) = 3 ifTrue: [finished := true. winner := aPlayer. ^true].
! !

!TerniLapilli methodsFor: 'private' stamp: 'Nipo 5/20/2019 21:03:44'!
checkIfVertical	
	
	self checkIfVerticalForPlayer: #Cross.
	self checkIfVerticalForPlayer: #Circle.
! !

!TerniLapilli methodsFor: 'private' stamp: 'Nipo 5/20/2019 21:02:26'!
checkIfVerticalForPlayer: aPlayer	
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

!TerniLapilli methodsFor: 'private' stamp: 'Nipo 5/20/2019 19:55:21'!
putCircleOn: aPosition
	((self at: aPosition) = #Empty) ifFalse: [^self error: TerniLapilli cannotPutPieceOnAnOcuppiedPosition].
	numberOfCircles = 3 ifTrue: [^ self error: TerniLapilli cannotPutMoreThanThreeCirclesErrorDescription].
	lastPiecePlaced = #Circle ifTrue: [^ self error: TerniLapilli cannotPutTheSamePieceTwice].
	lastPiecePlaced := #Circle.
	numberOfCircles := numberOfCircles + 1.
	self putPiece: #Circle on: aPosition.
	self checkIfGameIsFinished.
! !

!TerniLapilli methodsFor: 'private' stamp: 'Nipo 5/20/2019 19:55:15'!
putCrossOn: aPosition 
	((self at: aPosition) = #Empty) ifFalse: [^self error: TerniLapilli cannotPutPieceOnAnOcuppiedPosition].
	numberOfCrosses = 3 ifTrue: [^ self error: TerniLapilli cannotPutMoreThanThreeCrossesErrorDescription].
	lastPiecePlaced = #Cross ifTrue: [^ self error: TerniLapilli cannotPutTheSamePieceTwice].
	lastPiecePlaced := #Cross.
	numberOfCrosses := numberOfCrosses + 1.
	self putPiece: #Cross on: aPosition.
	self checkIfGameIsFinished.
! !


!TerniLapilli methodsFor: 'accessing' stamp: 'Nipo 5/20/2019 20:56:41'!
at: aPosition
	|positionOnBoard|
	
	positionOnBoard := (aPosition x - 1 * 3) + aPosition y.
	^ board at: positionOnBoard.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'Nipo 5/20/2019 20:23:30'!
winner
	^winner.! !


!TerniLapilli methodsFor: 'assertions' stamp: 'Nipo 5/20/2019 21:04:15'!
checkIfGameIsFinished	
	
	self checkIfHorizontal.
	self checkIfVertical.
	self checkIfDiagonal.
! !

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


!TerniLapilli class methodsFor: 'error descriptions' stamp: 'Nipo 5/20/2019 18:44:35'!
cannotPutMoreThanThreeCirclesErrorDescription
	^'No se pueden poner más de tres círculos'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'Nipo 5/20/2019 18:39:04'!
cannotPutMoreThanThreeCrossesErrorDescription
	^'No se pueden poner más de tres cruces'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'Nipo 5/20/2019 18:39:21'!
cannotPutPieceOnAnOcuppiedPosition
	^'No se puede colocar una pieza en una posición ocupada'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'Nipo 5/20/2019 18:01:37'!
cannotPutTheSamePieceTwice
	^'No se puede colocar la misma pieza dos veces consecutivas'! !
