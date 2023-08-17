//
//  SchoolListViewModelTests.swift
//  20230615-RakinMunjid-NYCSchoolsTests
//
//  Created by Rakin Munjid on 8/17/23.
//

import Foundation

import XCTest
@testable import _0230615_RakinMunjid_NYCSchools

// Mock implementation for NetworkServiceType
class MockNetworkService: NetworkServiceType {

    var mockSchoolRecords: [NYCResource]?
    var mockError: Error?
    var mockSchoolData: [SchoolSATData]?

    var isFetchSchoolRecordsCalled = false
    var isFetchSchoolDataCalled = false

    func fetchSchoolRecords(completion: @escaping ([NYCResource]?, Error?) -> Void) {
        isFetchSchoolDataCalled = true
        completion(mockSchoolRecords, mockError)
    }

    func fetchSchoolData(completion: @escaping (Result<[SchoolSATData], Error>) -> Void) {
        isFetchSchoolDataCalled = true
        if let mockData = mockSchoolData {
            completion(.success(mockData))
        } else if let mockError = mockError {
            completion(.failure(mockError))
        }
    }
}

class SchoolListViewModelTests: XCTestCase {

    var viewModel: SchoolListViewModel!
    var mockService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        viewModel = SchoolListViewModel(networkService: mockService)
    }

    func testFetchRecordsSuccess() {
        let mockRecord = NYCResource(dbn: "", name: "Test School", borough: "Test Borough", overview: "", website: "")
        mockService.mockSchoolRecords = [mockRecord]

        viewModel.fetchRecords { records, error in
            XCTAssertNotNil(records)
            XCTAssertEqual(records?.first?.name, "Test School")
            XCTAssertEqual(records?.first?.borough, "Test Borough")
            XCTAssertNil(error)
        }
    }

    func testFetchRecordsFailure() {
        let mockError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Fetch failed"])
        mockService.mockError = mockError

        viewModel.fetchRecords { records, error in
            XCTAssertNil(records)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, "Fetch failed")
        }
    }

    func testFilterAlphabetically() {
        let recordA = NYCResource(dbn: "", name: "A School", borough: "A Borough", overview: "", website: "")
        let recordB = NYCResource(dbn: "", name: "B School", borough: "B Borough", overview: "", website: "")

        viewModel.records = [recordB, recordA]
        viewModel.originalRecords = [recordB, recordA]

        viewModel.filterAlphabetically()

        XCTAssertEqual(viewModel.records.first?.name, "A School")
    }

    func testApplyBoroughFilter() {
        let recordA = NYCResource(dbn: "", name: "A School", borough: "A Borough", overview: "", website: "")
        let recordB = NYCResource(dbn: "", name: "B School", borough: "B Borough", overview: "", website: "")
        viewModel.records = [recordA, recordB]
        viewModel.originalRecords = [recordA, recordB]

        viewModel.applyBoroughFilter(borough: "A Borough")

        XCTAssertEqual(viewModel.records.count, 1)
        XCTAssertEqual(viewModel.records.first?.borough, "A Borough")
    }

    func testClearFilter() {
        let recordA = NYCResource(dbn: "", name: "A School", borough: "A Borough", overview: "", website: "")
        let recordB = NYCResource(dbn: "", name: "B School", borough: "B Borough", overview: "", website: "")
        viewModel.records = [recordA]
        viewModel.originalRecords = [recordA, recordB]

        viewModel.clearFilter()

        XCTAssertEqual(viewModel.records.count, 2)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
}

