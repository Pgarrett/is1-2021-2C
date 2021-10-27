!classDefinition: #MarsRoverReportTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverReportTest methodsFor: 'log tests' stamp: 'PhG 10/26/2021 20:22:02'!
test01PositionLogIsEmptyWhenRoverDidNotMove

	| marsRover positionLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLogger := Log new.
	marsRover notifyPositionsChangesTo: positionLogger.
	
	self assert: OrderedCollection new equals: 	positionLogger print.! !

!MarsRoverReportTest methodsFor: 'log tests' stamp: 'PhG 10/26/2021 20:22:08'!
test02DirectionLogIsEmptyWhenRoverDidNotMove

	| marsRover directionLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	directionLogger := Log new.
	marsRover notifyDirectionChangesTo: directionLogger.
	
	self assert: OrderedCollection new equals: 	directionLogger print.! !

!MarsRoverReportTest methodsFor: 'log tests' stamp: 'PhG 10/26/2021 20:22:12'!
test03FullLogIsEmptyWhenRoverDidNotMove

	| marsRover allChangesLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	allChangesLogger := Log new.
	marsRover notifyAllChangesTo: allChangesLogger.
	
	self assert: OrderedCollection new equals: 	allChangesLogger print.! !

!MarsRoverReportTest methodsFor: 'log tests' stamp: 'PhG 10/26/2021 20:22:16'!
test04PositionLogContainsForwardEntryWhenRoverMovesForwardOnce

	| marsRover positionLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLogger := Log new.
	marsRover notifyPositionsChangesTo: positionLogger.
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 1@2) equals: 	positionLogger print.! !

!MarsRoverReportTest methodsFor: 'log tests' stamp: 'PhG 10/26/2021 20:22:21'!
test05PositionLogContainsForwardAndBackwardEntriesWhenRoverMovedForwardAndBackwards

	| marsRover positionLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	positionLogger := Log new.
	marsRover notifyPositionsChangesTo: positionLogger.
	marsRover process: 'fb'.
	
	self assert: (OrderedCollection with: 1@2 with: 1@1) equals: 	positionLogger print.! !

!MarsRoverReportTest methodsFor: 'log tests' stamp: 'PhG 10/26/2021 20:22:28'!
test06DirectionLogContainsEastEntryWhenRoverRotatedRight

	| marsRover directionLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	directionLogger := Log new.
	marsRover notifyDirectionChangesTo: directionLogger.
	marsRover process: 'r'.
	
	self assert: (OrderedCollection with: MarsRoverHeadingEast) equals: directionLogger print.! !

!MarsRoverReportTest methodsFor: 'log tests' stamp: 'PhG 10/26/2021 20:22:35'!
test07DirectionLogContainsEastAndNorthEntriesWhenRoverRotatedRightAndLeft

	| marsRover directionLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	directionLogger := Log new.
	marsRover notifyDirectionChangesTo: directionLogger.
	marsRover process: 'rl'.
	
	self assert: (OrderedCollection with: MarsRoverHeadingEast with: MarsRoverHeadingNorth) equals: directionLogger print.! !

!MarsRoverReportTest methodsFor: 'log tests' stamp: 'PhG 10/26/2021 20:22:44'!
test08FullLogContainsNewForwardPositionAndRotatedEastEntriesWhenRoverMovedForwardAndRotatedRight

	| marsRover allChangesLogger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	allChangesLogger := Log new.
	marsRover notifyAllChangesTo: allChangesLogger.
	marsRover process: 'fr'.
	
	self assert: (OrderedCollection with: 1@2 with: MarsRoverHeadingEast) equals: allChangesLogger print.! !

!MarsRoverReportTest methodsFor: 'log tests' stamp: 'wb 10/27/2021 00:05:06'!
test12LogShouldOnlyTrackAfterSubscription

	| marsRover allStatus |

	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	marsRover process: 'f'.
	allStatus := Log new.
	marsRover notifyAllChangesTo: allStatus.
	marsRover process: 'frf'.

	self assert: (OrderedCollection with: 1@3 
							   with: MarsRoverHeadingEast 
							   with: 2@3) equals: allStatus print.! !


!MarsRoverReportTest methodsFor: 'status tests' stamp: 'PhG 10/26/2021 20:14:00'!
test09PositionStatusContainsNewForwardPositionWhenRoverMovedForward

	| marsRover positionStatus |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	positionStatus := Status new.
	marsRover notifyPositionsChangesTo: positionStatus.
	marsRover process: 'f'.
	
	self assert: 1@2 equals: positionStatus printPosition.! !

!MarsRoverReportTest methodsFor: 'status tests' stamp: 'wb 10/27/2021 00:13:58'!
test10DirectionStatusContainsEastAsNewDirectionPositionWhenRoverRotatedRight

	| marsRover directionStatus |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	directionStatus := Status new.
	marsRover notifyDirectionChangesTo: directionStatus.
	marsRover process: 'r'.
	
	self assert: MarsRoverHeadingEast equals: directionStatus printDirection.! !

