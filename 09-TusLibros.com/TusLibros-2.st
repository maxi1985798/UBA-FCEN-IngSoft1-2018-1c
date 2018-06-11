!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'm 6/10/2018 18:48:20'!
test09ACreditCardCanInformItsExpirationDate
	
	|validCreditCard cced|
	
	cced := GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2020).
	validCreditCard := CreditCard number: 123456789 expirationOn: cced .
	
	self assert: validCreditCard expiration = cced.! !

!CartTest methodsFor: 'tests' stamp: 'm 6/10/2018 19:41:19'!
test10ACashierCanGiveATransactionTicket
	
	|expiratedCreditCard cced aCashier aTicket aCart soldProduct |
	
	cced := GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2020).
	expiratedCreditCard  := CreditCard number: 123456789 expirationOn: cced .
	aCart := self createCart.
	soldProduct := self itemSellByTheStore.
	aCart add: soldProduct.
	aCashier := Cashier for: aCart with: expiratedCreditCard.
	
	aTicket := aCashier ticket.
	self assert: aTicket list size = 1.
	self assert: (aTicket list at: 1) product = soldProduct.
	self assert: (aTicket list at: 1) price = 16.
	self assert: aTicket total = 16.! !

!CartTest methodsFor: 'tests' stamp: 'm 6/10/2018 22:34:47'!
test10_1ACashierCanGiveATransactionTicketWhenYouBuy2Products
	
	|expiratedCreditCard cced aCashier aTicket aCart soldProduct |
	
	cced := GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2020).
	expiratedCreditCard  := CreditCard number: 123456789 expirationOn: cced .
	aCart := self createCart.
	soldProduct := self itemSellByTheStore.
	aCart add: soldProduct.
	aCart add: soldProduct.
	aCashier := Cashier for: aCart with: expiratedCreditCard.
	
	aTicket := aCashier ticket.
	self assert: aTicket list size = 2.
	self assert: (aTicket list at: 1) product = soldProduct.
	self assert: (aTicket list at: 1) price = 16.
	self assert: (aTicket list at: 2) product = soldProduct.
	self assert: (aTicket list at: 2) price = 16.
	self assert: aTicket total = 32.! !

!CartTest methodsFor: 'tests' stamp: 'm 6/10/2018 19:11:56'!
test11ACashierMusntMakeACheckoutWithAnExpiratedCreditCard
	
	|expiratedCreditCard cced aCashier|
	
	cced := GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2010).
	expiratedCreditCard  := CreditCard number: 123456789 expirationOn: cced .
	aCashier := Cashier for: self createCart with: expiratedCreditCard.
	
	self 
		should: [ aCashier ticket]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: aCashier class expiratedCreditCardDescription = anError messageText
			].
	! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'm 6/10/2018 19:51:27'!
defaultCatalog

	| catalog |

	catalog := Dictionary new.
	catalog at: self itemSellByTheStore put: 16.
	^ catalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


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


!Cart methodsFor: 'assertions' stamp: 'm 6/10/2018 19:52:56'!
assertIsValidItem: anItem

	(catalog keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'checkout' stamp: 'm 6/10/2018 23:56:06'!
generateProductListToSell
	| aSoldProductsList |
	aSoldProductsList _ items collect: [ :anItem |
		SoldProduct
			product: anItem
			withPrice: (catalog at: anItem) ].
	^ aSoldProductsList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'ticket of purchase' stamp: 'm 6/10/2018 23:56:06'!
ticket
	| soldProductsList |
	creditCard expiration < GregorianMonthOfYear current ifTrue: [ self error: self class expiratedCreditCardDescription ].
	soldProductsList _ cart generateProductListToSell.
	^ Ticket newWith: soldProductsList.! !


!Cashier methodsFor: 'initialization' stamp: 'm 6/10/2018 19:06:54'!
initializeWith: aCart andWith: aCreditCard 
	cart := aCart.
	creditCard := aCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'm 6/10/2018 19:08:41'!
expiratedCreditCardDescription
	^'Tarjeta de credito expirada'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'm 6/10/2018 19:06:16'!
for: aCart with: aCreditCard 
	^self new initializeWith: aCart andWith: aCreditCard .! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationMonth number expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'm 6/10/2018 14:42:55'!
initializeWithNumber: aNumber expirationOn: anExpirationMonthOfYear 
	number := aNumber.
	expiration := anExpirationMonthOfYear.! !


!CreditCard methodsFor: 'getters' stamp: 'm 6/10/2018 14:43:11'!
expiration
	^expiration! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'm 6/10/2018 14:42:04'!
number: aNumber expirationOn: anExpirationMonthOfYear 
	^self new initializeWithNumber: aNumber expirationOn: anExpirationMonthOfYear.! !


!classDefinition: #SoldProduct category: #TusLibros!
Object subclass: #SoldProduct
	instanceVariableNames: 'product price'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SoldProduct methodsFor: 'initialization' stamp: 'm 6/10/2018 20:19:47'!
initializeSelling: aProduct withPrice: aPriceNumber 
	product := aProduct.
	price := aPriceNumber! !


!SoldProduct methodsFor: 'getters' stamp: 'm 6/10/2018 20:22:47'!
price
	^price! !

!SoldProduct methodsFor: 'getters' stamp: 'm 6/10/2018 20:22:38'!
product
	^product! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SoldProduct class' category: #TusLibros!
SoldProduct class
	instanceVariableNames: ''!

!SoldProduct class methodsFor: 'as yet unclassified' stamp: 'm 6/10/2018 20:18:47'!
product: aProduct withPrice: aPrice
	^self new initializeSelling: aProduct withPrice: aPrice.! !


!classDefinition: #Ticket category: #TusLibros!
Object subclass: #Ticket
	instanceVariableNames: 'listOfSoldProducts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'ticket parts' stamp: 'm 6/10/2018 20:22:26'!
list
	^listOfSoldProducts copy.! !

!Ticket methodsFor: 'ticket parts' stamp: 'm 6/10/2018 22:33:17'!
total
	|totalPrice|
	totalPrice := listOfSoldProducts inject: 0 into: [ :partialSum :aSoldProduct | partialSum + aSoldProduct price ].
	^totalPrice.! !


!Ticket methodsFor: 'initialization' stamp: 'm 6/10/2018 20:21:59'!
initializeWithList: aColectionOfSoldProducts 
	listOfSoldProducts := aColectionOfSoldProducts.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'as yet unclassified' stamp: 'm 6/10/2018 20:21:10'!
newWith: aColectionOfSoldProducts 
	^self new initializeWithList: aColectionOfSoldProducts.! !
