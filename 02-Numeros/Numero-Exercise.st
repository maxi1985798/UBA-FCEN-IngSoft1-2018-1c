!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !


!NumeroTest methodsFor: 'setup' stamp: 'HernanWilkinson 5/7/2016 20:56'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	four := Entero with: 4.
	five := Entero with: 5.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:37:07'!
addAFraction: aNumber
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:37:19'!
addAnInteger: aNumber
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:36:06'!
dividesAFraction: aNumber
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:36:22'!
dividesAnInteger: aNumber
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:37:55'!
multiplyByAFraction: aNumber
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:37:44'!
multiplyByAnInteger: aNumber
	self subclassResponsibility.! !


!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:42:42'!
* aMultiplier 
	
	^aMultiplier multiplyByAnInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:42:49'!
+ anAdder 
	
	^anAdder addAnInteger: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:42:54'!
/ aDivisor
	^ aDivisor dividesAnInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 20:29:04'!
addAFraction: aFraction 
	^aFraction class with: (aFraction denominator * self) + aFraction numerator over: aFraction denominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'am 4/16/2018 21:04:32'!
addAnInteger: anEntero 
	^self class with: value + anEntero integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:21:43'!
dividesAFraction: aFraction
	^aFraction numerator / (aFraction denominator * self).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:27:03'!
dividesAnInteger: anInteger
	^ Fraccion
		with: anInteger 
		over: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 20:56:30'!
multiplyByAFraction: aFraction 
	^(self * aFraction numerator) / aFraction denominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 20:49:46'!
multiplyByAnInteger: anInteger 
	
	^self class with: value * anInteger integerValue! !


!Entero methodsFor: 'private' stamp: 'a 4/21/2018 20:10:47'!
createAFractionWithNumerator: anEnteroNoCero 
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'm 4/21/2018 21:10:46'!
with: aValue 
		|c|
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].	
	
	aValue isZero
		ifTrue: [c := EnteroCero]
		ifFalse: [
			aValue = 1 
				ifTrue:[c := EnteroUno ]
				ifFalse:[c := EnteroNiCeroNiUno ]
				].
			
	^c new initalizeWith: aValue.! !


!classDefinition: #EnteroCero category: #'Numero-Exercise'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroCero methodsFor: 'private' stamp: 'm 4/21/2018 20:55:15'!
createAFractionWithANonZeroDenominator: denominator

	^self
	! !

!EnteroCero methodsFor: 'private' stamp: 'm 4/21/2018 20:48:14'!
createAFractionWithNumerator: aDividend
	self error: self class canNotDivideByZeroErrorDescription.! !


!classDefinition: #EnteroNoCero category: #'Numero-Exercise'!
Entero subclass: #EnteroNoCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNoCero methodsFor: 'private' stamp: 'm 4/21/2018 21:12:20'!
createAFractionWithANonZeroDenominator: aDenominator
	self subclassResponsibility .! !

!EnteroNoCero methodsFor: 'private' stamp: 'm 4/21/2018 21:39:51'!
createAFractionWithCoprimeAndNonZeroAndNonOneNumerator: aNumerator
	self subclassResponsibility.! !

!EnteroNoCero methodsFor: 'private' stamp: 'm 4/21/2018 20:57:51'!
createAFractionWithNumerator: aDividend

	^aDividend createAFractionWithANonZeroDenominator: self! !

!EnteroNoCero methodsFor: 'private' stamp: 'm 4/21/2018 21:21:15'!
createAFractionWithNumeratorOne
	self subclassResponsibility.! !


!classDefinition: #EnteroNiCeroNiUno category: #'Numero-Exercise'!
EnteroNoCero subclass: #EnteroNiCeroNiUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNiCeroNiUno methodsFor: 'private' stamp: 'm 4/21/2018 21:39:51'!
createAFractionWithANonZeroDenominator: aDenominator
	| greatestCommonDivisor numerator denominator |
	greatestCommonDivisor _ self greatestCommonDivisorWith: aDenominator.
	numerator _ self // greatestCommonDivisor.
	denominator _ aDenominator // greatestCommonDivisor.
	^ denominator createAFractionWithCoprimeAndNonZeroAndNonOneNumerator: numerator.! !

!EnteroNiCeroNiUno methodsFor: 'private' stamp: 'm 4/21/2018 21:39:51'!
createAFractionWithCoprimeAndNonZeroAndNonOneNumerator: aNumerator
	^ Fraccion new
		initializeWith: aNumerator
		over: self.! !

!EnteroNiCeroNiUno methodsFor: 'private' stamp: 'm 4/21/2018 21:23:02'!
createAFractionWithNumeratorOne
	^Fraccion new initializeWith: (Entero with: 1) over: self.! !


!classDefinition: #EnteroUno category: #'Numero-Exercise'!
EnteroNoCero subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroUno methodsFor: 'private' stamp: 'm 4/21/2018 21:42:21'!
createAFractionWithANonZeroDenominator: aDenominator
	^aDenominator createAFractionWithNumeratorOne.! !

!EnteroUno methodsFor: 'private' stamp: 'm 4/21/2018 21:39:51'!
createAFractionWithCoprimeAndNonZeroAndNonOneNumerator: aNumerator
	^ aNumerator.! !

!EnteroUno methodsFor: 'private' stamp: 'm 4/21/2018 21:23:18'!
createAFractionWithNumeratorOne
	^self! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'initialization' stamp: 'm 4/21/2018 21:43:58'!
initializeWith: aNumerator over: aDenominator
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:43:36'!
* aMultiplier 
	
	^aMultiplier multiplyByAFraction: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:43:45'!
+ anAdder 
	
	^anAdder addAFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:43:51'!
/ aDivisor 
	
	^aDivisor dividesAFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 20:31:26'!
addAFraction: aFraction 
	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraction denominator) + (denominator * aFraction numerator).
	newDenominator := denominator * aFraction denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'am 4/16/2018 21:02:12'!
addAnInteger: anEntero 
	^self class with: (denominator * anEntero) + numerator over: denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:30:30'!
dividesAFraction: aFraction 
	^(denominator * aFraction numerator) / (numerator * aFraction denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 21:33:34'!
dividesAnInteger: anInteger
	^(anInteger * self denominator) / self numerator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 20:58:14'!
multiplyByAFraction: aFraction 
	^(numerator * aFraction numerator) / (denominator * aFraction denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'am 4/19/2018 20:43:21'!
multiplyByAnInteger: anInteger 
	^(self numerator * anInteger) / self denominator.! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'am 4/21/2018 20:25:59'!
with: aDividend over: aDivisor
	^aDivisor createAFractionWithNumerator: aDividend.
	! !
