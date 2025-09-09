//
//  NBPCurrencyRateResponseDTO+Mock.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Foundation
@testable import RecruitmentApp

extension NBPCurrencyRateResponseDTO {
    static var mock: NBPCurrencyRateResponseDTO {
        return NBPCurrencyRateResponseDTO(
            table: "A", currency: "dolar amerykański", code: "USD",
            rates: [
                NBPCurrencyRateDTO(
                    no: "173/A/NBP/2025", effectiveDate: Date(), mid: 3.6214)
            ])
    }
}
