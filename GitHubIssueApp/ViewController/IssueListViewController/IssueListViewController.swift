//
// IssueListViewController.swift
// GitHubIssueApp
//

import UIKit
import RxSwift
import RxCocoa

class IssueListViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var issueListTableView: UITableView!
    
    var viewModel = IssueListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        if SharedPreferences.getDate() != self.viewModel.currentDate {
            self.viewModel.getIssue()
        } else {
            self.viewModel.fetchLocalData()
        }
        
    }
}

extension IssueListViewController {
    private func setup(){
        self.setupUI()
        self.setupBinding(with: self.viewModel)
        NotificationCenter.default.addObserver(self, selector: #selector(networkChangeHandle), name: .networkChangedNotification, object: nil)
    }
    
    @objc func networkChangeHandle() {
        if SharedPreferences.getDate() != self.viewModel.currentDate {
            self.viewModel.getIssue()
        }
    }
    
    private func setupUI() {
        self.title = MessageConstant.issueList
        self.issueListTableView.tableFooterView = UIView()
        self.issueListTableView.separatorColor = .darkGray
    }
    
    private func setupBinding(with viewModel: IssueListViewModel){
        
        self.viewModel.issueListData
            .bind(to: issueListTableView.rx.items(cellIdentifier: String(describing: IssueTableViewCell.self), cellType: IssueTableViewCell.self)) { row, element, cell in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
        
        issueListTableView.rx
            .willDisplayCell
            .filter({[weak self] (cell, indexPath) in
                guard let `self` = self else { return false }
                return (indexPath.row + 1) == self.issueListTableView.numberOfRows(inSection: indexPath.section) - 3
            })
            .throttle(.milliseconds(1), latest: false, scheduler: MainScheduler.instance)
            .map({ event -> Void in
                return Void()
            })
            .bind(to: viewModel.callNextPage)
            .disposed(by: disposeBag)
        

        viewModel.selectedIssue.asObservable().subscribe(onNext: {[weak self] issue in
            guard let `self` = self else {return}
            guard let issue = issue else {return}
            self.pushToIssueDetails(selectedIssue: issue)
        }).disposed(by: self.disposeBag)
        
        self.issueListTableView
            .rx
            .modelSelected(IssueList.self)
            .bind(to: viewModel.selectedIssue)
            .disposed(by: disposeBag)
        
        viewModel.alertDialog.observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (title, message) in
                guard let `self` = self else {return}
                showAlertDialogue(title: title, message: message,viewController: self)
            }).disposed(by: disposeBag)
    }
}

extension IssueListViewController {
    func pushToIssueDetails(selectedIssue: IssueList) {
        let viewModel = IssueDetailViewModel.init(dependencies: self.viewModel.dependencies, issue: selectedIssue)
        let viewController = UIStoryboard.main.issueDetailViewController
        viewController.viewModel = viewModel
        
        viewModel.popToIssueList
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: self.disposeBag)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

