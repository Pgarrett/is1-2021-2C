!classDefinition: #TestRover category: 'MarsRover'!
TestCase subclass: #TestRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestRover methodsFor: 'set up' stamp: 'PhG 10/5/2021 19:08:49'!
east

	^East new.! !

!TestRover methodsFor: 'set up' stamp: 'PhG 10/5/2021 19:08:42'!
north

	^North new.! !

!TestRover methodsFor: 'set up' stamp: 'PhG 10/5/2021 19:08:57'!
south

	^South new.! !

!TestRover methodsFor: 'set up' stamp: 'PhG 10/5/2021 19:09:03'!
west

	^West new.! !


!TestRover methodsFor: 'tests position' stamp: 'PhG 10/6/2021 20:57:08'!
test01RoverDoesNotActWhenNoCommandsAreReceived
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:01:49'!
test02RoverMovesForwardHeadingNorth
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction .
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:02:24'!
test03RoverGoesBackwardsHeadingNorth
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:02:53'!
test04RoverMovesForwardHeadingSouth
	|marsRover direction|
	
	direction := self south.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@1 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:03:42'!
test05RoverGoesBackwardsHeadingSouth
	|marsRover direction|
	
	direction := self south.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@3 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:03:10'!
test06RoverMovesForwardHeadingEast
	|marsRover direction|
	
	direction := self east.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:03:54'!
test07RoverGoesBackwardsHeadingEast
	|marsRover direction|
	
	direction := self east.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:03:23'!
test08RoverMovesForwardHeadingWest
	|marsRover direction|
	
	direction := self west.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 0@2 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:04:04'!
test09RoverGoesBackwardsHeadingWest
	|marsRover direction|
	
	direction := self west.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 2@2 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:04:44'!
test20MovingForwardTwoTimesAdvancesToPointsOnYAxis
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:12:07'!
test21RoverDoesNotExecuteNextMovementCommandsAfterInvalidCommand
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'fxf'.
	
	self assert: (marsRover isAt: 1@3 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:13:59'!
test22RoverMovesForwardThenRotatesToTheRightTwice
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'frfr'.
	
	self assert: (marsRover isAt: 2@3 heading: self south).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/7/2021 00:13:32'!
test23RoverDoesNotExecuteNextCommandsAfterInvalidCommand
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'frxfr'.
	
	self assert: (marsRover isAt: 2@3 heading: self south).! !


!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:08:12'!
test10RotatingFromNorthToTheLeftMakesRoverHeadWest
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: self west).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:10:12'!
test11RotatingFromNorthToTheRightMakesRoverHeadEast
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: self east).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:08:35'!
test12RotatingFromEastToTheLeftMakesRoverHeadNorth
	|marsRover direction|
	
	direction := self east.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: self north).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:10:30'!
test13RotatingFromEastToTheRightMakesRoverHeadSouth
	|marsRover direction|
	
	direction := self east.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: self south).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:09:04'!
test14RotatingFromSouthToTheLeftMakesRoverHeadEast
	|marsRover direction|
	
	direction := self south.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: self east).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:10:47'!
test15RotatingFromSouthToTheRightMakesRoverHeadWest
	|marsRover direction|
	
	direction := self south.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: self west).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:09:21'!
test16RotatingFromWestToTheLeftMakesRoverHeadSouth
	|marsRover direction|
	
	direction := self west.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: self south).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:11:10'!
test17RotatingFromWestToTheRightMakesRoverHeadNorth
	|marsRover direction|
	
	direction := self west.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: self north).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:11:30'!
test18RotatingFromNorthToTheRightTwiceMakesRoverHeadSouth
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'rr'.
	
	self assert: (marsRover isAt: 1@2 heading: self south).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/7/2021 00:14:35'!
test19RoverDoesNotExecuteNextHeadingCommandsAfterInvalidCommand
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'rxr'.
	
	self assert: (marsRover isAt: 1@2 heading: self east).! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'execution' stamp: 'PhG 10/6/2021 23:58:56'!
executeFor: aRover at: aPosition heading: someDirection
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'handlers' stamp: 'PhG 10/6/2021 21:02:07'!
canHandle: aCommand
	self subclassResponsibility .! !


!classDefinition: #BackwardCommand category: 'MarsRover'!
Command subclass: #BackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!BackwardCommand methodsFor: 'execution' stamp: 'PhG 10/7/2021 00:00:18'!
executeFor: aRover at: aPosition heading: someDirection
	aRover moveBackwardsFrom: 	aPosition heading: someDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardCommand class' category: 'MarsRover'!
BackwardCommand class
	instanceVariableNames: ''!

!BackwardCommand class methodsFor: 'handlers' stamp: 'PhG 10/6/2021 21:23:30'!
canHandle: aCommand
	^$b = aCommand! !


!classDefinition: #ForwardCommand category: 'MarsRover'!
Command subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!ForwardCommand methodsFor: 'execution' stamp: 'PhG 10/6/2021 23:59:16'!
executeFor: aRover at: aPosition heading: someDirection
	aRover moveForwardFrom: 	aPosition heading: someDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: 'MarsRover'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'handlers' stamp: 'PhG 10/6/2021 21:23:35'!
canHandle: aCommand
	^$f = aCommand! !


