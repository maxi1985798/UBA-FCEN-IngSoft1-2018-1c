!classDefinition: #TicTacToeConsoleTest category: #TicTacToe!
TestCase subclass: #TicTacToeConsoleTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsoleTest methodsFor: 'tests' stamp: 'AM 6/3/2018 02:53:28'!
test01
	| game console lines |
	
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game register: console.
	
	game markWithXAt: 2 @ 2.
	lines _ console lines.
	
	self assert: console lines size equals: 2.
	self assert: (lines at: 1) = 'X marcó en 2@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.! !

!TicTacToeConsoleTest methodsFor: 'tests' stamp: 'AM 6/3/2018 02:37:35'!
test02
	| game console lines |
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game register: console.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	lines _ console lines.
	self
		assert: lines size
		equals: 4.
	self assert: (lines at: 1) = 'X marcó en 2@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.
	self assert: (lines at: 3) = 'O marcó en 1@1'.
	self assert: (lines at: 4) = 'Estado: Jugando X'.! !

!TicTacToeConsoleTest methodsFor: 'tests' stamp: 'AM 6/3/2018 02:37:35'!
test03
	| game console lines |
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game register: console.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 1.
	lines _ console lines.
	self
		assert: lines size
		equals: 10.
	self assert: (lines at: 1) = 'X marcó en 2@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.
	self assert: (lines at: 3) = 'O marcó en 1@1'.
	self assert: (lines at: 4) = 'Estado: Jugando X'.
	self assert: (lines at: 5) = 'X marcó en 1@3'.
	self assert: (lines at: 6) = 'Estado: Jugando O'.
	self assert: (lines at: 7) = 'O marcó en 1@2'.
	self assert: (lines at: 8) = 'Estado: Jugando X'.
	self assert: (lines at: 9) = 'X marcó en 3@1'.
	self assert: (lines at: 10) = 'Estado: Juego terminado - Ganó X!!'.! !

!TicTacToeConsoleTest methodsFor: 'tests' stamp: 'AM 6/3/2018 02:37:35'!
test04
	| game console lines |
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game register: console.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 3.
	game markWithOAt: 1 @ 3.
	lines _ console lines.
	self
		assert: lines size
		equals: 12.
	self assert: (lines at: 1) = 'X marcó en 2@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.
	self assert: (lines at: 3) = 'O marcó en 1@1'.
	self assert: (lines at: 4) = 'Estado: Jugando X'.
	self assert: (lines at: 5) = 'X marcó en 3@2'.
	self assert: (lines at: 6) = 'Estado: Jugando O'.
	self assert: (lines at: 7) = 'O marcó en 1@2'.
	self assert: (lines at: 8) = 'Estado: Jugando X'.
	self assert: (lines at: 9) = 'X marcó en 3@3'.
	self assert: (lines at: 10) = 'Estado: Jugando O'.
	self assert: (lines at: 11) = 'O marcó en 1@3'.
	self assert: (lines at: 12) = 'Estado: Juego terminado - Ganó O!!'.! !

!TicTacToeConsoleTest methodsFor: 'tests' stamp: 'AM 6/3/2018 02:37:35'!
test05
	| game console lines |
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game register: console.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 3.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 1 @ 3.
	lines _ console lines.
	self
		assert: lines size
		equals: 18.
	self assert: (lines at: 1) = 'X marcó en 2@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.
	self assert: (lines at: 3) = 'O marcó en 1@1'.
	self assert: (lines at: 4) = 'Estado: Jugando X'.
	self assert: (lines at: 5) = 'X marcó en 3@2'.
	self assert: (lines at: 6) = 'Estado: Jugando O'.
	self assert: (lines at: 7) = 'O marcó en 1@2'.
	self assert: (lines at: 8) = 'Estado: Jugando X'.
	self assert: (lines at: 9) = 'X marcó en 3@3'.
	self assert: (lines at: 10) = 'Estado: Jugando O'.
	self assert: (lines at: 11) = 'O marcó en 3@1'.
	self assert: (lines at: 12) = 'Estado: Jugando X'.
	self assert: (lines at: 13) = 'X marcó en 2@1'.
	self assert: (lines at: 14) = 'Estado: Jugando O'.
	self assert: (lines at: 15) = 'O marcó en 2@3'.
	self assert: (lines at: 16) = 'Estado: Jugando X'.
	self assert: (lines at: 17) = 'X marcó en 1@3'.
	self assert: (lines at: 18) = 'Estado: Juego terminado - Empate!!'.! !


