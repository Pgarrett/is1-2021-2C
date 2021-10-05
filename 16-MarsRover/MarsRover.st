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


!TestRover methodsFor: 'tests position' stamp: 'PhG 10/5/2021 19:10:06'!
test01
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


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'PhG 10/4/2021 20:51:55'!
initializeAt: somePosition heading: aDirection

	position := somePosition.
	heading := aDirection.! !


!MarsRover methodsFor: 'command execution' stamp: 'PhG 10/5/2021 19:29:35'!
process: aSequenceOfCommands

	(aSequenceOfCommands asOrderedCollection) do: [:aCommand| 		
		aCommand = $f ifTrue: [ position:= heading goForwardFrom: position.] 
		ifFalse: [ 
			aCommand = $b ifTrue: [position:= heading goBackwardsFrom: position.]
					ifFalse: [
						aCommand = $l ifTrue: [
							(heading isKindOf: North) ifTrue: [heading := West new.]
								ifFalse: [heading := North new.]
							]
								ifFalse: [heading := East new.]
						]
			]
		].! !


!MarsRover methodsFor: 'testing' stamp: 'PhG 10/5/2021 19:24:51'!
isAt: somePosition heading: aDirection

	^position = somePosition and: [heading class = aDirection class].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'PhG 10/4/2021 20:51:09'!
at: somePosition heading: someDirection

	^MarsRover new initializeAt: somePosition heading: someDirection .! !
