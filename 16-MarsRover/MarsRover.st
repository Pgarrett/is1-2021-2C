!classDefinition: #TestRover category: 'MarsRover'!
TestCase subclass: #TestRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestRover methodsFor: 'as yet unclassified' stamp: 'PhG 10/4/2021 20:50:30'!
test01
	|marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North).! !

!TestRover methodsFor: 'as yet unclassified' stamp: 'PhG 10/4/2021 21:11:23'!
test02
	|marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PhG 10/4/2021 20:51:55'!
initializeAt: somePosition heading: aDirection

	position := somePosition.
	heading := aDirection.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PhG 10/4/2021 20:52:34'!
isAt: somePosition heading: aDirection

	^position = somePosition and: [heading = aDirection].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PhG 10/4/2021 21:28:04'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand| position := position + (0@1)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'PhG 10/4/2021 20:51:09'!
at: somePosition heading: someDirection

	^MarsRover new initializeAt: somePosition heading: someDirection .! !
