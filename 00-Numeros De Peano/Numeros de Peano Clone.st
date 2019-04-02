!classDefinition: #I category: #'Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros de Peano'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'Axiomas' stamp: 'Nipo 3/28/2019 18:34:04'!
* unNumeroDePeano
	^unNumeroDePeano	! !

!I class methodsFor: 'Axiomas' stamp: 'Nipo 3/28/2019 17:52:15'!
+ unNumeroDePeano
	^ unNumeroDePeano next! !

!I class methodsFor: 'Axiomas' stamp: 'Nipo 4/1/2019 15:41:11'!
- unNumeroDePeano
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'Axiomas' stamp: 'Nipo 4/1/2019 16:29:38'!
/ unNumeroDePeano
	"podemos no sacar el if sin problemas"
	unNumeroDePeano = self ifTrue: [^self]
	ifFalse: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	! !

!I class methodsFor: 'Axiomas' stamp: 'Nipo 4/1/2019 15:45:16'!
< unNumeroDePeano
	^ (unNumeroDePeano = I) not.
	
	! !

!I class methodsFor: 'Axiomas' stamp: 'Nipo 3/28/2019 18:13:50'!
next
	"cloneNamed clona el objeto y lo devuelve con el nombre que le paso como colaborador"
	^ next.! !


!I class methodsFor: 'CodigosDeError' stamp: 'Nipo 4/1/2019 15:41:52'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor'.! !

!I class methodsFor: 'CodigosDeError' stamp: 'Nipo 4/1/2019 15:40:45'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Resta de números negativos no soportada'! !


!I class methodsFor: 'Metodos' stamp: 'Nipo 4/1/2019 16:17:06'!
esMayorQue: unNumeroDePeano
	^ false.
	! !

!I class methodsFor: 'Metodos' stamp: 'Nipo 4/1/2019 16:35:25'!
leMultiplicoA: unNumeroDePeano
	^ unNumeroDePeano.! !

!I class methodsFor: 'Metodos' stamp: 'Nipo 4/1/2019 15:37:59'!
leRestoAl: unNumeroDePeano
	^unNumeroDePeano previous.! !


!I class methodsFor: 'as yet unclassified' stamp: 'Nipo 4/2/2019 20:23:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: #'Numeros de Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros de Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'Axiomas' stamp: 'Nipo 4/1/2019 16:35:43'!
* unNumeroDePeano
	^  unNumeroDePeano leMultiplicoA: self.
	
	"4 * 3
	3 leMultiplicoA 4
	4 * 2 + (4)
	2 leMultiplicoA 4 + (4)
	4 * 1 + (8)
	1 leMultiplicoA 4 + (8)
	4 + 8 = 12"! !

!II class methodsFor: 'Axiomas' stamp: 'Nipo 3/28/2019 18:27:36'!
+ unNumeroDePeano
	"El previous no existe para el I"
	^ self previous + unNumeroDePeano next
	"recursión!! el + es simplemente un simbolito"! !

!II class methodsFor: 'Axiomas' stamp: 'Nipo 4/1/2019 15:34:31'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoAl: self.	! !

!II class methodsFor: 'Axiomas' stamp: 'Nipo 4/1/2019 16:03:21'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue:[^I].
	self chequearSiDividoPorNumeroMayor: unNumeroDePeano.
	^((self - unNumeroDePeano) / unNumeroDePeano) + I
	"basar la división en la resta. El tema es que si la división tenía algún resto explota todo todo. Podemos entregarlo así, pero podríamos seguir explorando para manejar el caso de los restos"! !

!II class methodsFor: 'Axiomas' stamp: 'Nipo 3/28/2019 18:56:45'!
next
	"cloneNamed clona el objeto y lo devuelve con el nombre que le paso como colaborador"
	next ifNil: 
		[
		next := self cloneNamed: (self name, 'I'). "Intentar si se puede crear un hijo en lugar de clonar todo. (addChild o algo así)"
		next previous: self.
		].
	^ next.! !

