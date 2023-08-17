//
//  DetailViewModel.swift
//  20230615-RakinMunjid-NYCSchools
//
//  Created by Rakin Munjid on 8/17/23.
//

import Foundation

public class DetailViewModel {
    var satData: SchoolSATData?
    var schoolData: NYCResource?

    // Transformed properties for the UI
    var schoolName: String {
        satData?.schoolName ?? ""
    }

    var schoolOverview: String {
        schoolData?.overview ?? ""
    }

    var testTakersText: String {
        if let num = satData?.numOfSatTestTakers {
            return "Test Takers: \(num)"
        }
        return ""
    }

    var criticalReadingText: String {
        if let score = satData?.satCriticalReadingAvgScore {
            return "Critical Reading Avg. Score: \(score)"
        }
        return ""
    }

    var mathScoreText: String {
        if let score = satData?.satMathAvgScore {
            return "Math Avg. Score: \(score)"
        }
        return ""
    }

    var writingScoreText: String {
        if let score = satData?.satWritingAvgScore {
            return "Writing Avg. Score: \(score)"
        }
        return ""
    }
}
