!classDefinition: #LuzAmarilla category: #Semaforo!
DenotativeObjectMorph subclass: #LuzAmarilla
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzAmarilla class' category: #Semaforo!
LuzAmarilla class
	instanceVariableNames: ''!

!LuzAmarilla class methodsFor: 'morph' stamp: 'JIG 3/25/2019 20:00:44'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'JIG 3/25/2019 21:03:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #LuzRoja category: #Semaforo!
DenotativeObjectMorph subclass: #LuzRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzRoja class' category: #Semaforo!
LuzRoja class
	instanceVariableNames: ''!

!LuzRoja class methodsFor: 'morph' stamp: 'JIG 3/25/2019 20:00:39'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!LuzRoja class methodsFor: 'as yet unclassified' stamp: 'JIG 3/25/2019 21:03:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #LuzVerde category: #Semaforo!
DenotativeObjectMorph subclass: #LuzVerde
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzVerde class' category: #Semaforo!
LuzVerde class
	instanceVariableNames: ''!

!LuzVerde class methodsFor: 'morph' stamp: 'JIG 3/25/2019 20:00:52'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!LuzVerde class methodsFor: 'as yet unclassified' stamp: 'JIG 3/25/2019 21:03:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #MiSemaforo category: #Semaforo!
DenotativeObjectMorph subclass: #MiSemaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MiSemaforo class' category: #Semaforo!
MiSemaforo class
	instanceVariableNames: 'estaApagado'!

!MiSemaforo class methodsFor: 'morph' stamp: 'JIG 3/25/2019 20:00:59'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!MiSemaforo class methodsFor: 'protocoloEncendidoApagado' stamp: 'JIG 3/25/2019 20:44:58'!
apagar
	LuzRoja color: Color black.
	LuzAmarilla color: Color black.
	LuzVerde color: Color black.
! !

!MiSemaforo class methodsFor: 'protocoloEncendidoApagado' stamp: 'JIG 3/25/2019 21:03:03'!
prender
	|enviarPrecaucionPorEncendido|
	enviarPrecaucionPorEncendido := 
	[
		LuzAmarilla color: Color yellow.
		(Delay for: 0.5*second) wait.
		LuzAmarilla color: Color black.
		(Delay for: 0.5*second) wait.
	].
	enviarPrecaucionPorEncendido value.
	enviarPrecaucionPorEncendido value.
	enviarPrecaucionPorEncendido value.
	enviarPrecaucionPorEncendido value.
	enviarPrecaucionPorEncendido value.! !


!MiSemaforo class methodsFor: 'as yet unclassified' stamp: 'JIG 3/25/2019 21:03:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	estaApagado := nil.! !

LuzAmarilla initializeAfterFileIn!
LuzRoja initializeAfterFileIn!
LuzVerde initializeAfterFileIn!
MiSemaforo initializeAfterFileIn!