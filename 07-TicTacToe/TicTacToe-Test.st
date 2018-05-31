!classDefinition: #TicTacToeTest category: #'TicTacToe-Test'!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'aGameWithNoPlays aTiedGame aGameWhereOWins'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:12:27'!
test01ThereIsNoMarksInNewGame

	self assert: aGameWithNoPlays XMarks isEmpty.
	self assert: aGameWithNoPlays OMarks isEmpty.! !

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

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:22:02'!
test20GameIsTiedWhenAllSlotsAreFilled

	self assert: aTiedGame isOver.
	self deny: aTiedGame hasPlayerXWon. 
	self deny: aTiedGame hasPlayerOWon. 
	self assert: aTiedGame isTied
! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:21:37'!
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

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:13:03'!
test22FirstTurnIsXsTurn

	self assert: aGameWithNoPlays isPlayingX.
	self deny: aGameWithNoPlays isPlayingO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:38:48'!
test23SecondTurnIsOsTurn
	| game |
	
	game := TicTacToe new.
	
	game markWithXAt: 1@1.
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:38:36'!
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

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:03:09'!
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

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:37:09'!
test25NeitherXOrOArePlayingWhenOWins
	
	self assert: aGameWhereOWins hasPlayerOWon.
	self deny: aGameWhereOWins isPlayingX.
	self deny: aGameWhereOWins isPlayingO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:36:46'!
test26GameIsNotTiedWhenOWins
	
	self deny: aGameWhereOWins isTied.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:11:55'!
test27GameIsNotTiedWhenXIsPlaying
	
	self deny: aGameWithNoPlays isTied .! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:25:33'!
test28ATiedGameHasNoPlayersPlaying
	
	self deny: aTiedGame isPlayingX.
	self deny: aTiedGame isPlayingO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 16:46:40'!
test29AGameWhereOWonIsOver
	
	self assert: aGameWhereOWins isOver.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 17:38:06'!
test30InATiedGamePlayerXCannotPlay

	self 
		should: [ aTiedGame markWithXAt: 3@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 4 equals: aTiedGame OMarks size.
			self assert: (aTiedGame OMarks includes: 1@1).
			self assert: (aTiedGame OMarks includes: 3@1).
			self assert: (aTiedGame OMarks includes: 2@3).
			self assert: (aTiedGame OMarks includes: 3@2).
			self assert: 5 equals: aTiedGame XMarks size.
			self assert: (aTiedGame XMarks includes: 2@2).
			self assert: (aTiedGame XMarks includes: 1@3).
			self assert: (aTiedGame XMarks includes: 2@1).
			self assert: (aTiedGame XMarks includes: 1@2).
			self assert: (aTiedGame XMarks includes: 3@3).
			]! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 17:39:35'!
test31InATiedGamePlayerOCannotPlay

	self 
		should: [ aTiedGame markWithOAt: 3@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 4 equals: aTiedGame OMarks size.
			self assert: (aTiedGame OMarks includes: 1@1).
			self assert: (aTiedGame OMarks includes: 3@1).
			self assert: (aTiedGame OMarks includes: 2@3).
			self assert: (aTiedGame OMarks includes: 3@2).
			self assert: 5 equals: aTiedGame XMarks size.
			self assert: (aTiedGame XMarks includes: 2@2).
			self assert: (aTiedGame XMarks includes: 1@3).
			self assert: (aTiedGame XMarks includes: 2@1).
			self assert: (aTiedGame XMarks includes: 1@2).
			self assert: (aTiedGame XMarks includes: 3@3).
			]! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 18:06:28'!
test32GameIsNotOverWhenXIsPlaying
	
	self deny: aGameWithNoPlays isOver.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'm 5/30/2018 18:09:05'!
test33GameIsNotOverWhenOIsPlaying
	|game|
	
	game := TicTacToe new.
	game markWithXAt: 1@1.
	
	self deny: game isOver.! !