!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/27/2017 17:25:54'!
functionalException

	^Error - MessageNotUnderstood! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/26/2017 15:10:54'!
test01GameStartsWithAnEmptyBoarAndPlayingX

	"I initialize it on each test and not in the setUp to facilitate the restar of the test - Hernan"
	
	game _ TicTacToe new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.
	
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:35'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO

	game _ TicTacToe new.
	
	game markAll: {1@1}.

	self assertXIsMarkedOn: {1@1} andOOn: {}.
	self assertIsPlayingO

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:31'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsY

	game _ TicTacToe new.

	game markAll: { 1 @ 1. 2 @ 2 }.

	self assertXIsMarkedOn: {1@1} andOOn: {2@2}.
	self assertIsPlayingX.

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:28'!
test04CanNotMarkWithXWhenLastMarkWasX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:23'!
test05CanNotMarkWithOWhenLastMarkWasO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:19'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:16'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:12'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.
	
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:08'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2. 3@3 }.

	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1. 3@3} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:04'!
test10XWinsWhenCompletesRowNumber1

	game _ TicTacToe new.

	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assertXWon.
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:59'!
test11XWinsWhenCompletesRowNumber2

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 3@1. 2@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:54'!
test12XWinsWhenCompletesRowNumber3

	game _ TicTacToe new.

	game markAll: {3@1. 1@1. 3@2. 2@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:50'!
test13XWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:45'!
test14XWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 1@1. 1@2. 2@2. 1@3. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:41'!
test15XWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: { 1@3. 1@2. 2@2. 2@1. 3@ 1 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:35'!
test16OWinsWhenCompletesARow

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:31'!
test17OWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 3@3. 1@2. 2@3. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:25'!
test18OWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 3@2. 1@3. 1@2. 2@2. 1@1. 3@1 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:20'!
test19OWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: {1@2. 1@1. 1@3. 2@2. 2@1. 3@3 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:15'!
test20OCanNotPlayWhenXWon

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markWithOAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:12'!
test21XCanNotPlayWhenOWon

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 2@1. 1@2. 3@1. 1@3 }.

	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: { 2@2. 2@1. 3@1 } ]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:08'!
test22GameCanEndUpTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self assertGameIsTied! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:01'!
test23XCanWinOnLastEmptyPosition

	game _ TicTacToe new.

	game markAll: { 2@2. 1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:41:58'!
test24CanNotPlayWhenGameIsTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'JG 5/12/2018 13:23:11'!
test25CanNotMarkOutsideBoard

	game _ TicTacToe new.

	#(0 4) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:49:43'!
test26OCanNotMarkWhenGameIsOver

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'AM 6/3/2018 02:32:50'!
test27XPlayIsLastPlay

	game _ TicTacToe new.
	game markAll: {1@1}.
	
	self assert: game lastPlay equals: 1@1.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'AM 6/3/2018 02:33:23'!
test28ThereIsNoLastPlayInNewGame

	game _ TicTacToe new.
	self
		should: [ game lastPlay ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe ThereAreNoPlaysYetErrorMessage equals: anError messageText.
		]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'AM 6/3/2018 02:33:47'!
test29OPlayIsLastPlay

	game _ TicTacToe new.
	game markAll: {1@1. 1@2}.
	
	self assert: game lastPlay equals: 1@2.! !


!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:06'!
assertCanNotMarkAt: aPosition

	self assertCanNotMarkUsing: [ game markWithXAt: aPosition ].
	self assertCanNotMarkUsing: [ game markWithOAt: aPosition ].
	
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:29'!
assertCanNotMarkUsing: aMarkingClosure

	self
		should: aMarkingClosure 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionOutsideBoardErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:14'!
assertGameIsNotOver

	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:48'!
assertGameIsOver
	
	self assert: game isOver.

	self deny: game isPlayingX.
	self deny: game isPlayingO.
		
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:40:41'!
assertGameIsTied

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:13:05'!
assertIsPlayingO
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.
	self assertGameIsNotOver ! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:05'!
assertIsPlayingX
		
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:38:07'!
assertOIsMarkedOn: oPositions
		
	self assert: oPositions size equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions) isEmpty.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:32:18'!
assertOWon

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self assert: game hasPlayerOWon.
	self deny: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:56'!
assertXIsMarkedOn: xPositions

	self assert: xPositions size equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions) isEmpty.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:44'!
