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


!classDefinition: #HanoiTower category: #'Stack-Exercise'!
Object subclass: #HanoiTower
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!HanoiTower methodsFor: 'accessing' stamp: 'am 4/25/2018 23:32:40'!
numberOfDisks
	self subclassResponsibility.! !

!HanoiTower methodsFor: 'accessing' stamp: 'am 4/25/2018 23:25:26'!
topDisk
	self subclassResponsibility.! !


!HanoiTower methodsFor: 'testing' stamp: 'am 4/25/2018 23:29:09'!
isEmpty
	self subclassResponsibility.! !


!classDefinition: #EmptyRod category: #'Stack-Exercise'!
HanoiTower subclass: #EmptyRod
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyRod methodsFor: 'testing' stamp: 'am 4/25/2018 23:29:08'!
isEmpty
	^ true.! !


!EmptyRod methodsFor: 'accessing' stamp: 'am 4/25/2018 23:32:40'!
numberOfDisks
	^ 0.! !

!EmptyRod methodsFor: 'accessing' stamp: 'am 4/25/2018 23:25:26'!
topDisk
	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #RodWithDisks category: #'Stack-Exercise'!
HanoiTower subclass: #RodWithDisks
	instanceVariableNames: 'element tower'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RodWithDisks methodsFor: 'intialization' stamp: 'am 4/25/2018 23:48:44'!
initializeWith: anObject on: anElementContainer
	element _ anObject.
	tower _ anElementContainer.! !


!RodWithDisks methodsFor: 'testing' stamp: 'am 4/25/2018 23:29:09'!
isEmpty
	^ false.! !


!RodWithDisks methodsFor: 'accessing' stamp: 'am 4/25/2018 23:48:44'!
laterTower
	^ tower.! !

!RodWithDisks methodsFor: 'accessing' stamp: 'am 4/25/2018 23:48:44'!
numberOfDisks
	^ 1 + tower numberOfDisks.! !

!RodWithDisks methodsFor: 'accessing' stamp: 'am 4/25/2018 23:25:26'!
topDisk
	^ element.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RodWithDisks class' category: #'Stack-Exercise'!
RodWithDisks class
	instanceVariableNames: ''!

!RodWithDisks class methodsFor: 'as yet unclassified' stamp: 'am 4/25/2018 23:47:33'!
newWith: anObject on: anStackContainer
	^ self new
		initializeWith: anObject
		on: anStackContainer.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'tower'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accessing' stamp: 'am 4/25/2018 23:43:00'!
pop
	| e |
	e _ tower topDisk.
	tower _ tower laterTower.
	^ e.! !

!OOStack methodsFor: 'accessing' stamp: 'am 4/25/2018 23:46:30'!
push: anObject
	| e |
	e _ RodWithDisks
		newWith: anObject
		on: tower.
	tower _ e.! !

!OOStack methodsFor: 'accessing' stamp: 'am 4/25/2018 23:35:34'!
size
	^ tower numberOfDisks.! !

!OOStack methodsFor: 'accessing' stamp: 'am 4/25/2018 23:35:34'!
top
	^ tower topDisk.! !


!OOStack methodsFor: 'testing' stamp: 'am 4/25/2018 23:35:34'!
isEmpty
	^ tower isEmpty.! !


!OOStack methodsFor: 'initialization' stamp: 'am 4/25/2018 23:35:34'!
initialize
	tower _ EmptyRod new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !
