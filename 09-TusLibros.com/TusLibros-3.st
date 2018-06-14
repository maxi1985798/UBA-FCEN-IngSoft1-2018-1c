!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory anExpiredCreditCard aNotExpiredCreditCard anEverythingIsOkMerchantProcesor testVar anNotEnoughCashMerchantProcesor aDisconnectedMerchantProcesor aStolenCreditCardMerchantProcesor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/14/2018 01:29:08'!
aDisconnectedMerchantProcesor
	
	^DisconnectedMerchantProcesor newWith: Dictionary new.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/14/2018 11:44:10'!
aStolenCreditCardMerchantProcesor
	^StolenCreditCardMerchantProcesor newWith: Dictionary new.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/11/2018 19:53:20'!
anEverythingIsOkMerchantProcesor
	^EverythingIsOkMerchantProcesor newWith: Dictionary new.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/13/2018 18:12:45'!
notEnoughCashMerchantProcesor
	^NotEnoughCashMerchantProcesor newWith: Dictionary new.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/14/2018 11:16:33'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	anExpiredCreditCard _ testObjectsFactory expiredCreditCard.
	aNotExpiredCreditCard _ testObjectsFactory notExpiredCreditCard.
	anEverythingIsOkMerchantProcesor := self anEverythingIsOkMerchantProcesor.
	anNotEnoughCashMerchantProcesor _ self notEnoughCashMerchantProcesor.
	aDisconnectedMerchantProcesor := self aDisconnectedMerchantProcesor.
	aStolenCreditCardMerchantProcesor := self aStolenCreditCardMerchantProcesor.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/13/2018 10:44:47'!
test01CanNotCheckoutAnEmptyCart

	| salesBook debitsOfANotExpiredCreditCard |
	
	salesBook := OrderedCollection new.

	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: aNotExpiredCreditCard 
			on: testObjectsFactory today
			registeringOn:  salesBook
			verifingWith: anEverythingIsOkMerchantProcesor. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty.
			debitsOfANotExpiredCreditCard := anEverythingIsOkMerchantProcesor debitsOf: aNotExpiredCreditCard.
			self assert: debitsOfANotExpiredCreditCard size = 0 ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/13/2018 10:44:53'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.

	cashier :=  Cashier 
					toCheckout: cart 
					charging: testObjectsFactory notExpiredCreditCard 
					on: testObjectsFactory today 
					registeringOn: OrderedCollection new 
					verifingWith: anEverythingIsOkMerchantProcesor.
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/13/2018 10:39:03'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook debitsOfAnExpiredCreditCard|

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: anExpiredCreditCard 
				on: testObjectsFactory today
				registeringOn: salesBook
				verifingWith: anEverythingIsOkMerchantProcesor ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			debitsOfAnExpiredCreditCard := anEverythingIsOkMerchantProcesor debitsOf: anExpiredCreditCard.
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty.
			self assert: debitsOfAnExpiredCreditCard size = 0]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/13/2018 10:39:18'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		verifingWith: anEverythingIsOkMerchantProcesor.
	total := cashier checkOut.
					
	self assert: salesBook notEmpty.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/14/2018 00:01:20'!
test05CashierMustUseMerchantProcesorToCheckout

	| cart cashier salesBook total  debitsOfANotExpiredCreditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: aNotExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		verifingWith: anEverythingIsOkMerchantProcesor.
	total := cashier checkOut.
	debitsOfANotExpiredCreditCard := anEverythingIsOkMerchantProcesor debitsOf: aNotExpiredCreditCard.
	self assert: salesBook notEmpty.
	self assert: salesBook first total = total.
	self assert: (debitsOfANotExpiredCreditCard includes: total).
	self assert: debitsOfANotExpiredCreditCard size = 1.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/13/2018 23:59:22'!
