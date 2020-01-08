//
// IssueDetailViewModel.swift
// GitHubIssueApp
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

//MARK:- IssueDetailViewModel
final class IssueDetailViewModel: BaseViewModel {
    
    let disposeBag = DisposeBag()
    typealias Dependencies = NetworkManager

    private let dependencies: Dependencies

    var selectedIssue: IssueList?
    
    var issueDetailTableData: Observable<[IssueDetailModel]>
    var issueDetailResponse: BehaviorRelay<[IssueDetailModel]> = BehaviorRelay(value: [])

    var popToIssueList = PublishSubject<Void>()
    
    init(dependencies: Dependencies, issue: IssueList) {
        self.dependencies = dependencies
        self.selectedIssue = issue
        self.issueDetailTableData = issueDetailResponse.asObservable()
        super.init()
    }
}

//MARK:- API Call
extension IssueDetailViewModel {
    func getIssueDetails() {
        
        if !NetworkReachabilityManager()!.isReachable{
            self.alertDialog.onNext((MessageConstant.error, MessageConstant.internetNotAvailable))
            return
        }
        
        showProgressHud(progressText: MessageConstant.isLoading)
        
        NetworkManager.makeRequestArray(HttpRouter.getIssueDetail(issueId: "\(self.selectedIssue?.number ?? 0)"))
            .onSuccess { (response: [IssueDetailModel]) in
                hideProgressHud()
                if response.count > 0 {
                    self.issueDetailResponse.accept(response)
                } else {
                    self.popToIssueList.onNext((
                        self.alertDialog.onNext((MessageConstant.appTitile, MessageConstant.commentsNotAvailable))
                    ))
                }
            }
            .onFailure { error in
                hideProgressHud()
                AppLog.error(error.localizedDescription)
                self.alertDialog.onNext((MessageConstant.error, error.localizedDescription))
            }.onComplete { _ in
        }
    }
    
}
