!classDefinition: #CompositeTeamTest category: 'ISW1-2021-2C-2doParcial'!
TestCase subclass: #CompositeTeamTest
	instanceVariableNames: 'meteorologyOfficeBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!CompositeTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:17:26'!
test01CompositeTeamStartsWithNoTeams

	self assert: CompositeTeam new isEmpty.! !

!CompositeTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:17:23'!
test02AddingTeamToCompositeTeamMakesItNonEmpty

	| compositeTeam |
	
	compositeTeam := CompositeTeam new.
	
	compositeTeam add: self simpleTeamWithAllFixed.

	self deny: compositeTeam isEmpty.! !

!CompositeTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:29:57'!
test03CanNotAddSameSimpleTeamTwice

	| compositeTeam simpleTeam |
	
	compositeTeam := CompositeTeam new.
	
	simpleTeam := self simpleTeamWithAllFixed.
	compositeTeam add: simpleTeam.
	
	self 
		should: [ compositeTeam add: simpleTeam ]
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: CompositeTeam canNotAddSameTeamTwiceErrorDescription.]! !

!CompositeTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:19:28'!
test04CompositeTeamCanHaveCompositeTeamInside

	| compositeTeam |
	
	compositeTeam := CompositeTeam new.
	
	compositeTeam add: self simpleTeamWithAllFixed.
	compositeTeam add: (CompositeTeam new add: self simpleTeamWithFixedPriceAndVariableConstructionCapacity).
	
	self assert: 2 equals: compositeTeam size.
	
	! !

!CompositeTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:30:20'!
test05AddedSimpleTeamCanNotBeAddedAsLeafOfOtherCompositeTeams

	| compositeTeam simpleTeam |
	
	compositeTeam := CompositeTeam new.
	
	simpleTeam := 	self simpleTeamWithAllFixed.
	compositeTeam add: simpleTeam.
	
	self 
		should: [ compositeTeam add: (CompositeTeam new add: simpleTeam) ]
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: CompositeTeam canNotAddSameTeamTwiceErrorDescription.]
	
	! !

!CompositeTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:43:21'!
test06ConstructionEtaIsLongestTeamEta

	| compositeTeam simpleTeam anotherSimpleTeam surfaceToConstruct |
	
	compositeTeam := CompositeTeam new.
	
	simpleTeam := 	self simpleTeamWithAllFixed.
	anotherSimpleTeam := self simpleTeamWithFixedPriceAndVariableConstructionCapacity.
	compositeTeam add: simpleTeam.
	compositeTeam add: anotherSimpleTeam.
	
	surfaceToConstruct := 56 * meter * meter.
	
	self assert: (simpleTeam etaForSurface: surfaceToConstruct/2) < (anotherSimpleTeam etaForSurface: surfaceToConstruct/2 ).
	self assert: (compositeTeam etaForSurface: surfaceToConstruct) equals: (anotherSimpleTeam etaForSurface: surfaceToConstruct/2 ).! !

!CompositeTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:46:47'!
test07ConstructionCostIsBothTeamsCostAdded

	| compositeTeam simpleTeam anotherSimpleTeam surfaceToConstruct teamsCostForSurface |
	
	compositeTeam := CompositeTeam new.
	
	simpleTeam := 	self simpleTeamWithAllFixed.
	anotherSimpleTeam := self simpleTeamWithFixedPriceAndVariableConstructionCapacity.
	compositeTeam add: simpleTeam.
	compositeTeam add: anotherSimpleTeam.
	
	surfaceToConstruct := 56 * meter * meter.
	
	teamsCostForSurface := (anotherSimpleTeam costForSurfaceOn: surfaceToConstruct/2 ) + (simpleTeam costForSurfaceOn: surfaceToConstruct/2 ).
	
	self assert: (compositeTeam costForSurfaceOn: surfaceToConstruct) equals: teamsCostForSurface.! !


