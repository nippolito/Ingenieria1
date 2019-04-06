!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'JIG 4/4/2019 19:51:36'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |
	customerBook := CustomerBook new.
	
	self assert: (self executing: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThanMilliseconds: 50). 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JIG 4/4/2019 19:51:36'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: (self executing: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThanMilliseconds: 100). 	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Nipo 4/6/2019 13:29:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self executeGivenClosure: [ customerBook addCustomerNamed: ''] throwsException: Error assertVerificationClosure: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Nipo 4/6/2019 13:29:12'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	self executeGivenClosure: [ customerBook removeCustomerNamed: 'Paul McCartney'.] throwsException: NotFound assertVerificationClosure: [ :anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JIG 4/4/2019 21:46:40'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self checkThatCustomerBook: customerBook matchesInQuantityToCustomerQuantityOfActive: 0 ofSuspended: 1 ofTotal: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JIG 4/4/2019 21:46:36'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkThatCustomerBook: customerBook matchesInQuantityToCustomerQuantityOfActive: 0 ofSuspended: 0 ofTotal: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Nipo 4/6/2019 13:29:12'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self executeGivenClosure: [customerBook suspendCustomerNamed: 'Paul McCartney'.] throwsException: CantSuspend assertVerificationClosure: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Nipo 4/6/2019 13:29:52'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self executeGivenClosure: [customerBook suspendCustomerNamed: johnLennon.] throwsException: CantSuspend assertVerificationClosure: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !


!CustomerBookTest methodsFor: 'auxiliares' stamp: 'JIG 4/4/2019 21:45:23'!
checkThatCustomerBook: aCustomerBook matchesInQuantityToCustomerQuantityOfActive: activeCustomersQuantity ofSuspended: suspendedCustomersQuantity ofTotal: totalCustomersQuantity

	self assert: activeCustomersQuantity equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedCustomersQuantity equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: totalCustomersQuantity equals: aCustomerBook numberOfCustomers.
	
! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'Nipo 4/6/2019 13:29:12'!
executeGivenClosure: aClosure throwsException: anException assertVerificationClosure: aVerificationClosure
	[aClosure value.
		self fail.]
	on: anException
	do: aVerificationClosure.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'Nipo 4/6/2019 13:44:34'!
executing: closureToBeEvaluated takesLessThanMilliseconds: aMillisecondsAmount
	| closureExecutionTime |
	
	closureExecutionTime := self measureClosureTime: closureToBeEvaluated inMeasure: millisecond.
	
	^closureExecutionTime < (aMillisecondsAmount * millisecond)
	
! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'Nipo 4/6/2019 13:44:27'!
measureClosureTime: aClosure inMeasure: aTimeMeasure
	| timeBeforeRunning timeAfterRunning |
	
	timeBeforeRunning := Time millisecondClockValue * aTimeMeasure.
	aClosure value.
	timeAfterRunning := Time millisecondClockValue * aTimeMeasure.
	
	^ timeAfterRunning-timeBeforeRunning
	
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Nipo 4/6/2019 13:48:27'!
removeCustomerNamed: aName 
	
	active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^NotFound signal.]].
	^aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:22'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:31'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