assertXIsMarkedOn: xPositions andOOn: oPositions
 
	self assertXIsMarkedOn: xPositions.
	self assertOIsMarkedOn: oPositions.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:30'!
assertXWon
	
	self assertGameIsOver.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.
! !


!classDefinition: #TicTacToeViewTest category: #TicTacToe!
TestCase subclass: #TicTacToeViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeViewTest methodsFor: 'tests' stamp: 'AM 6/3/2018 22:59:06'!
test01
	| game view boardStateText playingStateText lines nl |
	game _ TicTacToe new.
	view _ TicTacToeView new.
	game register: view.
	
	nl _ Character newLineCharacter asString.
	boardStateText _ 
	' | | ', nl,
	'-----', nl,
	' |X| ', nl,
	'-----', nl,
	' | | '.
	
	playingStateText _ 'Playing O'.

	game markWithXAt: 2 @ 2.
	lines _ view lines.
	
	self assert: (lines at: 1) = boardStateText.
	self assert: (lines at: 2) = playingStateText.! !

!TicTacToeViewTest methodsFor: 'tests' stamp: 'AM 6/3/2018 23:00:42'!
test02
	| game view boardStateText playingStateText lines nl |
	game _ TicTacToe new.
	view _ TicTacToeView new.
	game register: view.
	
	nl _ Character newLineCharacter asString.
	boardStateText _ 
	'X| | ', nl,
	'-----', nl,
	' |X| ', nl,
	'-----', nl,
	'O| | '.

	playingStateText _ 'Playing O'.

	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	game markWithXAt: 1@3.
	
	lines _ view lines.
	
	self assert: (lines at: 1) = boardStateText.
	self assert: (lines at: 2) = playingStateText.! !

!TicTacToeViewTest methodsFor: 'tests' stamp: 'AM 6/3/2018 23:16:45'!
test03
	| game view lines nl boardStateText playingStateText |
	game _ TicTacToe new.
	view _ TicTacToeView new.
	nl _ Character newLineCharacter asString.
	boardStateText _ 
	'X| | ', nl,
	'-----', nl,
	'O|X| ', nl,
	'-----', nl,
	'O| |X'.
	
	playingStateText _ 'X Won!!'.
	
	game register: view.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 1.
	lines _ view lines.
	
	self
		assert: lines size
		equals: 2.
	self assert: (lines at: 1) = boardStateText.
	self assert: (lines at: 2) = playingStateText.! !

!TicTacToeViewTest methodsFor: 'tests' stamp: 'AM 6/3/2018 23:28:47'!
test04
	| game view lines nl boardStateText playingStateText |
	game _ TicTacToe new.
	view _ TicTacToeView new.
	nl _ Character newLineCharacter asString.
	boardStateText _ 
	'O| |X', nl,
	'-----', nl,
	'O|X|X', nl,
	'-----', nl,
	'O| | '.
	
	playingStateText _ 'O Won!!'.
	
	game register: view.

	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 3.
	game markWithOAt: 1 @ 3.
	
	
	lines _ view lines.
	
	self
		assert: lines size
		equals: 2.
	self assert: (lines at: 1) = boardStateText.
	self assert: (lines at: 2) = playingStateText.! !

