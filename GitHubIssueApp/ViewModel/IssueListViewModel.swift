//
// IssueListViewModel.swift
// GitHubIssueApp
//

import Foundation
import ObjectMapper
import Alamofire
import RxSwift
import RxCocoa
import CoreData

//MARK:- IssueListViewModel
class IssueListViewModel: BaseViewModel {
    let disposeBag = DisposeBag()
    typealias Dependencies = NetworkManager

    var dependencies: Dependencies = Dependencies()

    var issueListData: Observable<[IssueList]>
    var issues: BehaviorRelay<[IssueList]> = BehaviorRelay(value: [])

    var nextPage: Int? = 1
    var pageDataIsAviable: Bool = true
    
    var callNextPage = PublishSubject<Void>()
    let selectedIssue = PublishSubject<IssueList?>()
    
    let currentDate:String = Date().toString() ?? ""
    
    override init() {
        self.issueListData = issues.asObservable()
        
        super.init()
        
        self.callNextPage.asObservable()
            .subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            
            if NetworkReachabilityManager()!.isReachable == true {
                if self.nextPage != nil {
                    self.getIssue(nextPage: self.nextPage!)
                }
            } else {
                AppLog.error(MessageConstant.internetNotAvailable)
                self.alertDialog.onNext((MessageConstant.error, MessageConstant.internetNotAvailable))
            }
        }).disposed(by: disposeBag)
    }
        
}

//MARK:- API Call
extension IssueListViewModel {
    
    func getIssue(nextPage: Int = 1) {
        if !NetworkReachabilityManager()!.isReachable{
            self.alertDialog.onNext((MessageConstant.error, MessageConstant.internetNotAvailable))
            return
        }
        
        let parameter = [ Params.page.rawValue : nextPage ] as [String : Any]
        
        if nextPage == 1 {
            showProgressHud(progressText: MessageConstant.isLoading)
        }
        
        if !pageDataIsAviable {
            return
        }
        
        NetworkManager.makeRequestArray(HttpRouter.getIssueList(parameter))
            .onSuccess { (response: [IssueListModel]) in
                
                hideProgressHud()
                if response.count > 0 {
                    for object in response {
                        object.saveObject()
                    }
                    self.fetchLocalData()
                } else {
                    self.pageDataIsAviable = false
                }
                let currentDate:String = Date().toString() ?? ""
                SharedPreferences.setCurrentDate(date: currentDate)
                self.nextPage = (self.nextPage ?? 1) + 1
            }
            .onFailure { error in
                hideProgressHud()
                AppLog.error(error.localizedDescription)
                self.alertDialog.onNext((MessageConstant.error, error.localizedDescription))
            }.onComplete { _ in
        }
    }
    
    func fetchLocalData() {
        if let savedObjects = CoreDataManager.sharedInstance.fetch(entityName: CoreData.issueObject as NSString) as? [IssueList], savedObjects.count > 0  {
             self.issues.accept(savedObjects)
        }
    }
}
