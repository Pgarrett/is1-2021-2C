!classDefinition: #NumerosNaturalesTest category: 'Numeros Naturales Tests'!
DenotativeObject subclass: #NumerosNaturalesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales Tests'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumerosNaturalesTest class' category: 'Numeros Naturales Tests'!
NumerosNaturalesTest class
	instanceVariableNames: ''!

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/28/2021 19:31:21'!
test01UnoMasUnSumandoEsElProximoDelSumando

	Assert that: I + II isEqualTo: II next.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:36:38'!
test02NumerosMayoresaUnoSumanBien

	Assert that: II + II isEqualTo: IIII.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:38:44'!
test03UnNumeroMenosUnoEsElPrevioDelNumero

	Assert that: II - I isEqualTo: II previous.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:38:55'!
test04NumerosMayoresaUnoRestanBien

	Assert that: IIII - II isEqualTo: II.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 20:15:03'!
test05RestaNoSoportaNumerosNegativos

	Assert should: [ I - II ] signal: Error withDescription: I descripcionDeErrorDeNumerosNegativosNoSoportados.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:39:18'!
test06UnNumeroMultiplicadoPorUnoEsIgualAlNumero

	Assert that: II * I isEqualTo: II.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:39:30'!
test07NumerosMayoresaUnoMultiplicanBien

	Assert that: II * II isEqualTo: IIII.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:39:44'!
test08UnoMultiplicadoUnoEsIgualAUno

	Assert that: I * I isEqualTo: I.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:39:54'!
test09NumerosMayoresaUnoDividenBien

	Assert that: IIII / II isEqualTo: II.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:40:07'!
test10UnNumeroDivididoUnoEsIgualAlNumero

	Assert that: II / I isEqualTo: II.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:40:18'!
test11UnoDivididoUnoEsIgualAUno

	Assert that: I / I isEqualTo: I.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'PhG 8/30/2021 19:51:37'!
test12DivisionNoSoportaDividirPorUnNumeroMayor

	Assert should: [ III /  IIII ] signal: Error withDescription: II descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	
	Assert should: [ I /  II] signal: Error withDescription: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
! !
