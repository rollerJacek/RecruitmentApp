//
//  Currency.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

struct Currency: Identifiable, Hashable {
    let id = UUID()
    let code: String
    let name: String
    let currentRate: Double
    let effectiveDate: Date
    let tableType: TableType
    let tableNo: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
        hasher.combine(tableType)
    }
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.code == rhs.code && lhs.tableType == rhs.tableType
    }
}