test07CannotMakeAPurchaseIfCreditCardDoesntHaveEnoughCash
	| cart cashier salesBook debitsFromCard saleTotal |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook _ OrderedCollection new.
	saleTotal := testObjectsFactory itemSellByTheStorePrice.
	cashier _ Cashier
		toCheckout: cart
		charging: aNotExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		verifingWith: anNotEnoughCashMerchantProcesor. 
	self
		should: [ cashier checkOut. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeANotEnoughCashCreditCardErrorMessage.
			debitsFromCard _ anNotEnoughCashMerchantProcesor debitsOf: aNotExpiredCreditCard.
			self assert: salesBook isEmpty.
			self assert: (debitsFromCard includes: saleTotal).
			self assert: debitsFromCard size = 1. ].
		
	

	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/14/2018 00:18:59'!
test08CanNotMakeAPurchaseIfMerchantProcesorIsDisconected
	| cart cashier salesBook debitsFromCard saleTotal |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook _ OrderedCollection new.
	saleTotal _ testObjectsFactory itemSellByTheStorePrice.
	cashier _ Cashier
		toCheckout: cart
		charging: aNotExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		verifingWith: aDisconnectedMerchantProcesor.
	self
		should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier merchantProcesorDisconnectedErrorMessage.
			debitsFromCard _ aDisconnectedMerchantProcesor debitsOf: aNotExpiredCreditCard.
			self assert: salesBook isEmpty.
			self assert: (debitsFromCard includes: saleTotal).
			self assert: debitsFromCard size = 1 ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'm 6/14/2018 11:45:35'!
test09CanNotMakeAPurchaseWithAStolenCreditCard
	| cart cashier salesBook debitsTriedFromCard saleTotal |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook _ OrderedCollection new.
	saleTotal _ testObjectsFactory itemSellByTheStorePrice.
	cashier _ Cashier
		toCheckout: cart
		charging: aNotExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		verifingWith: aStolenCreditCardMerchantProcesor.
	self
		should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier merchantProcesorStolenCreditCardErrorMessage.
			debitsTriedFromCard _ aStolenCreditCardMerchantProcesor debitsOf: aNotExpiredCreditCard.
			self assert: salesBook isEmpty.
			self assert: (debitsTriedFromCard includes: saleTotal).
			self assert: debitsTriedFromCard size = 1 ].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:04'!
catalog
	
	^ catalog! !

!Cart methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:05'!
itemsDo: aBlock
	
	^items do: aBlock ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCart salesBook merchantProcesor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'm 6/11/2018 20:00:33'!
checkOut
	
	| priceList total |
	
	priceList := cart catalog.
	total := 0.
	cart itemsDo: [ :anItem | total := total + (priceList at: anItem)].
	merchantProcesor debit: total from: creditCart.
	salesBook add: (Sale of: total).
	
	^total! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'm 6/11/2018 19:28:25'!
initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook verifingWith: aMerchantProcesor 
	cart := aCart.
	creditCart := aCreditCard.
	salesBook := aSalesBook.
	merchantProcesor := aMerchantProcesor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'm 6/14/2018 11:46:25'!
merchantProcesorStolenCreditCardErrorMessage
	^MerchantProcesorInterface stolenCreditCardErrorMessage.! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'm 6/14/2018 10:40:21'!
canNotChargeANotEnoughCashCreditCardErrorMessage
	^ MerchantProcesorInterface notEnoughCashMessageError.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'm 6/14/2018 10:40:27'!
merchantProcesorDisconnectedErrorMessage
	^ MerchantProcesorInterface disconnectedMerchantProcesorMessageError.! !


!Cashier class methodsFor: 'instance creation' stamp: 'm 6/11/2018 19:27:15'!
toCheckout: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook verifingWith: aMerchantProcesor 
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook verifingWith: aMerchantProcesor! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MerchantProcesorInterface category: #TusLibros!
Object subclass: #MerchantProcesorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcesorInterface methodsFor: 'to debit' stamp: 'm 6/14/2018 10:30:18'!
debit: anAmount from: aCreditCard 
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcesorInterface class' category: #TusLibros!
MerchantProcesorInterface class
	instanceVariableNames: ''!

