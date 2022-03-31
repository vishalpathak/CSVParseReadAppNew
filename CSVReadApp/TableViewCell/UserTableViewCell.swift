//
//  UserTableViewCell.swift
//  CSVRead
//
//  Created by C879403 on 30/03/22.
//

import Foundation
import UIKit

class UserTableViewCell : UITableViewCell {
    fileprivate let userFullName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black
        name.numberOfLines = 0
        name.font = UIFont.boldSystemFont(ofSize: 20.0)
        return name
    }()
    
    fileprivate let issueCount: UILabel = {
        let issue = UILabel()
        issue.translatesAutoresizingMaskIntoConstraints = false
        issue.textColor = .black
        issue.numberOfLines = 0
        issue.font = UIFont.boldSystemFont(ofSize: 16.0)
        return issue
    }()
    
    fileprivate let userDOB: UILabel = {
        let dob = UILabel()
        dob.translatesAutoresizingMaskIntoConstraints = false
        dob.textColor = .black
        dob.numberOfLines = 0
        dob.font = UIFont.boldSystemFont(ofSize: 16.0)
        return dob
    }()
    
    var userInfoViewModel: CSVUserViewModel? {
        didSet{
            userFullName.text = userInfoViewModel?.fullName
            issueCount.text = userInfoViewModel?.issueCount
            userDOB.text = userInfoViewModel?.dob
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(userFullName)
        addSubview(issueCount)
        addSubview(userDOB)
        setUpAutoLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAutoLayOut() {
        let constraints = [userFullName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                           userFullName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           userFullName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                           issueCount.topAnchor.constraint(equalTo: userFullName.bottomAnchor, constant: 16),
                           issueCount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           issueCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                           userDOB.topAnchor.constraint(equalTo: issueCount.bottomAnchor, constant: 16),
                           userDOB.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           userDOB.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                           userDOB.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
