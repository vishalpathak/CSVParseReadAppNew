//
//  CSVUserViewModel.swift
//  CSVReadApp
//
//  Created by C879403 on 31/03/22.
//

import Foundation

struct CSVUserViewModel {
    let fullName: String?
    let dob: String?
    let issueCount: String?
    
    init(data: CSVDataModel) {
        self.fullName = ("\(fullNameString)\(data.firstName ?? emptyString) \(data.lastName ?? emptyString)")
        self.dob = ("\(dobString)\(data.dob ?? emptyString)")
        self.issueCount = ("\(issueCountTitle)\(data.issueCount ?? 0)")
    }
}

protocol GetCSVData {
    func getData(csvCompletion: @escaping csvCompletion)
}
class CSVUsersViewModel: CSVReadUtil, GetCSVData {
    
    func mapDataModelToViewModel(model: [CSVDataModel]?) -> [CSVUserViewModel]? {
        if let model = model {
            let modelArray = model.map { (obj: CSVDataModel) -> CSVUserViewModel in
                return CSVUserViewModel(data: obj)
            }
            return modelArray
        } else {
            return nil
        }
    }
    
    func getData(csvCompletion: @escaping csvCompletion) {
        var stringCSV: String = emptyString
        DispatchQueue.backgroundTask(delay: dealayTime) {
            guard let strData = stringCSV.getStringDataFromUrl(stringURL: BaseUrlPath) else { return }
            stringCSV = strData
        } completion: {
            let dataModel = self.getAllValues(stringData: stringCSV)
            guard let viewModelData = self.mapDataModelToViewModel(model: dataModel) else {
                let err = NSError(domain: csvErrorMessage, code: csvErrorCode, userInfo: nil)
                csvCompletion(nil, err)
                return
            }
            csvCompletion(viewModelData, nil)
        }
    }
}