!MerchantProcesorInterface class methodsFor: 'error messages' stamp: 'm 6/14/2018 10:29:35'!
disconnectedMerchantProcesorMessageError
	^'MP desconectado'.! !

!MerchantProcesorInterface class methodsFor: 'error messages' stamp: 'm 6/14/2018 10:29:14'!
notEnoughCashMessageError
	^'Rechazado por no tener dinero'.! !

!MerchantProcesorInterface class methodsFor: 'error messages' stamp: 'm 6/14/2018 11:46:57'!
stolenCreditCardErrorMessage
	^'stolen credit card'.! !


!classDefinition: #MerchantProcesorInterfaceMock category: #TusLibros!
MerchantProcesorInterface subclass: #MerchantProcesorInterfaceMock
	instanceVariableNames: 'debits'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcesorInterfaceMock methodsFor: 'specific mock mesages' stamp: 'm 6/14/2018 02:06:56'!
debitsOf: aCreditCard 
	| debitsAmounts |
	debitsAmounts := debits at: aCreditCard ifAbsent: [ OrderedCollection new].
	^debitsAmounts.! !

!MerchantProcesorInterfaceMock methodsFor: 'specific mock mesages' stamp: 'm 6/14/2018 02:09:55'!
raiseException
	self subclassResponsibility.! !


!MerchantProcesorInterfaceMock methodsFor: 'to debit' stamp: 'm 6/14/2018 02:09:38'!
debit: anAmount from: aCreditCard 
	| creditCardDebits |
	creditCardDebits := debits at: aCreditCard ifAbsentPut: [ OrderedCollection new ].
	creditCardDebits add: anAmount .
	self raiseException.
"	self error: self class notEnoughCashMessageError."! !


!MerchantProcesorInterfaceMock methodsFor: 'initialization' stamp: 'm 6/14/2018 02:05:35'!
initializeWith: aDictionary 
	debits := aDictionary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcesorInterfaceMock class' category: #TusLibros!
MerchantProcesorInterfaceMock class
	instanceVariableNames: ''!

!MerchantProcesorInterfaceMock class methodsFor: 'instance creation' stamp: 'm 6/14/2018 02:12:19'!
newWith: aDictionary 
	^self new initializeWith: aDictionary.! !


!classDefinition: #DisconnectedMerchantProcesor category: #TusLibros!
MerchantProcesorInterfaceMock subclass: #DisconnectedMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!DisconnectedMerchantProcesor methodsFor: 'specific mock mesages' stamp: 'm 6/14/2018 02:10:50'!
raiseException
	self error: self class disconnectedMerchantProcesorMessageError.! !


!classDefinition: #EverythingIsOkMerchantProcesor category: #TusLibros!
MerchantProcesorInterfaceMock subclass: #EverythingIsOkMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!EverythingIsOkMerchantProcesor methodsFor: 'specific mock mesages' stamp: 'm 6/14/2018 02:10:40'!
raiseException
	! !


!classDefinition: #NotEnoughCashMerchantProcesor category: #TusLibros!
MerchantProcesorInterfaceMock subclass: #NotEnoughCashMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!NotEnoughCashMerchantProcesor methodsFor: 'specific mock mesages' stamp: 'm 6/14/2018 02:10:22'!
raiseException
	self error: self class notEnoughCashMessageError.! !


!classDefinition: #StolenCreditCardMerchantProcesor category: #TusLibros!
MerchantProcesorInterfaceMock subclass: #StolenCreditCardMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StolenCreditCardMerchantProcesor methodsFor: 'specific mock mesages' stamp: 'm 6/14/2018 11:47:54'!
raiseException
	self error: self class stolenCreditCardErrorMessage.! !


!classDefinition: #MonthOfYear category: #TusLibros!
Object subclass: #MonthOfYear
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MonthOfYear class' category: #TusLibros!
MonthOfYear class
	instanceVariableNames: ''!

!MonthOfYear class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:34'!
of: aDate 
	self shouldBeImplemented.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !
