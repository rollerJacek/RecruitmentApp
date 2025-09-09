//
//  NBPCurrencyTableDTO.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

struct NBPCurrencyTableDTO: Codable {
    let table: String
    let no: String
    let effectiveDate: Date
    let rates: [NBPRateDTO]
}

struct NBPRateDTO: Codable {
    let currency: String
    let code: String
    let mid: Double
}

extension Array where Element == NBPCurrencyTableDTO {
    func toDomainCurrency() -> [Currency] {
        return self.flatMap { response in
            let tableType = TableType(rawValue: response.table.uppercased()) ?? .A
            return response.rates.map { rate in
                Currency(
                    code: rate.code,
                    name: rate.currency,
                    currentRate: rate.mid,
                    effectiveDate: response.effectiveDate,
                    tableType: tableType,
                    tableNo: response.no
                )
            }
        }
    }
}
