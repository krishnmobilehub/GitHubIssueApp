//
//  HttpRouter.swift
//  GitHubIssueApp
//

import Foundation
import Alamofire

enum Params: String {
    case page
    case totalResults
    case totalPages
}

enum ConfigurationURLs {
    case baseURL(GitHubProject)
    
    var rawValue: String {
        switch self {
        case .baseURL(let projectName):
            return "https://api.github.com/repos/\(projectName.rawValue)"
        }
    }
}

enum GitHubProject: String {
    case firebase = "firebase/firebase-ios-sdk/"
}

enum HttpRouter: URLRequestConvertible {
    
    case getIssueList(Parameters)
    case getIssueDetail(issueId: String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getIssueList,
             .getIssueDetail:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getIssueList:
            return "issues"
        case .getIssueDetail(let id):
            return "issues/\(id)/comments"
        }
    }

    var headers: Bool? {
        switch self {
        default:
            return true
        }
    }
    
    var urlParameters: [String: Any]? {
        switch self {
        case .getIssueList(let param):
            return param
        case .getIssueDetail(_):
            return nil
        }
    }
    
    var isAuthToken: Bool {
        switch self {
        default:
            return false
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = NSURL(string: "\(ConfigurationURLs.baseURL(.firebase).rawValue)" + "\(self.path.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed) ?? "")")!
        var urlRequest = URLRequest(url: url as URL)
        urlRequest.httpMethod = method.rawValue
        AppLog.debug("\(MessageConstant.urlRequest) -->\(urlRequest)")
        
        switch self {
        case .getIssueList,
             .getIssueDetail:
            return try URLEncoding.queryString.encode(urlRequest, with: self.urlParameters)
        }
    }
}