!II class methodsFor: 'Axiomas' stamp: 'Nipo 3/28/2019 18:01:55'!
previous
	"Si el I recibe el mensaje previous basta con que no lo sepa responder"
	^ previous! !


!II class methodsFor: 'CodigosDeError' stamp: 'Nipo 4/1/2019 15:42:05'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor'.! !

!II class methodsFor: 'CodigosDeError' stamp: 'Nipo 4/1/2019 16:21:10'!
descripcionDeErrorDivisionNoEntera
	^'El dividendo no es múltiplo del divisor, no se puede realizar la división'! !


!II class methodsFor: 'Metodos' stamp: 'Nipo 4/1/2019 15:55:58'!
< unNumeroDePeano
	^ unNumeroDePeano esMayorQue: self.
	
	"4 < 3
	3 esMayorQue 4
	3 < 2
	2 esMayorQue 3
	2 < 1
	1 esMayorQue 2
	false"! !

!II class methodsFor: 'Metodos' stamp: 'Nipo 4/1/2019 16:19:05'!
chequearSiDividoPorNumeroMayor: unNumeroDePeano
	(unNumeroDePeano esMayorQue: self) ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor] ifFalse: [^ false].! !

!II class methodsFor: 'Metodos' stamp: 'Nipo 4/1/2019 15:54:03'!
esMayorQue: unNumeroDePeano
	^ unNumeroDePeano previous < self previous.! !

!II class methodsFor: 'Metodos' stamp: 'Nipo 4/1/2019 16:34:11'!
leMultiplicoA: unNumeroDePeano
	^ unNumeroDePeano + (unNumeroDePeano * (self previous))! !

!II class methodsFor: 'Metodos' stamp: 'Nipo 4/1/2019 15:37:26'!
leRestoAl: unNumeroDePeano
	^ unNumeroDePeano previous - self previous.! !

!II class methodsFor: 'Metodos' stamp: 'Nipo 3/28/2019 18:17:42'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!II class methodsFor: 'Metodos' stamp: 'Nipo 3/28/2019 18:05:41'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!II class methodsFor: 'as yet unclassified' stamp: 'Nipo 4/2/2019 20:23:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: #'Numeros de Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros de Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
* unNumeroDePeano
	^  unNumeroDePeano leMultiplicoA: self.
	
	"4 * 3
	3 leMultiplicoA 4
	4 * 2 + (4)
	2 leMultiplicoA 4 + (4)
	4 * 1 + (8)
	1 leMultiplicoA 4 + (8)
	4 + 8 = 12"! !

!III class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
+ unNumeroDePeano
	"El previous no existe para el I"
	^ self previous + unNumeroDePeano next
	"recursión!! el + es simplemente un simbolito"! !

!III class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoAl: self.	! !

!III class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue:[^I].
	self chequearSiDividoPorNumeroMayor: unNumeroDePeano.
	^((self - unNumeroDePeano) / unNumeroDePeano) + I
	"basar la división en la resta. El tema es que si la división tenía algún resto explota todo todo. Podemos entregarlo así, pero podríamos seguir explorando para manejar el caso de los restos"! !

!III class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
next
	"cloneNamed clona el objeto y lo devuelve con el nombre que le paso como colaborador"
	next ifNil: 
		[
		next := self cloneNamed: (self name, 'I'). "Intentar si se puede crear un hijo en lugar de clonar todo. (addChild o algo así)"
		next previous: self.
		].
	^ next.! !

!III class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
previous
	"Si el I recibe el mensaje previous basta con que no lo sepa responder"
	^ previous! !


!III class methodsFor: 'CodigosDeError' stamp: 'Nipo 4/2/2019 20:23:18'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor'.! !

!III class methodsFor: 'CodigosDeError' stamp: 'Nipo 4/2/2019 20:23:18'!
descripcionDeErrorDivisionNoEntera
	^'El dividendo no es múltiplo del divisor, no se puede realizar la división'! !


