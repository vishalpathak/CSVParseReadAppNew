//
//  ViewController.swift
//  CSVReadApp
//
//  Created by C879403 on 31/03/22.
//

import UIKit

class CSVHomeViewController: UIViewController, AddActivityIndicator {
    var csvViewModelArray = [CSVUserViewModel]()
    fileprivate lazy var tableInfoList: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(UserTableViewCell.self, forCellReuseIdentifier: cellId)
        return tb
    }()
    var activity: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIForViews()
        getDataFromViewModel()
    }
    
    // MARK: - SetUp UI
    func setUpUIForViews() -> Void {
        view.backgroundColor = .white
        view.addSubview(tableInfoList)
        let views = ["table":self.tableInfoList]
        var constraints =  NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[table]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllTop, metrics: nil, views: views)
        self.view.addConstraints(constraints)
        let stringConstraint = "V:|-0-[table]-0-|"
        constraints =  NSLayoutConstraint.constraints(withVisualFormat: stringConstraint, options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
        self.view.addConstraints(constraints)
    }
    
    // MARK: - get data from viewModel
    func getDataFromViewModel() {
        let csvData = CSVUsersViewModel()
        showActivityIndicator()
        csvData.getData { [weak self] csvData, requestError in
            if let error = requestError {
                DispatchQueue.main.async {
                    self?.alertView(message: error.localizedDescription, title: emptyString)
                }
                return
            }
            guard let allData = csvData else { return }
            self?.csvViewModelArray = allData
            DispatchQueue.main.async {
                self?.tableInfoList.reloadData()
                self?.hideActivity()
            }
        }
    }
    
    // MARK: - Show Activity
    func showActivityIndicator() {
        activity = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activity = UIActivityIndicatorView(style: .medium)
        } else { // Fallback on earlier versions
            activity = UIActivityIndicatorView(style: .whiteLarge)
        }
        activity?.center = view.center
        activity?.color = .red
        activity?.hidesWhenStopped = true
        guard let actView = activity else { return }
        view.addSubview(actView)
        actView.startAnimating()
    }
    
    func hideActivity() {
        activity?.stopAnimating()
    }
}

// MARK: - TableView DataSource and Delegate
extension CSVHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return csvViewModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableInfoList.dequeueReusableCell(withIdentifier: cellId) as? UserTableViewCell  else {
            return UserTableViewCell()
        }
        let obj = csvViewModelArray[indexPath.row]
        cell.userInfoViewModel = obj
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
