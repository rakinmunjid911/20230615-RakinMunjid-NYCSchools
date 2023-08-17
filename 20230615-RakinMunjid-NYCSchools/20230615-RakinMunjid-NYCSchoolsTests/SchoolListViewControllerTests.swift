//
//  SchoolListViewControllerTests.swift
//  20230615-RakinMunjid-NYCSchoolsTests
//
//  Created by Rakin Munjid on 8/17/23.
//

import Foundation

import XCTest
@testable import _0230615_RakinMunjid_NYCSchools

class SchoolListViewControllerTests: XCTestCase {

    var subject: SchoolListViewController!
    var mockViewModel: MockSchoolListViewModel!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockViewModel = MockSchoolListViewModel()
        mockNetworkService = MockNetworkService()
        subject = SchoolListViewController(viewModel: mockViewModel, networkService: mockNetworkService)
        _ = subject.view // To load the view
    }

    override func tearDown() {
        subject = nil
        mockViewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testViewDidLoadSetsTableViewDataSourceAndDelegate() {
        XCTAssertTrue(subject.tableView.dataSource is SchoolListViewController)
        XCTAssertTrue(subject.tableView.delegate is SchoolListViewController)
    }

    func testNumberOfRowsInSection() {
        mockViewModel.records = [NYCResource(dbn: "", name: "School 1", borough: "", overview: "", website: ""), NYCResource(dbn: "", name: "School 2", borough: "", overview: "", website: "")]
        XCTAssertEqual(subject.tableView.numberOfRows(inSection: 0), 2)
    }

    func testCellForRowAtIndexPath() {
        mockViewModel.records = [NYCResource(dbn: "", name: "Test School", borough: "", overview: "", website: "")]
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "Test School")
    }

    func testSelectRowFiresNetworkRequest() {
        let indexPath = IndexPath(row: 0, section: 0)
        subject.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        subject.tableView(subject.tableView, didSelectRowAt: indexPath)
        XCTAssertTrue(mockNetworkService.isFetchSchoolDataCalled)
    }

}

// Mock classes

class MockSchoolListViewModel: SchoolListViewModel {
    var isFetchRecordsCalled = false

    override func fetchRecords(completion: @escaping ([NYCResource]?, Error?) -> Void) {
        isFetchRecordsCalled = true
        completion([NYCResource(dbn: "", name: "Mock School", borough: "", overview: "", website: "")], nil)
    }
}

