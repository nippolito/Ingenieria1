!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/8/2019 02:58:13'!
invalidNumberTypeErrorDescription
	^ 'Tipo de número inválido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:59:03'!
* aMultiplier 
	^self subclassResponsibility.

	
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:59:13'!
+ anAdder 
	^self subclassResponsibility.
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:59:17'!
- aSubtrahend
	^self subclassResponsibility.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:59:20'!
/ aDivisor 
	^self subclassResponsibility.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:59:23'!
// aDivisor 
	
	^self subclassResponsibility.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 15:08:56'!
fibonacci

	^self subclassResponsibility
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 15:00:03'!
greatestCommonDivisorWith: anEntero 
	
	^self subclassResponsibility.! !


!Entero methodsFor: 'comparing' stamp: 'Nip 4/14/2019 14:59:42'!
= anObject

	^self subclassResponsibility.! !

!Entero methodsFor: 'comparing' stamp: 'Nip 4/14/2019 15:00:10'!
hash

	^self subclassResponsibility.! !


!Entero methodsFor: 'initialization' stamp: 'Nip 4/14/2019 15:00:16'!
initalizeWith: aValue 
	
	^self subclassResponsibility.! !


!Entero methodsFor: 'value' stamp: 'Nip 4/14/2019 15:01:10'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^ self subclassResponsibility.! !


!Entero methodsFor: 'printing' stamp: 'Nip 4/14/2019 15:02:50'!
printOn: aStream

	^ self subclassResponsibility.! !


!Entero methodsFor: 'testing' stamp: 'Nip 4/14/2019 15:02:00'!
isNegative
	
	^ self subclassResponsibility.! !

!Entero methodsFor: 'testing' stamp: 'Nip 4/14/2019 15:02:03'!
isOne
	
	^ self subclassResponsibility.! !

!Entero methodsFor: 'testing' stamp: 'Nip 4/14/2019 15:02:06'!
isZero
	
	^ self subclassResponsibility.! !


!Entero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:59:50'!
divideToEntero: aDividend

	^self subclassResponsibility.! !

!Entero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:59:57'!
divideToFraccion: aDividend

	^self subclassResponsibility.! !

!Entero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:02:21'!
multiplyToEntero: aMultiplier 

	^ self subclassResponsibility.

	
	! !

!Entero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:02:27'!
multiplyToFraccion: aMultiplier

	^ self subclassResponsibility.
	
	
	! !

!Entero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:02:30'!
substractToEntero: aMinuend

	^ self subclassResponsibility.
	! !

!Entero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:02:33'!
substractToFraccion: aMinuend
	
	^ self subclassResponsibility.
	
	! !

!Entero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:02:38'!
sumToEntero: anAdder

	^ self subclassResponsibility.
	
! !

!Entero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:02:41'!
sumToFraccion: anAdder
		^ self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'Nip 4/14/2019 15:00:49'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'Nip 4/14/2019 15:07:16'!
with: aValue 
	
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	aValue isZero ifTrue: [^ Zero new initalizeWith: aValue].
	aValue = 1 ifTrue: [^ One new initalizeWith: aValue].
	aValue > 1 ifTrue: [^ EnteroGreaterThanOne new initalizeWith: aValue].
	aValue < 0 ifTrue: [^ EnteroLessThanZero new initalizeWith: aValue].! !


!classDefinition: #EnteroGreaterThanOne category: #'Numero-Exercise'!
Entero subclass: #EnteroGreaterThanOne
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroGreaterThanOne methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:45:49'!
* aMultiplier 
	^aMultiplier multiplyToEntero: self.

	
	
	! !

!EnteroGreaterThanOne methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:45:49'!
+ anAdder 
	^anAdder sumToEntero: self.
	
! !

!EnteroGreaterThanOne methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:45:49'!
- aSubtrahend
	^aSubtrahend substractToEntero: self.
	! !

!EnteroGreaterThanOne methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:45:49'!
/ aDivisor 
	^aDivisor divideToEntero: self.! !

!EnteroGreaterThanOne methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:55:25'!
// aDivisor 
	
	^self class superclass with: value // aDivisor integerValue! !

!EnteroGreaterThanOne methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 15:11:51'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!EnteroGreaterThanOne methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:55:35'!
greatestCommonDivisorWith: anEntero 
	
	^self class superclass with: (value gcd: anEntero integerValue)! !


