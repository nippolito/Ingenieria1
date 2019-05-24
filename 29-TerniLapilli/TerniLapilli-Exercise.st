!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'middleCrossTerniLapilli crossOn12TerniLapilli slidingPhaseTerniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:46:04'!
test01CirclePlaysAfterCross
	
	self assert: (middleCrossTerniLapilli at: (2@2)) = #Cross.
	self deny: middleCrossTerniLapilli isOver.
	self assert: middleCrossTerniLapilli isPlayingCircle.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:53:38'!
test02CannotPutCrossesTwiceInARow
	
	self deny: middleCrossTerniLapilli isOver.
	self should: [ middleCrossTerniLapilli putCrossOn: (2@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutTheSamePieceTwiceErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:53:45'!
test03CannotPutCirclesTwiceInARow
	
	middleCrossTerniLapilli putCircleOn: (2@1).
		
	self deny: middleCrossTerniLapilli isOver.
	self should: [ middleCrossTerniLapilli putCircleOn: (2@3)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutTheSamePieceTwiceErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:46:40'!
test04CrossPlaysAfterCircle
	
	middleCrossTerniLapilli putCircleOn: (1@2).
	
	self deny: middleCrossTerniLapilli isOver.
	self assert: middleCrossTerniLapilli isPlayingCross.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:53:33'!
test05CannotPutMoreThanThreeCrosses
	
	middleCrossTerniLapilli putCircleOn: (3@2).
	middleCrossTerniLapilli putCrossOn: (1@2).
	middleCrossTerniLapilli putCircleOn: (3@3).
	middleCrossTerniLapilli putCrossOn: (2@3).
	middleCrossTerniLapilli putCircleOn: (2@1).
	
	self deny: middleCrossTerniLapilli isOver.
	self should: [ middleCrossTerniLapilli putCrossOn: (1@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutMoreThanThreeOfTheSamePieceErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'JIG 5/24/2019 13:52:27'!
test06CannotInitializeGamePlacingACrossOnAnInvalidPosition
	self should: [TerniLapilli startWithCrossOn: (10@-10).] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPlacePieceOnAnInvalidPositionErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:21:24'!
test07CannotPutACircleOnAnOccupiedPosition
	
	self should: [ middleCrossTerniLapilli putCircleOn: (2@2)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutPieceOnAnOcuppiedPositionErrorDescription = anError messageText].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:21:35'!
test08CannotPutACrossOnAnOccupiedPosition
	
	middleCrossTerniLapilli putCircleOn: (2@1).
	
	self should: [ middleCrossTerniLapilli putCrossOn: (2@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutPieceOnAnOcuppiedPositionErrorDescription = anError messageText].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:47:06'!
test09APlayerWinsAfterComplettingFirstHorizontalLineAndGameIsOver	
	
	crossOn12TerniLapilli putCircleOn: (2@2).
	crossOn12TerniLapilli putCrossOn: (1@1).
	crossOn12TerniLapilli putCircleOn: (3@2).
	crossOn12TerniLapilli putCrossOn: (1@3).
	
	self assert: crossOn12TerniLapilli isOver.
	self assert: crossOn12TerniLapilli hasPlayerCrossWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:47:16'!
test10APlayerWinsAfterComplettingOtherHorizontalLineAndGameIsOver
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@1).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@3).
	
	self assert: miTerniLapilli isOver.
	self assert: miTerniLapilli hasPlayerCrossWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:47:24'!
test11APlayerWinsAfterComplettingAVerticalLineAndGameIsOver
	
	middleCrossTerniLapilli putCircleOn: (1@1).
	middleCrossTerniLapilli putCrossOn: (1@2).
	middleCrossTerniLapilli putCircleOn: (3@3).
	middleCrossTerniLapilli putCrossOn: (3@2).
	
	self assert: middleCrossTerniLapilli isOver.
	self assert: middleCrossTerniLapilli hasPlayerCrossWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:47:31'!
test12APlayerWinsAfterComplettingADiagonalLineAndGameIsOver
	
	crossOn12TerniLapilli putCircleOn: (1@1).
	crossOn12TerniLapilli putCrossOn: (1@3).
	crossOn12TerniLapilli putCircleOn: (2@2).
	crossOn12TerniLapilli putCrossOn: (3@2).
	crossOn12TerniLapilli putCircleOn: (3@3).
	
	self assert: crossOn12TerniLapilli isOver.
	self assert: crossOn12TerniLapilli hasPlayerCircleWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:47:41'!
test13CannotPlaceAPieceIfGameIsOver
	
	middleCrossTerniLapilli putCircleOn: (1@1).
	middleCrossTerniLapilli putCrossOn: (1@2).
	middleCrossTerniLapilli putCircleOn: (3@3).
	middleCrossTerniLapilli putCrossOn: (3@2).
	
	self should: [middleCrossTerniLapilli putCircleOn: (2@1).] 
	raise: Error  
	withExceptionDo: [:anError|
			self assert: anError messageText = TerniLapilli cannotPlacePieceWhenTheGameIsOverErrorDescription.
			self assert: middleCrossTerniLapilli isOver.
			self assert: middleCrossTerniLapilli hasPlayerCrossWon.
	].

	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:28:41'!
test14CannotPlaceAPieceOutsideOfBoardRange
	
	self should: [middleCrossTerniLapilli putCircleOn: (50@50).] 
	raise: Error  
	withExceptionDo: [:anError|
			self assert: anError messageText = TerniLapilli cannotPlacePieceOnAnInvalidPositionErrorDescription.
	].

	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:47:54'!
test15CanSlideHorizontally
	
	crossOn12TerniLapilli putCircleOn: (1@1).
	crossOn12TerniLapilli putCrossOn: (1@3).
	crossOn12TerniLapilli putCircleOn: (2@2).
	crossOn12TerniLapilli putCrossOn: (3@2).
	crossOn12TerniLapilli putCircleOn: (2@3).
	
	crossOn12TerniLapilli slideCrossFrom: (3@2) towards: (3@1).	
	
	self deny: crossOn12TerniLapilli isOver.
	self assert: ((crossOn12TerniLapilli at: (3@1)) = #Cross).
	self assert: ((crossOn12TerniLapilli at: (3@2)) = #Empty).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:48:07'!
test16CanSlideVertically
	
	crossOn12TerniLapilli putCircleOn: (1@1).
	crossOn12TerniLapilli putCrossOn: (1@3).
	crossOn12TerniLapilli putCircleOn: (2@2).
	crossOn12TerniLapilli putCrossOn: (3@1).
	crossOn12TerniLapilli putCircleOn: (2@3).
	
	crossOn12TerniLapilli slideCrossFrom: (3@1) towards: (2@1).
	
	self deny: crossOn12TerniLapilli isOver.
	self assert: ((crossOn12TerniLapilli at: (2@1)) = #Cross).
	self assert: ((crossOn12TerniLapilli at: (3@1)) = #Empty).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:48:14'!
test17CanSlideDiagonally
	
	crossOn12TerniLapilli putCircleOn: (1@1).
	crossOn12TerniLapilli putCrossOn: (1@3).
	crossOn12TerniLapilli putCircleOn: (2@2).
	crossOn12TerniLapilli putCrossOn: (3@1).
	crossOn12TerniLapilli putCircleOn: (2@3).
	
	crossOn12TerniLapilli slideCrossFrom: (1@2) towards: (2@1).
	
	self deny: crossOn12TerniLapilli isOver.
	self assert: ((crossOn12TerniLapilli at: (2@1)) = #Cross).
	self assert: ((crossOn12TerniLapilli at: (1@2)) = #Empty).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:48:25'!
test18CanWinAfterSliding
	
	slidingPhaseTerniLapilli slideCrossFrom: (2@3) towards: (3@3).
	
	self assert: slidingPhaseTerniLapilli isOver.
	self assert: slidingPhaseTerniLapilli hasPlayerCrossWon.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:37:15'!
test19CannotSlideOnAnInvalidPosition
	
	self should: [slidingPhaseTerniLapilli slideCrossFrom: (2@3) towards: (2@4).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceOnAnInvalidPositionErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:37:15'!
test20CannotSlideOnAnOccupiedPosition
	
	self should: [slidingPhaseTerniLapilli slideCrossFrom: (2@3) towards: (2@2).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceOnAnOcuppiedPositionErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:37:15'!
test21CannotSlideAPieceThatIsNotYours
	
	self should: [slidingPhaseTerniLapilli slideCrossFrom: (3@1) towards: (3@2).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceThatIsNotYoursErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:38:32'!
test22CannotSlideToALocationThatNeedsToGoThroughMoreThanOnePosition
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

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:37:15'!
test23CannotSlideIfGameIsFinished
	
	slidingPhaseTerniLapilli slideCrossFrom: (1@1) towards: (2@1).
	
	self should: [slidingPhaseTerniLapilli slideCircleFrom: (3@1) towards: (3@2)]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceWhenGameIsFinishedErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:38:41'!
test24CannotSlideWhenStillPlacingPieces
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

!TerniLapilliTest methodsFor: 'test' stamp: 'Nip 5/24/2019 19:37:15'!
test25CannotSlideCrossWhenItIsNotCrossTurn
	
	slidingPhaseTerniLapilli slideCrossFrom: (2@3) towards: (3@2).
	
	self should: [slidingPhaseTerniLapilli slideCrossFrom: (1@1) towards: (2@1).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceWhenIsNotYourTurnErrorDescription = anError messageText 
	].
	! !


!TerniLapilliTest methodsFor: 'setup' stamp: 'Nip 5/24/2019 19:37:15'!
setUp
	middleCrossTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	crossOn12TerniLapilli := TerniLapilli startWithCrossOn: (1@2).
	
	slidingPhaseTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	slidingPhaseTerniLapilli putCircleOn: (1@2).
	slidingPhaseTerniLapilli putCrossOn: (2@2).
	slidingPhaseTerniLapilli putCircleOn: (1@3).
	slidingPhaseTerniLapilli putCrossOn: (2@3).
	slidingPhaseTerniLapilli putCircleOn: (3@1).! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board numberOfPieces turn phase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'accessing' stamp: 'Nipo 5/20/2019 20:56:41'!
at: aPosition
	|positionOnBoard|
	
	positionOnBoard := (aPosition x - 1 * 3) + aPosition y.
	^ board at: positionOnBoard.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'Nip 5/24/2019 19:51:12'!
nextTurn
	^turn nextPiece.
! !

!TerniLapilli methodsFor: 'accessing' stamp: 'JIG 5/24/2019 16:16:49'!
winner
	^phase winner.! !


!TerniLapilli methodsFor: 'assertions' stamp: 'Nip 5/24/2019 19:45:14'!
hasPlayerCircleWon
	^ self winner = #Circle! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Nip 5/24/2019 19:45:21'!
hasPlayerCrossWon
	^ self winner = #Cross! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JIG 5/24/2019 16:16:49'!
isOver
	^phase isOver.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Nip 5/24/2019 19:51:12'!
isPlayingCircle
	^ self nextTurn = #Circle! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Nip 5/24/2019 19:51:12'!
isPlayingCross
	^ self nextTurn = #Cross! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Nip 5/24/2019 20:29:50'!
isPositionValid: aPosition
	^(aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3).! !


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


!TerniLapilli methodsFor: 'operations - placing' stamp: 'JIG 5/24/2019 16:19:31'!
putCircleOn: aPosition
	turn errorIfACircleIsPlacedTwiceInARow.
	self putPiece: #Circle on: aPosition.
	turn := CrossTurn for: self.

	! !

!TerniLapilli methodsFor: 'operations - placing' stamp: 'JIG 5/24/2019 16:21:08'!
putCrossOn: aPosition
	turn errorIfACrossIsPlacedTwiceInARow.
	self putPiece: #Cross on: aPosition.
	turn := CircleTurn for: self.

	! !


!TerniLapilli methodsFor: 'operations - sliding' stamp: 'JIG 5/24/2019 16:33:31'!
slideCircleFrom: aPosition towards: anotherPosition
	turn errorIfSlidingCircleWhenIsNotYourTurn.
	self slidePiece: #Circle from: aPosition towards: anotherPosition.
	turn := CrossTurn for: self.

! !

!TerniLapilli methodsFor: 'operations - sliding' stamp: 'JIG 5/24/2019 16:33:37'!
slideCrossFrom: aPosition towards: anotherPosition
	turn errorIfSlidingCrossWhenIsNotYourTurn.
	self slidePiece: #Cross from: aPosition towards: anotherPosition.
	turn := CircleTurn for: self.

! !


!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 13:48:44'!
errorIfMoreThanThreeOfTheSamePieceArePlaced: aPiece
	(numberOfPieces at: aPiece) = 3 ifTrue: [^self error: self class cannotPutMoreThanThreeOfTheSamePieceErrorDescription ].
	numberOfPieces at: aPiece put: ((numberOfPieces at: aPiece) + 1).
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'Nip 5/24/2019 20:28:50'!
errorIfPlacingAPieceOnAnInvalidPosition: aPosition
	(self isPositionValid: aPosition) ifFalse: [self error: self class cannotPlacePieceOnAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 16:16:49'!
errorIfPlacingAPieceWhenGameIsOver
	^phase errorIfPlacingWhenIsOver.
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 14:25:26'!
errorIfPlacingOnAnOccupiedPosition: aPosition
	((self at: aPosition) = #Empty) ifFalse: [^self error: self class cannotPutPieceOnAnOcuppiedPositionErrorDescription].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'Nip 5/24/2019 20:30:09'!
errorIfSlidingAPieceFromAnInvalidPosition: aPosition
	(self isPositionValid: aPosition) ifFalse: [self error: self class cannotSlideFromAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'Nip 5/24/2019 20:30:14'!
errorIfSlidingAPieceTowardsAnInvalidPosition: aPosition
	(self isPositionValid: aPosition) ifFalse: [self error: self class cannotSlidePieceOnAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 14:43:54'!
errorIfSlidingFrom: aPosition ToAnUnreachablePosition: anotherPosition
	((((aPosition x) - (anotherPosition x)) abs > 1) or: [((aPosition y) - (anotherPosition y)) abs > 1])  ifTrue: [^self error: self class cannotSlideToAnUnreachablePositionErrorDescription ].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 14:31:36'!
errorIfSlidingFromAPositionThatIsNotYours: aPosition playingAs: aPiece.
	((self at: aPosition) = aPiece) ifFalse: [^self error: self class cannotSlidePieceThatIsNotYoursErrorDescription ].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 14:26:11'!
errorIfSlidingOnAnOccupiedPosition: aPosition
	((self at: aPosition) = #Empty) ifFalse: [^self error: self class cannotSlidePieceOnAnOcuppiedPositionErrorDescription ].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 16:16:49'!
errorIfSlidingWhenGameIsFinished
	phase errorIfSlidingWhenGameIsFinished.
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 16:16:49'!
errorIfSlidingWhenNotAllPiecesArePlaced
	phase errorIfSlidingWhenNotAllPiecesArePlaced.
	
	
	! !


!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:17:21'!
changeGameStateIfAnyPlayerCompletedADiagonalLine	
	
	self changeGameStateIfPlayerCompletedADiagonalLine: #Cross.
	self changeGameStateIfPlayerCompletedADiagonalLine: #Circle.
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:17:48'!
changeGameStateIfAnyPlayerCompletedAHorizontalLine
	self changeGameStateIfPlayerCompletedAHorizontalLine: #Cross.
	self changeGameStateIfPlayerCompletedAHorizontalLine: #Circle.	
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:16:56'!
changeGameStateIfAnyPlayerCompletedALine
	self changeGameStateIfAnyPlayerCompletedAHorizontalLine.
	self changeGameStateIfAnyPlayerCompletedAVerticalLine.
	self changeGameStateIfAnyPlayerCompletedADiagonalLine.
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:18:09'!
changeGameStateIfAnyPlayerCompletedAVerticalLine	
	
	self changeGameStateIfPlayerCompletedAVerticalLine: #Cross.
	self changeGameStateIfPlayerCompletedAVerticalLine: #Circle.
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:00:05'!
changeGameStateIfPlacingIsOver
	((numberOfPieces at: #Cross) = 3 and: (numberOfPieces at: #Circle) = 3) ifTrue: [
		phase := SlidingTerniLapilliPhase for: self.
	].
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:17:21'!
changeGameStateIfPlayerCompletedADiagonalLine: aPlayer	
	
	((self hasCompletedFirstDiagonal: aPlayer) or: 
	(self hasCompletedSecondDiagonal: aPlayer))
		ifTrue: [self changeStateToFinishedWithWinner: aPlayer].
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:17:48'!
changeGameStateIfPlayerCompletedAHorizontalLine: aPlayer	
	(((self hasCompletedFirstHorizontalLine: aPlayer) or: 
	(self hasCompletedSecondHorizontalLine: aPlayer)) or:
	(self hasCompletedThirdHorizontalLine: aPlayer))
		ifTrue: [self changeStateToFinishedWithWinner: aPlayer].! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:22:40'!
changeGameStateIfPlayerCompletedAVerticalLine: aPlayer	
	
	(((self hasCompletedFirstVerticalLine: aPlayer) or: 
	(self hasCompletedSecondVerticalLine: aPlayer)) or:
	(self hasCompletedThirdVerticalLine: aPlayer))
		ifTrue: [self changeStateToFinishedWithWinner: aPlayer].
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:23:56'!
changeStateToFinishedWithWinner: aPlayer
	phase := FinishedTerniLapilliPhase for: self withWinner: aPlayer.
	! !


!TerniLapilli methodsFor: 'private - initialization' stamp: 'JIG 5/21/2019 15:37:48'!
initializePieceCount 
	numberOfPieces := Dictionary new.
	numberOfPieces at: #Cross put: 0.
	numberOfPieces at: #Circle put: 0.
! !


!TerniLapilli methodsFor: 'private - operations' stamp: 'JIG 5/21/2019 15:33:06'!
placePieceOnBoard: aPiece at: aPosition
	board at: (aPosition x - 1 * 3 + aPosition y) put: aPiece. 

	! !

!TerniLapilli methodsFor: 'private - operations' stamp: 'Nip 5/24/2019 20:26:19'!
putPiece: aPiece on: aPosition
	self errorIfPlacingAPieceOnAnInvalidPosition: aPosition.
	self errorIfPlacingAPieceWhenGameIsOver.
	self errorIfPlacingOnAnOccupiedPosition: aPosition.
	self errorIfMoreThanThreeOfTheSamePieceArePlaced: aPiece.
	
	self placePieceOnBoard: aPiece at: aPosition.
	self changeGameStateIfPlacingIsOver.
	self changeGameStateIfAnyPlayerCompletedALine.

	! !

!TerniLapilli methodsFor: 'private - operations' stamp: 'Nip 5/24/2019 20:16:56'!
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
	self changeGameStateIfAnyPlayerCompletedALine.
! !


!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'Nip 5/24/2019 20:12:14'!
hasCompletedFirstDiagonal: aPlayer
	| firstDiagonal|
	
	firstDiagonal := OrderedCollection new.
	
	firstDiagonal 
		add: (board at: 1);
		add: (board at: 5);
 		add: (board at: 9).

	^ (firstDiagonal occurrencesOf: aPlayer) = 3! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'Nip 5/24/2019 20:08:29'!
hasCompletedFirstHorizontalLine: aPlayer
	^ ((board copyFrom: 1 to: 3) occurrencesOf: aPlayer) = 3! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'Nip 5/24/2019 20:22:25'!
hasCompletedFirstVerticalLine: aPlayer
	| firstColumn |
	
	firstColumn := OrderedCollection new.
	firstColumn 
		add: (board at: 1); 
		add: (board at: 4); 
		add: (board at: 7). 
	
	^ (firstColumn occurrencesOf: aPlayer) = 3! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'Nip 5/24/2019 20:12:42'!
hasCompletedSecondDiagonal: aPlayer
	| secondDiagonal|
	
	secondDiagonal := OrderedCollection new.
	
	secondDiagonal 
		add: (board at: 3);
		add: (board at: 5);
 		add: (board at: 7).

	^ (secondDiagonal occurrencesOf: aPlayer) = 3! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'Nip 5/24/2019 20:09:09'!
hasCompletedSecondHorizontalLine: aPlayer
	^ ((board copyFrom: 4 to: 6) occurrencesOf: aPlayer) = 3! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'Nip 5/24/2019 20:22:19'!
hasCompletedSecondVerticalLine: aPlayer
	| secondColumn |
	
	secondColumn := OrderedCollection new.
	secondColumn 
		add: (board at: 2); 
		add: (board at: 5); 
		add: (board at: 8). 
	
	^ (secondColumn occurrencesOf: aPlayer) = 3! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'Nip 5/24/2019 20:09:17'!
hasCompletedThirdHorizontalLine: aPlayer
	^ ((board copyFrom: 7 to: 9) occurrencesOf: aPlayer) = 3! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'Nip 5/24/2019 20:22:09'!
hasCompletedThirdVerticalLine: aPlayer
	| thirdColumn |
	
	thirdColumn := OrderedCollection new.
	thirdColumn 
		add: (board at: 3); 
		add: (board at: 6); 
		add: (board at: 9). 
	
	^ (thirdColumn occurrencesOf: aPlayer) = 3! !

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

!TerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:20:13'!
errorIfPlacingWhenIsOver
	^self subclassResponsibility .! !

!TerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:36:01'!
errorIfSlidingWhenGameIsFinished
	^self subclassResponsibility .! !

!TerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:38:38'!
errorIfSlidingWhenNotAllPiecesArePlaced
	^self subclassResponsibility .! !


!TerniLapilliPhase methodsFor: 'initialization' stamp: 'JIG 5/24/2019 15:11:08'!
initializeFor: aTerniLapilli
	terniLapilli := aTerniLapilli.! !


!TerniLapilliPhase methodsFor: 'testing' stamp: 'JIG 5/24/2019 15:22:20'!
isOver
	^self subclassResponsibility .! !


!TerniLapilliPhase methodsFor: 'winner' stamp: 'JIG 5/24/2019 15:41:31'!
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

!FinishedTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:39:52'!
errorIfPlacingWhenIsOver
	self error: terniLapilli class cannotPlacePieceWhenTheGameIsOverErrorDescription.! !

!FinishedTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:39:59'!
errorIfSlidingWhenGameIsFinished
	self error: terniLapilli class cannotSlidePieceWhenGameIsFinishedErrorDescription.! !

!FinishedTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:38:51'!
errorIfSlidingWhenNotAllPiecesArePlaced
! !


!FinishedTerniLapilliPhase methodsFor: 'initialization' stamp: 'Nip 5/24/2019 19:14:32'!
initializeFor: aTerniLapilli withWinner: aPlayer
	terniLapilli := aTerniLapilli.
	winner := aPlayer.! !


!FinishedTerniLapilliPhase methodsFor: 'testing' stamp: 'JIG 5/24/2019 15:22:28'!
isOver
	^true.! !


!FinishedTerniLapilliPhase methodsFor: 'winner' stamp: 'JIG 5/24/2019 15:41:44'!
winner
	^winner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinishedTerniLapilliPhase class' category: #'TerniLapilli-Exercise'!
FinishedTerniLapilliPhase class
	instanceVariableNames: ''!

!FinishedTerniLapilliPhase class methodsFor: 'initialization' stamp: 'Nip 5/24/2019 20:23:56'!
for: aTerniLapilli withWinner: aPlayer
	^self new initializeFor: aTerniLapilli withWinner: aPlayer.! !


!classDefinition: #PlacingTerniLapilliPhase category: #'TerniLapilli-Exercise'!
TerniLapilliPhase subclass: #PlacingTerniLapilliPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!PlacingTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:21:35'!
errorIfPlacingWhenIsOver
	! !

!PlacingTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:36:23'!
errorIfSlidingWhenGameIsFinished
	! !

!PlacingTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:42:31'!
errorIfSlidingWhenNotAllPiecesArePlaced
	self error: terniLapilli class cannotSlidePieceWhenStillPlacingPiecesErrorDescription.! !


!PlacingTerniLapilliPhase methodsFor: 'testing' stamp: 'JIG 5/24/2019 15:22:36'!
isOver
	^false. 
	! !


!PlacingTerniLapilliPhase methodsFor: 'winner' stamp: 'JIG 5/24/2019 15:41:56'!
winner
	^#Empty. 
	! !


!classDefinition: #SlidingTerniLapilliPhase category: #'TerniLapilli-Exercise'!
TerniLapilliPhase subclass: #SlidingTerniLapilliPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!SlidingTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:21:40'!
errorIfPlacingWhenIsOver! !

!SlidingTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:36:25'!
errorIfSlidingWhenGameIsFinished! !

!SlidingTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 15:39:05'!
errorIfSlidingWhenNotAllPiecesArePlaced! !


!SlidingTerniLapilliPhase methodsFor: 'testing' stamp: 'JIG 5/24/2019 15:22:44'!
isOver
	^false.! !


!SlidingTerniLapilliPhase methodsFor: 'winner' stamp: 'JIG 5/24/2019 15:42:01'!
winner
	^#Empty.! !


!classDefinition: #TerniLapilliTurn category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliTurn
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:19:46'!
errorIfACircleIsPlacedTwiceInARow
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:21:17'!
errorIfACrossIsPlacedTwiceInARow
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:29:44'!
errorIfSlidingCircleWhenIsNotYourTurn
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:29:33'!
errorIfSlidingCrossWhenIsNotYourTurn
	^self subclassResponsibility.! !


!TerniLapilliTurn methodsFor: 'initialization' stamp: 'JIG 5/24/2019 16:16:17'!
initializeFor: aTerniLapilli
	terniLapilli := aTerniLapilli.! !


!TerniLapilliTurn methodsFor: 'nextPiece' stamp: 'Nip 5/24/2019 19:16:16'!
nextPiece
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliTurn class' category: #'TerniLapilli-Exercise'!
TerniLapilliTurn class
	instanceVariableNames: ''!

!TerniLapilliTurn class methodsFor: 'initialization' stamp: 'JIG 5/24/2019 16:16:06'!
for: aTerniLapilli
	^self new initializeFor: aTerniLapilli.! !


!classDefinition: #CircleTurn category: #'TerniLapilli-Exercise'!
TerniLapilliTurn subclass: #CircleTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!CircleTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:22:39'!
errorIfACircleIsPlacedTwiceInARow! !

!CircleTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:22:42'!
errorIfACrossIsPlacedTwiceInARow
	self error: terniLapilli class cannotPutTheSamePieceTwiceErrorDescription.! !

!CircleTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:28:31'!
errorIfSlidingCircleWhenIsNotYourTurn! !

!CircleTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:28:04'!
errorIfSlidingCrossWhenIsNotYourTurn
	self error: terniLapilli class cannotSlidePieceWhenIsNotYourTurnErrorDescription.! !


!CircleTurn methodsFor: 'nextPiece' stamp: 'Nip 5/24/2019 19:16:16'!
nextPiece
	^#Circle.! !


!classDefinition: #CrossTurn category: #'TerniLapilli-Exercise'!
TerniLapilliTurn subclass: #CrossTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!CrossTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:22:32'!
errorIfACircleIsPlacedTwiceInARow
	self error: terniLapilli class cannotPutTheSamePieceTwiceErrorDescription.! !

!CrossTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:22:29'!
errorIfACrossIsPlacedTwiceInARow! !

!CrossTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:29:16'!
errorIfSlidingCircleWhenIsNotYourTurn
	self error: terniLapilli class cannotSlidePieceWhenIsNotYourTurnErrorDescription.! !

!CrossTurn methodsFor: 'errors - testing' stamp: 'JIG 5/24/2019 16:28:14'!
errorIfSlidingCrossWhenIsNotYourTurn
	! !


!CrossTurn methodsFor: 'nextPiece' stamp: 'Nip 5/24/2019 19:16:16'!
nextPiece
	^#Cross.! !
