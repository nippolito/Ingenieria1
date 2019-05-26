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

!TerniLapilliTest methodsFor: 'test' stamp: 'NI 5/26/2019 15:57:01'!
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

!TerniLapilli methodsFor: 'assertions' stamp: 'NI 5/26/2019 15:13:53'!
isPositionACircle: aPosition
	^(self at: aPosition) = #Circle! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NI 5/26/2019 15:13:43'!
isPositionACross: aPosition
	^(self at: aPosition) = #Cross! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NI 5/26/2019 15:14:39'!
isPositionEmpty: aPosition
	^(self at: aPosition) = #Empty! !

!TerniLapilli methodsFor: 'assertions' stamp: 'NI 5/26/2019 16:20:03'!
isPositionThatCantSlideDiagonally: aPosition
	|forbiddenDiagonalSlidingPositions|
	
	forbiddenDiagonalSlidingPositions := OrderedCollection with: (1@2) with: (2@1) with: (3@2) with: (2@3).
	^ forbiddenDiagonalSlidingPositions includes: aPosition.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Nip 5/24/2019 20:29:50'!
isPositionValid: aPosition
	^(aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3).! !


!TerniLapilli methodsFor: 'initialization' stamp: 'Nipo 5/20/2019 20:53:54'!
createBoard
	board := OrderedCollection new. 
	board addAll: #(#Empty #Empty #Empty #Empty #Empty #Empty #Empty #Empty #Empty).! !

!TerniLapilli methodsFor: 'initialization' stamp: 'NI 5/26/2019 17:00:06'!
initializeWithCrossOn: aPosition
	phase := PlacingFirstPiecesTerniLapilliPhase for: self.
	self createBoard.
	turn := CrossTurn for: self.
	self putCrossOn: aPosition.! !


!TerniLapilli methodsFor: 'operations - placing' stamp: 'NI 5/26/2019 16:40:22'!
putCircleOn: aPosition
	turn errorIfACircleIsPlacedWhenIsNotCircleTurn.
	self putPiece: #Circle on: aPosition.
	self changeGamePhase.
	turn := CrossTurn for: self.

	! !

!TerniLapilli methodsFor: 'operations - placing' stamp: 'NI 5/26/2019 16:31:38'!
putCrossOn: aPosition
	turn errorIfACrossIsPlacedWhenIsNotCrossTurn.
	self putPiece: #Cross on: aPosition.
	turn := CircleTurn for: self.

	! !


!TerniLapilli methodsFor: 'operations - sliding' stamp: 'NI 5/26/2019 16:31:45'!
slideCircleFrom: aPosition towards: anotherPosition
	turn errorIfSlidingCircleWhenIsNotCircleTurn.
	self slidePiece: #Circle from: aPosition towards: anotherPosition.
	turn := CrossTurn for: self.

! !

!TerniLapilli methodsFor: 'operations - sliding' stamp: 'NI 5/26/2019 16:31:51'!
slideCrossFrom: aPosition towards: anotherPosition
	turn errorIfSlidingCrossWhenIsNotCrossTurn.
	self slidePiece: #Cross from: aPosition towards: anotherPosition.
	turn := CircleTurn for: self.

! !


