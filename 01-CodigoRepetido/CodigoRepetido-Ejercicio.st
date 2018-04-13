!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: 'customerBook customerBookWithPaulMcCartney customerBookWithJohnLennon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'AM 4/12/2018 21:09:43'!
setUp

	customerBook := CustomerBook  new.
	customerBookWithPaulMcCartney := CustomerBook  new.
	customerBookWithPaulMcCartney addCustomerNamed:  'Paul McCartney'.
	customerBookWithJohnLennon  := CustomerBook  new.
	customerBookWithJohnLennon addCustomerNamed:  'John Lennon'.! !

!IdiomTest methodsFor: 'testing' stamp: 'AM 4/12/2018 21:30:03'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	self this:[customerBook addCustomerNamed: 'John Lennon'] shouldNotTakeMoreThan: 50
	! !

!IdiomTest methodsFor: 'testing' stamp: 'AM 4/12/2018 21:34:11'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.

	self this:[customerBookWithPaulMcCartney removeCustomerNamed: paulMcCartney] shouldNotTakeMoreThan: 100.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'AM 4/12/2018 21:01:52'!
test03CanNotAddACustomerWithEmptyName 
		
	self
		this:[customerBook addCustomerNamed: '']
		shouldRaise:Error
		andTest:[ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!IdiomTest methodsFor: 'testing' stamp: 'AM 4/12/2018 21:11:30'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon |
	johnLennon := 'John Lennon'.
	
	self
		this:[customerBookWithJohnLennon removeCustomerNamed: 'Paul McCartney']
		shouldRaise:NotFound
		andTest:[ :anError | 
			self assert: customerBookWithJohnLennon numberOfCustomers = 1.
			self assert: (customerBookWithJohnLennon includesCustomerNamed: johnLennon) ]! !


!IdiomTest methodsFor: 'extentions' stamp: 'AM 4/12/2018 21:32:54'!
this: aBlockClosure shouldNotTakeMoreThan: milliseconds 
	self assert: aBlockClosure timeToRun < milliseconds.! !

!IdiomTest methodsFor: 'extentions' stamp: 'AM 4/12/2018 20:59:36'!
this:aBlockClosure shouldRaise:anError andTest:anotherBlockClosure

[ aBlockClosure value.
	self fail ]
		on: anError 
		do: [ :e | 
			anotherBlockClosure value:e ]! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