!CompositeTeamTest methodsFor: 'simple team' stamp: 'PhG 11/25/2021 21:09:14'!
simpleTeamWithAllFixed

	| fixedPricingModel fixedCapacity |
	
	fixedPricingModel := FixedPricePerDay on: 2 * peso.
	fixedCapacity := FixedConstructionCapacityPerDay on: 25 * meter * meter.
	
	^SimpleTeam withPricingModel: fixedPricingModel andCapacity: fixedCapacity.! !

!CompositeTeamTest methodsFor: 'simple team' stamp: 'PhG 11/25/2021 21:34:50'!
simpleTeamWithFixedPriceAndVariableConstructionCapacity

	| fixedPricingModel variableCapacity |
	
	fixedPricingModel := FixedPricePerDay on: 2 * peso.
	variableCapacity := VariableConstructionCapacityPerDay on: 5 * meter * meter forFirst: 2* day  then: 1 * meter * meter.
	
	^SimpleTeam withPricingModel: fixedPricingModel andCapacity: variableCapacity.! !


!classDefinition: #ConstructionCapacityTest category: 'ISW1-2021-2C-2doParcial'!
TestCase subclass: #ConstructionCapacityTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!ConstructionCapacityTest methodsFor: 'fixed capacity tests' stamp: 'PhG 11/25/2021 19:15:31'!
test01Building25m2ForFixedConstructionCapacityOn25m2Takes1Day

	| fixedConstructionCapacity |
	
	fixedConstructionCapacity := FixedConstructionCapacityPerDay on: self metresSquare25.
	
	self assert: 1 * day equals: (fixedConstructionCapacity timeFor: self metresSquare25).! !

!ConstructionCapacityTest methodsFor: 'fixed capacity tests' stamp: 'PhG 11/25/2021 19:15:18'!
test02Building50m2ForFixedConstructionCapacityOn25m2Takes2Days

	| fixedConstructionCapacity |
	
	fixedConstructionCapacity := FixedConstructionCapacityPerDay on: self metresSquare25.
	
	self assert: 2 * day equals: (fixedConstructionCapacity timeFor: 50 * (meter * meter)).! !


!ConstructionCapacityTest methodsFor: 'days' stamp: 'PhG 11/25/2021 19:27:39'!
oneDay

	^ 1 * day! !

!ConstructionCapacityTest methodsFor: 'days' stamp: 'PhG 11/25/2021 19:27:45'!
twoDays

	^ 2 * day! !


!ConstructionCapacityTest methodsFor: 'metres square' stamp: 'PhG 11/25/2021 19:23:34'!
metresSquare10

	^ 10 * (meter * meter)! !

!ConstructionCapacityTest methodsFor: 'metres square' stamp: 'PhG 11/25/2021 19:30:45'!
metresSquare15

	^ 15 * (meter * meter)! !

!ConstructionCapacityTest methodsFor: 'metres square' stamp: 'PhG 11/25/2021 19:15:18'!
metresSquare25

	^ 25 * (meter * meter)! !


!ConstructionCapacityTest methodsFor: 'variable capacity tests' stamp: 'PhG 11/25/2021 19:26:29'!
test03CapacityAfterFirstDaysMustBeLessThanInitialCapacity
	
	self 
		should: [ VariableConstructionCapacityPerDay on: self metresSquare10 forFirst: 1 * day then: self metresSquare25]
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: VariableConstructionCapacityPerDay firstDaysMustBuildMoreSurfaceErrorDescription.]! !

!ConstructionCapacityTest methodsFor: 'variable capacity tests' stamp: 'PhG 11/25/2021 19:28:19'!
test04Building25m2ForVariableConstructionCapacityOn25m2For1DayTakes1Day

	| fixedConstructionCapacity |
	
	fixedConstructionCapacity := VariableConstructionCapacityPerDay on: self metresSquare25 forFirst: self oneDay then: self metresSquare10.
	
	self assert: self oneDay equals: (fixedConstructionCapacity timeFor: self metresSquare25).! !

