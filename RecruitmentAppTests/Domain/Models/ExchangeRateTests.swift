//
//  ExchangeRateTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
@testable import RecruitmentApp

@Suite("Exchange Rate Model Tests")
struct ExchangeRateTests {
    
    @Test("Rate with exactly 10% difference is considered significant")
    func exactlyTenPercentDifference() {
        let rate = ExchangeRate.mock(mid: 3.9836)
        let currentRate = 3.6214

        let result = rate.isSignificantlyDifferent(from: currentRate)

        #expect(result == true)
    }
    
    @Test("Rate with small difference is not significant")
    func smallDifferenceNotSignificant() {
        let rate = ExchangeRate.mock(mid: 3.6626)
        let currentRate = 3.6214

        let result = rate.isSignificantlyDifferent(from: currentRate)

        #expect(result == false)
    }
    
    @Test("Rate with real NBP data differences")
    func realNBPDataDifferences() {
        let currentRate = 3.6214
        let historicalRate = ExchangeRate.mock(mid: 3.6278)

        let result = historicalRate.isSignificantlyDifferent(from: currentRate)

        #expect(result == false)
    }
    
    @Test("Rate with negative large difference is significant")
    func negativeLargeDifferenceSignificant() {
        let rate = ExchangeRate.mock(mid: 3.2)
        let currentRate = 3.6214

        let result = rate.isSignificantlyDifferent(from: currentRate)

        #expect(result == true)
    }
    
    @Test("Rate with very large difference is significant")
    func veryLargeDifferenceSignificant() {
        let rate = ExchangeRate.mock(mid: 4.5)
        let currentRate = 3.6214

        let result = rate.isSignificantlyDifferent(from: currentRate)

        #expect(result == true)
    }
}
