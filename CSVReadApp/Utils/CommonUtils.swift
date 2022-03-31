//
//  CommonUtils.swift
//  CSVReadApp
//
//  Created by C879403 on 31/03/22.
//

import Foundation
import UIKit

final class CommonUtils {
    
    private init() {}
    static let shared = CommonUtils()
    
    func convertDateFormater(strDT: String, givenFormat: String, expectedFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        guard let date = dateFormatter.date(from: strDT) else { return nil }
        dateFormatter.dateFormat = expectedFormat
        return  dateFormatter.string(from: date)
    }
}

protocol AddActivityIndicator {
    var activity: UIActivityIndicatorView? { get set }
    func showActivityIndicator()
    func hideActivity()
}