!EnteroGreaterThanOne methodsFor: 'comparing' stamp: 'Nip 4/14/2019 14:45:50'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!EnteroGreaterThanOne methodsFor: 'comparing' stamp: 'Nip 4/14/2019 14:45:50'!
hash

	^value hash! !


!EnteroGreaterThanOne methodsFor: 'initialization' stamp: 'Nip 4/14/2019 14:45:50'!
initalizeWith: aValue 
	
	value := aValue! !


!EnteroGreaterThanOne methodsFor: 'value' stamp: 'Nip 4/14/2019 14:45:50'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!EnteroGreaterThanOne methodsFor: 'printing' stamp: 'Nip 4/14/2019 14:45:50'!
printOn: aStream

	aStream print: value ! !


!EnteroGreaterThanOne methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:48:41'!
isNegative
	
	^false! !

!EnteroGreaterThanOne methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:48:52'!
isOne
	
	^false! !

!EnteroGreaterThanOne methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:48:55'!
isZero
	
	^false! !


!EnteroGreaterThanOne methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:45:50'!
divideToEntero: aDividend

	^Fraccion with: aDividend over: self.! !

!EnteroGreaterThanOne methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:45:50'!
divideToFraccion: aDividend

	|newNumerator newDenominator|
	
	newNumerator := aDividend numerator.
	newDenominator := aDividend denominator * self.

	^ newNumerator / newDenominator ! !

!EnteroGreaterThanOne methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:55:45'!
multiplyToEntero: aMultiplier 

	^self class superclass with: value * aMultiplier integerValue.

	
	! !

!EnteroGreaterThanOne methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:45:50'!
multiplyToFraccion: aMultiplier

	|newNumerator newDenominator|
	
	newNumerator := self * aMultiplier numerator.
	newDenominator := aMultiplier denominator.

	^ newNumerator / newDenominator 
	
	
	! !

!EnteroGreaterThanOne methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:55:52'!
substractToEntero: aMinuend

	^ self class superclass with: aMinuend integerValue - value.
	! !

!EnteroGreaterThanOne methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:45:50'!
substractToFraccion: aMinuend
	
	|newNumerator newDenominator|
		
	newNumerator := aMinuend numerator - (self * aMinuend denominator).
	newDenominator := aMinuend denominator.
		
	^ newNumerator / newDenominator
	
	! !

!EnteroGreaterThanOne methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:55:57'!
sumToEntero: anAdder

	^ self class superclass with: value + anAdder integerValue
	
! !

!EnteroGreaterThanOne methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:45:50'!
sumToFraccion: anAdder
		"^ anAdder class with: (self class with: value * anAdder denominator integerValue + anAdder numerator integerValue) over: anAdder denominator."
		|newNumerator newDenominator|
		
		newNumerator := self * anAdder denominator + anAdder numerator.
		newDenominator := anAdder denominator.
		
		^ newNumerator / newDenominator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroGreaterThanOne class' category: #'Numero-Exercise'!
EnteroGreaterThanOne class
	instanceVariableNames: ''!

!EnteroGreaterThanOne class methodsFor: 'instance creation' stamp: 'Nip 4/14/2019 14:45:51'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !


!classDefinition: #EnteroLessThanZero category: #'Numero-Exercise'!
Entero subclass: #EnteroLessThanZero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroLessThanZero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:50:54'!
* aMultiplier 
	^aMultiplier multiplyToEntero: self.

	
	
	! !

!EnteroLessThanZero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:50:54'!
+ anAdder 
	^anAdder sumToEntero: self.
	
! !

!EnteroLessThanZero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:50:54'!
- aSubtrahend
	^aSubtrahend substractToEntero: self.
	! !

!EnteroLessThanZero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:50:54'!
/ aDivisor 
	^aDivisor divideToEntero: self.! !

!EnteroLessThanZero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:57:16'!
// aDivisor 
	
	^self class superclass with: value // aDivisor integerValue! !

!EnteroLessThanZero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 15:10:39'!
fibonacci

	^self error: self class superclass negativeFibonacciErrorDescription.
		! !

!EnteroLessThanZero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:57:25'!
greatestCommonDivisorWith: anEntero 
	
	^self class superclass with: (value gcd: anEntero integerValue)! !