!ConstructionCapacityTest methodsFor: 'variable capacity tests' stamp: 'PhG 11/25/2021 20:14:04'!
test05Building15m2ForVariableConstructionCapacityOn25m2For2DaysTakes1Day

	| fixedConstructionCapacity |
	
	fixedConstructionCapacity := VariableConstructionCapacityPerDay on: self metresSquare25 forFirst: self twoDays then: self metresSquare10.
	
	self assert: self oneDay equals: (fixedConstructionCapacity timeFor: self metresSquare15).! !

!ConstructionCapacityTest methodsFor: 'variable capacity tests' stamp: 'PhG 11/25/2021 20:04:47'!
test06Building25m2ForVariableConstructionCapacityOn15m2For2DaysTakes2Days

	| fixedConstructionCapacity |
	
	fixedConstructionCapacity := VariableConstructionCapacityPerDay on: self metresSquare15 forFirst: self twoDays then: self metresSquare10.
	
	self assert: self twoDays equals: (fixedConstructionCapacity timeFor: self metresSquare25).! !

!ConstructionCapacityTest methodsFor: 'variable capacity tests' stamp: 'PhG 11/25/2021 20:04:41'!
test07Building25m2ForVariableConstructionCapacityOn10m2For2DaysThen4m2Takes2ExtraDays

	| fixedConstructionCapacity |
	
	fixedConstructionCapacity := VariableConstructionCapacityPerDay on: self metresSquare10 forFirst: self twoDays then: (4 * meter * meter).
	
	self assert: 4 * day equals: (fixedConstructionCapacity timeFor: self metresSquare25).! !


!classDefinition: #PricingModelTest category: 'ISW1-2021-2C-2doParcial'!
TestCase subclass: #PricingModelTest
	instanceVariableNames: 'meteorologyOfficeBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!PricingModelTest methodsFor: 'variable price model tests' stamp: 'PhG 11/25/2021 18:27:59'!
test01PriceForRainyDayCanNotBeLessThanSunnyDay

	self 
		should: [ VariablePricePerDay onRainyDays: 100 * peso onSunnyDays: 150 * peso withMeteorologyOffice: self ]
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: VariablePricePerDay rainyDaysShouldBeMoreExpensiveErrorDescription.]! !

!PricingModelTest methodsFor: 'variable price model tests' stamp: 'PhG 11/25/2021 18:31:25'!
test02PriceForConstructionDuringSunnyDayIsSunnyDayPrice

	| variablePrice |
	
	meteorologyOfficeBehaviour := [:constructionDays | 0 * day].

	variablePrice := VariablePricePerDay onRainyDays: 200 * peso onSunnyDays: 150 * peso withMeteorologyOffice: self.

	self assert: (variablePrice priceFor: 1 * day) equals: 150 * peso.
	! !

!PricingModelTest methodsFor: 'variable price model tests' stamp: 'PhG 11/25/2021 18:31:21'!
test03PriceForConstructionDuringRainyDayIsRainyDayPrice

	| variablePrice |
	
	meteorologyOfficeBehaviour := [:constructionDays | 1 * day].

	variablePrice := VariablePricePerDay onRainyDays: 200 * peso onSunnyDays: 150 * peso withMeteorologyOffice: self.

	self assert: (variablePrice priceFor: 1 * day) equals: 200 * peso.
	! !

!PricingModelTest methodsFor: 'variable price model tests' stamp: 'PhG 11/25/2021 18:35:06'!
test04PriceForConstructionDuring20SunnyDaysIsSunnyDayPriceTimes20

	| variablePrice |
	
	meteorologyOfficeBehaviour := [:constructionDays | 0 * day].

	variablePrice := VariablePricePerDay onRainyDays: 200 * peso onSunnyDays: 15 * peso withMeteorologyOffice: self.

	self assert: (variablePrice priceFor: 20 * day) equals: 300 * peso.
	! !

!PricingModelTest methodsFor: 'variable price model tests' stamp: 'PhG 11/25/2021 18:36:04'!
test05PriceForConstructionDuring30RainyDaysIsRainyDayPriceTimes30

	| variablePrice |
	
	meteorologyOfficeBehaviour := [:constructionDays | 30 * day].

	variablePrice := VariablePricePerDay onRainyDays: 2 * peso onSunnyDays: 1 * peso withMeteorologyOffice: self.

	self assert: (variablePrice priceFor: 30 * day) equals: 60 * peso.
	! !

