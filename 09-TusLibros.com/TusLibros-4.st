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
	instanceVariableNames: 'anInvalidPassword aValidPassword aValidClientId anInvalidClientId aSingleClientDicc isbn1 aCatalog aTimer aValidCcn aValidCced aValidCco aValidCC anInvalidIdCart isbn2 debitBehavior anExpiredCC'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 11:47:19'!
test01cartShouldBeEmptyAfterCreation
	| aRestInterface idCart aBookList |
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId
		withPass: aValidPassword.
	aBookList _ aRestInterface listCart: idCart.
	self assert: aBookList isEmpty.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 11:48:13'!
test01_01CantListWithAnInvalidIdCart
	| aRestInterface |
	aRestInterface _ self aRestInterface.
	aRestInterface
		createCart: aValidClientId
		withPass: aValidPassword.
	self
		should: [ aRestInterface listCart: anInvalidIdCart ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidIdCartErrorMessage ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 15:07:07'!
test02CantCreateCartWithAnInvalidPassword
	| aRestInterface |
	aRestInterface _ self aRestInterface.
	self
		should: [
			aRestInterface
				createCart: aValidClientId
				withPass: anInvalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidPasswordErrorMessage ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 11:50:03'!
test03UserShouldExist
	| aRestInterface |
	aRestInterface _ self aRestInterface.
	self
		should: [
			aRestInterface
				createCart: anInvalidClientId
				withPass: anInvalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidUserErrorMessage ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 11:51:24'!
test04CartShouldntBeEmptyAfterAddingABook
	| aRestInterface idCart aBookList aQuantity |
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId
		withPass: aValidPassword.
	aQuantity _ 1.
	aRestInterface
		addToCart: idCart
		book: isbn1
		quantity: aQuantity.
	aBookList _ aRestInterface listCart: idCart.
	self deny: aBookList isEmpty.
	self assert: (aBookList occurrencesOf: isbn1) = 1.
	self assert: (aBookList occurrencesOf: isbn2) = 0.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 11:52:48'!
test05CantAddABookAfter30Min
	| aRestInterface idCart aQuantity |
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId
		withPass: aValidPassword.
	aQuantity _ 1.
	aTimer add30Minutes.
	self
		should: [
			aRestInterface
				addToCart: idCart
				book: isbn1
				quantity: aQuantity ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidCartErrorMessage ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 16:15:46'!
test06CanCheckOutCart
	"	debitBehavior _ "
	| aRestInterface idCart aQuantity aListPurchased |
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId
		withPass: aValidPassword.
	aQuantity _ 1.
	aRestInterface
		addToCart: idCart
		book: isbn1
		quantity: aQuantity.
	aRestInterface
		checkout: idCart
		with: aValidCC .
	aListPurchased _ aRestInterface
		listPurchases: aValidClientId
		withPass: aValidPassword.
	self assert: (aListPurchased occurrencesOf: isbn1) = 1.
	self assert: (aListPurchased total) = 10.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 11:59:11'!
test07CantCheckOutCartAfter30Min
	"	debitBehavior _ "
	| aRestInterface idCart aQuantity |
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId
		withPass: aValidPassword.
	aQuantity _ 1.
	aRestInterface
		addToCart: idCart
		book: isbn1
		quantity: aQuantity.
	aTimer add30Minutes.
	self
		should: [
			aRestInterface
				checkout: idCart
				with: aValidCC ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidCartErrorMessage ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 15:03:51'!
test08CantListCartAfter30Min
	"	debitBehavior _ "
	| aRestInterface idCart aQuantity |
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId
		withPass: aValidPassword.
	aQuantity _ 1.
	aRestInterface
		addToCart: idCart
		book: isbn1
		quantity: aQuantity.
	aTimer add30Minutes.
	self
		should: [ aRestInterface listCart: idCart ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidCartErrorMessage ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 15:26:27'!
test09CantCheckOutCartWhenMPFailsWithNotEnoughMoney
	"	debitBehavior _ "
	| aRestInterface idCart aQuantity |
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId
		withPass: aValidPassword.
	aQuantity _ 1.
	aRestInterface
		addToCart: idCart
		book: isbn1
		quantity: aQuantity.
	debitBehavior _ [ :anAmount :aCreditCard |
	self error: Cashier creditCardHasNoCreditErrorMessage ].
	self
		should: [
			aRestInterface
				checkout: idCart
				with: aValidCC ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface notEnoughMoneyErrorMessage ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'm 6/18/2018 15:27:02'!
test10CantCheckOutCartWithAnExpiredCC
	"	debitBehavior _ "
	| aRestInterface idCart aQuantity |
	aRestInterface _ self aRestInterface.
	idCart _ aRestInterface
		createCart: aValidClientId
		withPass: aValidPassword.
	aQuantity _ 1.
	aRestInterface
		addToCart: idCart
		book: isbn1
		quantity: aQuantity.
	self
		should: [
			aRestInterface
				checkout: idCart
				with: anExpiredCC ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage ].! !


!RestInterfaceTest methodsFor: 'test support' stamp: 'm 6/18/2018 03:26:43'!
aRestInterface
	^RestInterface newWithUsers: aSingleClientDicc catalog: aCatalog withTimer: aTimer withMerchanProcessor: self.! !

!RestInterfaceTest methodsFor: 'test support' stamp: 'm 6/16/2018 16:44:27'!
anISBN
	self shouldBeImplemented.! !

!RestInterfaceTest methodsFor: 'test support' stamp: 'm 6/18/2018 03:24:55'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!RestInterfaceTest methodsFor: 'test support' stamp: 'm 6/18/2018 15:22:52'!
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
	anExpiredCC _ StoreTestObjectsFactory new expiredCreditCard.
	
	anInvalidIdCart _ 9999999.
	
	debitBehavior := [ :anAmount :aCreditCard | ]! !


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


!Cart methodsFor: 'accesing' stamp: 'm 6/18/2018 12:23:57'!
itemsDo: aBlockClosure 
	items do: aBlockClosure.! !

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

!Cashier methodsFor: 'checkout - private' stamp: 'm 6/18/2018 12:58:43'!
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

!ListCart methodsFor: 'accesing' stamp: 'm 6/16/2018 23:42:27'!
isEmpty
	^itemsOccurences values allSatisfy: [ :anOccurence | anOccurence = 0].! !

!ListCart methodsFor: 'accesing' stamp: 'm 6/18/2018 00:41:43'!
occurrencesOf: anIsbn 
	^itemsOccurences at: anIsbn ifAbsent: [^0].! !


!ListCart methodsFor: 'initialization' stamp: 'm 6/18/2018 15:47:25'!
initializeFrom: aCart 
	itemsOccurences := Dictionary new.
	aCart itemsDo: [ :anItem | itemsOccurences at: anItem put: (aCart occurrencesOf: anItem)].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ListCart class' category: #TusLibros!
ListCart class
	instanceVariableNames: ''!

!ListCart class methodsFor: 'instance creation' stamp: 'm 6/18/2018 15:47:57'!
from: aCart 
	^self new initializeFrom: aCart .! !


!classDefinition: #ListPurchases category: #TusLibros!
Object subclass: #ListPurchases
	instanceVariableNames: 'itemsPurchased sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ListPurchases methodsFor: 'accesing' stamp: 'm 6/18/2018 12:53:54'!
occurrencesOf: anIsbn 
	^itemsPurchased occurrencesOf: anIsbn .! !

!ListPurchases methodsFor: 'accesing' stamp: 'm 6/18/2018 12:56:51'!
total
	^sales inject: 0 into: [ :currentSum :aSale | currentSum + aSale total ].! !


!ListPurchases methodsFor: 'initialization' stamp: 'm 6/18/2018 12:51:43'!
initializeWithItems: items andSales: paidSales 
	itemsPurchased := items.
	sales _ paidSales.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ListPurchases class' category: #TusLibros!
ListPurchases class
	instanceVariableNames: ''!

!ListPurchases class methodsFor: 'instance creation' stamp: 'm 6/18/2018 12:50:32'!
withItems: items andSales: paidSales 
	^self new initializeWithItems: items andSales: paidSales .! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'catalog clientList timer purchasedItems merchantProcessor nextIdCart purchasedSales nextIdTranssaction sessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'private' stamp: 'm 6/18/2018 14:55:05'!
getClientIdForCart: aCartId
	^ sessions keysAndValuesDo: [ :aClientId :aClientSession |
		aClientSession id = aCartId ifTrue: [ ^ aClientId ]].! !


!RestInterface methodsFor: 'initialization' stamp: 'm 6/18/2018 14:53:11'!
initializeWithUsers: aUserList catalog: aCatalog withTimer: aTimer withMerchanProcessor: aMerchantProcessor
	clientList _ aUserList.
	catalog _ aCatalog.
	timer _ aTimer.
	purchasedItems _ Dictionary new.
	merchantProcessor _ aMerchantProcessor.
	purchasedSales _ Dictionary new.
	sessions _ Dictionary new.
	nextIdTranssaction _ 1.
	nextIdCart _ 1.! !


!RestInterface methodsFor: 'product owner requirements' stamp: 'm 6/18/2018 14:55:05'!
addToCart: idCart book: anIsbn quantity: aQuantity
	| cart aClientId aClientSession |
	aClientId _ self getClientIdForCart: idCart.
	aClientSession _ sessions at: aClientId.
	aClientSession updateTimeStamp.
	"self checkCart: idCart."
	cart _ aClientSession cart.
	cart
		add: aQuantity
		of: anIsbn.! !

!RestInterface methodsFor: 'product owner requirements' stamp: 'm 6/18/2018 15:16:42'!
checkout: anIdCart with: aCreditCard
	| cart aCashier clientId clientPurchasedItems salesForClient aIdTranssaction clientSession |
	clientId _ self getClientIdForCart: anIdCart.
	clientSession _ sessions at: clientId.
	cart _ clientSession cart.
	"cart _ cartList at: anIdCart."
	"clientId := self getIdClientFor: anIdCart."
	clientSession updateTimeStamp.
	salesForClient _ purchasedSales
		at: clientId
		ifAbsentPut: [ OrderedCollection new ].
	aCashier _ Cashier
		toCheckout: cart
		charging: aCreditCard
		throught: merchantProcessor
		on: timer now
		registeringOn: salesForClient.
	
	[aCashier checkOut] 
		on: Error 
		do: [
			sessions removeKey: clientId.
			self error: self class notEnoughMoneyErrorMessage ].
	
	sessions removeKey: clientId.
	"cartList removeKey: anIdCart ."
	"openedCarts removeKey: anIdCart ."
	clientPurchasedItems _ purchasedItems
		at: clientId
		ifAbsentPut: [ OrderedCollection new ].
	cart itemsDo: [ :anIsbn |
		clientPurchasedItems add: anIsbn ].
	aIdTranssaction _ nextIdTranssaction.
	nextIdTranssaction _ nextIdTranssaction + 1.
	^ aIdTranssaction.! !

!RestInterface methodsFor: 'product owner requirements' stamp: 'm 6/18/2018 14:54:32'!
createCart: aClientId withPass: aPass 
	
	| aCart cartId |
	
	(clientList at: aClientId ifAbsent: [self error: self class invalidUserErrorMessage]) = aPass ifFalse: [self error: self class invalidPasswordErrorMessage].
	aCart := Cart acceptingItemsOf: catalog.
	cartId _ nextIdCart.
	nextIdCart _ nextIdCart  +1 .

	sessions at: aClientId put: (Session id: cartId cart: aCart timer: timer).
	^cartId.! !

!RestInterface methodsFor: 'product owner requirements' stamp: 'm 6/18/2018 15:48:17'!
listCart: aCartId	| cart aClientSession |
	
	aClientSession := sessions values detect: [ :aSession | aSession id = aCartId ] ifNone: [ self error: self class invalidIdCartErrorMessage ].
	aClientSession updateTimeStamp.
	cart _ aClientSession cart.
	^ListCart from: cart .
! !

!RestInterface methodsFor: 'product owner requirements' stamp: 'm 6/18/2018 12:49:22'!
listPurchases: aClienId withPass: aPass 
	^ListPurchases withItems: (purchasedItems at: aClienId) andSales: (purchasedSales at: aClienId).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'm 6/18/2018 03:12:44'!
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

!RestInterface class methodsFor: 'error messages' stamp: 'm 6/18/2018 15:16:28'!
notEnoughMoneyErrorMessage
	^'no hay suficiente dinero'.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'm 6/18/2018 12:57:59'!
initializeTotal: aTotal
	total := aTotal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'm 6/18/2018 12:57:43'!
of: aTotal
	^self new initializeTotal: aTotal.! !


!classDefinition: #Session category: #TusLibros!
Object subclass: #Session
	instanceVariableNames: 'id cart timer timestampLastAction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'initialization' stamp: 'm 6/18/2018 13:18:05'!
initializeWithId: anId cart: aCart timer: aTimer 
	id _ anId.
	cart _ aCart.
	timer _ aTimer.
	timestampLastAction _ timer now.! !


!Session methodsFor: 'accessing' stamp: 'm 6/18/2018 13:31:17'!
cart
	
	^cart! !

!Session methodsFor: 'accessing' stamp: 'm 6/18/2018 13:31:06'!
id
	^id! !


!Session methodsFor: 'timestamp update' stamp: 'm 6/18/2018 14:44:53'!
updateTimeStamp
	| curentTimeStamp |
	curentTimeStamp _ timer now.
	curentTimeStamp  < (timestampLastAction  + (Duration minutes: 30)) ifFalse: [self error: RestInterface invalidCartErrorMessage].
	timestampLastAction _ curentTimeStamp.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: #TusLibros!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instace creation' stamp: 'm 6/18/2018 13:16:32'!
id: anIdSession cart: aCart timer: aTimer
	^self new initializeWithId: anIdSession cart: aCart timer: aTimer.! !


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

!TimerStub methodsFor: 'initialization' stamp: 'AM 6/17/2018 23:52:05'!
initialize
	datetime _ DateAndTime now.! !


!TimerStub methodsFor: 'getting timestamp' stamp: 'AM 6/18/2018 00:08:35'!
now
	^datetime.! !


!TimerStub methodsFor: 'stub messages' stamp: 'm 6/18/2018 00:24:06'!
add30Minutes
	datetime _ datetime + (Duration minutes: 30).! !
