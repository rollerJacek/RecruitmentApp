//
//  CurrencyRepository.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

final class CurrencyRepository: CurrencyRepositoryProtocol {
    private let apiService: NBPAPIServiceProtocol
    
    init(apiService: NBPAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchAllAvailableCurrencies() async throws -> [Currency] {
        async let tableAResult = apiService.fetchCurrencyTable(type: .A)
        async let tableBResult = apiService.fetchCurrencyTable(type: .B)
        
        var currencies: [Currency] = []
        
        do {
            let tablesA = try await tableAResult
            currencies.append(contentsOf: tablesA.toDomainCurrency())
        } catch {
            print("Failed to fetch table A: \(error)")
        }
        
        do {
            let tablesB = try await tableBResult
            currencies.append(contentsOf: tablesB.toDomainCurrency())
        } catch {
            print("Failed to fetch table B: \(error)")
        }
        
        if currencies.isEmpty {
            throw NetworkError.noData
        }
        
        return currencies.sorted { $0.code < $1.code }
    }
    
    func fetchCurrencyHistory(for currencyCode: String, table: TableType, lastDays: Int) async throws -> [ExchangeRate] {
        async let exchangeRateResult = try await apiService.fetchCurrencyRate(table: table, code: currencyCode, last: lastDays)
        return try await exchangeRateResult.toDomainExchangeRates()
    }
}
