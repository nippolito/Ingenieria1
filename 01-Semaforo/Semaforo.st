!classDefinition: #SemaforoCabildo category: #Semaforo!
ThreeLightsContainer subclass: #SemaforoCabildo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoCabildo class' category: #Semaforo!
SemaforoCabildo class
	instanceVariableNames: ''!

!SemaforoCabildo class methodsFor: 'auxiliares' stamp: 'Nip 3/31/2019 17:06:25'!
activarPrecaucionPorEncendido
	self titilarLuzAmarillaCincoVeces
	! !

!SemaforoCabildo class methodsFor: 'auxiliares' stamp: 'Nip 4/2/2019 17:35:50'!
titilarLuzAmarilla
	SeñalDePrecaucionSemaforoCabildo color: Color yellow.
	(Delay for: 0.5*second) wait.
	SeñalDePrecaucionSemaforoCabildo color: Color black.
	(Delay for: 0.5*second) wait.! !

!SemaforoCabildo class methodsFor: 'auxiliares' stamp: 'Nip 3/31/2019 17:31:25'!
titilarLuzAmarillaCincoVeces
	5 timesRepeat: [self titilarLuzAmarilla]. ! !


!SemaforoCabildo class methodsFor: 'controlDeCirculacion' stamp: 'Nip 4/6/2019 14:41:43'!
activarSeñalDePrecaucionPorCambioDeTransito
	SeñalDePrecaucionSemaforoCabildo color: Color yellow.
	(Delay for: 1.5*second) wait.
	SeñalDePrecaucionSemaforoCabildo color: Color black.
	! !

!SemaforoCabildo class methodsFor: 'controlDeCirculacion' stamp: 'Nip 4/6/2019 14:39:24'!
cortarCirculacion
	SeñalDeAvanceSemaforoCabildo color: Color black.
	SeñalDeDetencionSemaforoCabildo color: Color red.
	SeñalDePrecaucionSemaforoCabildo color: Color black.! !

!SemaforoCabildo class methodsFor: 'controlDeCirculacion' stamp: 'Nipo 4/2/2019 19:35:14'!
permitirCirculacion
	SeñalDeAvanceSemaforoCabildo color: Color green.
	SeñalDeDetencionSemaforoCabildo color: Color black.
	SeñalDePrecaucionSemaforoCabildo color: Color black.! !


!SemaforoCabildo class methodsFor: 'protocoloEncendidoApagado' stamp: 'Nip 4/2/2019 17:35:49'!
apagar
	SeñalDeDetencionSemaforoCabildo color: Color black.
	SeñalDePrecaucionSemaforoCabildo color: Color black.
	SeñalDeAvanceSemaforoCabildo color: Color black.
! !

!SemaforoCabildo class methodsFor: 'protocoloEncendidoApagado' stamp: 'Nipo 4/4/2019 19:00:56'!
inicializar
	self addMorph: SeñalDeDetencionSemaforoCabildo.
	self addMorph: SeñalDePrecaucionSemaforoCabildo.
	self addMorph: SeñalDeAvanceSemaforoCabildo.
	SeñalDeDetencionSemaforoCabildo color: Color red.
	SeñalDePrecaucionSemaforoCabildo color: Color yellow.
	SeñalDeAvanceSemaforoCabildo color: Color green.
	self openInWorld.
	! !

!SemaforoCabildo class methodsFor: 'protocoloEncendidoApagado' stamp: 'Nip 4/6/2019 16:41:15'!
prender
	self activarPrecaucionPorEncendido.
	
	"SemaforoDeCabildoYCongreso openInWorld.
	SemaforoDeCabildoYCongreso addMorph: LuzRoja.
	SemaforoDeCabildoYCongreso addMorph: LuzAmarilla.
	SemaforoDeCabildoYCongreso addMorph: LuzVerde.
	LuzAmarilla color: Color yellow.
	LuzRoja color: Color red.
	LuzVerde color: Color green."! !