!PricingModelTest methodsFor: 'variable price model tests' stamp: 'PhG 11/25/2021 18:37:26'!
test06PriceForConstruction3SunnyDaysAnd2RainyIsCompositionOfAllPrices

	| variablePrice |
	
	meteorologyOfficeBehaviour := [:constructionDays | 2 * day].

	variablePrice := VariablePricePerDay onRainyDays: 10 * peso onSunnyDays: 5 * peso withMeteorologyOffice: self.

	self assert: (variablePrice priceFor: 5 * day) equals: 35 * peso.
	! !


!PricingModelTest methodsFor: 'meteorology office protocol' stamp: 'PhG 11/25/2021 18:25:46'!
rainyDaysInTheNext: anAmountOfDays
	
	^meteorologyOfficeBehaviour value: anAmountOfDays.! !


!PricingModelTest methodsFor: 'fixed price model tests' stamp: 'PhG 11/25/2021 18:47:56'!
test07PriceForOneDayIsFixedPriceConfigured

	| fixedPrice |
	
	fixedPrice := FixedPricePerDay on: 100 * peso.

	self assert: (fixedPrice priceFor: 1 * day) equals: 100 * peso.! !

!PricingModelTest methodsFor: 'fixed price model tests' stamp: 'PhG 11/25/2021 18:48:21'!
test08PriceFor30daysIsFixedPriceConfiguredTimes30

	| fixedPrice |
	
	fixedPrice := FixedPricePerDay on: 2 * peso.

	self assert: (fixedPrice priceFor: 30 * day) equals: 60 * peso.! !


!classDefinition: #SimpleTeamTest category: 'ISW1-2021-2C-2doParcial'!
TestCase subclass: #SimpleTeamTest
	instanceVariableNames: 'meteorologyOfficeBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!SimpleTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 20:56:42'!
test01teamOn25m2FixedPriceAnd25m2FixedCapacityTakes2Days

	| fixedPricingModel fixedCapacity simpleTeam |
	
	fixedPricingModel := FixedPricePerDay on: 2 * peso.
	fixedCapacity := FixedConstructionCapacityPerDay on: 25 * meter * meter.
	
	simpleTeam := SimpleTeam withPricingModel: fixedPricingModel andCapacity: fixedCapacity.
	
	self assert: 2 * day equals: (simpleTeam etaForSurface: 50 * meter * meter).! !

!SimpleTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 20:56:37'!
test02teamOn25m2FixedPriceAnd25m2FixedCapacityChargesTwoDaysWork

	| fixedPricingModel fixedCapacity simpleTeam |
	
	fixedPricingModel := FixedPricePerDay on: 2 * peso.
	fixedCapacity := FixedConstructionCapacityPerDay on: 25 * meter * meter.
	
	simpleTeam := SimpleTeam withPricingModel: fixedPricingModel andCapacity: fixedCapacity.
	
	self assert: 4 * peso equals: (simpleTeam costForSurfaceOn: 50 * meter * meter).! !

!SimpleTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 20:55:46'!
test03teamOn25m2VariablePriceAnd25m2FixedCapacityTakes2Days

	| variablePricingModel fixedCapacity simpleTeam |
	
	meteorologyOfficeBehaviour := [:constructionDays | 1 * day].
	
	variablePricingModel := VariablePricePerDay onRainyDays: 4*peso onSunnyDays: 2*peso withMeteorologyOffice: self.
	fixedCapacity := FixedConstructionCapacityPerDay on: 25 * meter * meter.
	
	simpleTeam := SimpleTeam withPricingModel: variablePricingModel andCapacity: fixedCapacity.
	
	self assert: 2 * day equals: (simpleTeam etaForSurface: 50 * meter * meter).! !

!SimpleTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:03:39'!
test04teamOn25m2VariablePriceAnd25m2FixedCapacityIsChargedBothTypeOfDays

	| variablePricingModel fixedCapacity simpleTeam |
	
	meteorologyOfficeBehaviour := [:constructionDays | 1 * day].
	
	variablePricingModel := VariablePricePerDay onRainyDays: 4*peso onSunnyDays: 2*peso withMeteorologyOffice: self.
	fixedCapacity := FixedConstructionCapacityPerDay on: 25 * meter * meter.
	
	simpleTeam := SimpleTeam withPricingModel: variablePricingModel andCapacity: fixedCapacity.
	
	self assert:6 * peso equals: (simpleTeam costForSurfaceOn: 50 * meter * meter).! !

!SimpleTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:03:33'!
test05teamOn55m2VariablePriceAndVariableCapacityIsChargedBothTypeOfDays

	| variablePricingModel variableCapacity simpleTeam |
	
	meteorologyOfficeBehaviour := [:constructionDays | 2 * day].
	
	variablePricingModel := VariablePricePerDay onRainyDays: 4*peso onSunnyDays: 2*peso withMeteorologyOffice: self.
	variableCapacity := VariableConstructionCapacityPerDay on: 15 * meter * meter forFirst: 1*day then: 10 *meter*meter .
	
	simpleTeam := SimpleTeam withPricingModel: variablePricingModel andCapacity: variableCapacity.
	
	self assert: 12 * peso equals: (simpleTeam costForSurfaceOn: 55 * meter * meter).! !

!SimpleTeamTest methodsFor: 'tests' stamp: 'PhG 11/25/2021 21:03:26'!
test06teamOn55m2VariablePriceAndVariableCapacityTakesFourDays

	| variablePricingModel variableCapacity simpleTeam |
	
	meteorologyOfficeBehaviour := [:constructionDays | 2 * day].
	
	variablePricingModel := VariablePricePerDay onRainyDays: 4*peso onSunnyDays: 2*peso withMeteorologyOffice: self.
	variableCapacity := VariableConstructionCapacityPerDay on: 15 * meter * meter forFirst: 1*day then: 10 *meter*meter .
	
	simpleTeam := SimpleTeam withPricingModel: variablePricingModel andCapacity: variableCapacity.
	
	self assert: 4*day equals: (simpleTeam etaForSurface: 55 * meter * meter).! !


!SimpleTeamTest methodsFor: 'meteorology office protocol' stamp: 'PhG 11/25/2021 20:51:43'!
rainyDaysInTheNext: anAmountOfDays
	
	^meteorologyOfficeBehaviour value: anAmountOfDays.! !


!classDefinition: #ConstructionCapacity category: 'ISW1-2021-2C-2doParcial'!
Object subclass: #ConstructionCapacity
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!ConstructionCapacity methodsFor: 'time to build' stamp: 'PhG 11/25/2021 19:03:13'!
timeFor: aConstructionSurface
	self subclassResponsibility.! !


!classDefinition: #FixedConstructionCapacityPerDay category: 'ISW1-2021-2C-2doParcial'!
ConstructionCapacity subclass: #FixedConstructionCapacityPerDay
	instanceVariableNames: 'constructionCapacityPerDay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!FixedConstructionCapacityPerDay methodsFor: 'time to build' stamp: 'PhG 11/25/2021 19:13:29'!
timeFor: aConstructionSurface

	^aConstructionSurface / constructionCapacityPerDay.! !


!FixedConstructionCapacityPerDay methodsFor: 'initialization' stamp: 'PhG 11/25/2021 19:11:54'!
initializeOn: aConstructionCapacityPerDay 
	
	constructionCapacityPerDay := aConstructionCapacityPerDay.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FixedConstructionCapacityPerDay class' category: 'ISW1-2021-2C-2doParcial'!
FixedConstructionCapacityPerDay class
	instanceVariableNames: ''!

!FixedConstructionCapacityPerDay class methodsFor: 'instance creation' stamp: 'PhG 11/25/2021 19:10:37'!
on: aSurfacePerDays

	^self new initializeOn: aSurfacePerDays/day ! !


