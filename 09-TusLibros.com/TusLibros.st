!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'myFirstBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'm 6/6/2018 14:59:21'!
setUp
	myFirstBook := 'my first book'.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'm 6/6/2018 14:56:54'!
test01
	| cart |
	
	cart := Cart new.
	
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'm 6/6/2018 14:59:28'!
test02
	
	| cart |
	
	cart := Cart new.
	cart add: myFirstBook.
	self deny: cart isEmpty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'm 6/6/2018 15:05:05'!
test03
	
	| cart |
	
	cart := Cart new.
	self assert: cart list isEmpty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'm 6/6/2018 15:09:14'!
test04
	
	| cart |
	
	cart := Cart new.
	
	cart add: myFirstBook.
	
	self deny: cart list isEmpty.
	self assert: cart list size = 1.
	self assert: (cart list includes: myFirstBook).
	
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'm 6/6/2018 15:00:25'!
add: aBook
	books add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'm 6/6/2018 15:01:01'!
initialize
	books := OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'm 6/6/2018 15:02:02'!
isEmpty
	^books isEmpty.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'm 6/6/2018 15:05:28'!
list
	^books copy.! !
