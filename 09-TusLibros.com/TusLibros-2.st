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

!CartTest methodsFor: 'tests' stamp: 'm 6/11/2018 16:01:00'!
test09ACreditCardCanInformIfItIsExpirated
	| validCreditCard cced afterToCced |
	cced _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2020).
	afterToCced _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2022).
	validCreditCard _ CreditCard
		number: 123456789
		expirationOn: cced.
	self assert: (validCreditCard isExpiratedOn: afterToCced).! !

!CartTest methodsFor: 'tests' stamp: 'm 6/11/2018 16:00:50'!
test09ACreditCardCanInformIfItIsNotExpirated
	| validCreditCard cced previousToCced |
	cced _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2020).
	previousToCced _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2019).
	validCreditCard _ CreditCard
		number: 123456789
		expirationOn: cced.
	self deny: (validCreditCard isExpiratedOn: previousToCced).! !

!CartTest methodsFor: 'tests' stamp: 'm 6/11/2018 11:02:09'!
test10ACreditCardCanInformItsNumber
	| validCreditCard cced |
	cced _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2020).
	validCreditCard _ CreditCard
		number: 123456789
		expirationOn: cced.
	self assert: validCreditCard number = 123456789.! !

!CartTest methodsFor: 'tests' stamp: 'm 6/11/2018 16:34:51'!
test11ACashierCanGiveATransactionTicketWhenYouBuy1Products
	| expiratedCreditCard cced aCashier aTicket aCart soldProduct aTransactionDate |
	cced _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2020).
	expiratedCreditCard _ CreditCard
		number: 123456789
		expirationOn: cced.
	aTransactionDate _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2019).
	aCart _ self createCart.
	soldProduct _ self itemSellByTheStore.
	aCart add: soldProduct.
	aCashier _ Cashier
		for: aCart
		with: expiratedCreditCard
		on: aTransactionDate.
	aTicket _ aCashier ticket.
	self assert: aTicket list size = 1.
	self assert: (aTicket list at: 1) product = soldProduct.
	self assert: (aTicket list at: 1) price = 16.
	self assert: aTicket total = 16.
	self assert: aTicket buyer = 123456789.
	self assert: aTicket transactionDate = aTransactionDate.! !

!CartTest methodsFor: 'tests' stamp: 'm 6/11/2018 16:39:40'!
test12ACashierCanGiveATransactionTicketWhenYouBuy2Products
	| expiratedCreditCard cced aCashier aTicket aCart soldProduct aTransactionDate |
	cced _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2020).
	aTransactionDate := GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2019).
	expiratedCreditCard _ CreditCard
		number: 123456789
		expirationOn: cced.
	
	aCart _ self createCart.
	soldProduct _ self itemSellByTheStore.
	aCart add: soldProduct.
	aCart add: soldProduct.
	aCashier _ Cashier for: aCart with: expiratedCreditCard on: aTransactionDate.
	aTicket _ aCashier ticket.
	self assert: aTicket list size = 2.
	self assert: (aTicket list at: 1) product = soldProduct.
	self assert: (aTicket list at: 1) price = 16.
	self assert: (aTicket list at: 2) product = soldProduct.
	self assert: (aTicket list at: 2) price = 16.
	self assert: aTicket total = 32.
	self assert: aTicket buyer = 123456789.
	self assert: aTicket transactionDate = aTransactionDate.! !

!CartTest methodsFor: 'tests' stamp: 'm 6/11/2018 16:03:40'!
test13ACashierMusntMakeACheckoutWithAnExpiratedCreditCard
	| expiratedCreditCard cced aCashier transactionDate |
	cced _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2010).
	transactionDate _ GregorianMonthOfYear februaryOf: (GregorianYear createYear: 2022).
	expiratedCreditCard _ CreditCard
		number: 123456789
		expirationOn: cced.
	aCashier _ Cashier for: self createCart with: expiratedCreditCard on: transactionDate.
	self
		should: [ aCashier ticket ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: aCashier class expiratedCreditCardDescription = anError messageText ].! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'm 6/11/2018 11:16:49'!
defaultCatalog
	| catalogDictionary |
	catalogDictionary _ Dictionary new.
	catalogDictionary
		at: self itemSellByTheStore
		put: 16.
	^Catalog newFromDictionary: catalogDictionary.
	
	! !

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


!Cart methodsFor: 'assertions' stamp: 'm 6/11/2018 11:18:55'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'checkout' stamp: 'm 6/11/2018 11:21:57'!
generateProductListToSell
	| aSoldProductsList |
	aSoldProductsList _ items collect: [ :anItem |
		SoldProduct
			product: anItem
			withPrice: (catalog priceFor: anItem) ].
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
	instanceVariableNames: 'cart creditCard transactionDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'ticket of purchase' stamp: 'm 6/11/2018 16:36:04'!
