//
//  SATModel.swift
//  20230615-RakinMunjid-NYCSchools
//
//  Created by Rakin Munjid on 8/17/23.
//

import Foundation

public struct SchoolSATData: Codable {
    let dbn: String?
    let schoolName: String?
    let numOfSatTestTakers: String?
    let satCriticalReadingAvgScore: String?
    let satMathAvgScore: String?
    let satWritingAvgScore: String?

    private enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}
