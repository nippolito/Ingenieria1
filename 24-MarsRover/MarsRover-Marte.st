!classDefinition: #MarsRoverTest category: #'MarsRover-Marte'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'ourMarsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:21:28'!
setUp
	ourMarsRover := MarsRover at: 0@0 pointing: #North.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:22:17'!
test01ProcessingAnEmptyStringDoesNothing
	"Estamos testeando que la secuencia vacia no tome efecto"
	| aSequenceOfCommands |
	aSequenceOfCommands := ''.
	
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (0@0) pointing: #North).
! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:23:05'!
test02MovesForwardWhenProcessingForwardCommand
	"Estamos testeando avanzar adelante mirando hacia el norte una vez"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'f'.
	ourMarsRover process: aSequenceOfCommands.
	self deny: (ourMarsRover isAt: (0@0) pointing: #North).
	self assert: (ourMarsRover isAt: (0@1) pointing: #North).
! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:23:47'!
test03MovesForwardMoreThanOneTimeWhenProcessingManyForwardCommands
	"Estamos testeando avanzar adelante yendo al norte mas de una vez"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'ff'.
	ourMarsRover process: aSequenceOfCommands.
	
	self assert: (ourMarsRover isAt: (0@2) pointing: #North).
! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:24:11'!
test04MovesBackwardWhenProcessingBackwardCommand
	"Estamos testeando retroceder mirando al norte una vez"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'b'.
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (0@-1) pointing: #North).
! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:24:40'!
test05RotatesLeftWhenProcessingLeftCommand
	"Estamos testeando rotar a la izquierda una vez mirando inicialmente al norte"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'l'.
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (0@0) pointing: #West).! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:25:02'!
test06RotatesRightWhenProcessingRightCommand
	"Estamos testeando rotar a la derecha una vez mirando inicialmente al norte"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'r'.
	ourMarsRover process: aSequenceOfCommands.
	self deny: (ourMarsRover isAt: (0@0) pointing: #North).
	self assert: (ourMarsRover isAt: (0@0) pointing: #East).! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/13/2019 10:21:35'!
test07DoesntProcessAnInvalidCommand
	"Estamos testeando que avanzar y luego tener un comando invalido nos devuelva una excepcion pero que se quede fijo"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'x'.
	self should: [ ourMarsRover process: aSequenceOfCommands. ] 		raise: Error 		withExceptionDo: [ :anError |			self assert: MarsRover cannotProcessInvalidCommandErrorDescription = anError messageText.			self assert: (ourMarsRover isAt: (0@0) pointing: #North).			].! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/13/2019 10:21:35'!
test08KeepsProcessingUntilAnInvalidCommandComesIn
	"Estamos testeando que avanzar y luego tener un comando invalido nos devuelva una excepcion pero que haya avanzado una UNICA vez"
	| aSequenceOfCommands |

	aSequenceOfCommands := 'fxf'.
	self should: [ ourMarsRover process: aSequenceOfCommands. ] 		raise: Error 		withExceptionDo: [:anError | 			self assert: MarsRover cannotProcessInvalidCommandErrorDescription = anError messageText.			self assert: (ourMarsRover isAt: (0@1) pointing: #North).].! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:26:24'!
test09CanRotateLeftManyTimes
	"Estamos testeando que rotar realizar 4 rotaciones hacia la izquierda nos da correctamente las 4 orientaciones (y se mantiene fija la coordenada)."
	| aSequenceOfCommands |
	aSequenceOfCommands := 'lllll'.
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (0@0) pointing: #West).
	"
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #West).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #South).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #East).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #North).
	"! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:26:44'!
test10CanRotateRightManyTimes
	"Estamos testeando que rotar realizar 4 rotaciones hacia la derecha nos da correctamente las 4 orientaciones (y se mantiene fija la coordenada)."
	| aSequenceOfCommands |
	aSequenceOfCommands := 'rrrrr'.
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (0@0) pointing: #East).
	"
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #East).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #South).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #West).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #North).
	"! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:27:46'!
test11MovesForwardInAnyOrientation
	"Estamos testeando que rotar izquierda y luego avanzar, debe considerar hacia que direccion debe avanzar"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'lf'.
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (-1@0) pointing: #West).
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (-1@-1) pointing: #South).
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (0@-1) pointing: #East).
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (0@0) pointing: #North).
	"	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'rf'.
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (1@0) pointing: #East).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (1@-1) pointing: #South).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@-1) pointing: #West).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #North)."! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:29:04'!
test12MovesBackwardsInAnyOrientation
	"Estamos testeando que rotar derecha y luego retroceder, debe considerar hacia que direccion debe retroceder"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'rb'.
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (-1@0) pointing: #East).
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (-1@1) pointing: #South).
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (0@1) pointing: #West).
	ourMarsRover process: aSequenceOfCommands.
	self assert: (ourMarsRover isAt: (0@0) pointing: #North).! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:29:30'!
test13AnyInvalidCommandShouldStopTheProcessing
	"Estamos testeando que cualquier comando invalido deje de ejecutar en el ?"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'ffffbfr?ffrfb'.
	self should: [ ourMarsRover process: aSequenceOfCommands. ] 
		raise: Error 
		withExceptionDo: [:anException | self assert: (ourMarsRover isAt: (0@4) pointing: #East).].! !


!classDefinition: #MarsRover category: #'MarsRover-Marte'!
Object subclass: #MarsRover
	instanceVariableNames: 'location state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRover methodsFor: 'operations' stamp: 'Nip 5/13/2019 10:02:36'!
moveBackwards
	state moveBackwards.
		! !

!MarsRover methodsFor: 'operations' stamp: 'Nip 5/13/2019 10:02:16'!
moveForward
	state moveForward.
		! !

!MarsRover methodsFor: 'operations' stamp: 'Nip 5/13/2019 10:21:35'!
process: aSequenceOfCommands
	aSequenceOfCommands do: [:aCommand |
		(self isValidCommand: aCommand) ifTrue: [self processSingleCommand: aCommand] 
			ifFalse: [self error: self class cannotProcessInvalidCommandErrorDescription ].
	].
! !

!MarsRover methodsFor: 'operations' stamp: 'Nip 5/13/2019 10:03:42'!
rotateLeft
	state rotateLeft.
		! !

!MarsRover methodsFor: 'operations' stamp: 'Nip 5/13/2019 10:03:52'!
rotateRight
	state rotateRight.
		! !


!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:17:55'!
isValidCommand: aCommand
	^ #($r $l $f $b) includes: aCommand.! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:26:00'!
moveBackwardsWhenPointingEast
	location := location - (1@0).! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:26:07'!
moveBackwardsWhenPointingNorth
	location := location - (0@1).! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:26:16'!
moveBackwardsWhenPointingSouth
	location := location - (0@-1).! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:26:23'!
moveBackwardsWhenPointingWest
	location := location - (-1@0).! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:35:01'!
moveForwardWhenNorthOrientation
	location := location + (0@1).! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:26:30'!
moveForwardWhenPointingEast
	location := location + (1@0).! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:26:38'!
moveForwardWhenPointingSouth
	location := location + (0@-1).! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:26:44'!
moveForwardWhenPointingWest
	location := location + (-1@0).! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/12/2019 15:39:35'!
pointingTo
	^ state pointingTo.! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:03:52'!
processSingleCommand: aCommand
	aCommand = $f ifTrue: [ self moveForward ].
	aCommand = $b ifTrue: [ self moveBackwards ].
	aCommand = $l ifTrue: [ self rotateLeft ].
	aCommand = $r ifTrue: [ self rotateRight ].
		! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:26:55'!
rotateLeftWhenPointingEast
	state := MarsRoverPointingNorthState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:27:01'!
rotateLeftWhenPointingNorth
	state := MarsRoverPointingWestState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:27:08'!
rotateLeftWhenPointingSouth
	state := MarsRoverPointingEastState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:27:14'!
rotateLeftWhenPointingWest
	state := MarsRoverPointingSouthState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:27:21'!
rotateRightWhenPointingEast

	state := MarsRoverPointingSouthState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:27:27'!
rotateRightWhenPointingNorth
	state := MarsRoverPointingEastState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:27:34'!
rotateRightWhenPointingSouth
	state := MarsRoverPointingWestState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'Nip 5/13/2019 10:27:40'!
rotateRightWhenPointingWest
	state := MarsRoverPointingNorthState new initializeWith: self.! !


!MarsRover methodsFor: 'initialization' stamp: 'Nip 5/13/2019 10:25:35'!
initializeAt: aPoint pointing: aDirection 
	location := aPoint.
	(aDirection = #North) ifTrue: [ state := MarsRoverPointingNorthState new initializeWith: self].
	(aDirection = #West) ifTrue: [ state := MarsRoverPointingWestState new initializeWith: self].
	(aDirection = #South) ifTrue: [ state := MarsRoverPointingSouthState new initializeWith: self].
	(aDirection = #East) ifTrue: [ state := MarsRoverPointingEastState new initializeWith: self].
	! !


!MarsRover methodsFor: 'testing' stamp: 'Nip 5/12/2019 15:40:52'!
isAt: aPoint pointing: aDirection
	^aPoint = location and: self pointingTo = aDirection.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Marte'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error messages' stamp: 'Nip 5/13/2019 10:21:35'!
cannotProcessInvalidCommandErrorDescription
	^'Comando Invalido'.! !


!MarsRover class methodsFor: 'initialization' stamp: 'JIG 5/10/2019 15:16:30'!
at: aPoint pointing: aDirection
	^self new initializeAt: aPoint pointing: aDirection.! !


!classDefinition: #MarsRoverState category: #'MarsRover-Marte'!
Object subclass: #MarsRoverState
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:35:39'!
moveBackwards
	^self subclassResponsibility.! !

!MarsRoverState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:33:27'!
moveForward
	^self subclassResponsibility.! !

!MarsRoverState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:03:41'!
rotateLeft
	^self subclassResponsibility.! !

!MarsRoverState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:03:52'!
rotateRight
	^self subclassResponsibility.! !


!MarsRoverState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:01'!
pointingTo

	^self subclassResponsibility.! !


!MarsRoverState methodsFor: 'initialization' stamp: 'JIG 5/10/2019 17:23:57'!
initializeWith: aMarsRover
	marsRover := aMarsRover.! !


!classDefinition: #MarsRoverPointingEastState category: #'MarsRover-Marte'!
MarsRoverState subclass: #MarsRoverPointingEastState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverPointingEastState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:15'!
pointingTo
	^ #East! !


!MarsRoverPointingEastState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:26:00'!
moveBackwards
	marsRover moveBackwardsWhenPointingEast.! !

!MarsRoverPointingEastState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:26:30'!
moveForward
	marsRover moveForwardWhenPointingEast.! !

!MarsRoverPointingEastState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:26:55'!
rotateLeft
	marsRover rotateLeftWhenPointingEast.! !

!MarsRoverPointingEastState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:27:21'!
rotateRight
	marsRover rotateRightWhenPointingEast.! !


!classDefinition: #MarsRoverPointingNorthState category: #'MarsRover-Marte'!
MarsRoverState subclass: #MarsRoverPointingNorthState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverPointingNorthState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:23'!
pointingTo
	^ #North! !


!MarsRoverPointingNorthState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:26:07'!
moveBackwards
	marsRover moveBackwardsWhenPointingNorth.! !

!MarsRoverPointingNorthState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:34:02'!
moveForward
	marsRover moveForwardWhenNorthOrientation.! !

!MarsRoverPointingNorthState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:27:01'!
rotateLeft
	marsRover rotateLeftWhenPointingNorth.! !

!MarsRoverPointingNorthState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:27:27'!
rotateRight
	marsRover rotateRightWhenPointingNorth.! !


!classDefinition: #MarsRoverPointingSouthState category: #'MarsRover-Marte'!
MarsRoverState subclass: #MarsRoverPointingSouthState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverPointingSouthState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:29'!
pointingTo
	^ #South! !


!MarsRoverPointingSouthState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:26:16'!
moveBackwards
	marsRover moveBackwardsWhenPointingSouth.! !

!MarsRoverPointingSouthState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:26:38'!
moveForward
	marsRover moveForwardWhenPointingSouth.! !

!MarsRoverPointingSouthState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:27:08'!
rotateLeft
	marsRover rotateLeftWhenPointingSouth.! !

!MarsRoverPointingSouthState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:27:34'!
rotateRight
	marsRover rotateRightWhenPointingSouth.! !


!classDefinition: #MarsRoverPointingWestState category: #'MarsRover-Marte'!
MarsRoverState subclass: #MarsRoverPointingWestState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverPointingWestState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:37'!
pointingTo
	^ #West! !


!MarsRoverPointingWestState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:26:24'!
moveBackwards
	marsRover moveBackwardsWhenPointingWest.! !

!MarsRoverPointingWestState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:26:44'!
moveForward
	marsRover moveForwardWhenPointingWest.! !

!MarsRoverPointingWestState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:27:15'!
rotateLeft
	marsRover rotateLeftWhenPointingWest.! !

!MarsRoverPointingWestState methodsFor: 'marsRover operations' stamp: 'Nip 5/13/2019 10:27:40'!
rotateRight
	marsRover rotateRightWhenPointingWest.! !
