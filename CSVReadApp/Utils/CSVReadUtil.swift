//
//  CSVReadUtil.swift
//  CSVReadApp
//
//  Created by C879403 on 31/03/22.
//

import Foundation

protocol CSVReadUtil {
    func getAllRows(stringData:String)-> [String]
    func getAllFields(oldFromString: String) -> [String]
    func getAllValues(stringData: String) -> [CSVDataModel]?
}

extension CSVReadUtil {
    
    func getAllRows(stringData:String)-> [String] {
        var cleanFile = stringData
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile.components(separatedBy: "\n")
    }
    
    func getAllFields(oldFromString: String) -> [String] {
        let delimiter = "\t"
        var newString = oldFromString.replacingOccurrences(of: "\",\"", with: delimiter)
        newString = newString.replacingOccurrences(of: ",\"", with: delimiter)
        newString = newString.replacingOccurrences(of: "\",", with: delimiter)
        newString = newString.replacingOccurrences(of: "\"", with: "")
        return newString.components(separatedBy: delimiter)
    }
    
    func getAllValues(stringData: String) -> [CSVDataModel]? {
        var userArray = [CSVDataModel]()
        let rows = getAllRows(stringData: stringData)
        let columnTitles = getAllFields(oldFromString: rows.first!)
        let columnArr = columnTitles[0].components(separatedBy: Delimiter.comma.rawValue)
        for i in 0..<rows.count {
            if i != 0 {
                let obj = rows[i].components(separatedBy: Delimiter.comma.rawValue)
                if columnArr.count == obj.count {
                    let ct = Int(obj[2]) ?? 0
                    let firstName = obj[0]
                    let lastName = obj[1]
                    var objCSV = CSVDataModel(dob: emptyString, firstName: firstName, lastName: lastName, issueCount: ct)
                    if let dt = CommonUtils.shared.convertDateFormater(strDT: obj[3], givenFormat: givenDateFormat, expectedFormat: expectedDateFormat) {
                        objCSV.dob = dt
                    }
                    userArray.append(objCSV)
                }
            }
        }
        return userArray
    }
}

