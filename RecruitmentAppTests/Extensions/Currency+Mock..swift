//
//  Currency+Mock..swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Foundation
@testable import RecruitmentApp

extension Currency {
    static func mock(
        code: String = "USD",
        name: String = "dolar amerykański",
        currentRate: Double = 3.6214,
        effectiveDate: Date = Date(),
        tableType: TableType = .A,
        tableNo: String = "173/A/NBP/2025"
    ) -> Currency {
        return Currency(
            code: code,
            name: name,
            currentRate: currentRate,
            effectiveDate: effectiveDate,
            tableType: tableType,
            tableNo: tableNo
        )
    }
}
