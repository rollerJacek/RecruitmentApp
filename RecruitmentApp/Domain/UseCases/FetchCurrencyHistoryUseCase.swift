//
//  FetchCurrencyHistoryUseCase.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

protocol FetchCurrencyHistoryUseCaseProtocol {
    func execute(for currency: Currency, lastDays: Int) async throws -> [ExchangeRate]
}

final class FetchCurrencyHistoryUseCase: FetchCurrencyHistoryUseCaseProtocol {
    private let repository: CurrencyRepositoryProtocol
    
    init(repository: CurrencyRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(for currency: Currency, lastDays: Int = Constants.UI.defaultHistoryDays) async throws -> [ExchangeRate] {
        let history = try await repository.fetchCurrencyHistory(
            for: currency.code,
            table: currency.tableType,
            lastDays: lastDays
        )

        return history.sorted { $0.effectiveDate > $1.effectiveDate }
    }
}
