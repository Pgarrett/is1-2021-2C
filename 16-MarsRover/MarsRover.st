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

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 19:10:32'!
test02
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction .
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 19:12:57'!
test03
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 19:12:51'!
test04
	|marsRover direction|
	
	direction := self south.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@1 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 19:12:46'!
test05
	|marsRover direction|
	
	direction := self south.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@3 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 19:12:41'!
test06
	|marsRover direction|
	
	direction := self east.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 19:12:36'!
test07
	|marsRover direction|
	
	direction := self east.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 19:12:30'!
test08
	|marsRover direction|
	
	direction := self west.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 0@2 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 19:12:24'!
test09
	|marsRover direction|
	
	direction := self west.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 2@2 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 22:46:05'!
test20
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: direction).! !

!TestRover methodsFor: 'tests position' stamp: 'PhG 10/6/2021 21:26:09'!
test21
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'fxf'.
	
	self assert: (marsRover isAt: 1@3 heading: direction).! !


!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/5/2021 19:12:11'!
test10
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: self west).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/5/2021 19:25:32'!
test11
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: self east).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/5/2021 19:28:02'!
test12
	|marsRover direction|
	
	direction := self east.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: self north).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/5/2021 22:31:40'!
test13
	|marsRover direction|
	
	direction := self east.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: self south).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/5/2021 22:34:03'!
test14
	|marsRover direction|
	
	direction := self south.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: self east).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/5/2021 22:35:16'!
test15
	|marsRover direction|
	
	direction := self south.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: self west).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/5/2021 22:36:48'!
test16
	|marsRover direction|
	
	direction := self west.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: self south).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/5/2021 22:37:37'!
test17
	|marsRover direction|
	
	direction := self west.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: self north).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/5/2021 22:44:03'!
test18
	|marsRover direction|
	
	direction := self north.
	marsRover := MarsRover at: 1@2 heading: direction.
	
	marsRover process: 'rr'.
	
	self assert: (marsRover isAt: 1@2 heading: self south).! !

!TestRover methodsFor: 'tests heading' stamp: 'PhG 10/6/2021 21:25:38'!
test19
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

!BackwardCommand methodsFor: 'as yet unclassified' stamp: 'PhG 10/6/2021 21:18:48'!
executeFor: aRover at: aPosition heading: someDirection.
	aRover moveBackwardFrom: 	aPosition heading: someDirection.! !

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

!ForwardCommand methodsFor: 'as yet unclassified' stamp: 'PhG 10/6/2021 21:15:46'!
executeFor: aRover at: aPosition heading: someDirection.
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

!RotateLeftCommand methodsFor: 'as yet unclassified' stamp: 'PhG 10/6/2021 21:19:05'!
executeFor: aRover at: aPosition heading: someDirection.
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

!RotateRightCommand methodsFor: 'as yet unclassified' stamp: 'PhG 10/6/2021 21:19:14'!
executeFor: aRover at: aPosition heading: someDirection.
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


!MarsRover methodsFor: 'movement' stamp: 'PhG 10/6/2021 21:17:25'!
moveBackwardFrom: 	aPosition heading: someDirection
	position:= someDirection goBackwardsFrom: aPosition! !

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
