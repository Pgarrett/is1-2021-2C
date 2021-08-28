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

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:56:37'!
test01UnoMasUnSumandoEsElProximoDelSumando
	Assert that: I + II isEqualTo: II next.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:57:15'!
test02NumerosMayoresaUnoSumanBien

	Assert that: II + II isEqualTo: IIII.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:58:52'!
test03UnNumeroMenosUnoEsElPrevioDelNumero

	Assert that: II - I isEqualTo: II previous.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:59:01'!
test04NumerosMayoresaUnoRestanBien

	Assert that: IIII - II isEqualTo: II.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:59:12'!
test05RestaNoSoportaNumerosNegativos

	Assert should: [ I - II ] signal: Error withDescription: I descripcionDeErrorDeNumerosNegativosNoSoportados.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:59:18'!
test06UnNumeroMultiplicadoPorUnoEsIgualAlNumero

	Assert that: II * I isEqualTo: II.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:59:26'!
test07NumerosMayoresaUnoMultiplicanBien

	Assert that: II * II isEqualTo: IIII.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:16:46'!
test08UnoMultiplicadoUnoEsIgualAUno

	Assert that: I * I isEqualTo: I.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:01:58'!
test09NumerosMayoresaUnoDividenBien

	Assert that: IIII / II isEqualTo: II.
! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:28'!
test10UnNumeroDivididoUnoEsIgualAlNumero

	Assert that: II / I isEqualTo: II.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'WB 8/28/2021 17:56:18'!
test11UnoDivididoUnoEsIgualAUno
	Assert that: I / I isEqualTo: I.! !

!NumerosNaturalesTest class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:59'!
test12DivisionNoSoportaDividirPorUnNumeroMayor

	Assert should: [ III /  IIII ] signal: Error withDescription: II descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	
	Assert should: [ I /  II] signal: Error withDescription: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
! !
