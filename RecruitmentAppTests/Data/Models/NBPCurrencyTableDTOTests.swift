//
//  NBPCurrencyTableDTOTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
import Foundation
@testable import RecruitmentApp

@Suite("NBP Currency Table DTO Tests")
struct NBPCurrencyTableDTOTests {
    
    @Test("Converts DTO to domain currencies correctly")
    func toDomainCurrenciesConversion() {
        let effectiveDate = Date()
        let tableDTO = [NBPCurrencyTableDTO(
            table: "A",
            no: "173/A/NBP/2025",
            effectiveDate: effectiveDate,
            rates: [
                NBPRateDTO(currency: "dolar amerykański", code: "USD", mid: 3.6214),
                NBPRateDTO(currency: "euro", code: "EUR", mid: 4.2484),
                NBPRateDTO(currency: "funt szterling", code: "GBP", mid: 4.8936)
            ]
        )]

        let currencies = tableDTO.toDomainCurrency()

        #expect(currencies.count == 3)
        
        let usd = currencies.first { $0.code == "USD" }
        #expect(usd != nil)
        #expect(usd?.name == "dolar amerykański")
        #expect(usd?.currentRate == 3.6214)
        #expect(usd?.tableType == .A)
        #expect(usd?.tableNo == "173/A/NBP/2025")
        #expect(usd?.effectiveDate == effectiveDate)
        
        let eur = currencies.first { $0.code == "EUR" }
        #expect(eur?.currentRate == 4.2484)
        
        let gbp = currencies.first { $0.code == "GBP" }
        #expect(gbp?.currentRate == 4.8936)
    }
    
    @Test("Handles table type B correctly")
    func tableTypeBConversion() {
        let tableDTO = [NBPCurrencyTableDTO(
            table: "B",
            no: "36/B/NBP/2025",
            effectiveDate: Date(),
            rates: [
                NBPRateDTO(currency: "afgani (Afganistan)", code: "AFN", mid: 0.051234)
            ]
        )]

        let currencies = tableDTO.toDomainCurrency()

        #expect(currencies.count == 1)
        #expect(currencies.first?.tableType == .B)
    }
    
    @Test("Handles unknown table type gracefully")
    func unknownTableTypeDefaultsToA() {
        let tableDTO = [NBPCurrencyTableDTO(
            table: "X",
            no: "123/X/NBP/2025",
            effectiveDate: Date(),
            rates: [
                NBPRateDTO(currency: "test currency", code: "TST", mid: 1.0)
            ]
        )]

        let currencies = tableDTO.toDomainCurrency()

        #expect(currencies.count == 1)
        #expect(currencies.first?.tableType == .A)
    }
    
    @Test("Handles empty rates array")
    func emptyRatesArray() {
        let tableDTO = [NBPCurrencyTableDTO(
            table: "A",
            no: "173/A/NBP/2025",
            effectiveDate: Date(),
            rates: []
        )]

        let currencies = tableDTO.toDomainCurrency()

        #expect(currencies.isEmpty)
    }
}
