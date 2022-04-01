//
//  Constants.swift
//  CSVReadApp
//
//  Created by C879403 on 31/03/22.
//

import Foundation

let fileName = "issues"
let emptyString = ""
let defaultZeroValue = 0
let givenDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
let expectedDateFormat = "dd MMM yyyy"

let dealayTime = 1.0
let csvErrorCode = 10
let csvErrorMessage = "something wrong"
let okTitle = "OK"

let userCellIdentifier = "userCellIdentifier"
let fullNameString = "Full Name: "
let dobString = "DOB: "
let issueCountTitle = "Issue Count: "
let navigationBarTitle = "All Users"
let cellAutoLayoutConstant = 16.0

typealias csvCompletion = (_ csvData: [CSVUserViewModel]?, _ requestError: Error?) -> ()

enum Delimiter: String {
    case comma = ","
    case pipe = "|"
}

enum FileExtesions: String {
    case csv = "csv"
    case json = "json"
}

let BaseUrlPath: URL? = {
    if let path = Bundle.main.url(forResource: fileName, withExtension: FileExtesions.csv.rawValue) {
        return path
    } else {
        return nil
    }
}()