!TicTacToeTest methodsFor: 'test support' stamp: 'm 5/30/2018 16:36:00'!
setUp
	aGameWithNoPlays := TicTacToe new.
	aTiedGame := TicTacToe new.
	aTiedGame markWithXAt: 2@2.
	aTiedGame markWithOAt: 1@1.	
	aTiedGame markWithXAt: 1@3.
	aTiedGame markWithOAt: 3@1.
	aTiedGame markWithXAt: 2@1.	
	aTiedGame markWithOAt: 2@3.
	aTiedGame markWithXAt: 1@2.	
	aTiedGame markWithOAt: 3@2.
	aTiedGame markWithXAt: 3@3.
	aGameWhereOWins := TicTacToe new.
	aGameWhereOWins markWithXAt: 3@3.
	aGameWhereOWins markWithOAt: 2@2.
	aGameWhereOWins markWithXAt: 1@2.
	aGameWhereOWins markWithOAt: 1@3.
	aGameWhereOWins markWithXAt: 3@2.
	aGameWhereOWins markWithOAt: 3@1.! !


!classDefinition: #TicTacToe category: #'TicTacToe-Test'!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!TicTacToe methodsFor: 'private' stamp: 'm 5/30/2018 12:37:20'!
hasCompletedColumn: positions
	^ (1 to: 3) anySatisfy: [ :y | (positions count: [ :position | position y = y ]) = 3 ].! !

!TicTacToe methodsFor: 'private' stamp: 'm 5/30/2018 18:11:53'!
hasCompletedRow: positions
	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!TicTacToe methodsFor: 'private' stamp: 'm 5/30/2018 18:17:08'!
hasDownDiagonal: positions
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'private' stamp: 'm 5/30/2018 18:17:18'!
hasUpDiagonal: positions
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'private' stamp: 'm 5/30/2018 18:17:30'!
hasWon: positions
	^ (self hasCompletedRow: positions) or: [
		(self hasCompletedColumn: positions) or: [
			(self hasDownDiagonal: positions) or: [ self hasUpDiagonal: positions ]]].! !

!TicTacToe methodsFor: 'private' stamp: 'm 5/31/2018 12:13:48'!
markWithOWhenPlayerXIsPlayingAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'private' stamp: 'm 5/31/2018 12:13:35'!
markWithOWhenplayerOIsPlayingAt: aPosition
	os , xs
		detect: [ :anotherPosition |
			anotherPosition = aPosition ]
		ifFound: [ :aFoundPosition |
			self error: self class positionTakenErrorMessage ]
		ifNone: [
			os add: aPosition.
			self hasOWon ifTrue: [ ^ state _ GameOverWithOAsWinner new ].
			state _ XPlaying new ].! !

!TicTacToe methodsFor: 'private' stamp: 'm 5/31/2018 12:13:08'!
markWithXWhenPlayerOIsPlayingAt: aPosition
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'private' stamp: 'm 5/31/2018 12:12:32'!
markWithXWhenPlayerXIsPlayingAt: aPosition
	os , xs
		detect: [ :anotherPosition |
			anotherPosition = aPosition ]
		ifFound: [ :aFoundPosition |
			self error: self class positionTakenErrorMessage ]
		ifNone: [
			xs add: aPosition.
			self hasXWon ifTrue: [ ^ state _ GameOverWithXAsWinner new ].
			self hasAllCellsOccupied ifTrue: [ ^ state _ GameOverWithDraw new ].
			state _ OPlaying new ].! !


!TicTacToe methodsFor: 'testing' stamp: 'm 5/30/2018 15:36:58'!
hasAllCellsOccupied
	^xs size + os size = 9.! !

!TicTacToe methodsFor: 'testing' stamp: 'm 5/30/2018 00:57:35'!
hasOWon
	^self hasWon: os.! !

!TicTacToe methodsFor: 'testing' stamp: 'm 5/30/2018 01:22:29'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing' stamp: 'm 5/30/2018 12:29:59'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing' stamp: 'm 5/29/2018 23:52:39'!
hasXWon
	^self hasWon: xs.! !

!TicTacToe methodsFor: 'testing' stamp: 'm 5/30/2018 15:51:39'!
isOver
	^ state isOver.! !

!TicTacToe methodsFor: 'testing' stamp: 'm 5/29/2018 22:49:48'!
isPlayingO
	^state isPlayingO.! !

!TicTacToe methodsFor: 'testing' stamp: 'm 5/29/2018 22:48:47'!
isPlayingX
	^state isPlayingX.! !

