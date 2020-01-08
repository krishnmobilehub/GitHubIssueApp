//
// IssueDetailViewController.swift
// GitHubIssueApp
//

import UIKit
import RxSwift
import RxCocoa

class IssueDetailViewController: BaseViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var viewModel: IssueDetailViewModel?
    
    //MARK:- View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.viewModel?.getIssueDetails()
        // Do any additional setup after loading the view.
    }
}

//MARK: - Setup Methods
extension IssueDetailViewController {
    
    private func setup() {
        
        self.setupUI()
        
        if let viewModel = self.viewModel {
            self.setupBinding(with: viewModel)
        }
        
        self.title = MessageConstant.comments
        self.detailTableView.tableFooterView = UIView()
        self.detailTableView.separatorColor = .darkGray
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkChangeHandle), name: .networkChangedNotification, object: nil)
    }
    
    private func setupUI() {
        self.detailTableView.tableFooterView = UIView()
        
        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backArrow"), style: .plain, target: self, action: #selector(leftButtonTappedwithDemo))
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
    }

    @objc func networkChangeHandle() {
        self.viewModel?.getIssueDetails()
    }
    
    @objc func leftButtonTappedwithDemo() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupBinding(with viewModel: IssueDetailViewModel) {
        
        self.viewModel?.issueDetailTableData
            .bind(to: detailTableView.rx.items(cellIdentifier: String(describing: IssueDetailTableViewCell.self), cellType: IssueDetailTableViewCell.self)) { row, element, cell in
                cell.configure(with: element)
        }
        .disposed(by: disposeBag)
        
        viewModel.alertDialog.observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (title, message) in
                guard let `self` = self else {return}
                let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                    self.viewModel?.popToIssueList.onNext(())
                }
                showAlertDialogueWithAction(title: title, withMessage: message, withActions: okAction, viewController: self)
            }).disposed(by: disposeBag)
    }
}
