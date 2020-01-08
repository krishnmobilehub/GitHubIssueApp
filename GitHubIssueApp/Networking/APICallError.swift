//
//  APICallError.swift
//  GitHubIssueApp
//

import Foundation
import ObjectMapper

// MARK: NetworkError
enum NetworkError: LocalizedError {
    case errorString(String)
    case errorModel(ErrorModel)
    case error(code: Double?, message: String)
    case generic
    
    var errorDescription: String? {
        switch self {
        case .errorString(let errorMessage): return errorMessage
        case .error(_, let message): return message
        case .errorModel(let errorMessage):
            if let error = errorMessage.statusMessage, !error.isEmpty {
                return error
            } else {
                return errorMessage.errors?[0] ?? MessageConstant.genericError
            }
        case .generic: return MessageConstant.genericError
        }
    }
    
    var info: (code: Double?, message: String) {
        switch self {
        case .error(let code, let message):
            return (code, message)
        case .errorModel(let errorMessage):
            if let error = errorMessage.statusMessage, !error.isEmpty {
                return (401, error)
            } else {
                return (422, errorMessage.errors?[0] ?? MessageConstant.genericError)
            }
        case .errorString(let errorMessage): return (nil, errorMessage)
        case .generic:
            return (nil, MessageConstant.genericError)
        }
    }
    
    var title: String {
        return MessageConstant.titleSorry
    }
}

// MARK: ErrorModel
class ErrorModel: Mappable {
    var statusCode: Int?
    var statusMessage: String?
    var errors: [String]?
    var message: String?
    var success: Bool?
    var documentationURL: String?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        statusCode <- map["status_code"]
        statusMessage <- map["status_message"]
        errors <- map["errors"]
        success <- map["success"]
        message <- map["message"]
        documentationURL <- map["documentation_url"]
    }
}
