//
//  CurrencyTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
@testable import RecruitmentApp

@Suite("Currency Model Tests")
struct CurrencyTests {
    
    @Test("Currency equality works correctly")
    func currencyEquality() {
        let currency1 = Currency.mock(code: "USD", tableType: .A)
        let currency2 = Currency.mock(code: "USD", tableType: .A)
        let currency3 = Currency.mock(code: "EUR", tableType: .A)
        let currency4 = Currency.mock(code: "USD", tableType: .B)

        #expect(currency1 == currency2)
        #expect(currency1 != currency3)
        #expect(currency1 != currency4)
    }
    
    @Test("Currency hashing works correctly")
    func currencyHashing() {
        let currency1 = Currency.mock(code: "USD", tableType: .A)
        let currency2 = Currency.mock(code: "USD", tableType: .A)

        let set = Set([currency1, currency2])

        #expect(set.count == 1)
    }
    
    @Test("Currency with different table types have different hashes")
    func currencyDifferentTableTypes() {
        let currencyA = Currency.mock(code: "USD", tableType: .A)
        let currencyB = Currency.mock(code: "USD", tableType: .B)

        let set = Set([currencyA, currencyB])

        #expect(set.count == 2)
        #expect(currencyA != currencyB)
    }
}
