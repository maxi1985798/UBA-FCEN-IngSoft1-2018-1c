!classDefinition: #TicTacToeTest category: #'TicTacToe-Test'!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:20:22'!
test01ThereIsNoMarksInNewGame
	| game |
	game _ TicTacToe new.
	self assert: game XMarks isEmpty.
	self assert: game OMarks isEmpty.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:25:07'!
test02AddingOneXMarkToGameOnlyAddsOneXMark

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	
	self assert: 1 equals: game XMarks size.
	self assert: (game XMarks includes: 1@1).
	self assert: game OMarks isEmpty.
	
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:27:16'!
test03MarkingAnXAndAnOAddsOneXAndOneOToGame

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	
	self assert: 1 equals: game XMarks size.
	self assert: (game XMarks includes: 1@1).
	self assert: 1 equals: game OMarks size.
	self assert: (game OMarks includes: 2@2).
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:28:37'!
test04XPlayerCannotStealTurn

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	
	self
	should: [game markWithXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.	
		self assert: 1 equals: game XMarks size.
		self assert: (game XMarks includes: 1@1).
		self assert: game OMarks isEmpty.
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:28:53'!
test05OPlayerCannotStealTurn

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	self
	should: [game markWithOAt: 3@3]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.	
		self assert: 1 equals: game XMarks size.
		self assert: (game XMarks includes: 1@1).
		self assert: 1 equals: game OMarks size.
		self assert: (game OMarks includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:31:57'!
test06XCannotOverwriteHimself

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	self
	should: [game markWithXAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game XMarks size.
		self assert: (game XMarks includes: 1@1).
		self assert: 1 equals: game OMarks size.
		self assert: (game OMarks includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:31:25'!
test07XCannotOverwriteOMarks

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	self
	should: [game markWithXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game XMarks size.
		self assert: (game XMarks includes: 1@1).
		self assert: 1 equals: game OMarks size.
		self assert: (game OMarks includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:33:11'!
test08OCannotOverwriteXMarks

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	self
	should: [game markWithOAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game XMarks size.
		self assert: (game XMarks includes: 1@1).
		self assert:  game OMarks isEmpty.

		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:34:09'!
test09OCannotOverwriteHimself

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	game markWithXAt: 3@3.
	self
	should: [game markWithOAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 2 equals: game XMarks size.
		self assert: (game XMarks includes: 1@1).
		self assert: (game XMarks includes: 3@3).
		self assert: 1 equals: game OMarks size.
		self assert: (game OMarks includes: 2@2).
		
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 19:47:01'!
test10NeitherPlayerCanWinWithOnlyTwoMoves

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	game markWithXAt: 2@2.
	game markWithOAt: 3@3.
	
		self deny: game hasPlayerOWon.
		self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 18:46:00'!
test11ThreeXMarksInHorizontalLineMakesXWin

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	game markWithXAt: 1@2.
	game markWithOAt: 3@3.
	game markWithXAt: 1@3.
	
	
		self assert: game hasPlayerXWon.
		self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 18:46:05'!
test14ThreeXMarksInVerticalLineMakesXWin

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	game markWithXAt: 2@1.
	game markWithOAt: 3@3.
	game markWithXAt: 3@1.
	
	
		self assert: game hasPlayerXWon.
		self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 18:46:09'!
test15ThreeXMarksInDownwardsDiagonalLineMakesXWin

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	game markWithXAt: 2@2.
	game markWithOAt: 2@3.
	game markWithXAt: 3@3.
	
	
		self assert: game hasPlayerXWon.
		self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 18:46:13'!
test16ThreeXMarksInUpwardsDiagonalLineMakesXWin

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 3@1.
	game markWithOAt: 2@1.
	game markWithXAt: 2@2.
	game markWithOAt: 1@2.
	game markWithXAt: 1@3.
	
	
		self assert: game hasPlayerXWon.
		self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 18:46:19'!
test17ThreeOMarksInHorizontalLineMakesOWin

	|game|
	
	game := TicTacToe new.

	game markWithXAt: 3@1.
	game markWithOAt: 1@1.
	game markWithXAt: 2@2.
	game markWithOAt: 1@2.
	game markWithXAt: 3@3.
	game markWithOAt: 1@3.
	
		self assert: game hasPlayerOWon.
		self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:56:10'!
test18CannotPlayWhenXHasAlreadyWon

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 1@1.	
	game markWithOAt: 2@1.
	game markWithXAt: 1@2.
	game markWithOAt: 3@1.	
	game markWithXAt: 1@3.

	self 
		should: [ game markWithOAt: 3@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game OMarks size.
			self assert: (game OMarks includes: 2@1).
			self assert: (game OMarks includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 17:56:57'!
test19CannotPlayWhenOHasAlreadyWon

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@1.	
	game markWithXAt: 2@1.
	game markWithOAt: 1@2.
	game markWithXAt: 3@1.	
	game markWithOAt: 1@3.

	self 
		should: [ game markWithXAt: 3@2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game XMarks size.
			self assert: (game XMarks includes: 2@2).
			self assert: (game XMarks includes: 2@1).
			self assert: (game XMarks includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 18:46:24'!
test20GameIsTiedWhenAllSlotsAreFilled

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@1.	
	game markWithXAt: 1@3.
	game markWithOAt: 3@1.
	game markWithXAt: 2@1.	
	game markWithOAt: 2@3.
	game markWithXAt: 1@2.	
	game markWithOAt: 3@2.
	game markWithXAt: 3@3.
	
	self assert: game isOver.
	self deny: game hasPlayerXWon. 
	self deny: game hasPlayerOWon. 
	self assert: game isTied
! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 18:46:32'!
test21GameWonByXWithAllSlotsFilledIsNotTied

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@2.	
	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	game markWithXAt: 1@3.	
	game markWithOAt: 2@3.
	game markWithXAt: 3@2.	
	game markWithOAt: 3@1.
	game markWithXAt: 3@3.
	
	self assert: game isOver.
	self assert: game hasPlayerXWon. 
	self deny: game hasPlayerOWon. 
	self deny: game isTied
! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 19:35:22'!
test22FirstTurnIsXsTurn

	| game |
	
	game := TicTacToe new.
	
	self assert: game isPlayingX.
	self deny: game isPlayingO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 19:35:48'!
test23SecondTurnIsOsTurn

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 1@1.
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 19:42:39'!
test23_01XAndOsTurnsAreInterleaved

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	
	game markWithXAt: 3@3.
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 19:45:25'!
test24NeitherXOrOArePlayingWhenXWins

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@2.	
	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	game markWithXAt: 1@3.	
	game markWithOAt: 2@3.
	game markWithXAt: 3@2.	
	game markWithOAt: 3@1.
	game markWithXAt: 3@3.
	
	self assert: game hasPlayerXWon.
	self deny: game isPlayingX.
	self deny: game isPlayingO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AM 5/27/2018 19:45:35'!
test25NeitherXOrOArePlayingWhenOWins

	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 3@3.
	game markWithOAt: 2@2.
	game markWithXAt: 1@2.
	game markWithOAt: 1@3.
	game markWithXAt: 3@2.
	game markWithOAt: 3@1.
	
	self assert: game hasPlayerOWon.
	self deny: game isPlayingX.
	self deny: game isPlayingO.! !


!classDefinition: #TicTacToe category: #'TicTacToe-Test'!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs turn winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!TicTacToe methodsFor: 'private' stamp: 'jg 5/22/2018 12:51:23'!
hasCompletedColumn: positions
	
	^ (1 to: 3) anySatisfy: [ :y | (positions count: [ :position | position y = y ]) = 3 ]! !

!TicTacToe methodsFor: 'private' stamp: 'jg 5/22/2018 12:36:01'!
hasCompletedRow: positions

	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!TicTacToe methodsFor: 'private' stamp: 'jg 5/22/2018 12:56:21'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]
! !

!TicTacToe methodsFor: 'private' stamp: 'jg 5/22/2018 13:02:13'!
hasUpDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'private' stamp: 'AM 5/27/2018 19:15:41'!
hasWon: positions
	^ (self hasCompletedRow: positions) or: [
		(self hasCompletedColumn: positions) or: [
			(self hasDownDiagonal: positions) or: [ self hasUpDiagonal: positions ]]].! !


!TicTacToe methodsFor: 'testing' stamp: 'AM 5/27/2018 18:21:53'!
hasPlayerOWon
	^ winner = #o.! !

!TicTacToe methodsFor: 'testing' stamp: 'AM 5/27/2018 18:20:28'!
hasPlayerXWon
	^ winner = #x.! !

!TicTacToe methodsFor: 'testing' stamp: 'AM 5/27/2018 20:13:32'!
isOver
	^ (winner = #none) not or: [ self isTied ].! !

!TicTacToe methodsFor: 'testing' stamp: 'AM 5/27/2018 19:50:20'!
isPlayingO
	^self isOver not and:  [turn = #o].! !

!TicTacToe methodsFor: 'testing' stamp: 'AM 5/27/2018 19:50:27'!
isPlayingX
	^self isOver not and:  [turn = #x].! !

!TicTacToe methodsFor: 'testing' stamp: 'AM 5/27/2018 20:03:12'!
isTied
	^ xs size + os size = 9 and: [winner = #none].! !


!TicTacToe methodsFor: 'accessing' stamp: 'AM 5/27/2018 16:57:09'!
OMarks
	^ os copy.! !

!TicTacToe methodsFor: 'accessing' stamp: 'AM 5/27/2018 16:52:20'!
XMarks
	^ xs copy.! !


!TicTacToe methodsFor: 'initialization' stamp: 'AM 5/27/2018 19:59:37'!
initialize
	
	xs:= Set new.
	os:= Set new.
	
	turn:= #x.
	winner := #none.! !


!TicTacToe methodsFor: 'evaluating' stamp: 'AM 5/27/2018 20:07:58'!
markWithOAt: aPosition
	self isOver ifTrue: [ self error: self class canNotPlayWhenGameIsOverErrorMessage ].
	turn = #o ifFalse: [ self error: self class notOTurnErrorMessage ].
	(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	
	os add: aPosition.
	(self hasWon: os) ifTrue: [ ^ winner _ #o ].
	turn _ #x.! !

!TicTacToe methodsFor: 'evaluating' stamp: 'AM 5/27/2018 20:07:51'!
markWithXAt: aPosition
	self isOver ifTrue: [ self error: self class canNotPlayWhenGameIsOverErrorMessage ].
	turn = #x ifFalse: [ self error: self class notXTurnErrorMessage ].
	(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	
	xs add: aPosition.
	(self hasWon: xs) ifTrue: [ ^ winner _ #x ].
	turn _ #o.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #'TicTacToe-Test'!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:15:31'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'AM 5/27/2018 17:04:14'!
notOTurnErrorMessage

	^'Not O turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:26:38'!
notXTurnErrorMessage

	^'Not X turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 11:20:12'!
positionTakenErrorMessage
	
	^'Position taken'! !
