//
// BaseViewController.swift
// GitHubIssueApp
//

import UIKit
import RxSwift
import RxCocoa

//MARK:- BaseViewController
class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
