//
//  BaseViewController.swift
//  CSVReadApp
//
//  Created by C879403 on 01/04/22.
//

import UIKit

class BaseViewController: UIViewController {

    var activity: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Show Activity
    func showActivityIndicator() {
        if #available(iOS 13.0, *) {
            activity = UIActivityIndicatorView(style: .medium)
        } else { // Fallback on earlier versions
            activity = UIActivityIndicatorView(style: .whiteLarge)
        }
        activity.center = view.center
        activity.color = .red
        activity.hidesWhenStopped = true
        view.addSubview(activity)
        activity.startAnimating()
    }
    
    func hideActivity() {
        activity.stopAnimating()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