!SemaforoCabildo class methodsFor: 'morph' stamp: 'Nipo 4/4/2019 17:01:43'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself! !


!SemaforoCabildo class methodsFor: 'as yet unclassified' stamp: 'Nip 4/6/2019 16:44:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeAvanceSemaforoCabildo category: #Semaforo!
SemaforoCabildo subclass: #SeñalDeAvanceSemaforoCabildo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceSemaforoCabildo class' category: #Semaforo!
SeñalDeAvanceSemaforoCabildo class
	instanceVariableNames: ''!

!SeñalDeAvanceSemaforoCabildo class methodsFor: 'morph' stamp: 'JIG 3/25/2019 20:00:52'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDeAvanceSemaforoCabildo class methodsFor: 'as yet unclassified' stamp: 'Nip 4/6/2019 16:44:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencionSemaforoCabildo category: #Semaforo!
SemaforoCabildo subclass: #SeñalDeDetencionSemaforoCabildo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionSemaforoCabildo class' category: #Semaforo!
SeñalDeDetencionSemaforoCabildo class
	instanceVariableNames: ''!

!SeñalDeDetencionSemaforoCabildo class methodsFor: 'morph' stamp: 'JIG 3/25/2019 20:00:39'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDeDetencionSemaforoCabildo class methodsFor: 'as yet unclassified' stamp: 'Nip 4/6/2019 16:44:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaucionSemaforoCabildo category: #Semaforo!
SemaforoCabildo subclass: #SeñalDePrecaucionSemaforoCabildo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionSemaforoCabildo class' category: #Semaforo!
SeñalDePrecaucionSemaforoCabildo class
	instanceVariableNames: ''!

!SeñalDePrecaucionSemaforoCabildo class methodsFor: 'morph' stamp: 'JIG 3/25/2019 20:00:44'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDePrecaucionSemaforoCabildo class methodsFor: 'as yet unclassified' stamp: 'Nip 4/6/2019 16:44:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SemaforoCongreso category: #Semaforo!
ThreeLightsContainer subclass: #SemaforoCongreso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoCongreso class' category: #Semaforo!
SemaforoCongreso class
	instanceVariableNames: ''!

!SemaforoCongreso class methodsFor: 'auxiliares' stamp: 'Nip 4/6/2019 14:22:49'!
activarPrecaucionPorEncendido
	self titilarLuzAmarillaCincoVeces
	! !

!SemaforoCongreso class methodsFor: 'auxiliares' stamp: 'Nip 4/6/2019 14:38:23'!
titilarLuzAmarilla
	SeñalDePrecaucionSemaforoCongreso color: Color yellow.
	(Delay for: 0.5*second) wait.
	SeñalDePrecaucionSemaforoCongreso color: Color black.
	(Delay for: 0.5*second) wait.! !

!SemaforoCongreso class methodsFor: 'auxiliares' stamp: 'Nip 4/6/2019 14:22:49'!
titilarLuzAmarillaCincoVeces
	5 timesRepeat: [self titilarLuzAmarilla]. ! !


!SemaforoCongreso class methodsFor: 'controlDeCirculacion' stamp: 'Nip 4/6/2019 14:41:47'!
activarSeñalDePrecaucionPorCambioDeTransito
	SeñalDePrecaucionSemaforoCongreso color: Color yellow.
	(Delay for: 1.5*second) wait.
	SeñalDePrecaucionSemaforoCongreso color: Color black.
	! !

!SemaforoCongreso class methodsFor: 'controlDeCirculacion' stamp: 'Nip 4/6/2019 14:38:22'!
cortarCirculacion
	SeñalDeAvanceSemaforoCongreso color: Color black.
	SeñalDePrecaucionSemaforoCongreso color: Color black.
	SeñalDeDetencionSemaforoCongreso color: Color red.
	! !

!SemaforoCongreso class methodsFor: 'controlDeCirculacion' stamp: 'Nip 4/6/2019 14:38:22'!
permitirCirculacion
	SeñalDeAvanceSemaforoCongreso color: Color green.
	SeñalDeDetencionSemaforoCongreso color: Color black.
	SeñalDePrecaucionSemaforoCongreso color: Color black.! !


!SemaforoCongreso class methodsFor: 'protocoloEncendidoApagado' stamp: 'Nip 4/6/2019 14:38:23'!
apagar
	SeñalDeDetencionSemaforoCongreso color: Color black.
	SeñalDePrecaucionSemaforoCongreso color: Color black.
	SeñalDeAvanceSemaforoCongreso color: Color black.
! !

!SemaforoCongreso class methodsFor: 'protocoloEncendidoApagado' stamp: 'Nip 4/6/2019 14:38:23'!
inicializar
	self addMorph: SeñalDeDetencionSemaforoCongreso.
	self addMorph: SeñalDePrecaucionSemaforoCongreso.
	self addMorph: SeñalDeAvanceSemaforoCongreso.
	SeñalDeDetencionSemaforoCongreso color: Color red.
	SeñalDePrecaucionSemaforoCongreso color: Color yellow.
	SeñalDeAvanceSemaforoCongreso color: Color green.
	self openInWorld.
	! !

!SemaforoCongreso class methodsFor: 'protocoloEncendidoApagado' stamp: 'Nip 4/6/2019 16:41:28'!
prender
	self activarPrecaucionPorEncendido.
	
	"SemaforoDeCabildoYCongreso openInWorld.
	SemaforoDeCabildoYCongreso addMorph: LuzRoja.
	SemaforoDeCabildoYCongreso addMorph: LuzAmarilla.
	SemaforoDeCabildoYCongreso addMorph: LuzVerde.
	LuzAmarilla color: Color yellow.
	LuzRoja color: Color red.
	LuzVerde color: Color green."! !


!SemaforoCongreso class methodsFor: 'morph' stamp: 'Nip 4/6/2019 14:22:49'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself! !


!SemaforoCongreso class methodsFor: 'as yet unclassified' stamp: 'Nip 4/6/2019 16:44:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeAvanceSemaforoCongreso category: #Semaforo!
SemaforoCongreso subclass: #SeñalDeAvanceSemaforoCongreso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceSemaforoCongreso class' category: #Semaforo!
SeñalDeAvanceSemaforoCongreso class
	instanceVariableNames: ''!

!SeñalDeAvanceSemaforoCongreso class methodsFor: 'morph' stamp: 'Nip 4/6/2019 14:24:04'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDeAvanceSemaforoCongreso class methodsFor: 'as yet unclassified' stamp: 'Nip 4/6/2019 16:44:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencionSemaforoCongreso category: #Semaforo!
SemaforoCongreso subclass: #SeñalDeDetencionSemaforoCongreso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionSemaforoCongreso class' category: #Semaforo!
SeñalDeDetencionSemaforoCongreso class
	instanceVariableNames: ''!

!SeñalDeDetencionSemaforoCongreso class methodsFor: 'morph' stamp: 'Nip 4/6/2019 14:24:22'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDeDetencionSemaforoCongreso class methodsFor: 'as yet unclassified' stamp: 'Nip 4/6/2019 16:44:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaucionSemaforoCongreso category: #Semaforo!
SemaforoCongreso subclass: #SeñalDePrecaucionSemaforoCongreso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionSemaforoCongreso class' category: #Semaforo!
SeñalDePrecaucionSemaforoCongreso class
	instanceVariableNames: ''!

!SeñalDePrecaucionSemaforoCongreso class methodsFor: 'morph' stamp: 'Nip 4/6/2019 14:24:27'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!SeñalDePrecaucionSemaforoCongreso class methodsFor: 'as yet unclassified' stamp: 'Nip 4/6/2019 16:44:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #OrquestadorCabildoYCongreso category: #Semaforo!
DenotativeObjectMorph subclass: #OrquestadorCabildoYCongreso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorCabildoYCongreso class' category: #Semaforo!
OrquestadorCabildoYCongreso class
	instanceVariableNames: 'calleEnCirculacion'!

