//
//  DashBoardModel.swift
//  Covid_break_Out
//
//  Created by JHA Nilesh Kumar on 25/03/20.
//  Copyright © 2020 JHA Nilesh Kumar. All rights reserved.
//

import Foundation


struct DashBoardModel: Codable {
    let casesTimeSeries: [CasesTimeSery]?
    let keyValues: [KeyValue]?
    let statewise: [Statewise]?
    let tested: [Tested]?

    enum CodingKeys: String, CodingKey {
        case casesTimeSeries = "cases_time_series"
        case keyValues = "key_values"
        case statewise, tested
    }
}

// MARK: - CasesTimeSery
struct CasesTimeSery: Codable {
    let  date: String?
    let dailyconfirmed,dailydeceased, dailyrecovered : String
    let totalconfirmed, totaldeceased, totalrecovered: String?
}

// MARK: - KeyValue
struct KeyValue: Codable {
    let confirmeddelta, deceaseddelta: String?
    let lastupdatedtime: String?
    let recovereddelta, statesdelta: String?
}


// MARK: - Statewise
struct Statewise: Codable {
    let active, confirmed, deaths: String?
    let lastupdatedtime: String?
    let recovered : String?
    let state : String
}

// MARK: - Tested
struct Tested: Codable {
    let source, totalindividualstested, totalpositivecases, totalsamplestested: String?
    let updatetimestamp: String?
}
