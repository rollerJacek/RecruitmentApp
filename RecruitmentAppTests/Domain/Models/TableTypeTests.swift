//
//  TableTypeTests.swift
//  RecruitmentApp
//
//  Created by Jacek Stąporek on 09/09/2025.
//

import Testing
@testable import RecruitmentApp

@Suite("Table Type Tests")
struct TableTypeTests {
    
    @Test("Table type raw values are correct")
    func tableTypeRawValues() {
        #expect(TableType.A.rawValue == "A")
        #expect(TableType.B.rawValue == "B")
    }
    
    @Test("Table type from raw value works correctly")
    func tableTypeFromRawValue() {
        #expect(TableType(rawValue: "A") == .A)
        #expect(TableType(rawValue: "B") == .B)
        #expect(TableType(rawValue: "C") == nil)
    }
    
    @Test("All cases contains correct table types")
    func allCasesContainment() {
        let allCases = TableType.allCases
        #expect(allCases.count == 2)
        #expect(allCases.contains(.A))
        #expect(allCases.contains(.B))
    }
}
