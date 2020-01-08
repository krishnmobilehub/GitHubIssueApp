//
//  UIStoryboard+Controllers.swift
//  GitHubIssueApp
//

import Foundation
import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIStoryboard {
    var issueListViewController: IssueListViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: IssueListViewController.self)) as? IssueListViewController else {
            fatalError(String(describing: IssueListViewController.self) + "\(NSLocalizedString(MessageConstant.couldFoundStoryboard, comment: ""))")
        }
        return viewController
    }

    var issueDetailViewController: IssueDetailViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: IssueDetailViewController.self)) as? IssueDetailViewController else {
            fatalError(String(describing: IssueListViewController.self) + "\(NSLocalizedString(MessageConstant.couldFoundStoryboard, comment: ""))")
        }
        return viewController
    }
    
}
