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
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'anInvalidPassword aValidPassword aValidClientId anInvalidClientId aSingleClientDicc isbn1 aCatalog aTimer aValidCcn aValidCced aValidCco aValidCC anInvalidIdCart isbn2 debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 03:26:43'!
aRestInterface
	^RestInterface newWithUsers: aSingleClientDicc catalog: aCatalog withTimer: aTimer withMerchanProcessor: self.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'm 6/16/2018 16:44:27'!
anISBN
	self shouldBeImplemented.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 03:24:55'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 03:26:00'!
setUp
	anInvalidPassword := 'unaPassInvalida'.
	aValidPassword := 'unaPassValida'.
	aValidClientId _ 'idCliente'.
	anInvalidClientId _ 'idCliente2'.
	
	aSingleClientDicc _ Dictionary new.
	aSingleClientDicc at: aValidClientId put: aValidPassword.
	
	isbn1 := '123456789'.
	isbn2 := '987654321'.
	
	aCatalog := Dictionary new.
	aCatalog at: isbn1 put: 10.
	aCatalog at: isbn2 put: 45.
	
	aTimer _ TimerStub new.
	
	aValidCcn _ '4444 333 22'.
	
	aValidCC _ StoreTestObjectsFactory new notExpiredCreditCard.
	
	anInvalidIdCart _ 9999999.
	
	debitBehavior := [ :anAmount :aCreditCard | ]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 00:24:47'!
test01
	| aRestInterface idCart aBookList |
	
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId 
		withPass: aValidPassword .
	aBookList := aRestInterface listCart: idCart.
	self assert: aBookList isEmpty.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 01:26:09'!
test01_01
	| aRestInterface |
	
	aRestInterface _ self aRestInterface.
	
	aRestInterface
		createCart: aValidClientId 
		withPass: aValidPassword .	
	
	self 
		should: [aRestInterface listCart: anInvalidIdCart. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidIdCartErrorMessage. ]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2018 21:14:12'!
test02
	| aRestInterface |
	
	aRestInterface _ self aRestInterface.
	
	self 
		should: [aRestInterface createCart: aValidClientId withPass: anInvalidPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidPasswordErrorMessage. ]
		
		
		
		! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AM 6/14/2018 21:16:34'!
test03
	| aRestInterface |
	
	aRestInterface _ self aRestInterface.
	
	self 
		should: [aRestInterface createCart: anInvalidClientId withPass: anInvalidPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidUserErrorMessage. ]
		
		
		
		! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 01:52:49'!
test04
	| aRestInterface idCart aBookList aQuantity |
	
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId 
		withPass: aValidPassword .
	aQuantity := 1.
	aRestInterface addToCart: idCart book: isbn1 quantity: aQuantity.
	aBookList := aRestInterface listCart: idCart.
	
	self deny: aBookList isEmpty.
	self assert: (aBookList occurrencesOf: isbn1) = 1.
	self assert: (aBookList occurrencesOf: isbn2) = 0.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'AM 6/17/2018 23:42:16'!
test05
	| aRestInterface idCart aQuantity |
	
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId 
		withPass: aValidPassword .
	aQuantity := 1.
	
	aTimer add30Minutes.
	
	self 
		should: [aRestInterface addToCart: idCart book: isbn1 quantity: aQuantity. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidCartErrorMessage. ]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 03:25:19'!
test06checkOutCart
	| aRestInterface idCart aQuantity aListPurchased |
"	debitBehavior _ "
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId 
		withPass: aValidPassword.
	aQuantity := 1.
	aRestInterface addToCart: idCart book: isbn1 quantity: aQuantity.
	aRestInterface checkout: idCart with: aValidCC.
	aListPurchased := aRestInterface listPurchases: aValidClientId withPass: aValidPassword.
	
	self assert: (aListPurchased occurrencesOf: isbn1) = 1.
	self assert: (aListPurchased occurrencesOf: isbn2) = 0.
	self assert: aListPurchased size = 0.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 02:29:49'!
test06_01checkOutCart
	| aRestInterface idCart aQuantity aListPurchased |
	
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId 
		withPass: aValidPassword.
	aQuantity := 1.
	aRestInterface addToCart: idCart book: isbn1 quantity: aQuantity.
	aRestInterface checkout: idCart with: aValidCC.
	aListPurchased := aRestInterface listPurchases: aValidClientId withPass: aValidPassword.
	
	self assert: (aListPurchased occurrencesOf: isbn1) = 1.
	self assert: (aListPurchased occurrencesOf: isbn2) = 0.
	self assert: aListPurchased size = 0.! !


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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


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
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #ListCart category: #TusLibros!
Object subclass: #ListCart
	instanceVariableNames: 'itemsOccurences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ListCart methodsFor: 'as yet unclassified' stamp: 'm 6/16/2018 23:41:15'!