!TicTacToeViewTest methodsFor: 'tests' stamp: 'AM 6/3/2018 23:33:26'!
test05
	| game view lines nl boardStateText playingStateText |
	game _ TicTacToe new.
	view _ TicTacToeView new.
	nl _ Character newLineCharacter asString.
	boardStateText _ 
	'X|O|X', nl,
	'-----', nl,
	'O|X|X', nl,
	'-----', nl,
	'O|X|O'.
	
	playingStateText _ 'Tied!!'.
	
	game register: view.

	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 3.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 1 @ 3.
	
	
	lines _ view lines.
	
	self
		assert: lines size
		equals: 2.
	self assert: (lines at: 1) = boardStateText.
	self assert: (lines at: 2) = playingStateText.! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state playerOPositions playerXPositions listeners lastPlay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'initialization' stamp: 'AM 6/3/2018 02:28:51'!
initialize
	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	state _ PlayingX for: self.
	listeners _ OrderedCollection new.
	
	lastPlay _ nil.! !


!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:39'!
markAll: positions

	positions do: [ :aPosition | self markAt: aPosition ]! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:23'!
markAt: aPosition

	^state markAt: aPosition ! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 10/27/2017 10:30:17'!
markWithOAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithOAt: aPosition.! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 10/27/2017 10:24:49'!
markWithXAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithXAt: aPosition.! !


!TicTacToe methodsFor: 'marking board - private' stamp: 'AM 6/3/2018 02:15:21'!
add: aPosition to: positions nextPlayerState: nextPlayingState winnerState: winnerState

	positions add: aPosition.
	
	lastPlay _ aPosition.
	state := (self stateAfterAddingTo: positions with: nextPlayingState and: winnerState) for: self.
	listeners do: [
		:aListener | aListener updateWith: self.
		]
	! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/27/2017 10:26:10'!
assertIsInBoardBounds: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'JG 5/12/2018 12:34:04'!
markWithOWhenPlayingOAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerOPositions
		nextPlayerState: PlayingX
		winnerState: PlayerOWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOWhenPlayingXAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXWhenPlayingOAt: aPoint
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXWhenPlayingXAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerXPositions
		nextPlayerState: PlayingO
		winnerState: PlayerXWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:44:57'!
stateAfterAddingTo: positions with: nextPlayingState and: winnerState

	(self hasWin: positions) ifTrue: [ ^ winnerState ].
	self shouldBeTiedWhenNoOneWon ifTrue: [ ^ GameTied ].

	^ nextPlayingState.! !


!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:01'!
isTied
	
	^ state isTied! !


!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !


!TicTacToe methodsFor: 'testing board positions' stamp: 'HAW 10/25/2017 15:50:52'!
isTaken: aPosition
	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TicTacToe methodsFor: 'positions' stamp: 'AM 6/3/2018 02:28:04'!
lastPlay

	lastPlay isNil ifTrue: [self error: self class ThereAreNoPlaysYetErrorMessage].
	^lastPlay.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:22:42'!
has: positions threeOf: aPositionComponent

	^(positions collect: aPositionComponent) asBag contents values includes: 3 
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:09:34'!
hasCompletedColumn: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition x ]
	
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:25:55'!
hasCompletedDiagonal: positions 
	
	^(self hasUpDiagonal: positions) or: [self hasDownDiagonal: positions]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:47'!
