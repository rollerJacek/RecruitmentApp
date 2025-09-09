//
//  NBPAPIServiceTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
import Foundation
@testable import RecruitmentApp

@Suite("NBP API Service Tests")
struct NBPAPIServiceTests {
    
    @Test("Currency table endpoint URL generation is correct")
    func currencyTableEndpoints() {
        #expect(NBPEndpoint.currencyTablesA.url == "https://api.nbp.pl/api/exchangerates/tables/a/")
        #expect(NBPEndpoint.currencyTablesB.url == "https://api.nbp.pl/api/exchangerates/tables/b/")
    }
    
    @Test("Currency rate history endpoint URL generation is correct")
    func currencyRateHistoryEndpoint() {
        let endpoint = NBPEndpoint.currencyRateHistory(table: .A, code: "USD", days: 14)
        #expect(endpoint.url == "https://api.nbp.pl/api/exchangerates/rates/a/usd/last/14/")
    }
    
    @Test("Currency rate history endpoint handles different parameters")
    func currencyRateHistoryDifferentParameters() {
        let endpoint = NBPEndpoint.currencyRateHistory(table: .B, code: "EUR", days: 30)
        #expect(endpoint.url == "https://api.nbp.pl/api/exchangerates/rates/b/eur/last/30/")
    }
    
    @Test("Currency rate history endpoint converts code to lowercase")
    func currencyCodeLowercase() {
        let endpoint = NBPEndpoint.currencyRateHistory(table: .A, code: "USD", days: 7)
        #expect(endpoint.url.contains("/usd/"))
        #expect(!endpoint.url.contains("/USD/"))
    }
}
