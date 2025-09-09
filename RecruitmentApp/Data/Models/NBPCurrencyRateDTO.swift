//
//  NBPCurrencyRateDTO.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

struct NBPCurrencyRateResponseDTO: Codable {
    let table: String
    let currency: String
    let code: String
    let rates: [NBPCurrencyRateDTO]
}

struct NBPCurrencyRateDTO: Codable {
    let no: String
    let effectiveDate: Date
    let mid: Double
}

extension NBPCurrencyRateResponseDTO {
    func toDomainExchangeRates() -> [ExchangeRate] {
        return rates.map { rate in
            ExchangeRate(
                mid: rate.mid,
                effectiveDate: rate.effectiveDate,
                tableNo: rate.no
            )
        }
    }
}
