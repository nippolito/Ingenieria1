!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'ourSentences ourFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'asd 4/19/2019 11:51:25'!
setUp

	ourSentences := OOStack new.
	ourSentences push: 'winter is coming'.
	ourSentences push: 'winning is everything'.
	ourSentences push: 'The winds of Winter'.
	ourSentences push: 'Winter is here'.
	
	ourFinder := SentenceFinderByPrefix with: ourSentences.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'asd 4/19/2019 11:52:05'!
test01PrefixShouldNotBeEmpty
	
	self
	should: [ ourFinder find: '']
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText = 'El prefijo está vacío' ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'asd 4/19/2019 11:52:42'!
test02PrefixShouldNotContainEmptySpaces
	
	self
	should: [ ourFinder find: 'h ']
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText = 'El prefijo tiene al menos un espacio vacío' ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'asd 4/19/2019 14:38:37'!
test03FinderSentencesShouldNotChangeAfterExecution
	|oldSentences newSentences topsEqual|
	
	oldSentences := ourFinder sentences copy.
	ourFinder find: 'Wint'.
	newSentences := ourFinder sentences.
	
	self assert: newSentences size = oldSentences size.
	
	topsEqual := true.
	oldSentences size timesRepeat: [
		topsEqual := (newSentences pop = oldSentences pop) and: topsEqual.
	].

	self assert: topsEqual = true.	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'asd 4/19/2019 11:54:24'!
test04FinderIsCaseSensitive
	|someSentences aFinder resultFound|

	someSentences := OOStack new.
	someSentences push: 'winter is coming'.
	
	aFinder := SentenceFinderByPrefix with: someSentences.
	
	resultFound := aFinder find: 'Winter'.
	
	self assert: resultFound isEmpty.
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'asd 4/19/2019 14:39:07'!
test05ResultIsEmptyWhenSentencesAreEmpty
	|someSentences resultFound aFinder|
		
	someSentences := OOStack new.
	
	aFinder := SentenceFinderByPrefix with: someSentences.
	
	resultFound := aFinder find: 'Winter'.
	
	self assert: resultFound isEmpty.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'asd 4/19/2019 11:56:00'!
test06CatedraExampleWorksWell
	|resultFound|

	resultFound := ourFinder find: 'Wint'.
	
	self assert: resultFound size = 1.
	self assert: resultFound first = 'Winter is here'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'asd 4/19/2019 11:57:21'!
test07CatedraExampleWithDifferentSentenceOrderWorksWell
	|someSentences aFinder resultFound|

	someSentences := OOStack new.
	someSentences push: 'The winds of Winter'.
	someSentences push: 'winter is coming'.
	someSentences push: 'Winter is here'.
	someSentences push: 'winning is everything'.
	
	aFinder := SentenceFinderByPrefix with: someSentences.

	resultFound := aFinder find: 'Wint'.
	
	self assert: resultFound size = 1.
	self assert: resultFound first = 'Winter is here'.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'asd 4/19/2019 16:38:38'!
test08FinderWorksWellWhenSentencesHaveStrangeCharacters
	|aStack aFinder resultFound|
	
	aStack := OOStack new.
	aStack push: '//'.
	aStack push: '$%x&)('.
	aStack push: '*^*]{}"·!!ºª'.
	aFinder := SentenceFinderByPrefix with: aStack.

	resultFound := aFinder find: '*^'.
	
	self assert: resultFound size = 1.
	self assert: resultFound first = '*^*]{}"·!!ºª'.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'asd 4/19/2019 16:47:05'!
test09FinderCanReturnMoreThanOneSentence
	|resultFound|

	resultFound := ourFinder find: 'win'.
	
	self assert: resultFound size = 2.
	self assert: (resultFound find: 'winter is coming') > 0. 
	self assert: (resultFound find: 'winning is everything') > 0.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size lastElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'methods' stamp: 'Nipo 4/22/2019 14:24:36'!
initialize
	lastElement := Base new.
	size := 0.
	"^self."
	
	
	! !

!OOStack methodsFor: 'methods' stamp: 'nacho 4/22/2018 19:42:08'!
isEmpty
 	
	^(size = 0).! !

!OOStack methodsFor: 'methods' stamp: 'asd 4/19/2019 13:47:15'!
pop
	|anElement|
	anElement := lastElement.
	lastElement := anElement previous.
	size := size - 1.
	^anElement value.
	
	! !

!OOStack methodsFor: 'methods' stamp: 'asd 4/19/2019 14:01:47'!
push: anElement
	lastElement := StackableElement new initializeWith: anElement andPrevious: lastElement.
	size _ size + 1.
	
	! !

!OOStack methodsFor: 'methods' stamp: 'nacho 4/22/2018 22:43:22'!
size
 
	^size.! !

!OOStack methodsFor: 'methods' stamp: 'asd 4/19/2019 13:47:23'!
top	
	^lastElement value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackTop category: #'Stack-Exercise'!
Object subclass: #OOStackTop
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTop methodsFor: 'methods' stamp: 'asd 4/19/2019 16:29:06'!
previous
	^self subclassResponsibility.! !

!OOStackTop methodsFor: 'methods' stamp: 'asd 4/19/2019 16:29:15'!
value
	^self subclassResponsibility.! !


!classDefinition: #Base category: #'Stack-Exercise'!
OOStackTop subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'methods' stamp: 'asd 4/19/2019 13:46:31'!
previous
	^self error: OOStack stackEmptyErrorDescription.! !

!Base methodsFor: 'methods' stamp: 'asd 4/19/2019 13:46:42'!
value
	^self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #StackableElement category: #'Stack-Exercise'!
OOStackTop subclass: #StackableElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackableElement methodsFor: 'initialization' stamp: 'asd 4/19/2019 13:51:45'!
initializeWith: aValue andPrevious: anElement
	value := aValue.
	previous := anElement.
	^self.! !


!StackableElement methodsFor: 'methods' stamp: 'asd 4/19/2019 13:45:42'!
previous 
	^previous.! !

!StackableElement methodsFor: 'methods' stamp: 'asd 4/19/2019 13:45:46'!
value
	^value.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'methods - private' stamp: 'Nipo 4/22/2019 10:33:06'!
sentencesAsOrderedCollection
	|sentencesOC sentencesBackup|
	
	sentencesOC := OrderedCollection new.	
	sentencesBackup := sentences copy.
	
	sentences size timesRepeat: [
		sentencesOC add: sentences pop.
	].
	
	sentences := sentencesBackup.
	
	^sentencesOC! !


!SentenceFinderByPrefix methodsFor: 'methods' stamp: 'Nipo 4/22/2019 10:33:53'!
find: aPrefix

	|sentencesThatMatch sentencesAsOC|
	
	aPrefix isEmpty ifTrue: [self error: 'El prefijo está vacío'].
	(aPrefix select: [:a | a asString = ' ']) isEmpty ifFalse: [self error: 'El prefijo tiene al menos un espacio vacío'].	

	sentencesAsOC := self sentencesAsOrderedCollection.
	
	sentencesThatMatch := sentencesAsOC select: [:aSentence | aSentence beginsWith: aPrefix].
	
	^sentencesThatMatch.! !

!SentenceFinderByPrefix methodsFor: 'methods' stamp: 'asd 4/19/2019 11:59:42'!
sentences
	^sentences! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'asd 4/19/2019 11:41:49'!
initializeWith: someSentences
	sentences := someSentences.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'asd 4/19/2019 11:47:29'!
with: someSentences
	^ self new initializeWith: someSentences.! !
