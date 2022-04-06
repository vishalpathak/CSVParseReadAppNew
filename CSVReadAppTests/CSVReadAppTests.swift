//
//  CSVReadAppTests.swift
//  CSVReadAppTests
//
//  Created by C879403 on 31/03/22.
//

import XCTest
@testable import CSVReadApp

class CSVReadAppTests: XCTestCase {

    private var csvUserViewModel: CSVUsersViewModel!
    override func setUpWithError() throws {
        csvUserViewModel = CSVUsersViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        csvUserViewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDataInfoModel() {
        //Model Object for failing test case
        let objCsv = CSVDataModel(dob: "2001-04-20T00:00:00", firstName: "john", lastName: "john", issueCount: 4)
        let objViewModelCsv = CSVUserViewModel(data: objCsv)
        guard let first = objCsv.firstName, let lastN = objCsv.lastName, let full = objViewModelCsv.fullName else { return }
        XCTAssertEqual(full, "Full Name: \(first) \(lastN)")
        XCTAssertEqual(objViewModelCsv.dob!, "DOB: 2001-04-20T00:00:00")
    }
    
    func testStringData() {
        let strData = emptyString.getStringDataFromUrl(stringURL: BaseUrlPath)
        XCTAssertNotNil(strData)
    }
    
    func testConvertDateFormatter() {
        let expectedDate = "02 Jan 1978"
        let givenDateStr = CommonUtils.convertDateFormater(strDT: "1978-01-02T00:00:00", givenFormat: givenDateFormat, expectedFormat: expectedDateFormat)
        XCTAssertEqual(givenDateStr, expectedDate)
    }
    
    func testModelMapping() {
        let objCsv1 = CSVDataModel(dob: "2001-04-20T00:00:00", firstName: "john", lastName: "john", issueCount: 4)
        let objCsv2 = CSVDataModel(dob: "1950-11-12T00:00:00", firstName: "Fiona", lastName: "de Vries", issueCount: 7)
        let csvModel = [objCsv1, objCsv2]
        let csvViewModel = csvUserViewModel.mapDataModelToViewModel(model: csvModel)
        XCTAssertNotNil(csvViewModel)
    }
    
    func testCSVModelData() {
        let expectation = expectation(description: "callback called")
        csvUserViewModel.getData { csvData, requestError in
            XCTAssertNotNil(csvData)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}

class TestCSVConvertUtil: XCTestCase, CSVReadUtil {
    
    func testCSVDataModel() {
        let objCsv = CSVDataModel(dob: "2001-04-20T00:00:00", firstName: "Theo", lastName: "Jansen", issueCount: 5)
        guard let strData = emptyString.getStringDataFromUrl(stringURL: BaseUrlPath) else { return }
        let dataModel = self.getAllValues(stringData: strData)!
        let firstN = dataModel[0].firstName
        XCTAssertEqual(objCsv.firstName, firstN)
    }
}
    
