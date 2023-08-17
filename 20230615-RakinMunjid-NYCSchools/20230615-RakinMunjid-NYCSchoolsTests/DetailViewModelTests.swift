//
//  DetailViewModelTests.swift
//  20230615-RakinMunjid-NYCSchoolsTests
//
//  Created by Rakin Munjid on 8/17/23.
//

import Foundation

import XCTest
@testable import _0230615_RakinMunjid_NYCSchools

class DetailViewModelTests: XCTestCase {

    var viewModel: DetailViewModel!

    override func setUp() {
        super.setUp()
        viewModel = DetailViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testSchoolName() {
        let mockData = SchoolSATData(dbn: "", schoolName: "Test School", numOfSatTestTakers: "", satCriticalReadingAvgScore: "", satMathAvgScore: "", satWritingAvgScore: "")
        viewModel.satData = mockData
        XCTAssertEqual(viewModel.schoolName, "Test School")
    }

    func testSchoolOverview() {
      //  let mockData = NYCResource(overview: "Test Overview")
        let mockData = NYCResource(dbn: "", name: "", borough: "", overview: "Test Overview", website: "")
        viewModel.schoolData = mockData
        XCTAssertEqual(viewModel.schoolOverview, "Test Overview")
    }

    func testTestTakersText() {
        let mockData = SchoolSATData(dbn: "", schoolName: "", numOfSatTestTakers: "500", satCriticalReadingAvgScore: "", satMathAvgScore: "", satWritingAvgScore: "")
        viewModel.satData = mockData
        XCTAssertEqual(viewModel.testTakersText, "Test Takers: 500")
    }

    func testCriticalReadingText() {
        let mockData = SchoolSATData(dbn: "", schoolName: "", numOfSatTestTakers: "", satCriticalReadingAvgScore: "500", satMathAvgScore: "", satWritingAvgScore: "")
        viewModel.satData = mockData
        XCTAssertEqual(viewModel.criticalReadingText, "Critical Reading Avg. Score: 500")
    }

    func testMathScoreText() {
        let mockData = SchoolSATData(dbn: "", schoolName: "", numOfSatTestTakers: "", satCriticalReadingAvgScore: "", satMathAvgScore: "600", satWritingAvgScore: "")
        viewModel.satData = mockData
        XCTAssertEqual(viewModel.mathScoreText, "Math Avg. Score: 600")
    }

    func testWritingScoreText() {
        let mockData = SchoolSATData(dbn: "", schoolName: "", numOfSatTestTakers: "", satCriticalReadingAvgScore: "", satMathAvgScore: "", satWritingAvgScore: "570")
        viewModel.satData = mockData
        XCTAssertEqual(viewModel.writingScoreText, "Writing Avg. Score: 570")
    }
}
