//
//  _0230615_RakinMunjid_NYCSchoolsUITestsLaunchTests.swift
//  20230615-RakinMunjid-NYCSchoolsUITests
//
//  Created by Rakin Munjid on 8/15/23.
//

import XCTest

class _0230615_RakinMunjid_NYCSchoolsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