hasCompletedLine: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition y ]
! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:25:48'!
hasCompletedStraightLine: positions
	
	^(self hasCompletedColumn: positions) or: [self hasCompletedLine: positions ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:26:17'!
hasWin: positions

	^positions size >= 3 and: [ (self hasCompletedStraightLine: positions) or: [ self hasCompletedDiagonal: positions ]].
		
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:44:42'!
shouldBeTiedWhenNoOneWon

	^ playerXPositions size = 5 and: [ playerOPositions size = 4 ].! !


!TicTacToe methodsFor: 'state informing' stamp: 'm 6/3/2018 22:43:35'!
informAGameTiedStateTo: aListener 
	^aListener gameTiedStateIn: self.! !

!TicTacToe methodsFor: 'state informing' stamp: 'm 6/3/2018 22:40:04'!
informAPlayerOWonStateTo: aListener 
	^aListener playerOWonStateIn: self .! !

!TicTacToe methodsFor: 'state informing' stamp: 'm 6/3/2018 22:40:51'!
informAPlayerXWonStateTo: aListener
	^ aListener playerXWonStateIn: self.! !

!TicTacToe methodsFor: 'state informing' stamp: 'm 6/3/2018 22:23:57'!
informAPlayingOTo: aListener 
	^aListener playingOStateIn: self.! !

!TicTacToe methodsFor: 'state informing' stamp: 'm 6/3/2018 22:33:55'!
informAPlayingXStateTo: aListener
	^aListener playingXStateIn: self.! !

!TicTacToe methodsFor: 'state informing' stamp: 'AM 6/3/2018 23:47:24'!
informLastActionOn: aListener
	^ state
		informActionFrom: self
		to: aListener.! !


!TicTacToe methodsFor: 'binding' stamp: 'AM 5/31/2018 19:36:02'!
register: aListener 
	listeners add: aListener.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'AM 6/3/2018 02:20:09'!
ThereAreNoPlaysYetErrorMessage
	
	^'There are no plays yet'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/27/2017 10:26:31'!
positionOutsideBoardErrorMessage
	
	^'Position is outside board'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeObserver category: #TicTacToe!
Object subclass: #TicTacToeObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObserver methodsFor: 'state update' stamp: 'AM 6/3/2018 23:39:50'!
gameTiedStateIn: aTicTacToe 

	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'state update' stamp: 'AM 6/3/2018 23:39:37'!
playerOWonStateIn: aTicTacToe 

	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'state update' stamp: 'AM 6/3/2018 23:39:28'!
playerXWonStateIn: aTicTacToe 

	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'state update' stamp: 'AM 6/3/2018 23:39:12'!
playingOStateIn: aTicTacToe

	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'state update' stamp: 'AM 6/3/2018 23:38:55'!
playingXStateIn: aTicTacToe

	self subclassResponsibility.! !


!TicTacToeObserver methodsFor: 'updating' stamp: 'AM 6/3/2018 23:38:29'!
updateWith: aTicTacToe

	self subclassResponsibility.! !


!classDefinition: #TicTacToeConsole category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeConsole
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsole methodsFor: 'initialization' stamp: 'm 6/3/2018 22:29:10'!
initialize
	log _ OrderedCollection new.! !


!TicTacToeConsole methodsFor: 'accessing' stamp: 'AM 5/31/2018 20:11:49'!
lines
	^log.! !


!TicTacToeConsole methodsFor: 'state update' stamp: 'm 6/3/2018 22:43:57'!
gameTiedStateIn: aTicTacToe 
	log add:  'X marcó en ', aTicTacToe lastPlay asString.
	log add: 'Estado: Juego terminado - Empate!!'.
! !

!TicTacToeConsole methodsFor: 'state update' stamp: 'm 6/3/2018 22:41:51'!
playerOWonStateIn: aTicTacToe 
	log add:  'O marcó en ', aTicTacToe lastPlay asString.
	log add: 'Estado: Juego terminado - Ganó O!!'.! !

!TicTacToeConsole methodsFor: 'state update' stamp: 'm 6/3/2018 22:40:51'!
playerXWonStateIn: aTicTacToe
	log add: 'X marcó en ' , aTicTacToe lastPlay asString.
	log add: 'Estado: Juego terminado - Ganó X!!'.! !

!TicTacToeConsole methodsFor: 'state update' stamp: 'm 6/3/2018 22:24:19'!
playingOStateIn: aTicTacToe 
	log add:  'X marcó en ', aTicTacToe lastPlay asString.
	log add: 'Estado: Jugando O'.! !

!TicTacToeConsole methodsFor: 'state update' stamp: 'm 6/3/2018 22:34:35'!
playingXStateIn: aTicTacToe 
	log add:  'O marcó en ', aTicTacToe lastPlay asString.
	log add: 'Estado: Jugando X'.! !


!TicTacToeConsole methodsFor: 'updating' stamp: 'AM 6/3/2018 23:47:24'!
updateWith: aTicTacToe
	aTicTacToe informLastActionOn: self.! !


!classDefinition: #TicTacToeView category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeView
	instanceVariableNames: 'log board state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeView methodsFor: 'private' stamp: 'AM 6/3/2018 04:36:43'!
draw: aSymbol at: aPosition 
	(board at: 4 - aPosition y) at: aPosition x put: aSymbol asString.! !

!TicTacToeView methodsFor: 'private' stamp: 'AM 6/3/2018 04:00:04'!
printBoard
	| hLine vSeparator newLine |
	
	hLine _ '-----'.
	vSeparator _ $|.
	newLine _ Character newLineCharacter.
	
	^String streamContents: [ :stream|
		stream nextPutAll: ((board at: 1) at: 1).
		stream nextPut: vSeparator.
		stream nextPutAll: ((board at: 1) at: 2).
		stream nextPut: vSeparator.
		stream nextPutAll: ((board at: 1) at: 3).
		stream nextPut: newLine.
		stream nextPutAll: hLine.
		stream nextPut: newLine.
		stream nextPutAll: ((board at: 2) at: 1).
		stream nextPut: vSeparator.
		stream nextPutAll: ((board at: 2) at: 2).
		stream nextPut: vSeparator.
		stream nextPutAll: ((board at: 2) at: 3).
		stream nextPut: newLine.
		stream nextPutAll: hLine.
		stream nextPut: newLine.
		stream nextPutAll: ((board at: 3) at: 1).
		stream nextPut: vSeparator.
		stream nextPutAll: ((board at: 3) at: 2).
		stream nextPut: vSeparator.
		stream nextPutAll: ((board at: 3) at: 3).
		].! !


!TicTacToeView methodsFor: 'accessing' stamp: 'AM 6/3/2018 04:09:28'!
lines
	^Array with: self printBoard with: state.! !


!TicTacToeView methodsFor: 'initialization' stamp: 'AM 6/3/2018 04:23:26'!
initialize

	log _ OrderedCollection new.
	
	board  _ Array with: (OrderedCollection with: ' ' with: ' ' with: ' ') with: (OrderedCollection with: ' ' with: ' ' with: ' ') with: (OrderedCollection with: ' ' with: ' ' with: ' ').! !


!TicTacToeView methodsFor: 'state update' stamp: 'AM 6/3/2018 23:34:29'!
gameTiedStateIn: aTicTacToe 

	self draw: #X at: aTicTacToe lastPlay.
	state _ 'Tied!!'.! !

!TicTacToeView methodsFor: 'state update' stamp: 'AM 6/3/2018 23:30:22'!
playerOWonStateIn: aTicTacToe 

	self draw: #O at: aTicTacToe lastPlay.
	state _ 'O Won!!'.! !

!TicTacToeView methodsFor: 'state update' stamp: 'AM 6/3/2018 23:20:14'!
playerXWonStateIn: aTicTacToe 

		self draw: #X at: aTicTacToe lastPlay.
		state _ 'X Won!!'.! !

!TicTacToeView methodsFor: 'state update' stamp: 'AM 6/3/2018 23:21:37'!
playingOStateIn: aTicTacToe 

	self draw: #X at: aTicTacToe lastPlay.
	state _ 'Playing O'.! !

!TicTacToeView methodsFor: 'state update' stamp: 'AM 6/3/2018 23:38:43'!
playingXStateIn: aTicTacToe

	self draw: #O at: aTicTacToe lastPlay.
	state _ 'Playing X'.! !


!TicTacToeView methodsFor: 'updating' stamp: 'AM 6/3/2018 23:47:24'!
updateWith: aTicTacToe
	aTicTacToe informLastActionOn: self.! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerOWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerXWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isOver
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isTied
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingO
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingX
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:31'!
markAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !


!TicTacToeState methodsFor: 'state informing' stamp: 'AM 6/3/2018 23:05:29'!
informActionFrom: aTicTacToe to: aListener

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'HAW 10/25/2017 13:05:29'!
for: aTicTacToe 
	
	^self new initializeFor: aTicTacToe ! !


!classDefinition: #GameOverState category: #TicTacToe!
TicTacToeState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 11:53:57'!
isOver
	
	^true! !


!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:23'!
isPlayingO
	
	^false! !

!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:27'!
isPlayingX
	
	^false! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:09'!
markAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameTied category: #TicTacToe!
GameOverState subclass: #GameTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:49'!
isTied
	
	^true! !


!GameTied methodsFor: 'state informing' stamp: 'm 6/3/2018 22:42:59'!
informActionFrom: aTicTacToe to: aListener 
	^aTicTacToe informAGameTiedStateTo: aListener.! !


!classDefinition: #PlayerOWon category: #TicTacToe!
GameOverState subclass: #PlayerOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ true.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:06:24'!
isTied
	
	^false! !


!PlayerOWon methodsFor: 'state informing' stamp: 'm 6/3/2018 22:39:28'!
informActionFrom: aTicTacToe to: aListener 
	^aTicTacToe informAPlayerOWonStateTo: aListener.! !


!classDefinition: #PlayerXWon category: #TicTacToe!
GameOverState subclass: #PlayerXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ true.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:25:44'!
isTied
	
	^false! !


!PlayerXWon methodsFor: 'state informing' stamp: 'm 6/3/2018 22:38:35'!
informActionFrom: aTicTacToe to: aListener
	^ aTicTacToe informAPlayerXWonStateTo: aListener.! !


!classDefinition: #PlayingState category: #TicTacToe!
TicTacToeState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:10'!
hasPlayerOWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:17'!
hasPlayerXWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:26'!
isOver
	
	^false! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:52'!
isTied
	
	^false! !


!classDefinition: #PlayingO category: #TicTacToe!
PlayingState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:27'!
isPlayingX
	
	^false! !


!PlayingO methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:13'!
markAt: aPosition

	^game markWithOAt: aPosition ! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:45'!
markWithOAt: aPosition
	game markWithOWhenPlayingOAt: aPosition.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXAt: aPosition
	game markWithXWhenPlayingOAt: aPosition.! !


!PlayingO methodsFor: 'state informing' stamp: 'm 6/3/2018 22:20:39'!
informActionFrom: aTicTacToe to: aTicTacToeConsole 
	^aTicTacToe informAPlayingOTo: aTicTacToeConsole.! !


!classDefinition: #PlayingX category: #TicTacToe!
PlayingState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:50'!
isPlayingO
	
	^false! !

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:17'!
markAt: aPosition

	^game markWithXAt: aPosition ! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOAt: aPosition
	game markWithOWhenPlayingXAt: aPosition.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXAt: aPosition
	game markWithXWhenPlayingXAt: aPosition.! !


!PlayingX methodsFor: 'state informing' stamp: 'm 6/3/2018 22:33:08'!
informActionFrom: aTicTacToe to: aListener 
	^aTicTacToe informAPlayingXStateTo: aListener.! !