!TicTacToe methodsFor: 'testing' stamp: 'm 5/30/2018 12:33:18'!
isTied
	"^ xs size + os size = 9 and: [winner = #none]."
	^state isTied
	! !


!TicTacToe methodsFor: 'accessing' stamp: 'AM 5/27/2018 16:57:09'!
OMarks
	^ os copy.! !

!TicTacToe methodsFor: 'accessing' stamp: 'AM 5/27/2018 16:52:20'!
XMarks
	^ xs copy.! !


!TicTacToe methodsFor: 'initialization' stamp: 'm 5/30/2018 18:11:16'!
initialize
	xs:= Set new.
	os:= Set new.
	state := XPlaying new.! !


!TicTacToe methodsFor: 'evaluating' stamp: 'm 5/29/2018 23:16:06'!
markWithOAt: aPosition
	^state markWithOAt: aPosition on: self.
"	self isOver ifTrue: [ self error: self class canNotPlayWhenGameIsOverErrorMessage ].
	turn = #o ifFalse: [ self error: self class notOTurnErrorMessage ].
	(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	os add: aPosition.
	(self hasWon: os) ifTrue: [ ^ winner _ #o ].
	turn _ #x.
	"! !

!TicTacToe methodsFor: 'evaluating' stamp: 'm 5/29/2018 22:52:34'!
markWithXAt: aPosition
	^state markWithXAt: aPosition on: self.
"	self isOver ifTrue: [ self error: self class canNotPlayWhenGameIsOverErrorMessage ].
	turn = #x ifFalse: [ self error: self class notXTurnErrorMessage ].
	(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	xs add: aPosition.
	(self hasWon: xs) ifTrue: [ ^ winner _ #x ].
	turn _ #o."! !

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


!classDefinition: #TicTacToeState category: #'TicTacToe-Test'!
Object subclass: #TicTacToeState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!TicTacToeState methodsFor: 'game actions' stamp: 'm 5/30/2018 16:15:22'!
markWithOAt: aPosition on: aTicTacToe 
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'game actions' stamp: 'm 5/30/2018 16:15:26'!
markWithXAt: aPosition on: aTicTacToe 
	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'testing' stamp: 'm 5/30/2018 18:13:33'!
hasPlayerOWon
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'testing' stamp: 'm 5/30/2018 18:13:47'!
hasPlayerXWon
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'testing' stamp: 'm 5/30/2018 18:14:03'!
isOver
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'testing' stamp: 'm 5/30/2018 18:14:15'!
isPlayingO
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'testing' stamp: 'm 5/30/2018 18:15:47'!
isPlayingX
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'testing' stamp: 'm 5/30/2018 18:16:12'!
isTied
	self subclassResponsibility.! !


!classDefinition: #GameOverWithDraw category: #'TicTacToe-Test'!
TicTacToeState subclass: #GameOverWithDraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!GameOverWithDraw methodsFor: 'testing' stamp: 'm 5/30/2018 15:50:38'!
hasPlayerOWon
	^false.! !

!GameOverWithDraw methodsFor: 'testing' stamp: 'm 5/30/2018 15:50:25'!
hasPlayerXWon
	^false.! !

!GameOverWithDraw methodsFor: 'testing' stamp: 'm 5/30/2018 15:52:29'!
isOver
	^true.! !

!GameOverWithDraw methodsFor: 'testing' stamp: 'm 5/30/2018 16:25:59'!
isPlayingO
	^false.! !

!GameOverWithDraw methodsFor: 'testing' stamp: 'm 5/30/2018 16:25:47'!
isPlayingX
	^false.! !

!GameOverWithDraw methodsFor: 'testing' stamp: 'm 5/30/2018 15:50:11'!
isTied
	^true.! !


!GameOverWithDraw methodsFor: 'game actions' stamp: 'm 5/30/2018 17:39:48'!
markWithOAt: aPosition on: aTicTacToe 
	self error: aTicTacToe class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverWithDraw methodsFor: 'game actions' stamp: 'm 5/30/2018 17:37:06'!
markWithXAt: aPosition on: aTicTacToe 
	self error: aTicTacToe class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameOverWithOAsWinner category: #'TicTacToe-Test'!
TicTacToeState subclass: #GameOverWithOAsWinner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!GameOverWithOAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 01:25:49'!
hasPlayerOWon
	^true.! !

!GameOverWithOAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 01:26:06'!
hasPlayerXWon
	^false.! !

!GameOverWithOAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 16:47:06'!
isOver
	^true.! !

!GameOverWithOAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 15:54:50'!
isPlayingO
	^false.! !

!GameOverWithOAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 15:54:35'!
isPlayingX
	^false.! !

!GameOverWithOAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 16:05:04'!
isTied
	^false.! !


!GameOverWithOAsWinner methodsFor: 'game actions' stamp: 'm 5/30/2018 01:10:05'!
markWithOAt: aPosition on: aTicTacToe 
	self error: aTicTacToe class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverWithOAsWinner methodsFor: 'game actions' stamp: 'm 5/30/2018 01:39:33'!
markWithXAt: aPosition on: aTicTacToe 
	self error: aTicTacToe class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameOverWithXAsWinner category: #'TicTacToe-Test'!
TicTacToeState subclass: #GameOverWithXAsWinner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!GameOverWithXAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 01:25:17'!
hasPlayerOWon
	^false.! !

!GameOverWithXAsWinner methodsFor: 'testing' stamp: 'm 5/29/2018 23:55:34'!
hasPlayerXWon
	^true.! !

!GameOverWithXAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 15:51:54'!
isOver
	^true.! !

!GameOverWithXAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 15:54:16'!
isPlayingO
	^false.! !

!GameOverWithXAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 15:54:02'!
isPlayingX
	^false.! !

!GameOverWithXAsWinner methodsFor: 'testing' stamp: 'm 5/30/2018 01:52:42'!
isTied
	^false.! !


!GameOverWithXAsWinner methodsFor: 'game actions' stamp: 'm 5/30/2018 00:13:32'!
markWithOAt: aPosition on: aTicTacToe 
	self error: aTicTacToe class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverWithXAsWinner methodsFor: 'game actions' stamp: 'm 5/30/2018 01:39:42'!
markWithXAt: aPosition on: aTicTacToe 
	self error: aTicTacToe class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #OPlaying category: #'TicTacToe-Test'!
TicTacToeState subclass: #OPlaying
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!OPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 01:27:04'!
hasPlayerOWon
	^false.! !

!OPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 00:11:57'!
hasPlayerXWon
	^false.! !

!OPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 18:09:20'!
isOver
	^false.! !

!OPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 15:53:19'!
isPlayingO
	^true.! !

!OPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 15:53:02'!
isPlayingX
	^false.! !

!OPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 01:53:18'!
isTied
	^false.! !


!OPlaying methodsFor: 'game actions' stamp: 'm 5/31/2018 12:13:35'!
markWithOAt: aPosition on: aTicTacToe
	^ aTicTacToe markWithOWhenplayerOIsPlayingAt: aPosition.! !

!OPlaying methodsFor: 'game actions' stamp: 'm 5/31/2018 12:13:08'!
markWithXAt: aPosition on: aTicTacToe
	^ aTicTacToe markWithXWhenPlayerOIsPlayingAt: aPosition.! !


!classDefinition: #XPlaying category: #'TicTacToe-Test'!
TicTacToeState subclass: #XPlaying
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Test'!

!XPlaying methodsFor: 'game actions' stamp: 'm 5/31/2018 12:13:48'!
markWithOAt: aPosition on: aTicTacToe
	^ aTicTacToe markWithOWhenPlayerXIsPlayingAt: aPosition.! !

!XPlaying methodsFor: 'game actions' stamp: 'm 5/31/2018 12:12:32'!
markWithXAt: aPosition on: aTicTacToe
	^ aTicTacToe markWithXWhenPlayerXIsPlayingAt: aPosition.! !


!XPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 01:24:51'!
hasPlayerOWon
	^false.! !

!XPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 00:11:26'!
hasPlayerXWon
	^false.! !

!XPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 18:06:50'!
isOver
	^false.! !

!XPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 01:46:42'!
isPlayingO
	^false.! !

!XPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 01:46:12'!
isPlayingX
	^true.! !

!XPlaying methodsFor: 'testing' stamp: 'm 5/30/2018 16:09:09'!
isTied
	^false.! !