!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/26/2019 16:59:33'!
errorIfMoreThanThreeOfTheSamePieceArePlaced: aPiece
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

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 14:25:26'!
errorIfPlacingOnAnOccupiedPosition: aPosition
	((self at: aPosition) = #Empty) ifFalse: [^self error: self class cannotPutPieceOnAnOcuppiedPositionErrorDescription].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'Nip 5/24/2019 20:30:09'!
errorIfSlidingAPieceFromAnInvalidPosition: aPosition
	(self isPositionValid: aPosition) ifFalse: [self error: self class cannotSlideFromAnInvalidPositionErrorDescription ].
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/26/2019 16:13:46'!
errorIfSlidingAPieceTowardsAnInvalidPosition: aPosition
    (self isPositionValid: aPosition) ifFalse: [self error: self class cannotSlidePieceToAnInvalidPositionErrorDescription].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/26/2019 16:24:18'!
errorIfSlidingDiagonalFrom: aPosition toAnInvalidPosition: anotherPosition.
	((((aPosition x - anotherPosition x) abs + (aPosition y - anotherPosition y) abs) > 1) and: [(self isPositionThatCantSlideDiagonally: aPosition)]) ifTrue: [self error: self class cannotSlidePieceToAnInvalidPositionErrorDescription]! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 14:43:54'!
errorIfSlidingFrom: aPosition ToAnUnreachablePosition: anotherPosition
	((((aPosition x) - (anotherPosition x)) abs > 1) or: [((aPosition y) - (anotherPosition y)) abs > 1])  ifTrue: [^self error: self class cannotSlideToAnUnreachablePositionErrorDescription ].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'JIG 5/24/2019 14:31:36'!
errorIfSlidingFromAPositionThatIsNotYours: aPosition playingAs: aPiece.
	((self at: aPosition) = aPiece) ifFalse: [^self error: self class cannotSlidePieceThatIsNotYoursErrorDescription ].
	
	! !

!TerniLapilli methodsFor: 'private - errors' stamp: 'NI 5/26/2019 16:07:14'!
errorIfSlidingOnAnOccupiedPosition: aPosition
	((self at: aPosition) = #Empty) ifFalse: [^self error: self class cannotSlidePieceToAnOcuppiedPositionErrorDescription ].
	
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

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/26/2019 16:45:39'!
changePhaseToPlacingSecondPieces
	phase := PlacingSecondPiecesTerniLapilliPhase for: self.! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/26/2019 16:45:48'!
changePhaseToPlacingThirdPieces
	phase := PlacingThirdPiecesTerniLapilliPhase for: self.! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'NI 5/26/2019 16:45:59'!
changePhaseToSliding
	phase := SlidingTerniLapilliPhase for: self.! !

!TerniLapilli methodsFor: 'private - game state' stamp: 'Nip 5/24/2019 20:23:56'!
changeStateToFinishedWithWinner: aPlayer
	phase := FinishedTerniLapilliPhase for: self withWinner: aPlayer.
	! !


!TerniLapilli methodsFor: 'private - operations' stamp: 'JIG 5/21/2019 15:33:06'!
placePieceOnBoard: aPiece at: aPosition
	board at: (aPosition x - 1 * 3 + aPosition y) put: aPiece. 

	! !

!TerniLapilli methodsFor: 'private - operations' stamp: 'NI 5/26/2019 16:39:18'!
putPiece: aPiece on: aPosition
	self errorIfPlacingAPieceOnAnInvalidPosition: aPosition.
	self errorIfPlacingAPieceWhenGameIsOver.
	self errorIfPlacingOnAnOccupiedPosition: aPosition.
	self errorIfMoreThanThreeOfTheSamePieceArePlaced: aPiece.
	
	self placePieceOnBoard: aPiece at: aPosition.
	self changeGameStateIfAnyPlayerCompletedALine.

	! !

!TerniLapilli methodsFor: 'private - operations' stamp: 'NI 5/26/2019 16:25:48'!
slidePiece: aPiece from: aPosition towards: anotherPosition
	self errorIfSlidingWhenGameIsFinished.
	self errorIfSlidingWhenNotAllPiecesArePlaced.
	self errorIfSlidingAPieceFromAnInvalidPosition: aPosition.
	self errorIfSlidingAPieceTowardsAnInvalidPosition: anotherPosition.
	self errorIfSlidingOnAnOccupiedPosition: anotherPosition.
	self errorIfSlidingFromAPositionThatIsNotYours: aPosition playingAs: aPiece.
	self errorIfSlidingFrom: aPosition ToAnUnreachablePosition: anotherPosition.
	self errorIfSlidingDiagonalFrom: aPosition toAnInvalidPosition: anotherPosition.
	
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
	instanceVariableNames: 'terniLapilli'
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

!CircleTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:22'!
errorIfACircleIsPlacedWhenIsNotCircleTurn! !

!CircleTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:38'!
errorIfACrossIsPlacedWhenIsNotCrossTurn
	self error: terniLapilli class cannotPutTheSamePieceTwiceErrorDescription.! !

!CircleTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:45'!
errorIfSlidingCircleWhenIsNotCircleTurn! !

!CircleTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:51'!
errorIfSlidingCrossWhenIsNotCrossTurn
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

!CrossTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:22'!
errorIfACircleIsPlacedWhenIsNotCircleTurn
	self error: terniLapilli class cannotPutTheSamePieceTwiceErrorDescription.! !

!CrossTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:38'!
errorIfACrossIsPlacedWhenIsNotCrossTurn! !

!CrossTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:44'!
errorIfSlidingCircleWhenIsNotCircleTurn
	self error: terniLapilli class cannotSlidePieceWhenIsNotYourTurnErrorDescription.! !

!CrossTurn methodsFor: 'errors - testing' stamp: 'NI 5/26/2019 16:31:50'!
errorIfSlidingCrossWhenIsNotCrossTurn
	! !


!CrossTurn methodsFor: 'nextPiece' stamp: 'Nip 5/24/2019 19:16:16'!
nextPiece
	^#Cross.! !