initializeFrom: aCart with: aCatalog 
	itemsOccurences := Dictionary new.
	aCatalog keys do: [ :anIsbn | itemsOccurences at: anIsbn put: (aCart occurrencesOf: anIsbn)]
	! !

!ListCart methodsFor: 'as yet unclassified' stamp: 'm 6/16/2018 23:42:27'!
isEmpty
	^itemsOccurences values allSatisfy: [ :anOccurence | anOccurence = 0].! !

!ListCart methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 00:41:43'!
occurrencesOf: anIsbn 
	^itemsOccurences at: anIsbn ifAbsent: [^0].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ListCart class' category: #TusLibros!
ListCart class
	instanceVariableNames: ''!

!ListCart class methodsFor: 'instance creation' stamp: 'm 6/16/2018 23:36:29'!
from: aCart 
	self shouldBeImplemented.! !

!ListCart class methodsFor: 'instance creation' stamp: 'm 6/16/2018 23:39:21'!
from: aCart with: aCatalog 
	^self new initializeFrom: aCart with: aCatalog .! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'catalog cartList clientList timer cartTimestampList purchasedItems merchantProcessor nextIdCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'as yet unclassified' stamp: 'AM 6/17/2018 23:57:24'!
addToCart: idCart book: anIsbn quantity: aQuantity 
	| cart |
	
	self checkCart: idCart.
	cart := cartList at: idCart.
	cart add: aQuantity of: anIsbn.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'AM 6/18/2018 00:16:00'!
checkCart: aCartId
	timer now  < ((cartTimestampList at: aCartId) + (Duration minutes: 30)) ifFalse: [self error: self class invalidCartErrorMessage].! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 03:22:31'!
checkout: anIdCart with: aCreditCard 
	| cart aCashier |
	cart _ cartList at: anIdCart.
	aCashier _ Cashier 
		toCheckout: cart 
		charging: aCreditCard 
		throught: merchantProcessor 
		on: timer now 
		registeringOn: (purchasedItems at: anIdCart ifAbsentPut: [OrderedCollection new] ). 
	aCashier checkOut.
	cartList removeKey: anIdCart .! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 03:19:09'!
createCart: aClientId withPass: aPass 
	
	| aCart cartId |
	
	(clientList at: aClientId ifAbsent: [self error: self class invalidUserErrorMessage]) = aPass ifFalse: [self error: self class invalidPasswordErrorMessage].
	aCart := Cart acceptingItemsOf: catalog.
	cartId _ nextIdCart.
	nextIdCart _ nextIdCart  +1 .
	cartList at: cartId put: aCart.
	cartTimestampList at: cartId put: timer now.
	^cartId.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 03:16:18'!
initializeWithUsers: aUserList catalog: aCatalog withTimer: aTimer withMerchanProcessor: aMerchantProcessor
	clientList _ aUserList.
	cartList _ Dictionary new..
	catalog _ aCatalog.
	timer _ aTimer.
	cartTimestampList _ Dictionary new.
	purchasedItems _ Dictionary new.
	merchantProcessor _ aMerchantProcessor.
	nextIdCart _ 1.! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 01:36:22'!
listCart: aCartId	| cart |
	
	cart := cartList at: aCartId ifAbsent: [ self error: self class invalidIdCartErrorMessage ] .
	^ListCart from: cart with: catalog.
! !

!RestInterface methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 02:12:52'!
listPurchases: aClienId withPass: aPass 
	^purchasedItems at: aClienId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 03:12:44'!
newWithUsers: aUserList catalog: aCatalog withTimer: aTimer withMerchanProcessor: aMerchanProcessor
	^ self new
		initializeWithUsers: aUserList
		catalog: aCatalog
		withTimer: aTimer
		withMerchanProcessor: aMerchanProcessor.! !


!RestInterface class methodsFor: 'error messages' stamp: 'AM 6/18/2018 00:09:34'!
invalidCartErrorMessage
	^'the cart is invalid or has expired'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'm 6/18/2018 01:27:31'!
invalidIdCartErrorMessage
	^'id carrito invalido'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'AM 6/14/2018 21:12:41'!
invalidPasswordErrorMessage
	^'Password invalida'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'AM 6/14/2018 21:20:10'!
invalidUserErrorMessage
	^'Usuario Invalido'.! !



!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TimerStub category: #TusLibros!
Object subclass: #TimerStub
	instanceVariableNames: 'datetime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimerStub methodsFor: 'as yet unclassified' stamp: 'm 6/18/2018 00:24:06'!
add30Minutes
	datetime _ datetime + (Duration minutes: 30).! !

!TimerStub methodsFor: 'as yet unclassified' stamp: 'AM 6/17/2018 23:52:05'!
initialize
	datetime _ DateAndTime now.! !

!TimerStub methodsFor: 'as yet unclassified' stamp: 'AM 6/18/2018 00:08:35'!
now
	^datetime.! !
