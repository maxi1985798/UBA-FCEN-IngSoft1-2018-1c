!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'myFirstBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'test support' stamp: 'm 6/6/2018 14:59:21'!
setUp
	myFirstBook := 'my first book'.! !


!TusLibrosTest methodsFor: 'tests' stamp: 'm 6/7/2018 15:08:39'!
test01ANewCartStartsEmpty

	| cart |
	
	cart := Cart new.
	
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'm 6/7/2018 15:04:48'!
test02ACartWithABookIsNotEmpty
	
	| cart |
	
	cart := Cart new.
	cart add: myFirstBook.
	self deny: cart isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'm 6/7/2018 15:06:10'!
test03ListingAnEmptyCartShouldBeEmpty
	
	| cart |
	
	cart := Cart new.
	self assert: cart list isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'm 6/7/2018 15:08:11'!
test04ListingACartWithABookShouldReturnAListWithABook
	
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

!Cart methodsFor: 'testing' stamp: 'm 6/6/2018 15:02:02'!
isEmpty
	^books isEmpty.! !


!Cart methodsFor: 'adding' stamp: 'm 6/6/2018 15:00:25'!
add: aBook
	books add: aBook.! !


!Cart methodsFor: 'initialization' stamp: 'm 6/6/2018 15:01:01'!
initialize
	books := OrderedCollection new.! !


!Cart methodsFor: 'listing' stamp: 'm 6/6/2018 15:05:28'!
list
	^books copy.! !
