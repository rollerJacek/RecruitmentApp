//
//  Date+Extensions.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 08/09/2025.
//

import Foundation

extension Date {
    static let nbpDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var nbpFormatted: String {
        return Date.nbpDateFormatter.string(from: self)
    }
}
