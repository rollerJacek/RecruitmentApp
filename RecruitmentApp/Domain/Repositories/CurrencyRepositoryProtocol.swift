//
//  CurrencyRepositoryProtocol.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

protocol CurrencyRepositoryProtocol {
    func fetchAllAvailableCurrencies() async throws -> [Currency]
    func fetchCurrencyHistory(for currencyCode: String, table: TableType, lastDays: Int) async throws -> [ExchangeRate]
}