!EnteroLessThanZero methodsFor: 'comparing' stamp: 'Nip 4/14/2019 14:50:54'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!EnteroLessThanZero methodsFor: 'comparing' stamp: 'Nip 4/14/2019 14:50:54'!
hash

	^value hash! !


!EnteroLessThanZero methodsFor: 'initialization' stamp: 'Nip 4/14/2019 14:50:54'!
initalizeWith: aValue 
	
	value := aValue! !


!EnteroLessThanZero methodsFor: 'value' stamp: 'Nip 4/14/2019 14:50:54'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!EnteroLessThanZero methodsFor: 'printing' stamp: 'Nip 4/14/2019 14:50:54'!
printOn: aStream

	aStream print: value ! !


!EnteroLessThanZero methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:51:30'!
isNegative
	
	^true! !

!EnteroLessThanZero methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:50:55'!
isOne
	
	^false! !

!EnteroLessThanZero methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:50:55'!
isZero
	
	^false! !


!EnteroLessThanZero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:50:55'!
divideToEntero: aDividend

	^Fraccion with: aDividend over: self.! !

!EnteroLessThanZero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:50:55'!
divideToFraccion: aDividend

	|newNumerator newDenominator|
	
	newNumerator := aDividend numerator.
	newDenominator := aDividend denominator * self.

	^ newNumerator / newDenominator ! !

!EnteroLessThanZero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:57:00'!
multiplyToEntero: aMultiplier 

	^self class superclass with: value * aMultiplier integerValue.

	
	! !

!EnteroLessThanZero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:50:55'!
multiplyToFraccion: aMultiplier

	|newNumerator newDenominator|
	
	newNumerator := self * aMultiplier numerator.
	newDenominator := aMultiplier denominator.

	^ newNumerator / newDenominator 
	
	
	! !

!EnteroLessThanZero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:57:04'!
substractToEntero: aMinuend

	^ self class superclass with: aMinuend integerValue - value.
	! !

!EnteroLessThanZero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:50:55'!
substractToFraccion: aMinuend
	
	|newNumerator newDenominator|
		
	newNumerator := aMinuend numerator - (self * aMinuend denominator).
	newDenominator := aMinuend denominator.
		
	^ newNumerator / newDenominator
	
	! !

!EnteroLessThanZero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:57:08'!
sumToEntero: anAdder

	^ self class superclass with: value + anAdder integerValue
	
! !

!EnteroLessThanZero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:12:50'!
sumToFraccion: anAdder
		|newNumerator newDenominator|
		
		newNumerator := self * anAdder denominator + anAdder numerator.
		newDenominator := anAdder denominator.
		
		^ newNumerator / newDenominator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroLessThanZero class' category: #'Numero-Exercise'!
EnteroLessThanZero class
	instanceVariableNames: ''!

!EnteroLessThanZero class methodsFor: 'instance creation' stamp: 'Nip 4/14/2019 14:50:55'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !


!classDefinition: #One category: #'Numero-Exercise'!
Entero subclass: #One
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!One methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:05:46'!
* aMultiplier 
	^aMultiplier.

	
	
	! !

!One methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:08:07'!
+ anAdder 
	^ anAdder sumToEntero: self.
	
! !

!One methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:05:33'!
- aSubtrahend
	^ aSubtrahend substractToEntero: self.
	! !

!One methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:09:33'!
/ aDivisor 
	^ aDivisor divideToEntero: self.! !

!One methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:13:44'!
// aDivisor 
	
	^ self class superclass with: value // aDivisor integerValue! !

!One methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 15:11:14'!
fibonacci

	^ self class superclass with: 1.! !

!One methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 14:05:33'!
greatestCommonDivisorWith: anEntero 
	
	^self! !


!One methodsFor: 'comparing' stamp: 'Nip 4/14/2019 14:05:33'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!One methodsFor: 'comparing' stamp: 'Nip 4/14/2019 14:05:33'!
hash

	^value hash! !


!One methodsFor: 'initialization' stamp: 'Nip 4/14/2019 14:34:42'!
initalizeWith: aValue 

	aValue = 1 ifFalse: [ self error: 'No puedo crear al One con valor distinto de uno' ].
	
	value := aValue! !


!One methodsFor: 'value' stamp: 'Nip 4/14/2019 14:30:53'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^1! !


