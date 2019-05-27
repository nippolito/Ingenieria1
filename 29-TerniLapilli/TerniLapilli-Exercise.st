!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'middleCrossTerniLapilli crossOn12TerniLapilli crossOn11TerniLapilli slidingPhaseTerniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:15:55'!
test00BoardHasGotOnlyOnePieceAfterInitializing
	
	self assert: (middleCrossTerniLapilli isPositionACross: (2@2)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (1@1)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (1@2)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (1@3)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (2@1)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (2@3)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (3@1)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (3@2)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (3@3)).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:11:49'!
test01CirclePlaysAfterCross
	
	self deny: middleCrossTerniLapilli isOver.
	self assert: middleCrossTerniLapilli isPlayingCircle.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:57:27'!
test02CrossPlaysAfterCircle
	
	middleCrossTerniLapilli putCircleOn: (1@2).
	
	self deny: middleCrossTerniLapilli isOver.
	self assert: middleCrossTerniLapilli isPlayingCross.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:10:19'!
test03CannotPutCirclesWhenItIsCrossTurn
	
	middleCrossTerniLapilli putCircleOn: (2@1).
		
	self deny: middleCrossTerniLapilli isOver.
	self should: [ middleCrossTerniLapilli putCircleOn: (2@3)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutTheSamePieceTwiceErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:57:24'!
test04CannotPutCrossesWhenItIsCircleTurn
	
	self deny: middleCrossTerniLapilli isOver.
	self should: [ middleCrossTerniLapilli putCrossOn: (2@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutTheSamePieceTwiceErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:45:01'!
test05PlacingCircleOnlyAffectsOneBoardPosition
	
	middleCrossTerniLapilli putCircleOn: (1@2).
	
	self assert: (middleCrossTerniLapilli isPositionACross: (2@2)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (1@1)).
	self assert: (middleCrossTerniLapilli isPositionACircle: (1@2)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (1@3)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (2@1)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (2@3)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (3@1)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (3@2)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (3@3)).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:45:39'!
test06PlacingCrossOnlyAffectsOneBoardPosition
	
	middleCrossTerniLapilli putCircleOn: (1@2).
	middleCrossTerniLapilli putCrossOn: (1@1).
	
	self assert: (middleCrossTerniLapilli isPositionACross: (2@2)).
	self assert: (middleCrossTerniLapilli isPositionACross: (1@1)).
	self assert: (middleCrossTerniLapilli isPositionACircle: (1@2)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (1@3)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (2@1)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (2@3)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (3@1)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (3@2)).
	self assert: (middleCrossTerniLapilli isPositionEmpty: (3@3)).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 16:58:54'!
test07CannotPutMoreThanThreeCrosses
	
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

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:57:06'!
test08CannotInitializeGamePlacingACrossOnAnInvalidPosition
	self should: [TerniLapilli startWithCrossOn: (10@-10).] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPlacePieceOnAnInvalidPositionErrorDescription = anError messageText].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/27/2019 11:26:05'!
test09CannotPutACircleOnAnOccupiedPosition
	
	self should: [ middleCrossTerniLapilli putCircleOn: (2@2)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutPieceOnAnOcuppiedPositionErrorDescription = anError messageText].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:57'!
test10CannotPutACrossOnAnOccupiedPosition
	
	middleCrossTerniLapilli putCircleOn: (2@1).
	
	self should: [ middleCrossTerniLapilli putCrossOn: (2@1)] 
	raise: Error 
	withExceptionDo: [:anError | 
			self assert: TerniLapilli cannotPutPieceOnAnOcuppiedPositionErrorDescription = anError messageText].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:51'!
test11APlayerWinsAfterComplettingFirstHorizontalLineAndGameIsOver	
	
	crossOn12TerniLapilli putCircleOn: (2@2).
	crossOn12TerniLapilli putCrossOn: (1@1).
	crossOn12TerniLapilli putCircleOn: (3@2).
	crossOn12TerniLapilli putCrossOn: (1@3).
	
	self assert: crossOn12TerniLapilli isOver.
	self assert: crossOn12TerniLapilli hasPlayerCrossWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:48'!
test12APlayerWinsAfterComplettingOtherHorizontalLineAndGameIsOver
	
	|miTerniLapilli|
	
	miTerniLapilli := TerniLapilli startWithCrossOn: (2@1).
	
	miTerniLapilli putCircleOn: (1@1).
	miTerniLapilli putCrossOn: (2@2).
	miTerniLapilli putCircleOn: (1@2).
	miTerniLapilli putCrossOn: (2@3).
	
	self assert: miTerniLapilli isOver.
	self assert: miTerniLapilli hasPlayerCrossWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:44'!
test13APlayerWinsAfterComplettingAVerticalLineAndGameIsOver
	
	middleCrossTerniLapilli putCircleOn: (1@1).
	middleCrossTerniLapilli putCrossOn: (1@2).
	middleCrossTerniLapilli putCircleOn: (3@3).
	middleCrossTerniLapilli putCrossOn: (3@2).
	
	self assert: middleCrossTerniLapilli isOver.
	self assert: middleCrossTerniLapilli hasPlayerCrossWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:41'!
test14APlayerWinsAfterComplettingADiagonalLineAndGameIsOver
	
	crossOn12TerniLapilli putCircleOn: (1@1).
	crossOn12TerniLapilli putCrossOn: (1@3).
	crossOn12TerniLapilli putCircleOn: (2@2).
	crossOn12TerniLapilli putCrossOn: (3@2).
	crossOn12TerniLapilli putCircleOn: (3@3).
	
	self assert: crossOn12TerniLapilli isOver.
	self assert: crossOn12TerniLapilli hasPlayerCircleWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:37'!
test15CannotPlaceAPieceIfGameIsOver
	
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

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:34'!
test16CannotPlaceAPieceOutsideOfBoardRange
	
	self should: [middleCrossTerniLapilli putCircleOn: (50@50).] 
	raise: Error  
	withExceptionDo: [:anError|
			self assert: anError messageText = TerniLapilli cannotPlacePieceOnAnInvalidPositionErrorDescription.
	].

	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:31'!
test17CanSlideHorizontally
	
	crossOn12TerniLapilli putCircleOn: (1@1).
	crossOn12TerniLapilli putCrossOn: (1@3).
	crossOn12TerniLapilli putCircleOn: (2@2).
	crossOn12TerniLapilli putCrossOn: (3@2).
	crossOn12TerniLapilli putCircleOn: (2@3).
	
	crossOn12TerniLapilli slideCrossFrom: (3@2) towards: (3@1).	
	
	self deny: crossOn12TerniLapilli isOver.
	self assert: (crossOn12TerniLapilli isPositionACross: (3@1)).
	self assert: (crossOn12TerniLapilli isPositionEmpty: (3@2))! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:27'!
test18CanSlideVertically
	
	crossOn12TerniLapilli putCircleOn: (1@1).
	crossOn12TerniLapilli putCrossOn: (1@3).
	crossOn12TerniLapilli putCircleOn: (2@2).
	crossOn12TerniLapilli putCrossOn: (3@1).
	crossOn12TerniLapilli putCircleOn: (2@3).
	
	crossOn12TerniLapilli slideCrossFrom: (3@1) towards: (2@1).
	
	self deny: crossOn12TerniLapilli isOver.
	self assert: (crossOn12TerniLapilli isPositionACross: (2@1)).
	self assert: (crossOn12TerniLapilli isPositionEmpty: (3@1))! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:25'!
test19CanSlideOnAValidDiagonal
	
	slidingPhaseTerniLapilli slideCrossFrom: (2@2) towards: (3@3).
	
	self deny: slidingPhaseTerniLapilli isOver.
	self assert: (slidingPhaseTerniLapilli isPositionACross: (3@3)).
	self assert: (slidingPhaseTerniLapilli isPositionEmpty: (2@2))! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:21'!
test20CanWinAfterSliding
	
	slidingPhaseTerniLapilli slideCrossFrom: (2@3) towards: (3@3).
	
	self assert: slidingPhaseTerniLapilli isOver.
	self assert: slidingPhaseTerniLapilli hasPlayerCrossWon.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:18'!
test21CrossSlidesAfterCircle
	
	self assert: slidingPhaseTerniLapilli isPlayingCross.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:56:15'!
test22CircleSlidesAfterCross
	
	slidingPhaseTerniLapilli slideCrossFrom: (2@2) towards: (3@2).
	self assert: slidingPhaseTerniLapilli isPlayingCircle
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 16:01:27'!
test23SlidingACircleOnlyModifiesTwoBoardPositions
	
	slidingPhaseTerniLapilli slideCrossFrom: (2@2) towards: (3@3).
	slidingPhaseTerniLapilli slideCircleFrom: (3@1) towards: (2@1).
	
	self assert: (slidingPhaseTerniLapilli isPositionACross: (1@1)).
	self assert: (slidingPhaseTerniLapilli isPositionACircle: (1@2)).
	self assert: (slidingPhaseTerniLapilli isPositionACircle: (1@3)).
	self assert: (slidingPhaseTerniLapilli isPositionACircle: (2@1)).
	self assert: (slidingPhaseTerniLapilli isPositionEmpty: (2@2)).
	self assert: (slidingPhaseTerniLapilli isPositionACross: (2@3)).
	self assert: (slidingPhaseTerniLapilli isPositionEmpty: (3@1)).
	self assert: (slidingPhaseTerniLapilli isPositionEmpty: (3@2)).
	self assert: (slidingPhaseTerniLapilli isPositionACross: (3@3)).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 16:01:42'!
test24SlidingACrossOnlyModifiesTwoBoardPositions
	
	slidingPhaseTerniLapilli slideCrossFrom: (2@2) towards: (3@3).
	
	self assert: (slidingPhaseTerniLapilli isPositionACross: (1@1)).
	self assert: (slidingPhaseTerniLapilli isPositionACircle: (1@2)).
	self assert: (slidingPhaseTerniLapilli isPositionACircle: (1@3)).
	self assert: (slidingPhaseTerniLapilli isPositionEmpty: (2@1)).
	self assert: (slidingPhaseTerniLapilli isPositionEmpty: (2@2)).
	self assert: (slidingPhaseTerniLapilli isPositionACross: (2@3)).
	self assert: (slidingPhaseTerniLapilli isPositionACircle: (3@1)).
	self assert: (slidingPhaseTerniLapilli isPositionEmpty: (3@2)).
	self assert: (slidingPhaseTerniLapilli isPositionACross: (3@3)).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 16:06:59'!
test25CannotSlideToAnInvalidPosition
	
	self should: [slidingPhaseTerniLapilli slideCrossFrom: (2@3) towards: (2@4).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceToAnInvalidPositionErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 16:07:14'!
test26CannotSlideToAnOccupiedPosition
	
	self should: [slidingPhaseTerniLapilli slideCrossFrom: (2@3) towards: (2@2).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceToAnOcuppiedPositionErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 16:01:34'!
test27CannotSlideAPieceThatIsNotYours
	
	self should: [slidingPhaseTerniLapilli slideCrossFrom: (3@1) towards: (3@2).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceThatIsNotYoursErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:55:42'!
test28CannotSlideToALocationThatNeedsToGoThroughMoreThanOnePosition
	
	crossOn11TerniLapilli putCircleOn: (1@2).
	crossOn11TerniLapilli putCrossOn: (2@2).
	crossOn11TerniLapilli putCircleOn: (1@3).
	crossOn11TerniLapilli putCrossOn: (2@3).
	crossOn11TerniLapilli putCircleOn: (3@2).
	
	self should: [crossOn11TerniLapilli slideCrossFrom: (1@1) towards: (3@1).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlideToAnUnreachablePositionErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:55:38'!
test29CannotSlideIfGameIsFinished
	
	slidingPhaseTerniLapilli slideCrossFrom: (1@1) towards: (2@1).
	
	self should: [slidingPhaseTerniLapilli slideCircleFrom: (3@1) towards: (3@2)]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceWhenGameIsFinishedErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:55:32'!
test30CannotSlideWhenStillPlacingPieces
	
	crossOn11TerniLapilli putCircleOn: (1@2).
	crossOn11TerniLapilli putCrossOn: (2@2).
	crossOn11TerniLapilli putCircleOn: (1@3).
	crossOn11TerniLapilli putCrossOn: (3@2).
	
	self should: [crossOn11TerniLapilli slideCircleFrom: (1@3) towards: (2@3).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceWhenStillPlacingPiecesErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:55:29'!
test31CannotSlideCrossWhenItIsNotCrossTurn
	
	slidingPhaseTerniLapilli slideCrossFrom: (2@2) towards: (3@2).
	
	self should: [slidingPhaseTerniLapilli slideCrossFrom: (1@1) towards: (2@1).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceWhenIsNotYourTurnErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:55:26'!
test32CannotSlideCircleWhenItIsNotCircleTurn
	
	self should: [slidingPhaseTerniLapilli slideCircleFrom: (3@1) towards: (2@1).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceWhenIsNotYourTurnErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 16:26:27'!
test33CannotSlideDiagonalLeftToAPositionForbiddenByBoard
	
	self should: [slidingPhaseTerniLapilli slideCrossFrom: (2@3) towards: (3@2).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceToAnInvalidPositionErrorDescription = anError messageText 
	].
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 16:29:50'!
test34CannotSlideDiagonalRightToAPositionForbiddenByBoard

	crossOn11TerniLapilli putCircleOn: (1@3).
	crossOn11TerniLapilli putCrossOn: (1@2).
	crossOn11TerniLapilli putCircleOn: (2@2).
	crossOn11TerniLapilli putCrossOn: (3@1).
	crossOn11TerniLapilli putCircleOn: (3@2).
	
	self should: [crossOn11TerniLapilli slideCrossFrom: (1@2) towards: (2@3).]
	raise: Error
      withExceptionDo: [:anError |
		self assert: TerniLapilli cannotSlidePieceToAnInvalidPositionErrorDescription = anError messageText 
	].
	! !


!TerniLapilliTest methodsFor: 'setup' stamp: 'NI 5/26/2019 15:03:57'!
setUp
	middleCrossTerniLapilli := TerniLapilli startWithCrossOn: (2@2).
	
	crossOn12TerniLapilli := TerniLapilli startWithCrossOn: (1@2).
	
	crossOn11TerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	
	slidingPhaseTerniLapilli := TerniLapilli startWithCrossOn: (1@1).
	slidingPhaseTerniLapilli putCircleOn: (1@2).
	slidingPhaseTerniLapilli putCrossOn: (2@2).
	slidingPhaseTerniLapilli putCircleOn: (1@3).
	slidingPhaseTerniLapilli putCrossOn: (2@3).
	slidingPhaseTerniLapilli putCircleOn: (3@1).! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board turn phase'
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

!TerniLapilli methodsFor: 'assertions' stamp: 'NI 5/27/2019 11:20:03'!
isPositionACircle: aPosition
	^(self at: aPosition) isCircle.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NI 5/27/2019 11:20:07'!
isPositionACross: aPosition
	^(self at: aPosition) isCross! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NI 5/27/2019 11:20:12'!
isPositionEmpty: aPosition
	^(self at: aPosition) isEmpty! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NI 5/26/2019 16:20:03'!
isPositionThatCantSlideDiagonally: aPosition
	|forbiddenDiagonalSlidingPositions|
	
	forbiddenDiagonalSlidingPositions := OrderedCollection with: (1@2) with: (2@1) with: (3@2) with: (2@3).
	^ forbiddenDiagonalSlidingPositions includes: aPosition.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Nip 5/24/2019 20:29:50'!
isPositionValid: aPosition
	^(aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3).! !


!TerniLapilli methodsFor: 'initialization' stamp: 'NI 5/27/2019 11:29:15'!
createBoard
	|slot1 slot2 slot3 slot4 slot5 slot6 slot7 slot8 slot9|
	board := OrderedCollection new. 
	
	slot1 := TerniLapilliEmptyBoardSlot new.
	slot2 := TerniLapilliEmptyBoardSlot new.
	slot3 := TerniLapilliEmptyBoardSlot new.
	slot4 := TerniLapilliEmptyBoardSlot new.
	slot5 := TerniLapilliEmptyBoardSlot new.
	slot6 := TerniLapilliEmptyBoardSlot new.
	slot7 := TerniLapilliEmptyBoardSlot new.
	slot8 := TerniLapilliEmptyBoardSlot new.
	slot9 := TerniLapilliEmptyBoardSlot new.
	
	board add: slot1; add: slot2; add: slot3;add: slot4; add: slot5; add: slot6;add: slot7; add: slot8; add: slot9.! !

!TerniLapilli methodsFor: 'initialization' stamp: 'Nipo 5/27/2019 14:10:47'!
initializeWithCrossOn: aPosition
	phase := PlacingFirstPiecesTerniLapilliPhase for: self.
	self createBoard.
	turn := TerniLapilliCrossTurn new.
	self putCrossOn: aPosition.! !


!TerniLapilli methodsFor: 'operations - placing' stamp: 'Nipo 5/27/2019 14:10:55'!
putCircleOn: aPosition
	turn errorIfACircleIsPlacedWhenIsNotCircleTurn.
	self ensureIsValidPlacingOn: aPosition.
	self placeCircleOnBoardAt: aPosition.
	self changeGameStateIfCircleCompletedALine.
	self changeGamePhase.
	turn := TerniLapilliCrossTurn new.

	! !

!TerniLapilli methodsFor: 'operations - placing' stamp: 'Nipo 5/27/2019 14:11:00'!
putCrossOn: aPosition
	turn errorIfACrossIsPlacedWhenIsNotCrossTurn.
	self ensureIsValidPlacingOn: aPosition. 
	self placeCrossOnBoardAt: aPosition.
	self changeGameStateIfCrossCompletedALine.
	turn := TerniLapilliCircleTurn new.

	! !


!TerniLapilli methodsFor: 'operations - sliding' stamp: 'Nipo 5/27/2019 14:11:05'!
slideCircleFrom: aPosition towards: anotherPosition
	turn errorIfSlidingCircleWhenIsNotCircleTurn.
	self ensureIsValidSlidingFrom: aPosition towards: anotherPosition.
	self errorIfSlidingCircleFromAPositionThatIsNotCircle: aPosition.
	self placeCircleOnBoardAt: anotherPosition.
	self removeFromBoardPieceAt: aPosition.
	self changeGameStateIfCircleCompletedALine.
	turn := TerniLapilliCrossTurn new.

! !

!TerniLapilli methodsFor: 'operations - sliding' stamp: 'Nipo 5/27/2019 14:11:09'!
slideCrossFrom: aPosition towards: anotherPosition
	turn errorIfSlidingCrossWhenIsNotCrossTurn.
	self ensureIsValidSlidingFrom: aPosition towards: anotherPosition.
	self errorIfSlidingCrossFromAPositionThatIsNotCross: aPosition.
	self placeCrossOnBoardAt: anotherPosition.
	self removeFromBoardPieceAt: aPosition.
	self changeGameStateIfCrossCompletedALine.
	turn := TerniLapilliCircleTurn new.

! !


!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/26/2019 21:55:58'!
firstDiagonal
	| firstDiagonal|
	
	firstDiagonal := OrderedCollection new.
	
	firstDiagonal 
		add: (board at: 1);
		add: (board at: 5);
 		add: (board at: 9).

	^ firstDiagonal! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/26/2019 21:56:40'!
firstHorizontalLine
	^ board copyFrom: 1 to: 3! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/26/2019 21:57:17'!
firstVerticalLine
	| firstColumn |
	
	firstColumn := OrderedCollection new.
	firstColumn 
		add: (board at: 1); 
		add: (board at: 4); 
		add: (board at: 7). 
	
	^ firstColumn! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/27/2019 10:43:01'!
placeCircleOnBoardAt: aPosition
	board at: (aPosition x - 1 * 3 + aPosition y) put: (TerniLapilliCircleBoardSlot new). 

	! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/27/2019 10:42:49'!
placeCrossOnBoardAt: aPosition
	board at: (aPosition x - 1 * 3 + aPosition y) put: (TerniLapilliCrossBoardSlot new). 

	! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/27/2019 11:11:13'!
removeFromBoardPieceAt: aPosition
	board at: (aPosition x - 1 * 3 + aPosition y) put: (TerniLapilliEmptyBoardSlot new).! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/26/2019 21:56:21'!
secondDiagonal
	| secondDiagonal|
	
	secondDiagonal := OrderedCollection new.
	
	secondDiagonal 
		add: (board at: 3);
		add: (board at: 5);
 		add: (board at: 7).

	^ secondDiagonal! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/26/2019 21:56:54'!
secondHorizontalLine
	^ board copyFrom: 4 to: 6! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/26/2019 21:57:28'!
secondVerticalLine
	| secondColumn |
	
	secondColumn := OrderedCollection new.
	secondColumn 
		add: (board at: 2); 
		add: (board at: 5); 
		add: (board at: 8). 
	
	^ secondColumn! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/26/2019 21:57:06'!
thirdHorizontalLine
	^ board copyFrom: 7 to: 9! !

!TerniLapilli methodsFor: 'private - board' stamp: 'NI 5/26/2019 21:57:41'!
thirdVerticalLine
	| thirdColumn |
	
	thirdColumn := OrderedCollection new.
	thirdColumn 
		add: (board at: 3); 
		add: (board at: 6); 
		add: (board at: 9). 
	
	^ thirdColumn! !


!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/27/2019 10:39:11'!
errorIfMoreThanThreeOfTheSamePieceArePlaced
	phase errorIfNotInPlacingPhase.
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'Nip 5/24/2019 20:28:50'!
errorIfPlacingAPieceOnAnInvalidPosition: aPosition
	(self isPositionValid: aPosition) ifFalse: [self error: self class cannotPlacePieceOnAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 16:16:49'!
errorIfPlacingAPieceWhenGameIsOver
	^phase errorIfPlacingWhenIsOver.
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/27/2019 11:31:19'!
errorIfPlacingOnAnOccupiedPosition: aPosition
	(self at: aPosition) errorIfPlacingOnAnOccupiedPosition.
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'Nip 5/24/2019 20:30:09'!
errorIfSlidingAPieceFromAnInvalidPosition: aPosition
	(self isPositionValid: aPosition) ifFalse: [self error: self class cannotSlideFromAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/26/2019 16:13:46'!
errorIfSlidingAPieceTowardsAnInvalidPosition: aPosition
    (self isPositionValid: aPosition) ifFalse: [self error: self class cannotSlidePieceToAnInvalidPositionErrorDescription].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/27/2019 11:31:26'!
errorIfSlidingCircleFromAPositionThatIsNotCircle: aPosition
	(self at: aPosition) errorIfSlidingFromAPositionThatIsNotCircle.
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/27/2019 11:31:30'!
errorIfSlidingCrossFromAPositionThatIsNotCross: aPosition
	(self at: aPosition) errorIfSlidingFromAPositionThatIsNotCross.
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/26/2019 16:24:18'!
errorIfSlidingDiagonalFrom: aPosition toAnInvalidPosition: anotherPosition.
	((((aPosition x - anotherPosition x) abs + (aPosition y - anotherPosition y) abs) > 1) and: [(self isPositionThatCantSlideDiagonally: aPosition)]) ifTrue: [self error: self class cannotSlidePieceToAnInvalidPositionErrorDescription]! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 14:43:54'!
errorIfSlidingFrom: aPosition ToAnUnreachablePosition: anotherPosition
	((((aPosition x) - (anotherPosition x)) abs > 1) or: [((aPosition y) - (anotherPosition y)) abs > 1])  ifTrue: [^self error: self class cannotSlideToAnUnreachablePositionErrorDescription ].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/27/2019 11:31:07'!
errorIfSlidingOnAnOccupiedPosition: aPosition
	(self at: aPosition) errorIfSlidingOnAnOccupiedPosition.
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 16:16:49'!
errorIfSlidingWhenGameIsFinished
	phase errorIfSlidingWhenGameIsFinished.
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 16:16:49'!
errorIfSlidingWhenNotAllPiecesArePlaced
	phase errorIfSlidingWhenNotAllPiecesArePlaced.
	
	
	! !


!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/26/2019 16:59:10'!
changeGamePhase
	phase changeGamePhase.
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/27/2019 10:50:01'!
changeGameStateIfCircleCompletedADiagonalLine
	
	(self hasCircleCompletedFirstDiagonal or: 
	self hasCircleCompletedSecondDiagonal)
		ifTrue: [self changeStateToFinishedWithWinner: #Circle].
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/27/2019 10:49:05'!
changeGameStateIfCircleCompletedAHorizontalLine	
	((self hasCircleCompletedFirstHorizontalLine or: 
	self hasCircleCompletedSecondHorizontalLine) or:
	self hasCircleCompletedThirdHorizontalLine)
		ifTrue: [self changeStateToFinishedWithWinner: #Circle].! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/27/2019 10:48:28'!
changeGameStateIfCircleCompletedALine
	self changeGameStateIfCircleCompletedAHorizontalLine.
	self changeGameStateIfCircleCompletedAVerticalLine.
	self changeGameStateIfCircleCompletedADiagonalLine.
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/27/2019 10:51:58'!
changeGameStateIfCircleCompletedAVerticalLine	
	
	((self hasCircleCompletedFirstVerticalLine or: 
	self hasCircleCompletedSecondVerticalLine) or:
	self hasCircleCompletedThirdVerticalLine)
		ifTrue: [self changeStateToFinishedWithWinner: #Circle].
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/27/2019 10:50:44'!
changeGameStateIfCrossCompletedADiagonalLine
	
	(self hasCrossCompletedFirstDiagonal or: 
	self hasCrossCompletedSecondDiagonal)
		ifTrue: [self changeStateToFinishedWithWinner: #Cross].
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/27/2019 10:47:24'!
changeGameStateIfCrossCompletedAHorizontalLine	
	((self hasCrossCompletedFirstHorizontalLine or: 
	self hasCrossCompletedSecondHorizontalLine) or:
	self hasCrossCompletedThirdHorizontalLine)
		ifTrue: [self changeStateToFinishedWithWinner: #Cross].! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/27/2019 10:44:15'!
changeGameStateIfCrossCompletedALine
	self changeGameStateIfCrossCompletedAHorizontalLine.
	self changeGameStateIfCrossCompletedAVerticalLine.
	self changeGameStateIfCrossCompletedADiagonalLine.
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/27/2019 10:48:10'!
changeGameStateIfCrossCompletedAVerticalLine	
	
	((self hasCrossCompletedFirstVerticalLine or: 
	self hasCrossCompletedSecondVerticalLine) or:
	self hasCrossCompletedThirdVerticalLine)
		ifTrue: [self changeStateToFinishedWithWinner: #Cross].
! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nipo 5/27/2019 14:10:40'!
changePhaseToPlacingSecondPieces
	phase := PlacingSecondPiecesTerniLapilliPhase for: self.! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nipo 5/27/2019 14:10:36'!
changePhaseToPlacingThirdPieces
	phase := PlacingThirdPiecesTerniLapilliPhase for: self.! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nipo 5/27/2019 14:10:31'!
changePhaseToSliding
	phase := SlidingTerniLapilliPhase for: self.! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:23:56'!
changeStateToFinishedWithWinner: aPlayer
	phase := FinishedTerniLapilliPhase for: self withWinner: aPlayer.
	! !


!TerniLapilli methodsFor: 'private - valid plays' stamp: 'NI 5/27/2019 10:40:38'!
ensureIsValidPlacingOn: aPosition
	self errorIfPlacingAPieceOnAnInvalidPosition: aPosition.
	self errorIfPlacingAPieceWhenGameIsOver.
	self errorIfPlacingOnAnOccupiedPosition: aPosition.
	self errorIfMoreThanThreeOfTheSamePieceArePlaced.
! !

!TerniLapilli methodsFor: 'private - valid plays' stamp: 'NI 5/27/2019 11:04:22'!
ensureIsValidSlidingFrom: aPosition towards: anotherPosition.
	self errorIfSlidingWhenGameIsFinished.
	self errorIfSlidingWhenNotAllPiecesArePlaced.
	self errorIfSlidingAPieceFromAnInvalidPosition: aPosition.
	self errorIfSlidingAPieceTowardsAnInvalidPosition: anotherPosition.
	self errorIfSlidingOnAnOccupiedPosition: anotherPosition.
	self errorIfSlidingFrom: aPosition ToAnUnreachablePosition: anotherPosition.
	self errorIfSlidingDiagonalFrom: aPosition toAnInvalidPosition: anotherPosition.
! !


!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:01:21'!
hasCircleCompletedFirstDiagonal

	^ self firstDiagonal allSatisfy: [:aPosition | aPosition isCircle]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:02:16'!
hasCircleCompletedFirstHorizontalLine
	^ self firstHorizontalLine allSatisfy: [:aPosition | aPosition isCircle]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:06:03'!
hasCircleCompletedFirstVerticalLine
	
	^ self firstVerticalLine allSatisfy: [:aPosition | aPosition isCircle]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:07:53'!
hasCircleCompletedSecondDiagonal

	^ self secondDiagonal allSatisfy: [:aPosition | aPosition isCircle]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:07:29'!
hasCircleCompletedSecondHorizontalLine
	^ self secondHorizontalLine allSatisfy: [:aPosition | aPosition isCircle]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:06:20'!
hasCircleCompletedSecondVerticalLine
	
	^ self secondVerticalLine allSatisfy: [:aPosition | aPosition isCircle]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:07:19'!
hasCircleCompletedThirdHorizontalLine
	^ self thirdHorizontalLine allSatisfy: [:aPosition | aPosition isCircle]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:06:29'!
hasCircleCompletedThirdVerticalLine
	
	^ self thirdVerticalLine allSatisfy: [:aPosition | aPosition isCircle]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:00:38'!
hasCrossCompletedFirstDiagonal

	^ self firstDiagonal allSatisfy: [:aPosition | aPosition isCross]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:02:09'!
hasCrossCompletedFirstHorizontalLine
	^ self firstHorizontalLine allSatisfy: [:aPosition | aPosition isCross]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:05:58'!
hasCrossCompletedFirstVerticalLine
	
	^ self firstVerticalLine allSatisfy: [:aPosition | aPosition isCross]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:08:11'!
hasCrossCompletedSecondDiagonal

	^ self secondDiagonal allSatisfy: [:aPosition | aPosition isCross]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:07:00'!
hasCrossCompletedSecondHorizontalLine
	^ self secondHorizontalLine allSatisfy: [:aPosition | aPosition isCross]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:06:43'!
hasCrossCompletedSecondVerticalLine
	
	^ self secondVerticalLine allSatisfy: [:aPosition | aPosition isCross]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:07:10'!
hasCrossCompletedThirdHorizontalLine
	^ self thirdHorizontalLine allSatisfy: [:aPosition | aPosition isCross]! !

!TerniLapilli methodsFor: 'private - winning assertions' stamp: 'NI 5/26/2019 22:06:36'!
hasCrossCompletedThirdVerticalLine
	
	^ self thirdVerticalLine allSatisfy: [:aPosition | aPosition isCross]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'initialization' stamp: 'Nipo 5/20/2019 19:33:31'!
startWithCrossOn: aPosition
	^ self new initializeWithCrossOn: aPosition.! !


!TerniLapilli class methodsFor: 'error descriptions' stamp: 'NI 5/26/2019 16:33:25'!
cannotPlacePieceOnAnInvalidPositionErrorDescription
	^'No se puede colocar una pieza en una posición inválida.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'NI 5/26/2019 16:33:35'!
cannotPlacePieceWhenTheGameIsOverErrorDescription
	^'No se puede colocar una pieza si el juego ya terminó!!'! !

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

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'NI 5/26/2019 16:33:47'!
cannotSlideFromAnInvalidPositionErrorDescription
	^'No se puede deslizar una pieza desde una posición inválida'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'NI 5/26/2019 16:33:54'!
cannotSlidePieceThatIsNotYoursErrorDescription
	^'No se puede deslizar una pieza que pertenece al otro jugador o está vacía'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'NI 5/26/2019 16:07:04'!
cannotSlidePieceToAnInvalidPositionErrorDescription
	^'No se puede deslizar una pieza a una posición inválida.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'NI 5/26/2019 16:07:14'!
cannotSlidePieceToAnOcuppiedPositionErrorDescription
	^'No se puede deslizar una pieza hacia una posición ocupada'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'NI 5/26/2019 16:34:00'!
cannotSlidePieceWhenGameIsFinishedErrorDescription
	^'No se puede deslizar una pieza si el juego está terminado'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 14:58:34'!
cannotSlidePieceWhenIsNotYourTurnErrorDescription
	^'No se puede deslizar una pieza cuando no es tu turno'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'JIG 5/24/2019 14:50:27'!
cannotSlidePieceWhenStillPlacingPiecesErrorDescription
	^'No se puede deslizar una pieza hasta que se coloquen todas las piezas correspondientes'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'NI 5/26/2019 16:34:13'!
cannotSlideToAnUnreachablePositionErrorDescription
	^'No se puede deslizar una pieza hacia una posición que no es lindante a tu posición'.! !


!classDefinition: #TerniLapilliBoardSlot category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliBoardSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 10:57:12'!
errorIfPlacingOnAnOccupiedPosition
	self subclassResponsibility.! !

!TerniLapilliBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:07:43'!
errorIfSlidingFromAPositionThatIsNotCircle
	self subclassResponsibility.! !

!TerniLapilliBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:07:47'!
errorIfSlidingFromAPositionThatIsNotCross
	self subclassResponsibility.! !

!TerniLapilliBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 10:59:12'!
errorIfSlidingOnAnOccupiedPosition
	self subclassResponsibility.! !


!TerniLapilliBoardSlot methodsFor: 'assertions' stamp: 'NI 5/27/2019 10:28:02'!
isCircle
	^false! !

!TerniLapilliBoardSlot methodsFor: 'assertions' stamp: 'NI 5/27/2019 10:28:05'!
isCross
	^false! !

!TerniLapilliBoardSlot methodsFor: 'assertions' stamp: 'NI 5/27/2019 10:28:10'!
isEmpty
	^false! !


!classDefinition: #TerniLapilliCircleBoardSlot category: #'TerniLapilli-Exercise'!
TerniLapilliBoardSlot subclass: #TerniLapilliCircleBoardSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliCircleBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:25:23'!
errorIfPlacingOnAnOccupiedPosition
	^self error: TerniLapilli cannotPutPieceOnAnOcuppiedPositionErrorDescription! !

!TerniLapilliCircleBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:07:25'!
errorIfSlidingFromAPositionThatIsNotCircle
	! !

!TerniLapilliCircleBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:25:29'!
errorIfSlidingFromAPositionThatIsNotCross
	^self error: TerniLapilli cannotSlidePieceThatIsNotYoursErrorDescription.! !

!TerniLapilliCircleBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:25:32'!
errorIfSlidingOnAnOccupiedPosition
	^self error: TerniLapilli cannotSlidePieceToAnOcuppiedPositionErrorDescription! !


!TerniLapilliCircleBoardSlot methodsFor: 'assertions' stamp: 'NI 5/27/2019 10:28:23'!
isCircle
	^true! !


!classDefinition: #TerniLapilliCrossBoardSlot category: #'TerniLapilli-Exercise'!
TerniLapilliBoardSlot subclass: #TerniLapilliCrossBoardSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliCrossBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:25:37'!
errorIfPlacingOnAnOccupiedPosition
	^self error: TerniLapilli cannotPutPieceOnAnOcuppiedPositionErrorDescription! !

!TerniLapilliCrossBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:25:42'!
errorIfSlidingFromAPositionThatIsNotCircle
	^self error: TerniLapilli cannotSlidePieceThatIsNotYoursErrorDescription.! !

!TerniLapilliCrossBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:08:11'!
errorIfSlidingFromAPositionThatIsNotCross! !

!TerniLapilliCrossBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:25:46'!
errorIfSlidingOnAnOccupiedPosition
	^self error: TerniLapilli cannotSlidePieceToAnOcuppiedPositionErrorDescription! !


!TerniLapilliCrossBoardSlot methodsFor: 'assertions' stamp: 'NI 5/27/2019 10:28:31'!
isCross
	^true! !


!classDefinition: #TerniLapilliEmptyBoardSlot category: #'TerniLapilli-Exercise'!
TerniLapilliBoardSlot subclass: #TerniLapilliEmptyBoardSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliEmptyBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 10:57:37'!
errorIfPlacingOnAnOccupiedPosition! !

!TerniLapilliEmptyBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:25:52'!
errorIfSlidingFromAPositionThatIsNotCircle
	^self error: TerniLapilli cannotSlidePieceThatIsNotYoursErrorDescription.! !

!TerniLapilliEmptyBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 11:25:55'!
errorIfSlidingFromAPositionThatIsNotCross
	^self error: TerniLapilli cannotSlidePieceThatIsNotYoursErrorDescription.! !

!TerniLapilliEmptyBoardSlot methodsFor: 'errors - testing' stamp: 'NI 5/27/2019 10:59:01'!
errorIfSlidingOnAnOccupiedPosition! !


!TerniLapilliEmptyBoardSlot methodsFor: 'assertions' stamp: 'NI 5/27/2019 10:28:40'!
isEmpty
	^true! !


!classDefinition: #TerniLapilliPhase category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliPhase
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPhase methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:58:47'!
errorIfNotInPlacingPhase
	self error: terniLapilli class cannotPutMoreThanThreeOfTheSamePieceErrorDescription.! !

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


!FinishedTerniLapilliPhase methodsFor: 'terniLapilli game phase' stamp: 'NI 5/26/2019 16:52:28'!
changeGamePhase
! !

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

!PlacingTerniLapilliPhase methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:56:52'!
errorIfNotInPlacingPhase
	! !

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


!PlacingTerniLapilliPhase methodsFor: 'terniLapilli game phase' stamp: 'NI 5/26/2019 16:42:45'!
changeGamePhase
	^ self subclassResponsibility.
	! !


!classDefinition: #PlacingFirstPiecesTerniLapilliPhase category: #'TerniLapilli-Exercise'!
PlacingTerniLapilliPhase subclass: #PlacingFirstPiecesTerniLapilliPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!PlacingFirstPiecesTerniLapilliPhase methodsFor: 'terniLapilli game phase' stamp: 'NI 5/26/2019 16:43:54'!
changeGamePhase
	^ terniLapilli changePhaseToPlacingSecondPieces.! !


!classDefinition: #PlacingSecondPiecesTerniLapilliPhase category: #'TerniLapilli-Exercise'!
PlacingTerniLapilliPhase subclass: #PlacingSecondPiecesTerniLapilliPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!PlacingSecondPiecesTerniLapilliPhase methodsFor: 'terniLapilli game phase' stamp: 'NI 5/26/2019 16:47:41'!
changeGamePhase
	terniLapilli changePhaseToPlacingThirdPieces! !


!classDefinition: #PlacingThirdPiecesTerniLapilliPhase category: #'TerniLapilli-Exercise'!
PlacingTerniLapilliPhase subclass: #PlacingThirdPiecesTerniLapilliPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!PlacingThirdPiecesTerniLapilliPhase methodsFor: 'terniLapilli game phase' stamp: 'NI 5/26/2019 16:44:35'!
changeGamePhase
	terniLapilli changePhaseToSliding.! !


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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:22'!
errorIfACircleIsPlacedWhenIsNotCircleTurn
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:38'!
errorIfACrossIsPlacedWhenIsNotCrossTurn
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:44'!
errorIfSlidingCircleWhenIsNotCircleTurn
	^self subclassResponsibility.! !

!TerniLapilliTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:51'!
errorIfSlidingCrossWhenIsNotCrossTurn
	^self subclassResponsibility.! !



!TerniLapilliTurn methodsFor: 'nextPiece' stamp: 'Nip 5/24/2019 19:16:16'!
nextPiece
	^self subclassResponsibility.! !


!classDefinition: #TerniLapilliCircleTurn category: #'TerniLapilli-Exercise'!
TerniLapilliTurn subclass: #TerniLapilliCircleTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliCircleTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:22'!
errorIfACircleIsPlacedWhenIsNotCircleTurn! !

!TerniLapilliCircleTurn methodsFor: 'errors - testing' stamp: 'Nipo 5/27/2019 14:08:53'!
errorIfACrossIsPlacedWhenIsNotCrossTurn
	self error: TerniLapilli cannotPutTheSamePieceTwiceErrorDescription.! !

!TerniLapilliCircleTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:45'!
errorIfSlidingCircleWhenIsNotCircleTurn! !

!TerniLapilliCircleTurn methodsFor: 'errors - testing' stamp: 'Nipo 5/27/2019 14:09:07'!
errorIfSlidingCrossWhenIsNotCrossTurn
	self error: TerniLapilli cannotSlidePieceWhenIsNotYourTurnErrorDescription.! !


!TerniLapilliCircleTurn methodsFor: 'nextPiece' stamp: 'Nip 5/24/2019 19:16:16'!
nextPiece
	^#Circle.! !


!classDefinition: #TerniLapilliCrossTurn category: #'TerniLapilli-Exercise'!
TerniLapilliTurn subclass: #TerniLapilliCrossTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliCrossTurn methodsFor: 'errors - testing' stamp: 'Nipo 5/27/2019 14:09:24'!
errorIfACircleIsPlacedWhenIsNotCircleTurn
	self error: TerniLapilli cannotPutTheSamePieceTwiceErrorDescription.! !

!TerniLapilliCrossTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:38'!
errorIfACrossIsPlacedWhenIsNotCrossTurn! !

!TerniLapilliCrossTurn methodsFor: 'errors - testing' stamp: 'Nipo 5/27/2019 14:09:31'!
errorIfSlidingCircleWhenIsNotCircleTurn
	self error: TerniLapilli cannotSlidePieceWhenIsNotYourTurnErrorDescription.! !

!TerniLapilliCrossTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:50'!
errorIfSlidingCrossWhenIsNotCrossTurn
	! !


!TerniLapilliCrossTurn methodsFor: 'nextPiece' stamp: 'Nip 5/24/2019 19:16:16'!
nextPiece
	^#Cross.! !
