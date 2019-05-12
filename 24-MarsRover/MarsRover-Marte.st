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

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:25:34'!
test07DoesntProcessAnInvalidCommand
	"Estamos testeando que avanzar y luego tener un comando invalido nos devuelva una excepcion pero que se quede fijo"
	| aSequenceOfCommands |
	aSequenceOfCommands := 'x'.
	self should: [ ourMarsRover process: aSequenceOfCommands. ] 		raise: Error 		withExceptionDo: [ :anError |			self assert: MarsRover cannotProcessInvalidCommand = anError messageText.			self assert: (ourMarsRover isAt: (0@0) pointing: #North).			].! !

!MarsRoverTest methodsFor: 'test' stamp: 'Nip 5/11/2019 17:26:03'!
test08KeepsProcessingUntilAnInvalidCommandComesIn
	"Estamos testeando que avanzar y luego tener un comando invalido nos devuelva una excepcion pero que haya avanzado una UNICA vez"
	| aSequenceOfCommands |

	aSequenceOfCommands := 'fxf'.
	self should: [ ourMarsRover process: aSequenceOfCommands. ] 		raise: Error 		withExceptionDo: [:anError | 			self assert: MarsRover cannotProcessInvalidCommand = anError messageText.			self assert: (ourMarsRover isAt: (0@1) pointing: #North).].! !

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

!MarsRover methodsFor: 'private' stamp: 'Nip 5/12/2019 15:39:35'!
pointingTo
	^ state pointingTo.! !

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


!MarsRover methodsFor: 'testing' stamp: 'Nip 5/12/2019 15:40:52'!
isAt: aPoint pointing: aDirection
	^aPoint = location and: self pointingTo = aDirection.
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


!MarsRoverState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:01'!
pointingTo

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

!MarsRoverEastOrientationState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:15'!
pointingTo
	^ #East! !


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

!MarsRoverNorthOrientationState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:23'!
pointingTo
	^ #North! !


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

!MarsRoverSouthOrientationState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:29'!
pointingTo
	^ #South! !


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

!MarsRoverWestOrientationState methodsFor: 'private' stamp: 'Nip 5/12/2019 15:40:37'!
pointingTo
	^ #West! !


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