!One methodsFor: 'printing' stamp: 'Nip 4/14/2019 14:05:34'!
printOn: aStream

	aStream print: value ! !


!One methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:16:10'!
divideToEntero: aDividend

	^ aDividend! !

!One methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:16:15'!
divideToFraccion: aDividend

	^ aDividend! !

!One methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:16:22'!
multiplyToEntero: aMultiplier 

	^ aMultiplier! !

!One methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:16:26'!
multiplyToFraccion: aMultiplier

	^ aMultiplier! !

!One methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:56:47'!
substractToEntero: aMinuend

	^ self class superclass with: aMinuend integerValue - 1.
	! !

!One methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:19:15'!
substractToFraccion: aMinuend
		
	^ aMinuend class with: aMinuend numerator - aMinuend denominator over: aMinuend denominator.! !

!One methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:56:41'!
sumToEntero: anAdder

	^self class superclass with: anAdder integerValue + 1.
	! !

!One methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:20:08'!
sumToFraccion: anAdder		
		^ anAdder class with: anAdder numerator + anAdder denominator over: anAdder denominator! !


!One methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:05:34'!
isNegative
	
	^false! !

!One methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:31:03'!
isOne
	
	^true! !

!One methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:31:13'!
isZero
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'One class' category: #'Numero-Exercise'!
One class
	instanceVariableNames: ''!

!One class methodsFor: 'instance creation' stamp: 'Nip 4/14/2019 14:05:34'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !


!classDefinition: #Zero category: #'Numero-Exercise'!
Entero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Zero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 12:57:42'!
* aMultiplier 
	^self.

	
	
	! !

!Zero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 12:57:48'!
+ anAdder 
	^anAdder.
	
! !

!Zero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 13:23:49'!
- aSubtrahend
	^ aSubtrahend substractToEntero: self.
	! !

!Zero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 13:04:04'!
/ aDivisor 
	^self.! !

!Zero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 13:04:32'!
// aDivisor 
	
	^ self! !

!Zero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 15:11:21'!
fibonacci

	^ self class superclass with: 1! !

!Zero methodsFor: 'arithmetic operations' stamp: 'Nip 4/14/2019 13:05:33'!
greatestCommonDivisorWith: anEntero 
	
	^self! !


!Zero methodsFor: 'comparing' stamp: 'Nip 4/14/2019 12:57:03'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Zero methodsFor: 'comparing' stamp: 'Nip 4/14/2019 12:57:03'!
hash

	^value hash! !


!Zero methodsFor: 'initialization' stamp: 'Nip 4/14/2019 13:28:56'!
initalizeWith: aValue 

	aValue isZero ifFalse: [ self error: 'No puedo crear al Zero con valor distinto de cero' ].
	
	value := aValue! !


!Zero methodsFor: 'value' stamp: 'Nip 4/14/2019 13:28:01'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^0! !


!Zero methodsFor: 'printing' stamp: 'Nip 4/14/2019 12:57:03'!
printOn: aStream

	aStream print: value ! !


!Zero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 13:58:58'!
divideToEntero: aDividend

	^ self error: self class superclass canNotDivideByZeroErrorDescription.! !

!Zero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 14:00:21'!
divideToFraccion: aDividend

	^ self error: self class superclass canNotDivideByZeroErrorDescription ! !

!Zero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 13:51:36'!
multiplyToEntero: aMultiplier 

	^self.! !

!Zero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 13:51:44'!
multiplyToFraccion: aMultiplier

	^ self! !

!Zero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 13:51:56'!
substractToEntero: aMinuend

	^ aMinuend.
	! !

!Zero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 13:52:13'!
substractToFraccion: aMinuend
		
	^ aMinuend! !

!Zero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 13:52:19'!
sumToEntero: anAdder

	^anAdder
	! !

!Zero methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 13:52:26'!
sumToFraccion: anAdder		
		^ anAdder! !


!Zero methodsFor: 'testing' stamp: 'Nip 4/14/2019 13:27:52'!
isNegative
	
	^false! !

!Zero methodsFor: 'testing' stamp: 'Nip 4/14/2019 13:29:17'!
isOne
	
	^false! !

!Zero methodsFor: 'testing' stamp: 'Nip 4/14/2019 14:31:20'!
isZero
	
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zero class' category: #'Numero-Exercise'!
Zero class
	instanceVariableNames: ''!