!classDefinition: #VariableConstructionCapacityPerDay category: 'ISW1-2021-2C-2doParcial'!
ConstructionCapacity subclass: #VariableConstructionCapacityPerDay
	instanceVariableNames: 'initialSurfacePerDay amountOfDays remainingSurfacePerDay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!VariableConstructionCapacityPerDay methodsFor: 'time to build' stamp: 'PhG 11/25/2021 20:39:17'!
timeFor: aConstructionSurface

	| daysForInitialSurface remainingConstructionSurface |
	
	daysForInitialSurface := aConstructionSurface / initialSurfacePerDay.
	
	daysForInitialSurface <= amountOfDays ifTrue: [^daysForInitialSurface ceiling].
	
	daysForInitialSurface := daysForInitialSurface floor.
	
	remainingConstructionSurface := self remainingConstructionSurfaceFor: daysForInitialSurface after: aConstructionSurface.
	
	^daysForInitialSurface + (self daysForRemainingSurface: remainingConstructionSurface).! !


!VariableConstructionCapacityPerDay methodsFor: 'initialization' stamp: 'PhG 11/25/2021 19:22:08'!
initializeOn: anInitialSurfacePerDay forFirst: anAmountOfDays then: aRemainingSurfacePerDay  

	initialSurfacePerDay := anInitialSurfacePerDay.
	amountOfDays := anAmountOfDays.
	remainingSurfacePerDay := aRemainingSurfacePerDay.! !


!VariableConstructionCapacityPerDay methodsFor: 'private' stamp: 'PhG 11/25/2021 20:34:14'!
daysForRemainingSurface: remainingConstructionSurface

	^(remainingConstructionSurface / remainingSurfacePerDay) ceiling.! !

!VariableConstructionCapacityPerDay methodsFor: 'private' stamp: 'PhG 11/25/2021 20:37:22'!
remainingConstructionSurfaceFor: daysForInitialSurface after: aConstructionSurface

	^ aConstructionSurface - (initialSurfacePerDay * daysForInitialSurface)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VariableConstructionCapacityPerDay class' category: 'ISW1-2021-2C-2doParcial'!
VariableConstructionCapacityPerDay class
	instanceVariableNames: ''!

!VariableConstructionCapacityPerDay class methodsFor: 'instance creation' stamp: 'PhG 11/25/2021 19:32:50'!
on: aSurfacePerDays forFirst: anAmountOfDays then: aRemainingSurfacePerDay

	aSurfacePerDays < aRemainingSurfacePerDay ifTrue: [self error: self firstDaysMustBuildMoreSurfaceErrorDescription.].
	
	^self new initializeOn: aSurfacePerDays/day forFirst: anAmountOfDays then: aRemainingSurfacePerDay/day ! !


!VariableConstructionCapacityPerDay class methodsFor: 'error description' stamp: 'PhG 11/25/2021 19:26:29'!
firstDaysMustBuildMoreSurfaceErrorDescription

	^'First days must have more building capacity'! !


!classDefinition: #PricingModel category: 'ISW1-2021-2C-2doParcial'!
Object subclass: #PricingModel
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!PricingModel methodsFor: 'budget' stamp: 'PhG 11/25/2021 18:46:27'!
priceFor: anAmountOfDays
	self subclassResponsibility.! !


!classDefinition: #FixedPricePerDay category: 'ISW1-2021-2C-2doParcial'!
PricingModel subclass: #FixedPricePerDay
	instanceVariableNames: 'pricePerDay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!FixedPricePerDay methodsFor: 'initialization' stamp: 'PhG 11/25/2021 17:59:46'!
initializeCharging: aPricePerDay 

	pricePerDay := aPricePerDay.! !


!FixedPricePerDay methodsFor: 'budget' stamp: 'PhG 11/25/2021 18:08:52'!
priceFor: timeToBuild 

	^pricePerDay * timeToBuild ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FixedPricePerDay class' category: 'ISW1-2021-2C-2doParcial'!
FixedPricePerDay class
	instanceVariableNames: ''!

!FixedPricePerDay class methodsFor: 'instance creation' stamp: 'PhG 11/25/2021 18:09:58'!
on: aPricePerDay 
	^self new initializeCharging: (aPricePerDay / day)! !


