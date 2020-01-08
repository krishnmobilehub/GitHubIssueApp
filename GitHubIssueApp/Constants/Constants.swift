//
//  Constants.swift
//  GitHubIssueApp
//

import Foundation
import UIKit

//MARK:- Global Variables
var AppName: String {
    return (Bundle.main.infoDictionary!["CFBundleName"] as? String ?? "")
}

// MARK: Validation messages
struct MessageConstant {
    static let appTitile = AppName
    static let internetNotAvailable = "No Internet Available. Please connect to wifi."
    static let genericError = "Something went wrong. Please try again or contact support if the issue persists."
    static let titleSorry = "Sorry"
    static let errorMessage = "status_message"
    static let message = "message"
    static let isLoading = "Loading..."
    static let error = "Error"
    static let info = "Information"
    static let response = "Response"
    static let urlRequest = "urlRequest"
    static let comments = "Comments"
    static let commentsNotAvailable = "Comments not available"
    static let issueList = "Issue List"
    static let failureReason = "There was an error creating or loading the application's saved data."
    static let dictSavedFailed = "Failed to initialize the application's saved data"
    static let couldFetch = "Could not fetch."
    static let unresolvedError = "Unresolved error"
    static let couldFoundStoryboard = "couldn't be found in Storyboard file"
}

struct CoreData {
    static let dbName = "GitIssue"
    static let issueObject = "IssueList"
}