!MarsRoverReportTest methodsFor: 'status tests' stamp: 'PhG 10/26/2021 20:13:49'!
test11FullStatusContainsEastAsNewDirectionAndNewForwardPositionWhenRoverRotatedRightAndMovedForward

	| marsRover allStatus |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	allStatus := Status new.
	marsRover notifyAllChangesTo: allStatus.
	marsRover process: 'fr'.
	
	self assert: (OrderedCollection with: 1@2 with: MarsRoverHeadingEast) equals: allStatus printAll.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
Object subclass: #Log
	instanceVariableNames: 'updates positionUpdates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'print' stamp: 'PhG 10/26/2021 20:20:12'!
print
	"Usamos esto para no tener que assertear sobre los streams"
	^updates copy.! !


!Log methodsFor: 'initialization' stamp: 'PhG 10/26/2021 20:20:21'!
initialize
	updates := OrderedCollection new.! !


!Log methodsFor: 'update' stamp: 'PhG 10/26/2021 20:21:05'!
updateDirection: aDirectionUpdate
	updates add: aDirectionUpdate.! !

!Log methodsFor: 'update' stamp: 'PhG 10/26/2021 20:20:58'!
updatePosition: aPositionUpdate
	updates add: aPositionUpdate.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionSubscribers directionSubscribers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'PhG 10/26/2021 19:58:02'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	positionSubscribers := OrderedCollection new.
	directionSubscribers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'PhG 10/26/2021 08:45:06'!
headEast
	
	self nowHead: (MarsRoverHeadingEast for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'PhG 10/26/2021 08:44:59'!
headNorth
	
	self nowHead: (MarsRoverHeadingNorth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'PhG 10/26/2021 08:44:50'!
headSouth
	
	self nowHead: (MarsRoverHeadingSouth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'PhG 10/26/2021 08:44:42'!
headWest
	
	self nowHead: (MarsRoverHeadingWest for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'PhG 10/26/2021 20:16:42'!
nowHead: newDirection
	
	head := newDirection.
	directionSubscribers do: [:aDirectionSusbscriber | aDirectionSusbscriber updateDirection: (head class)].! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'PhG 10/26/2021 08:43:52'!
moveEast
	
	self moveTowards: 1@0! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'PhG 10/26/2021 08:43:47'!
moveNorth
	
	self moveTowards: 0@1! !

!MarsRover methodsFor: 'moving' stamp: 'PhG 10/26/2021 08:43:38'!
moveSouth
	
	self moveTowards: 0@-1! !

!MarsRover methodsFor: 'moving' stamp: 'PhG 10/26/2021 20:16:34'!
moveTowards: anOffset
	
	position := position + anOffset.
	positionSubscribers do: [:aPositionSusbscriber | aPositionSusbscriber updatePosition: position].! !

!MarsRover methodsFor: 'moving' stamp: 'PhG 10/26/2021 08:43:31'!
moveWest
	
	self moveTowards: -1@0.! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'PhG 10/26/2021 08:47:32'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^		self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^		self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^		self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'report' stamp: 'PhG 10/26/2021 20:02:11'!
notifyAllChangesTo: aSubscriber 
	self notifyPositionsChangesTo: aSubscriber.
	self notifyDirectionChangesTo: aSubscriber.! !

!MarsRover methodsFor: 'report' stamp: 'PhG 10/26/2021 19:57:39'!
notifyDirectionChangesTo: aDirectionSubscriber 
	directionSubscribers add: aDirectionSubscriber! !

!MarsRover methodsFor: 'report' stamp: 'PhG 10/26/2021 19:49:22'!
notifyPositionsChangesTo: aPositionSubscriber
	positionSubscribers add: aPositionSubscriber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #Status category: 'MarsRover-WithHeading'!
Object subclass: #Status
	instanceVariableNames: 'directionUpdate positionUpdate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Status methodsFor: 'update' stamp: 'PhG 10/26/2021 20:24:00'!
updateDirection: aDirectionUpdate
	directionUpdate := aDirectionUpdate.! !

!Status methodsFor: 'update' stamp: 'PhG 10/26/2021 20:09:59'!
updatePosition: aPositionUpdate
	positionUpdate := aPositionUpdate.! !


!Status methodsFor: 'print' stamp: 'PhG 10/26/2021 20:13:25'!
printAll
	^OrderedCollection with: positionUpdate with: directionUpdate.! !

!Status methodsFor: 'print' stamp: 'wb 10/27/2021 00:14:11'!
printDirection
	^directionUpdate.! !

!Status methodsFor: 'print' stamp: 'PhG 10/26/2021 20:13:03'!
printPosition
	^positionUpdate copy! !