!Zero class methodsFor: 'instance creation' stamp: 'Nip 4/14/2019 12:57:04'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Nipo 4/11/2019 20:42:24'!
* aMultiplier
	^aMultiplier multiplyToFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Nipo 4/11/2019 20:20:50'!
+ anAdder 
	
	^anAdder sumToFraccion: self
	
 ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Nipo 4/11/2019 20:42:33'!
- aSubtrahend 	
	^ aSubtrahend substractToFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Nip 4/13/2019 18:20:00'!
/ aDivisor 
	^aDivisor divideToFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'Nip 4/14/2019 15:18:37'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	"
	Podríamos crear para sacar los ifs de las dos anteriores precondiciones mensajes del estilo 'errorIfZero' o 'errorIfOne' que tengan las cuatro subclases de Entero.
	Si EnteroGreaterThanOne o EnteroLessThanZero o One reciben el mensaje 'errorIfZero', sus métodos devolverían nil.
	En cambio, si Zero recibe el mensaje 'errorIfZero' devolvería self error: 'una fraccion no puede ser cero'.
	De forma análoga con errorIfOne.
	
	Luego, sólo bastaría con hacer aNumerator errorIfZero. aDenominator errorIfOne.
	"
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:14:35'!
divideToEntero: aDividend

	|newNumerator newDenominator|
		
	newNumerator := denominator * aDividend.
	newDenominator := numerator.
		
	^ newNumerator / newDenominator! !

!Fraccion methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:14:40'!
divideToFraccion: aDividend

	|newNumerator newDenominator|
		
	newNumerator := aDividend numerator * denominator.
	newDenominator := aDividend denominator * numerator.
		
	^ newNumerator / newDenominator	! !

!Fraccion methodsFor: 'auxiliary operations' stamp: 'Nip 4/12/2019 17:58:46'!
multiplyToEntero: aMultiplier 

	|newNumerator newDenominator|
		
	newNumerator := self numerator * aMultiplier.
	newDenominator := self denominator.
	
	^newNumerator / newDenominator.		
	
 ! !

!Fraccion methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:14:46'!
multiplyToFraccion: aMultiplier

	|newNumerator newDenominator|
		
	newNumerator := numerator * aMultiplier numerator.
	newDenominator := denominator * aMultiplier denominator.
		
	^ newNumerator / newDenominator	! !

!Fraccion methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:14:50'!
substractToEntero: aMinuend

	|newNumerator newDenominator|
		
	newNumerator := aMinuend * denominator - numerator.
	newDenominator := denominator.
		
	^ newNumerator / newDenominator

 ! !

!Fraccion methodsFor: 'auxiliary operations' stamp: 'Nipo 4/11/2019 21:17:46'!
substractToFraccion: aMinuend	

	| newNumerator newDenominator |
	
	newNumerator := aMinuend numerator * denominator - (aMinuend denominator * numerator).
	newDenominator := aMinuend denominator * denominator.
		
	^newNumerator / newDenominator 		

! !

!Fraccion methodsFor: 'auxiliary operations' stamp: 'Nip 4/14/2019 15:14:56'!
sumToEntero: anAdder

	|newNumerator newDenominator|
		
	newNumerator := anAdder * denominator + numerator.
	newDenominator := denominator.
		
	^ newNumerator / newDenominator! !

!Fraccion methodsFor: 'auxiliary operations' stamp: 'Nip 4/12/2019 17:58:56'!
sumToFraccion: anAdder 

	|newNumerator newDenominator|
		
	newNumerator := anAdder numerator * self denominator + (anAdder denominator * self numerator).
	newDenominator := anAdder denominator * self denominator.
	
	^newNumerator / newDenominator.		
	
 ! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'Nip 4/14/2019 15:22:53'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^ Zero new initalizeWith: 0].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	
	"No se me ocurre cómo sacar estos ifs. El primero es fácil ya que puedo hacer aDivisor errorIfZero.
	Pero para los otros no se cómo hacer, dado que si bien podríamos hacer mensajes como 'returnZeroIfIsZero' para el segundo if, 
		tendríamos que lograr que en el caso de que ese mensaje sea recibido por Zero, además de retornar '^Zero new initalizeWith: 0'
		al mensaje 'returnZeroIfIsZero', también tendría que retornar eso en el mensaje with:over: (o sea, cortar 
		la ejecución del método de with:over).
	"
	! !
