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


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'firstStackElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accessing' stamp: 'm 4/25/2018 01:06:58'!
pop
	| e |
	e _ firstStackElement getElement.
	firstStackElement _ firstStackElement nextContainer.
	^ e.! !

!OOStack methodsFor: 'accessing' stamp: 'm 4/25/2018 01:06:58'!
push: anObject
	| e |
	e _ StackContainer
		newWith: anObject
		andOn: firstStackElement.
	firstStackElement _ e.! !

!OOStack methodsFor: 'accessing' stamp: 'm 4/25/2018 01:06:58'!
size
	^ firstStackElement numberInTheStack.! !

!OOStack methodsFor: 'accessing' stamp: 'm 4/25/2018 01:06:58'!
top
	^ firstStackElement getElement.! !


!OOStack methodsFor: 'testing' stamp: 'm 4/25/2018 01:06:58'!
isEmpty
	^ firstStackElement isStackBottom.! !


!OOStack methodsFor: 'initialization' stamp: 'm 4/25/2018 01:06:58'!
initialize
	firstStackElement _ StackBottom new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'accessing' stamp: 'm 4/25/2018 01:08:48'!
getElement
	self shouldBeImplemented.! !

!StackElement methodsFor: 'accessing' stamp: 'm 4/25/2018 01:09:51'!
numberInTheStack
	self shouldBeImplemented.! !


!StackElement methodsFor: 'testing' stamp: 'm 4/25/2018 01:09:27'!
isStackBottom
	self shouldBeImplemented.! !


!classDefinition: #StackBottom category: #'Stack-Exercise'!
StackElement subclass: #StackBottom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBottom methodsFor: 'testing' stamp: 'm 4/25/2018 00:23:42'!
isStackBottom
	^ true.! !


!StackBottom methodsFor: 'accessing' stamp: 'm 4/25/2018 01:05:27'!
getElement
	self error: OOStack stackEmptyErrorDescription.! !

!StackBottom methodsFor: 'accessing' stamp: 'm 4/25/2018 01:02:24'!
numberInTheStack
	^ 0.! !


!classDefinition: #StackContainer category: #'Stack-Exercise'!
StackElement subclass: #StackContainer
	instanceVariableNames: 'element onStackContainer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackContainer methodsFor: 'intialization' stamp: 'm 4/25/2018 00:33:07'!
initializeWith: anObject andOn: anElementContainer
	element _ anObject.
	onStackContainer _ anElementContainer.! !


!StackContainer methodsFor: 'testing' stamp: 'm 4/25/2018 00:23:42'!
isStackBottom
	^ false.! !


!StackContainer methodsFor: 'accessing' stamp: 'm 4/25/2018 00:29:39'!
getElement
	^element.! !

!StackContainer methodsFor: 'accessing' stamp: 'm 4/25/2018 00:33:07'!
nextContainer
	^ onStackContainer.! !

!StackContainer methodsFor: 'accessing' stamp: 'm 4/25/2018 01:02:24'!
numberInTheStack
	^ 1 + onStackContainer numberInTheStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackContainer class' category: #'Stack-Exercise'!
StackContainer class
	instanceVariableNames: ''!

!StackContainer class methodsFor: 'as yet unclassified' stamp: 'm 4/25/2018 00:19:29'!
newWith: anObject andOn: anStackContainer
	^self new initializeWith: anObject andOn: anStackContainer.! !