!OrquestadorCabildoYCongreso class methodsFor: 'controlGeneral' stamp: 'Nip 4/6/2019 16:40:52'!
apagarSemaforos
	SemaforoCabildo apagar.
	SemaforoCongreso apagar.
! !

!OrquestadorCabildoYCongreso class methodsFor: 'controlGeneral' stamp: 'Nip 4/6/2019 16:40:58'!
inicializarSemaforos
	SemaforoCabildo inicializar.
	SemaforoCongreso inicializar.! !

!OrquestadorCabildoYCongreso class methodsFor: 'controlGeneral' stamp: 'Nip 4/6/2019 16:41:04'!
prenderSemaforos
	SemaforoCabildo prender.
	SemaforoCongreso prender.
	self comenzarTransitoCabildoYCongreso.! !


!OrquestadorCabildoYCongreso class methodsFor: 'manejoDeTransito' stamp: 'Nip 4/6/2019 14:38:28'!
activarPrecaucionCambioDeTransito
	SemaforoCabildo activarSeñalDePrecaucionPorCambioDeTransito.
	SemaforoCongreso activarSeñalDePrecaucionPorCambioDeTransito.
	
! !

!OrquestadorCabildoYCongreso class methodsFor: 'manejoDeTransito' stamp: 'Nipo 4/2/2019 19:35:14'!
comenzarTransitoCabildo
	SemaforoCabildo permitirCirculacion.! !

!OrquestadorCabildoYCongreso class methodsFor: 'manejoDeTransito' stamp: 'Nip 4/6/2019 16:37:03'!
comenzarTransitoCabildoYCongreso
	[true] whileTrue: [
			self detenerTransitoCongreso.
			self comenzarTransitoCabildo.
			self permitirTransitoDeCalleEnCirculacionUnRato .
			self activarPrecaucionCambioDeTransito.
			self detenerTransitoCabildo.
			self comenzarTransitoCongreso.
			self permitirTransitoDeCalleEnCirculacionUnRato .
			self activarPrecaucionCambioDeTransito.
			].
! !

!OrquestadorCabildoYCongreso class methodsFor: 'manejoDeTransito' stamp: 'Nip 4/6/2019 14:38:27'!
comenzarTransitoCongreso
	SemaforoCongreso permitirCirculacion.! !

!OrquestadorCabildoYCongreso class methodsFor: 'manejoDeTransito' stamp: 'Nipo 4/2/2019 19:34:36'!
detenerTransitoCabildo
	SemaforoCabildo cortarCirculacion.! !

!OrquestadorCabildoYCongreso class methodsFor: 'manejoDeTransito' stamp: 'Nip 4/6/2019 14:38:28'!
detenerTransitoCongreso
	SemaforoCongreso cortarCirculacion.! !

!OrquestadorCabildoYCongreso class methodsFor: 'manejoDeTransito' stamp: 'Nip 4/6/2019 16:36:38'!
permitirTransitoDeCalleEnCirculacionUnRato
	(Delay for: 5*second) wait.
	
	! !


!OrquestadorCabildoYCongreso class methodsFor: 'as yet unclassified' stamp: 'Nip 4/6/2019 16:44:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	calleEnCirculacion := nil.! !

SemaforoCabildo initializeAfterFileIn!
SeñalDeAvanceSemaforoCabildo initializeAfterFileIn!
SeñalDeDetencionSemaforoCabildo initializeAfterFileIn!
SeñalDePrecaucionSemaforoCabildo initializeAfterFileIn!
SemaforoCongreso initializeAfterFileIn!
SeñalDeAvanceSemaforoCongreso initializeAfterFileIn!
SeñalDeDetencionSemaforoCongreso initializeAfterFileIn!
SeñalDePrecaucionSemaforoCongreso initializeAfterFileIn!
OrquestadorCabildoYCongreso initializeAfterFileIn!