!classDefinition: #VariablePricePerDay category: 'ISW1-2021-2C-2doParcial'!
PricingModel subclass: #VariablePricePerDay
	instanceVariableNames: 'meteorologyOffice priceForRainyDays priceForSunnyDays'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!VariablePricePerDay methodsFor: 'initialization' stamp: 'PhG 11/25/2021 18:29:40'!
initializeWithPriceForRainyDays: aPriceForRainyDays priceForSunnyDays: aPriceForSunnyDays withMeteorologyOffice: aMeteorologyOffice 

	priceForRainyDays := aPriceForRainyDays.
	priceForSunnyDays := aPriceForSunnyDays.
	meteorologyOffice := aMeteorologyOffice.! !


!VariablePricePerDay methodsFor: 'budget' stamp: 'PhG 11/25/2021 18:45:47'!
priceFor: anAmountOfDays 

	| rainyDays |
	
	rainyDays := meteorologyOffice rainyDaysInTheNext: anAmountOfDays.

	^(self priceForRainyDaysFor: rainyDays) + (self priceForSunnyDaysFor: (anAmountOfDays - rainyDays)).! !


!VariablePricePerDay methodsFor: 'private' stamp: 'PhG 11/25/2021 18:43:02'!
priceForRainyDaysFor: anAmountOfRainyDays 

	^priceForRainyDays * anAmountOfRainyDays.! !

!VariablePricePerDay methodsFor: 'private' stamp: 'PhG 11/25/2021 18:43:26'!
priceForSunnyDaysFor: anAmountOfSunnyDays 

	^priceForSunnyDays * anAmountOfSunnyDays.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VariablePricePerDay class' category: 'ISW1-2021-2C-2doParcial'!
VariablePricePerDay class
	instanceVariableNames: ''!

!VariablePricePerDay class methodsFor: 'error descriptions' stamp: 'PhG 11/25/2021 18:17:22'!
rainyDaysShouldBeMoreExpensiveErrorDescription
	^'Rainy days should be more expensive!!'.! !


!VariablePricePerDay class methodsFor: 'instance creation' stamp: 'PhG 11/25/2021 18:33:38'!
onRainyDays: aPriceForRainyDays onSunnyDays: aPriceForSunnyDays withMeteorologyOffice: aMeteorologyOffice

	aPriceForRainyDays < aPriceForSunnyDays ifTrue: [self error: self rainyDaysShouldBeMoreExpensiveErrorDescription ].
	
	^self new initializeWithPriceForRainyDays: aPriceForRainyDays/day priceForSunnyDays: aPriceForSunnyDays/day withMeteorologyOffice: aMeteorologyOffice.! !


!classDefinition: #Team category: 'ISW1-2021-2C-2doParcial'!
Object subclass: #Team
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!


!classDefinition: #CompositeTeam category: 'ISW1-2021-2C-2doParcial'!
Team subclass: #CompositeTeam
	instanceVariableNames: 'teams parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!CompositeTeam methodsFor: 'adding' stamp: 'PhG 11/25/2021 21:26:28'!
add: teamToAdd 

	self assertCanAdd: teamToAdd.

	teams add: teamToAdd.
	teamToAdd addedTo: self.! !

!CompositeTeam methodsFor: 'adding' stamp: 'PhG 11/25/2021 21:27:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!CompositeTeam methodsFor: 'adding' stamp: 'PhG 11/25/2021 21:25:47'!
addedTo: aCompositeTeam
	
	parents add: aCompositeTeam ! !


!CompositeTeam methodsFor: 'initialization' stamp: 'PhG 11/25/2021 21:25:59'!
initialize

	teams := OrderedCollection new.
	parents := OrderedCollection new.! !


!CompositeTeam methodsFor: 'testing' stamp: 'PhG 11/25/2021 21:22:36'!
anyRootParentIsComposedBy: teamToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: teamToAdd]! !