ticket
	| soldProductsList |
	(creditCard isExpiratedOn: transactionDate) ifTrue: [ self error: self class expiratedCreditCardDescription ].
	soldProductsList _ cart generateProductListToSell.
	^ Ticket  buyer: creditCard number soldProducts: soldProductsList on: transactionDate.! !


!Cashier methodsFor: 'initialization' stamp: 'm 6/11/2018 15:57:08'!
initializeWith: aCart andWith: aCreditCard on: aGregorianMonthOfYear 
	cart := aCart.
	creditCard := aCreditCard.
	transactionDate := aGregorianMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'm 6/10/2018 19:08:41'!
expiratedCreditCardDescription
	^'Tarjeta de credito expirada'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'm 6/11/2018 15:56:05'!
for: aCart with: aCreditCard on: aGregorianMonthOfYear 
	^self new initializeWith: aCart andWith: aCreditCard on: aGregorianMonthOfYear.! !


!classDefinition: #Catalog category: #TusLibros!
Object subclass: #Catalog
	instanceVariableNames: 'dictionaryOfProductsAndPrices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalog methodsFor: 'initialization' stamp: 'm 6/11/2018 11:18:27'!
initializeFromDictionary: aDictionary 
	dictionaryOfProductsAndPrices := aDictionary.! !


!Catalog methodsFor: 'testing' stamp: 'm 6/11/2018 11:19:40'!
includes: aProduct 
	^dictionaryOfProductsAndPrices keys includes: aProduct .! !


!Catalog methodsFor: 'accessing' stamp: 'm 6/11/2018 11:24:45'!
priceFor: aProduct 
	^dictionaryOfProductsAndPrices at: aProduct ifAbsent: [ self error: self class productNotInCatalogDescription].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalog class' category: #TusLibros!
Catalog class
	instanceVariableNames: ''!

!Catalog class methodsFor: 'instance creation' stamp: 'm 6/11/2018 11:17:38'!
newFromDictionary: aDictionary 
	^self new initializeFromDictionary: aDictionary .! !


!Catalog class methodsFor: 'error descriptions' stamp: 'm 6/11/2018 11:26:02'!
productNotInCatalogDescription
	^'El producto no esta en el catalogo'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'm 6/10/2018 14:42:55'!
initializeWithNumber: aNumber expirationOn: anExpirationMonthOfYear 
	number := aNumber.
	expiration := anExpirationMonthOfYear.! !


!CreditCard methodsFor: 'accessing' stamp: 'm 6/11/2018 10:45:45'!
number
	
	^number! !


!CreditCard methodsFor: 'testing' stamp: 'm 6/11/2018 15:59:36'!
isExpiratedOn: aGregorianMonthOfYear 
	^expiration < aGregorianMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'm 6/10/2018 14:42:04'!
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


!SoldProduct methodsFor: 'accesing' stamp: 'm 6/10/2018 20:22:47'!
price
	^price! !

!SoldProduct methodsFor: 'accesing' stamp: 'm 6/10/2018 20:22:38'!
product
	^product! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SoldProduct class' category: #TusLibros!
SoldProduct class
	instanceVariableNames: ''!

!SoldProduct class methodsFor: 'instance creation' stamp: 'm 6/10/2018 20:18:47'!
product: aProduct withPrice: aPrice
	^self new initializeSelling: aProduct withPrice: aPrice.! !


!classDefinition: #Ticket category: #TusLibros!
Object subclass: #Ticket
	instanceVariableNames: 'listOfSoldProducts buyer transactionDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'ticket parts' stamp: 'm 6/11/2018 10:49:25'!
buyer
	
	^buyer! !

!Ticket methodsFor: 'ticket parts' stamp: 'm 6/10/2018 20:22:26'!
list
	^listOfSoldProducts copy.! !

!Ticket methodsFor: 'ticket parts' stamp: 'm 6/10/2018 22:33:17'!
total
	|totalPrice|
	totalPrice := listOfSoldProducts inject: 0 into: [ :partialSum :aSoldProduct | partialSum + aSoldProduct price ].
	^totalPrice.! !


!Ticket methodsFor: 'initialization' stamp: 'm 6/11/2018 16:38:16'!
initializeWithBuyer: ccNumber soldProducts: aSoldProductsList on: aGregorianMonthOfYear 
	listOfSoldProducts := aSoldProductsList.
	buyer := ccNumber.
	transactionDate := aGregorianMonthOfYear.! !


!Ticket methodsFor: 'accessing' stamp: 'm 6/11/2018 16:35:13'!
transactionDate
	^transactionDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'm 6/11/2018 16:37:06'!
buyer: ccNumber soldProducts: aSoldProductsList on: aGregorianMonthOfYear 
	^self new initializeWithBuyer: ccNumber soldProducts: aSoldProductsList on: aGregorianMonthOfYear.! !