!classDefinition: #RotateLeftCommand category: 'MarsRover'!
Command subclass: #RotateLeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeftCommand methodsFor: 'execution' stamp: 'PhG 10/6/2021 23:59:21'!
executeFor: aRover at: aPosition heading: someDirection
	aRover rotateLeftFrom: someDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeftCommand class' category: 'MarsRover'!
RotateLeftCommand class
	instanceVariableNames: ''!

!RotateLeftCommand class methodsFor: 'handlers' stamp: 'PhG 10/6/2021 21:23:42'!
canHandle: aCommand
	^$l = aCommand! !


!classDefinition: #RotateRightCommand category: 'MarsRover'!
Command subclass: #RotateRightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRightCommand methodsFor: 'execution' stamp: 'PhG 10/6/2021 23:59:26'!
executeFor: aRover at: aPosition heading: someDirection
	aRover rotateRightFrom: someDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRightCommand class' category: 'MarsRover'!
RotateRightCommand class
	instanceVariableNames: ''!

!RotateRightCommand class methodsFor: 'handlers' stamp: 'PhG 10/6/2021 21:23:48'!
canHandle: aCommand
	^$r = aCommand! !


!classDefinition: #Direction category: 'MarsRover'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Direction methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:00:10'!
goBackwardsFrom: aPosition
	self subclassResponsibility.! !

!Direction methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:00:24'!
goForwardFrom: aPosition
	self subclassResponsibility.! !


!Direction methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:39:14'!
rotateLeft
	self subclassResponsibility .! !

!Direction methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:39:11'!
rotateRight
	self subclassResponsibility .! !


!classDefinition: #East category: 'MarsRover'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:02:12'!
goBackwardsFrom: currentPosition
	^currentPosition - (1@0).! !

!East methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:02:06'!
goForwardFrom: currentPosition
	^currentPosition + (1@0).! !


!East methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:39:42'!
rotateLeft
	^North new.! !

!East methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:39:56'!
rotateRight
	^South new.! !


!classDefinition: #North category: 'MarsRover'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:01:12'!
goBackwardsFrom: currentPosition
	^currentPosition - (0@1).! !

!North methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:00:54'!
goForwardFrom: currentPosition
	^currentPosition + (0@1).! !


!North methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:40:03'!
rotateLeft
	^West new.! !

!North methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:40:09'!
rotateRight
	^East new.! !


!classDefinition: #South category: 'MarsRover'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:01:39'!
goBackwardsFrom: currentPosition
	^currentPosition + (0@1).! !

!South methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:01:35'!
goForwardFrom: currentPosition
	^currentPosition - (0@1).! !


!South methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:40:16'!
rotateLeft
	^East new.! !

!South methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:40:22'!
rotateRight
	^West new.! !


!classDefinition: #West category: 'MarsRover'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:02:28'!
goBackwardsFrom: currentPosition
	^currentPosition + (1@0).! !

!West methodsFor: 'movement' stamp: 'PhG 10/5/2021 19:02:22'!
goForwardFrom: currentPosition
	^currentPosition - (1@0).! !


!West methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:40:29'!
rotateLeft
	^South new.! !

!West methodsFor: 'direction' stamp: 'PhG 10/5/2021 22:40:34'!
rotateRight
	^North new.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'PhG 10/5/2021 22:46:42'!
initializeAt: somePosition heading: aDirection

	position := somePosition.
	direction := aDirection.! !


!MarsRover methodsFor: 'command execution' stamp: 'PhG 10/6/2021 21:19:27'!
process: aSequenceOfCommands
	
	|commandToExecute|

	(aSequenceOfCommands asOrderedCollection) do: [:aCommand| 		
		
		commandToExecute := (Command allSubclasses) detect: [:aSubclass | aSubclass canHandle: aCommand] ifNone: [^nil].
		(commandToExecute new) executeFor: self at: position heading: direction.
"		aCommand = $f ifTrue: [ position:= direction goForwardFrom: position ].
		aCommand = $b ifTrue: [ position:= direction goBackwardsFrom: position ].
		aCommand = $l ifTrue: [ direction := direction rotateLeft ].
		aCommand = $r ifTrue: [ direction := direction rotateRight ]."

	].! !


!MarsRover methodsFor: 'testing' stamp: 'PhG 10/5/2021 22:46:42'!
isAt: somePosition heading: aDirection

	^position = somePosition and: [direction class = aDirection class].! !


!MarsRover methodsFor: 'movement' stamp: 'PhG 10/7/2021 00:00:18'!
moveBackwardsFrom: 	aPosition heading: someDirection
	position := someDirection goBackwardsFrom: aPosition! !

!MarsRover methodsFor: 'movement' stamp: 'PhG 10/6/2021 21:17:13'!
moveForwardFrom: 	aPosition heading: someDirection
	position := someDirection goForwardFrom: aPosition! !

!MarsRover methodsFor: 'movement' stamp: 'PhG 10/6/2021 21:18:07'!
rotateLeftFrom: someDirection
	direction := someDirection rotateLeft.! !

!MarsRover methodsFor: 'movement' stamp: 'PhG 10/6/2021 21:18:17'!
rotateRightFrom: someDirection
	direction := someDirection rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'PhG 10/4/2021 20:51:09'!
at: somePosition heading: someDirection

	^MarsRover new initializeAt: somePosition heading: someDirection .! !