!CompositeTeam methodsFor: 'testing' stamp: 'PhG 11/25/2021 21:20:59'!
isComposedBy: aTeam

	^ self = aTeam or: [ teams anySatisfy: [ :compositeTeam | (compositeTeam isComposedBy: aTeam) or: [ aTeam isComposedBy: compositeTeam ]]]! !

!CompositeTeam methodsFor: 'testing' stamp: 'PhG 11/25/2021 21:17:43'!
isEmpty

	^teams isEmpty.! !


!CompositeTeam methodsFor: 'accessing' stamp: 'PhG 11/25/2021 21:18:12'!
size
	^teams size! !


!CompositeTeam methodsFor: 'team management' stamp: 'PhG 11/25/2021 21:22:56'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!CompositeTeam methodsFor: 'assertions' stamp: 'PhG 11/25/2021 21:24:14'!
assertCanAdd: teamToAdd

	(self anyRootParentIsComposedBy: teamToAdd) ifTrue: [ self error: CompositeTeam canNotAddSameTeamTwiceErrorDescription ].
! !


!CompositeTeam methodsFor: 'eta for surface' stamp: 'PhG 11/25/2021 21:45:49'!
etaForSurface: aConstructionSurface 

	|surfacePerTeam|
	surfacePerTeam := self surfacePerTeam: aConstructionSurface.

	^(teams collect: [:aTeam | aTeam etaForSurface: surfacePerTeam]) asSortedCollection last.! !

!CompositeTeam methodsFor: 'eta for surface' stamp: 'PhG 11/25/2021 21:45:36'!
surfacePerTeam: aConstructionSurface

	^ aConstructionSurface /(teams size)! !


!CompositeTeam methodsFor: 'cost for surface' stamp: 'PhG 11/25/2021 21:46:37'!
costForSurfaceOn: aConstructionSurface 
	
	|surfacePerTeam|
	surfacePerTeam := self surfacePerTeam: aConstructionSurface.

	^teams sum: [:aTeam | aTeam costForSurfaceOn: surfacePerTeam].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompositeTeam class' category: 'ISW1-2021-2C-2doParcial'!
CompositeTeam class
	instanceVariableNames: ''!

!CompositeTeam class methodsFor: 'error descriptions' stamp: 'PhG 11/25/2021 21:12:55'!
canNotAddSameTeamTwiceErrorDescription

	^'Can not add same team twice'! !


!classDefinition: #SimpleTeam category: 'ISW1-2021-2C-2doParcial'!
Team subclass: #SimpleTeam
	instanceVariableNames: 'pricingModel constructionCapacity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!SimpleTeam methodsFor: 'initialization' stamp: 'PhG 11/25/2021 20:46:34'!
initializeWithPricingModel: aPricingModel andCapacity: aConstructionCapacity 
	pricingModel := aPricingModel.
	constructionCapacity := aConstructionCapacity.! !


!SimpleTeam methodsFor: 'surface cost' stamp: 'PhG 11/25/2021 20:47:30'!
costForSurfaceOn: aConstructionSurface 
	
	^pricingModel priceFor: (constructionCapacity timeFor: aConstructionSurface).! !


!SimpleTeam methodsFor: 'eta for surface' stamp: 'PhG 11/25/2021 20:49:35'!
etaForSurface: aConstructionSurface 
	^constructionCapacity timeFor: aConstructionSurface ! !


!SimpleTeam methodsFor: 'composition' stamp: 'PhG 11/25/2021 21:26:48'!
addedTo: aCompositeTeam
 ! !

!SimpleTeam methodsFor: 'composition' stamp: 'PhG 11/25/2021 21:21:16'!
isComposedBy: aTeam

	^self = aTeam ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimpleTeam class' category: 'ISW1-2021-2C-2doParcial'!
SimpleTeam class
	instanceVariableNames: ''!

!SimpleTeam class methodsFor: 'instance creation' stamp: 'PhG 11/25/2021 20:46:16'!
withPricingModel: aPricingModel andCapacity: aConstructionCapacity 
	
	^self new initializeWithPricingModel: aPricingModel andCapacity: aConstructionCapacity ! !
