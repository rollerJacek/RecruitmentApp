//
//  ExchangeRate+Mock.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Foundation
@testable import RecruitmentApp

extension ExchangeRate {
    static func mock(
        mid: Double = 3.6214,
        effectiveDate: Date = Date(),
        tableNo: String = "173/A/NBP/2025"
    ) -> ExchangeRate {
        return ExchangeRate(
            mid: mid,
            effectiveDate: effectiveDate,
            tableNo: tableNo
        )
    }
}