!III class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
< unNumeroDePeano
	^ unNumeroDePeano esMayorQue: self.
	
	"4 < 3
	3 esMayorQue 4
	3 < 2
	2 esMayorQue 3
	2 < 1
	1 esMayorQue 2
	false"! !

!III class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
chequearSiDividoPorNumeroMayor: unNumeroDePeano
	(unNumeroDePeano esMayorQue: self) ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor] ifFalse: [^ false].! !

!III class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
esMayorQue: unNumeroDePeano
	^ unNumeroDePeano previous < self previous.! !

!III class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
leMultiplicoA: unNumeroDePeano
	^ unNumeroDePeano + (unNumeroDePeano * (self previous))! !

!III class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
leRestoAl: unNumeroDePeano
	^ unNumeroDePeano previous - self previous.! !

!III class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!III class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!III class methodsFor: 'as yet unclassified' stamp: 'Nipo 4/2/2019 20:23:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: #'Numeros de Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros de Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
* unNumeroDePeano
	^  unNumeroDePeano leMultiplicoA: self.
	
	"4 * 3
	3 leMultiplicoA 4
	4 * 2 + (4)
	2 leMultiplicoA 4 + (4)
	4 * 1 + (8)
	1 leMultiplicoA 4 + (8)
	4 + 8 = 12"! !

!IIII class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
+ unNumeroDePeano
	"El previous no existe para el I"
	^ self previous + unNumeroDePeano next
	"recursión!! el + es simplemente un simbolito"! !

!IIII class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoAl: self.	! !

!IIII class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue:[^I].
	self chequearSiDividoPorNumeroMayor: unNumeroDePeano.
	^((self - unNumeroDePeano) / unNumeroDePeano) + I
	"basar la división en la resta. El tema es que si la división tenía algún resto explota todo todo. Podemos entregarlo así, pero podríamos seguir explorando para manejar el caso de los restos"! !

!IIII class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
next
	"cloneNamed clona el objeto y lo devuelve con el nombre que le paso como colaborador"
	next ifNil: 
		[
		next := self cloneNamed: (self name, 'I'). "Intentar si se puede crear un hijo en lugar de clonar todo. (addChild o algo así)"
		next previous: self.
		].
	^ next.! !

!IIII class methodsFor: 'Axiomas' stamp: 'Nipo 4/2/2019 20:23:18'!
previous
	"Si el I recibe el mensaje previous basta con que no lo sepa responder"
	^ previous! !


!IIII class methodsFor: 'CodigosDeError' stamp: 'Nipo 4/2/2019 20:23:18'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un número mayor'.! !

!IIII class methodsFor: 'CodigosDeError' stamp: 'Nipo 4/2/2019 20:23:18'!
descripcionDeErrorDivisionNoEntera
	^'El dividendo no es múltiplo del divisor, no se puede realizar la división'! !


!IIII class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
< unNumeroDePeano
	^ unNumeroDePeano esMayorQue: self.
	
	"4 < 3
	3 esMayorQue 4
	3 < 2
	2 esMayorQue 3
	2 < 1
	1 esMayorQue 2
	false"! !

!IIII class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
chequearSiDividoPorNumeroMayor: unNumeroDePeano
	(unNumeroDePeano esMayorQue: self) ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor] ifFalse: [^ false].! !

!IIII class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
esMayorQue: unNumeroDePeano
	^ unNumeroDePeano previous < self previous.! !

!IIII class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
leMultiplicoA: unNumeroDePeano
	^ unNumeroDePeano + (unNumeroDePeano * (self previous))! !

!IIII class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
leRestoAl: unNumeroDePeano
	^ unNumeroDePeano previous - self previous.! !

!IIII class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!IIII class methodsFor: 'Metodos' stamp: 'Nipo 4/2/2019 20:23:18'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!IIII class methodsFor: 'as yet unclassified' stamp: 'Nipo 4/2/2019 20:23:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!