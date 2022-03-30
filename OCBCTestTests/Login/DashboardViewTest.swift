//
//  DashboardViewTest.swift
//  OCBCTestTests
//
//  Created by Rajesh on 30/3/22.
//

import XCTest
@testable import OCBCTest

class DashboardViewTest: XCTestCase {
    var view: DashboardViewController!
    var presenter: DashboardPresenterMock!
    
    override func setUpWithError() throws {
        presenter = DashboardPresenterMock()
        guard let dashboardView = DashboardConfigurator.shared.createDashboard(userName: "Test") as? DashboardViewController else { return }
        view = dashboardView
        view.presenter = presenter
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        presenter = nil
        view = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testDashBoardViewMethod() {
        XCTAssertNotNil(view)
        view.myTableView = UITableView()
        view.myTableView?.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardTableViewCell")
        view.myTableView?.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
        view.myTableView?.cellForRow(at: IndexPath.init(row: 1, section: 0))
        let date = view.dateFormtor(date: "2022-03-27T17:19:48.265Z")
        XCTAssertNotNil(date)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
