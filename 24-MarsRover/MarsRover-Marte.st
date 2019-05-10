!classDefinition: #MarsRoverTest category: #'MarsRover-Marte'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 17:53:42'!
test01ProcessingAnEmptyStringDoesNothing
	"Estamos testeando que la secuencia vacia no tome efecto"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := ''.
	
	aMarsRover process: aSequenceOfCommands.
	
	self assert: (aMarsRover isAt: (0@0) pointing: #North).
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 17:53:46'!
test02MovesForwardWhenProcessingForwardCommand
	"Estamos testeando avanzar adelante mirando hacia el norte una vez"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'f'.
	
	aMarsRover process: aSequenceOfCommands.
	
	self deny: (aMarsRover isAt: (0@0) pointing: #North).
	self assert: (aMarsRover isAt: (0@1) pointing: #North).
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 17:53:49'!
test03MovesForwardMoreThanOneTimeWhenProcessingManyForwardCommands
	"Estamos testeando avanzar adelante yendo al norte mas de una vez"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'ff'.
	
	aMarsRover process: aSequenceOfCommands.
	
	self assert: (aMarsRover isAt: (0@2) pointing: #North).
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 17:53:55'!
test04MovesBackwardWhenProcessingBackwardCommand
	"Estamos testeando retroceder mirando al norte una vez"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'b'.
	
	aMarsRover process: aSequenceOfCommands.
	
	self assert: (aMarsRover isAt: (0@-1) pointing: #North).
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 17:54:20'!
test05RotatesLeftWhenProcessingLeftCommand
	"Estamos testeando rotar a la izquierda una vez mirando inicialmente al norte"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'l'.
	
	aMarsRover process: aSequenceOfCommands.
	
	self assert: (aMarsRover isAt: (0@0) pointing: #West).! !

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 17:54:33'!
test06RotatesRightWhenProcessingRightCommand
	"Estamos testeando rotar a la derecha una vez mirando inicialmente al norte"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'r'.
	
	aMarsRover process: aSequenceOfCommands.
	
	self deny: (aMarsRover isAt: (0@0) pointing: #North).
	self assert: (aMarsRover isAt: (0@0) pointing: #East).! !

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 18:15:35'!
test07DoesntProcessAnInvalidCommand
	"Estamos testeando que avanzar y luego tener un comando invalido nos devuelva una excepcion pero que se quede fijo"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'x'.
	
	self should: [ aMarsRover process: aSequenceOfCommands. ] 
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: MarsRover cannotProcessInvalidCommand = anError messageText.
			self assert: (aMarsRover isAt: (0@0) pointing: #North).
			].! !

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 18:15:48'!
test08KeepsProcessingUntilAnInvalidCommandComesIn
	"Estamos testeando que avanzar y luego tener un comando invalido nos devuelva una excepcion pero que haya avanzado una UNICA vez"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'fxf'.
	
	self should: [ aMarsRover process: aSequenceOfCommands. ] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: MarsRover cannotProcessInvalidCommand = anError messageText.
			self assert: (aMarsRover isAt: (0@1) pointing: #North).].! !

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 18:04:49'!
test09CanRotateLeftManyTimes
	"Estamos testeando que rotar realizar 4 rotaciones hacia la izquierda nos da correctamente las 4 orientaciones (y se mantiene fija la coordenada)."
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'lllll'.
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #West).
	
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

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 18:05:29'!
test10CanRotateRightManyTimes
	"Estamos testeando que rotar realizar 4 rotaciones hacia la derecha nos da correctamente las 4 orientaciones (y se mantiene fija la coordenada)."
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'rrrrr'.
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #East).
	
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

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 18:35:15'!
test11MovesForwardInAnyOrientation
	"Estamos testeando que rotar izquierda y luego avanzar, debe considerar hacia que direccion debe avanzar"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'lf'.
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (-1@0) pointing: #West).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (-1@-1) pointing: #South).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@-1) pointing: #East).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #North).
	
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

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 18:35:38'!
test12MovesBackwardsInAnyOrientation
	"Estamos testeando que rotar derecha y luego retroceder, debe considerar hacia que direccion debe retroceder"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'rb'.
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (-1@0) pointing: #East).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (-1@1) pointing: #South).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@1) pointing: #West).
	
	aMarsRover process: aSequenceOfCommands.
	self assert: (aMarsRover isAt: (0@0) pointing: #North).! !

!MarsRoverTest methodsFor: 'test' stamp: 'JIG 5/10/2019 18:36:53'!
test13AnyInvalidCommandShouldStopTheProcessing
	"Estamos testeando que cualquier comando invalido deje de ejecutar en el ?"
	| aMarsRover aSequenceOfCommands |
	
	aMarsRover := MarsRover at: 0@0 pointing: #North.
	aSequenceOfCommands := 'ffffbfr?ffrfb'.
	
	self should: [ aMarsRover process: aSequenceOfCommands. ] 
		raise: Error 
		withExceptionDo: [:anException | self assert: (aMarsRover isAt: (0@4) pointing: #East).].! !


!classDefinition: #MarsRover category: #'MarsRover-Marte'!
Object subclass: #MarsRover
	instanceVariableNames: 'location direction state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRover methodsFor: 'operations' stamp: 'JIG 5/10/2019 18:13:14'!
process: aSequenceOfCommands
	aSequenceOfCommands do: [:aCommand |
		(self isValidCommand: aCommand) ifTrue: [self processSingleCommand: aCommand] 
			ifFalse: [self error: self class cannotProcessInvalidCommand ].
	].
! !


!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 18:10:39'!
isValidCommand: aCommand
	^((aCommand = $r or: aCommand = $l) or: aCommand = $f) or: aCommand = $b.! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:37:05'!
moveBackwardsWhenEastOrientation
	location := location - (1@0).! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:37:20'!
moveBackwardsWhenNorthOrientation
	location := location - (0@1).! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:37:31'!
moveBackwardsWhenSouthOrientation
	location := location - (0@-1).! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:37:41'!
moveBackwardsWhenWestOrientation
	location := location - (-1@0).! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:34:51'!
moveForwardWhenEastOrientation
	location := location + (1@0).! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:35:01'!
moveForwardWhenNorthOrientation
	location := location + (0@1).! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:35:18'!
moveForwardWhenSouthOrientation
	location := location + (0@-1).! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:35:10'!
moveForwardWhenWestOrientation
	location := location + (-1@0).! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 18:08:59'!
processSingleCommand: aCommand
	aCommand = $f ifTrue: [ state moveForward ].
	aCommand = $b ifTrue: [ state moveBackwards ].
	aCommand = $l ifTrue: [ state turnLeft ].
	aCommand = $r ifTrue: [ state turnRight ].
		! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:27:55'!
turnLeftWhenEastOrientation
	direction := #North.
	state := MarsRoverNorthOrientationState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:28:15'!
turnLeftWhenNorthOrientation
	direction := #West.
	state := MarsRoverWestOrientationState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:30:19'!
turnLeftWhenSouthOrientation
	direction := #East.
	state := MarsRoverEastOrientationState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:29:09'!
turnLeftWhenWestOrientation
	direction := #South.
	state := MarsRoverSouthOrientationState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:32:21'!
turnRightWhenEastOrientation
	direction := #South.
	state := MarsRoverSouthOrientationState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:32:47'!
turnRightWhenNorthOrientation
	direction := #East.
	state := MarsRoverEastOrientationState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:32:32'!
turnRightWhenSouthOrientation
	direction := #West.
	state := MarsRoverWestOrientationState new initializeWith: self.! !

!MarsRover methodsFor: 'private' stamp: 'JIG 5/10/2019 17:32:40'!
turnRightWhenWestOrientation
	direction := #North.
	state := MarsRoverNorthOrientationState new initializeWith: self.! !


!MarsRover methodsFor: 'initialization' stamp: 'JIG 5/10/2019 17:22:57'!
initializeAt: aPoint pointing: aDirection 
	location := aPoint.
	direction := aDirection.
	(aDirection = #North) ifTrue: [ state := MarsRoverNorthOrientationState new initializeWith: self].
	(aDirection = #West) ifTrue: [ state := MarsRoverWestOrientationState new initializeWith: self].
	(aDirection = #South) ifTrue: [ state := MarsRoverSouthOrientationState new initializeWith: self].
	(aDirection = #East) ifTrue: [ state := MarsRoverEastOrientationState new initializeWith: self].
	! !


!MarsRover methodsFor: 'testing' stamp: 'JIG 5/10/2019 15:54:37'!
isAt: aPoint pointing: aDirection
	^aPoint = location and: aDirection = direction.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Marte'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error messages' stamp: 'JIG 5/10/2019 18:12:21'!
cannotProcessInvalidCommand
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

!MarsRoverState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:25:54'!
turnLeft
	^self subclassResponsibility.! !

!MarsRoverState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:31:17'!
turnRight
	^self subclassResponsibility.! !


!MarsRoverState methodsFor: 'initialization' stamp: 'JIG 5/10/2019 17:23:57'!
initializeWith: aMarsRover
	marsRover := aMarsRover.! !


!classDefinition: #MarsRoverEastOrientationState category: #'MarsRover-Marte'!
MarsRoverState subclass: #MarsRoverEastOrientationState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverEastOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:36:15'!
moveBackwards
	marsRover moveBackwardsWhenEastOrientation.! !

!MarsRoverEastOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:33:50'!
moveForward
	marsRover moveForwardWhenEastOrientation.! !

!MarsRoverEastOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:26:20'!
turnLeft
	marsRover turnLeftWhenEastOrientation.! !

!MarsRoverEastOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:31:31'!
turnRight
	marsRover turnRightWhenEastOrientation.! !


!classDefinition: #MarsRoverNorthOrientationState category: #'MarsRover-Marte'!
MarsRoverState subclass: #MarsRoverNorthOrientationState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverNorthOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:36:29'!
moveBackwards
	marsRover moveBackwardsWhenNorthOrientation.! !

!MarsRoverNorthOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:34:02'!
moveForward
	marsRover moveForwardWhenNorthOrientation.! !

!MarsRoverNorthOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:26:41'!
turnLeft
	marsRover turnLeftWhenNorthOrientation.! !

!MarsRoverNorthOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:31:42'!
turnRight
	marsRover turnRightWhenNorthOrientation.! !


!classDefinition: #MarsRoverSouthOrientationState category: #'MarsRover-Marte'!
MarsRoverState subclass: #MarsRoverSouthOrientationState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverSouthOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:36:36'!
moveBackwards
	marsRover moveBackwardsWhenSouthOrientation.! !

!MarsRoverSouthOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:34:10'!
moveForward
	marsRover moveForwardWhenSouthOrientation.! !

!MarsRoverSouthOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:26:50'!
turnLeft
	marsRover turnLeftWhenSouthOrientation.! !

!MarsRoverSouthOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:31:52'!
turnRight
	marsRover turnRightWhenSouthOrientation.! !


!classDefinition: #MarsRoverWestOrientationState category: #'MarsRover-Marte'!
MarsRoverState subclass: #MarsRoverWestOrientationState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Marte'!

!MarsRoverWestOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:36:42'!
moveBackwards
	marsRover moveBackwardsWhenWestOrientation.! !

!MarsRoverWestOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:34:17'!
moveForward
	marsRover moveForwardWhenWestOrientation.! !

!MarsRoverWestOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:26:58'!
turnLeft
	marsRover turnLeftWhenWestOrientation.! !

!MarsRoverWestOrientationState methodsFor: 'marsRover operations' stamp: 'JIG 5/10/2019 17:32:03'!
turnRight
	marsRover turnRightWhenWestOrientation.! !
