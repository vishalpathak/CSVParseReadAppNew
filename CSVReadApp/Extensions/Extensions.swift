//
//  Extensions.swift
//  CSVReadApp
//
//  Created by C879403 on 31/03/22.
//

import Foundation
import UIKit

extension DispatchQueue {
    static func backgroundTask(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}

extension String {
    func getStringDataFromUrl(stringURL: URL?) -> String? {
        //let fileURL = Bundle.main.url(forResource: stringURL, withExtension: extesion)
        if let url = stringURL {
            do {
                return try String(contentsOf: url, encoding: .utf8)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}

extension UIViewController {
    func alertView(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: okTitle, style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
