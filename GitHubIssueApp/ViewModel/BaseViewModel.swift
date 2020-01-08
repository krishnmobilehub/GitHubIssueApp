//
// BaseViewModel.swift
// GitHubIssueApp
//

import Foundation
import RxSwift
import RxCocoa

//MARK:- BaseViewModel
class BaseViewModel {
    // Dispose Bag
    let alert = PublishSubject<(String)>()
    let alertDialog = PublishSubject<(String,String)>()
}
