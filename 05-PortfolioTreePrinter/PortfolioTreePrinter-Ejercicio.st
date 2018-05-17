!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:22:46'!
test03_01WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	self assert: (Withdraw register: withdrawValue on: account) value equals: withdrawValue 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:36'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:30'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:24:31'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |

	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:11:42'!
test20_01CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolioTwo

    | account1 account2 account3 complexPortfolio1 complexPortfolio2 |
    
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    account3 := ReceptiveAccount new.    
    complexPortfolio1 := Portfolio with: account1 with: account2.
    complexPortfolio2 := Portfolio with: account3 with: account1.

    self 
        should: [ Portfolio with: complexPortfolio1 with: complexPortfolio2 ]
        raise: Error
        withExceptionDo: [ :invalidPortfolio |
            self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:30:52'!
test21_01TransferIsReachedFromTransacctions

	| fromAccount toAccount transfer |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	transfer := Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert:  100 = transfer value.
	self assert: fromAccount transactions first transfer equals: transfer.
	self assert: toAccount transactions first transfer equals: transfer.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:27:01'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount fromAccountLines toAccountLines|

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	
	fromAccountLines := self accountSummaryLinesOf: fromAccount.
	toAccountLines := self accountSummaryLinesOf: toAccount.
	
	self assert: 3 = fromAccountLines size.
	self assert: 'Deposito por 100' = (fromAccountLines at: 1).
	self assert: 'Extraccion por 50' = (fromAccountLines at: 2).
	self assert: 'Transferencia por -100' = (fromAccountLines at: 3).
	
	self assert: 1 = toAccountLines size.
	self assert: 'Transferencia por 100' = (toAccountLines at: 1).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:29'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self portofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:30'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self reversePortofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'm 5/15/2018 17:23:03'!
accountSummaryLinesOf: aReceptiveAccount 
	
	^(AccountSummary of: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'm 5/15/2018 17:22:57'!
accountTransferNetOf: aReceptiveAccount 
	
	^(TransferNet of: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'm 5/15/2018 17:22:53'!
investmentEarningsOf: aReceptiveAccount 
	
	^(InvestmentEarnings of: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'm 5/15/2018 17:22:48'!
investmentNetOf: aReceptiveAccount 
	
	^(InvestmentNet of: aReceptiveAccount) value.
	! !

!PortfolioTest methodsFor: 'test support' stamp: 'AM 5/17/2018 00:26:51'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionaryOfAccountsAndNames
	
	^(IdentifyAccount for: aPortfolio with: aDictionaryOfAccountsAndNames) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'AM 5/17/2018 00:26:58'!
reversePortofolioTreeOf: aPortfolio namingAccountWith: aNamingAccounts
	^(IdentifyAccount for: aPortfolio with: aNamingAccounts) value reverse.! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'm 5/15/2018 17:54:56'!
affectbalance: aBalance 
	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'AM 5/14/2018 18:25:31'!
workWith: anAccountSummary 
	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'accessing' stamp: 'AM 5/10/2018 21:03:55'!
transfer
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'AM 5/10/2018 21:59:29'!
affectbalance: aBalance 
	^aBalance - value.! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'm 5/15/2018 11:33:51'!
workWith: aMethodObject 
	^aMethodObject valueForCertificateOfDeposit: value tna: tna numberOfDays: numberOfDays.! !


!CertificateOfDeposit methodsFor: 'initialization' stamp: 'AM 5/10/2018 21:58:29'!
initializeWith: anAmount during: aNumberOfDays at: anInterestRate on: aSummarizingAccount 
	
	value _ anAmount.
	numberOfDays _ aNumberOfDays.
	tna _ anInterestRate.
	account _ aSummarizingAccount.
	
	aSummarizingAccount register: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'AM 5/10/2018 21:33:53'!
register: anAmount during: numberOfDays at: anInterestRate on: aSummarizingAccount 
	
	 ^self new initializeWith: anAmount during: numberOfDays at: anInterestRate on: aSummarizingAccount.! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'evaluating' stamp: 'AM 5/10/2018 20:22:28'!
affectbalance: aBalance 
	^aBalance + value.! !

!Deposit methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'evaluating' stamp: 'AM 5/14/2018 18:40:26'!
workWith: aMethodObject
	^aMethodObject valueForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'evaluating' stamp: 'AM 5/10/2018 20:54:39'!
affectbalance: aBalance 
	^aBalance + self value.! !

!TransferDeposit methodsFor: 'evaluating' stamp: 'AM 5/10/2018 21:02:52'!
value
	^transfer value.! !

!TransferDeposit methodsFor: 'evaluating' stamp: 'AM 5/14/2018 18:40:53'!
workWith: aMethodObject 
	^aMethodObject valueForTransferDeposit: self.! !


!TransferDeposit methodsFor: 'initialization' stamp: 'AM 5/10/2018 20:48:50'!
initializeKnowing: aTransfer 
	transfer _ aTransfer.! !


!TransferDeposit methodsFor: 'accessing' stamp: 'AM 5/10/2018 21:05:27'!
transfer
	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'AM 5/10/2018 20:48:35'!
newKnowing: aTransfer 
	^self new initializeKnowing: aTransfer.! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'evaluating' stamp: 'AM 5/10/2018 20:50:23'!
affectbalance: aBalance 
	^aBalance - self value.! !

!TransferWithdraw methodsFor: 'evaluating' stamp: 'AM 5/10/2018 21:02:35'!
value
	^transfer value.! !

!TransferWithdraw methodsFor: 'evaluating' stamp: 'AM 5/14/2018 18:41:00'!
workWith: aMethodObject 
	^aMethodObject valueForTransferWithdraw: self.! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'AM 5/10/2018 20:46:32'!
initializeKnowing: aTransfer 
	transfer _ aTransfer.! !


!TransferWithdraw methodsFor: 'accessing' stamp: 'AM 5/10/2018 21:05:08'!
transfer
	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'AM 5/10/2018 20:45:57'!
newKnowing: aTransfer 
	^self new initializeKnowing: aTransfer.! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'evaluating' stamp: 'm 5/15/2018 17:08:57'!
affectbalance: aBalance
	^aBalance - value.! !

!Withdraw methodsFor: 'evaluating' stamp: 'AM 5/10/2018 20:09:05'!
value

	^ value.! !

!Withdraw methodsFor: 'evaluating' stamp: 'AM 5/14/2018 18:41:43'!
workWith: aMethodObject 
	^aMethodObject valueForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountTransactionMethod category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransactionMethod
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransactionMethod methodsFor: 'evaluating' stamp: 'AM 5/16/2018 19:51:09'!
value

self subclassResponsibility.! !

!AccountTransactionMethod methodsFor: 'evaluating' stamp: 'AM 5/16/2018 19:52:29'!
valueForCertificateOfDeposit: aCertificateOfDepositValue tna: aTnaValue numberOfDays: aNumberOfDays

	self subclassResponsibility.! !

!AccountTransactionMethod methodsFor: 'evaluating' stamp: 'AM 5/16/2018 19:52:56'!
valueForDeposit: aDeposit

	self subclassResponsibility.! !

!AccountTransactionMethod methodsFor: 'evaluating' stamp: 'AM 5/16/2018 19:53:20'!
valueForTransferDeposit: aTransferDeposit

	self subclassResponsibility.! !

!AccountTransactionMethod methodsFor: 'evaluating' stamp: 'AM 5/16/2018 19:54:43'!
valueForTransferWithdraw: aTransferWithdraw

	self subclassResponsibility.! !

!AccountTransactionMethod methodsFor: 'evaluating' stamp: 'AM 5/16/2018 19:55:10'!
valueForWithdraw: aWithdraw

	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionMethod subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'evaluating' stamp: 'AM 5/16/2018 20:11:38'!
value
	summary _ OrderedCollection new.
	account transactionsDo: [ :aTransaction |
		summary add: (aTransaction workWith: self) ].
	^ summary.! !

!AccountSummary methodsFor: 'evaluating' stamp: 'm 5/15/2018 11:51:03'!
valueForCertificateOfDeposit: aCertificateOfDepositValue tna: aTnaValue numberOfDays: aNumberOfDays
	^'Plazo fijo por ', aCertificateOfDepositValue asString , ' durante ', aNumberOfDays asString , ' dias a una tna de ', (aTnaValue*100) asString , '%'! !

!AccountSummary methodsFor: 'evaluating' stamp: 'AM 5/14/2018 18:30:30'!
valueForDeposit: aDeposit 
	^'Deposito por ', aDeposit value printString.! !

!AccountSummary methodsFor: 'evaluating' stamp: 'AM 5/14/2018 18:37:41'!
valueForTransferDeposit: aTransferDeposit 
	^'Transferencia por ', aTransferDeposit transfer value printString.! !

!AccountSummary methodsFor: 'evaluating' stamp: 'AM 5/14/2018 18:36:18'!
valueForTransferWithdraw: aTransferWithdraw 
	^'Transferencia por -', aTransferWithdraw transfer value printString.! !

!AccountSummary methodsFor: 'evaluating' stamp: 'AM 5/14/2018 18:32:50'!
valueForWithdraw: aWithdraw 
	^'Extraccion por ', aWithdraw value printString.! !


!AccountSummary methodsFor: 'initialization' stamp: 'AM 5/14/2018 18:14:21'!
initializeWith: aReceptiveAccount 
	account _ aReceptiveAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'AM 5/14/2018 18:13:49'!
of: aReceptiveAccount 
	^self new initializeWith: aReceptiveAccount.! !


!classDefinition: #InvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionMethod subclass: #InvestmentEarnings
	instanceVariableNames: 'accountInvestmentEarnings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarnings methodsFor: 'evaluating' stamp: 'AM 5/16/2018 20:12:48'!
value
	accountInvestmentEarnings _ 0.
	account transactionsDo: [ :aTransaction |
		accountInvestmentEarnings _ accountInvestmentEarnings + (aTransaction workWith: self) ].
	^ accountInvestmentEarnings.! !

!InvestmentEarnings methodsFor: 'evaluating' stamp: 'm 5/15/2018 12:33:17'!
valueForCertificateOfDeposit: aCertificateOfDepositValue tna: aTnaValue numberOfDays: aNumberOfDays
	^ (aTnaValue/360)*aNumberOfDays*aCertificateOfDepositValue.! !

!InvestmentEarnings methodsFor: 'evaluating' stamp: 'AM 5/16/2018 20:00:32'!
valueForDeposit: aDeposit

	^0.! !

!InvestmentEarnings methodsFor: 'evaluating' stamp: 'AM 5/16/2018 20:01:10'!
valueForTransferDeposit: aTransferDeposit

	^0.! !

!InvestmentEarnings methodsFor: 'evaluating' stamp: 'AM 5/16/2018 20:02:22'!
valueForTransferWithdraw: aTransferWithdraw

	^0.! !

!InvestmentEarnings methodsFor: 'evaluating' stamp: 'AM 5/16/2018 20:03:49'!
valueForWithdraw: aWithdraw

	^0.! !


!InvestmentEarnings methodsFor: 'initialization' stamp: 'm 5/15/2018 12:27:03'!
initializeWith: aReceptiveAccount 
	account := aReceptiveAccount .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentEarnings class
	instanceVariableNames: ''!

!InvestmentEarnings class methodsFor: 'instance creation' stamp: 'm 5/15/2018 12:26:42'!
of: aReceptiveAccount 
	^self new initializeWith: aReceptiveAccount.! !


!classDefinition: #InvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionMethod subclass: #InvestmentNet
	instanceVariableNames: 'accountInvestmentNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNet methodsFor: 'evaluating' stamp: 'm 5/15/2018 12:23:34'!
value
	accountInvestmentNet := 0.
	account transactionsDo: [ :aTransaction | accountInvestmentNet := accountInvestmentNet + (aTransaction workWith: self)].
	^accountInvestmentNet ! !

!InvestmentNet methodsFor: 'evaluating' stamp: 'm 5/15/2018 12:26:02'!
valueForCertificateOfDeposit: aCertificateOfDepositValue tna: aTnaValue numberOfDays: aNumberOfDays
	^aCertificateOfDepositValue.! !

!InvestmentNet methodsFor: 'evaluating' stamp: 'm 5/15/2018 12:24:41'!
valueForDeposit: aDeposit 
	^0.! !

!InvestmentNet methodsFor: 'evaluating' stamp: 'm 5/15/2018 12:25:21'!
valueForTransferWithdraw: aTransferWithdraw 
	^0.! !

!InvestmentNet methodsFor: 'evaluating' stamp: 'm 5/15/2018 12:25:02'!
valueForWithdraw: aWithdraw 
	^0.! !


!InvestmentNet methodsFor: 'initialization' stamp: 'm 5/15/2018 12:18:28'!
initializeWith: aReceptiveAccount 
	account _ aReceptiveAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentNet class
	instanceVariableNames: ''!

!InvestmentNet class methodsFor: 'instance creation' stamp: 'm 5/15/2018 12:18:10'!
of: aReceptiveAccount 
	^self new initializeWith: aReceptiveAccount.! !


!classDefinition: #TransferNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionMethod subclass: #TransferNet
	instanceVariableNames: 'accountTransferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferNet methodsFor: 'evaluating' stamp: 'AM 5/14/2018 19:05:47'!
value
	accountTransferNet := 0.
	account transactionsDo: [ :aTransaction | accountTransferNet := accountTransferNet + (aTransaction workWith: self)].
	^accountTransferNet! !

!TransferNet methodsFor: 'evaluating' stamp: 'm 5/15/2018 11:35:16'!
valueForCertificateOfDeposit: aCertificateOfDepositValue tna: aTnaValue numberOfDays: aNumberOfDays
	^0! !

!TransferNet methodsFor: 'evaluating' stamp: 'AM 5/14/2018 19:03:19'!
valueForDeposit: aDeposit 
	^0.! !

!TransferNet methodsFor: 'evaluating' stamp: 'AM 5/14/2018 19:09:53'!
valueForTransferDeposit: aTransferDeposit 
	^aTransferDeposit transfer value.! !

!TransferNet methodsFor: 'evaluating' stamp: 'AM 5/14/2018 19:09:20'!
valueForTransferWithdraw: aTransferWithdraw 
	^(-1) * aTransferWithdraw transfer value.! !

!TransferNet methodsFor: 'evaluating' stamp: 'AM 5/14/2018 19:06:59'!
valueForWithdraw: aWithdraw 
	^0.! !


!TransferNet methodsFor: 'initialization' stamp: 'AM 5/14/2018 18:44:40'!
initializeWith: aReceptiveAccount 
	account _ aReceptiveAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'AM 5/14/2018 18:44:07'!
of: aReceptiveAccount 
	^self new initializeWith: aReceptiveAccount.! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:26'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount manages: anAccount) or: [ anAccount manages: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:01'!
manages: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'evaluating' stamp: 'AM 5/16/2018 22:45:22'!
accountsDo: aBlockClosure 
	accounts do: aBlockClosure.! !

!Portfolio methodsFor: 'evaluating' stamp: 'AM 5/16/2018 22:37:40'!
workWith: aMethodObject
	"^aMethodObject portfolio: self withAccounts: accounts."
	
	^aMethodObject valueWithPortfolio: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'AM 5/10/2018 20:19:05'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affectbalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AM 5/14/2018 18:25:02'!
transactionsDo: aBlockClosure 
	transactions do: aBlockClosure.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'evaluating' stamp: 'AM 5/16/2018 22:48:41'!
workWith: aMethodObject
	"^anMethodObject receptiveAccount: self."
	
	^aMethodObject valueWithReceptiveAccount: self.! !


!classDefinition: #SummarizingAccountMethod category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccountMethod
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccountMethod methodsFor: 'evaluating' stamp: 'AM 5/16/2018 22:28:51'!
value

	self subclassResponsibility.! !

!SummarizingAccountMethod methodsFor: 'evaluating' stamp: 'AM 5/17/2018 00:30:56'!
valueWithPortfolio: aPortfolio 

	self subclassResponsibility.! !

!SummarizingAccountMethod methodsFor: 'evaluating' stamp: 'AM 5/17/2018 00:31:25'!
valueWithReceptiveAccount: aReceptiveAccount

	self subclassResponsibility.! !


!classDefinition: #IdentifyAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountMethod subclass: #IdentifyAccount
	instanceVariableNames: 'account accountNameMapper listOfAccountNames level'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!IdentifyAccount methodsFor: 'evaluating' stamp: 'AM 5/16/2018 22:56:31'!
value

	listOfAccountNames _ OrderedCollection new.

	^account workWith: self.! !

!IdentifyAccount methodsFor: 'evaluating' stamp: 'AM 5/16/2018 23:48:06'!
valueWithPortfolio: aPortfolio 

	listOfAccountNames add: (self shift: (accountNameMapper at: aPortfolio) times: level).
	level _ level + 1.
	
	aPortfolio accountsDo: [ :anAccount |  anAccount workWith: self].
	
	level _ level - 1.

	^listOfAccountNames.! !

!IdentifyAccount methodsFor: 'evaluating' stamp: 'AM 5/16/2018 23:47:47'!
valueWithReceptiveAccount: aReceptiveAccount 
	^listOfAccountNames add: (self shift: (accountNameMapper at: aReceptiveAccount) times: level).! !


!IdentifyAccount methodsFor: 'initialization' stamp: 'AM 5/16/2018 23:11:50'!
initializeFor: aSummarizingAccount with: aDictionary atLevel: aLevel 
	account _ aSummarizingAccount.
	accountNameMapper _ aDictionary.
	level _ aLevel.! !


!IdentifyAccount methodsFor: 'private' stamp: 'AM 5/17/2018 00:07:05'!
shift: aString times: aNumber

	|resultingString|
	
	resultingString _ ''.
	
	aNumber timesRepeat: [resultingString _ (resultingString append: Character space asString)].
	
	^resultingString append: aString.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IdentifyAccount class' category: #'PortfolioTreePrinter-Ejercicio'!
IdentifyAccount class
	instanceVariableNames: ''!

!IdentifyAccount class methodsFor: 'instance creation' stamp: 'AM 5/16/2018 23:08:49'!
for: aSummarizingAccount with: aDictionary 
	^self for: aSummarizingAccount with: aDictionary atLevel: 0.! !

!IdentifyAccount class methodsFor: 'instance creation' stamp: 'AM 5/16/2018 23:12:35'!
for: aPortfolio with: aDictionary atLevel: aLevel
	^self new initializeFor: aPortfolio with: aDictionary atLevel: aLevel.! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'amount from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'AM 5/10/2018 20:39:05'!
initializeWith: anAmount from: aSummarizingAccount to: aSummarizingAccount2 

	|withdraw deposit|

	amount _ anAmount.
	from _ aSummarizingAccount.
	to _ aSummarizingAccount2.
	
	withdraw _ TransferWithdraw newKnowing: self.
	deposit _ TransferDeposit newKnowing: self.
	
	aSummarizingAccount register: withdraw.
	aSummarizingAccount2 register: deposit.! !


!Transfer methodsFor: 'value' stamp: 'AM 5/10/2018 21:01:56'!
value
	^amount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AM 5/10/2018 19:04:10'!
register: anAmount from: aSummarizingAccount to: aSummarizingAccount2 
	^self new initializeWith: anAmount from: aSummarizingAccount to: aSummarizingAccount2.! !
