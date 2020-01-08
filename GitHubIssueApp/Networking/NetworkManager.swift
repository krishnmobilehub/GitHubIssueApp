//
//  NetworkManager.swift
//  GitHubIssueApp
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import BrightFutures

struct NetworkManager {
    
    static let networkQueue = DispatchQueue(label: "\(String(describing: Bundle.main.bundleIdentifier)).networking-queue", attributes: .concurrent)

    static func makeRequestArray<T: Mappable>(_ urlRequest: URLRequestConvertible) -> Future<[T], NetworkError> {
        let promise = Promise<[T], NetworkError>()
        // Check network connectivity
        if let isInternetConectivity = NetworkReachabilityManager()?.isReachable, isInternetConectivity == true {
            let request = Alamofire.request(urlRequest)
                .validate()
                .responseArray(queue: networkQueue) { (response: DataResponse<[T]>) -> Void in
                    print(response.result)
                     AppLog.debug("\n\(MessageConstant.response): \(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)\n")
                    URLCache.shared.removeAllCachedResponses()
                    guard response.data != nil else {
                        promise.failure(NetworkError.error(code: 0, message: ""))
                        return
                    }
                    
                    switch response.result {
                    case .success:
                        if let error = error(fromResponseObject: response) {
                            promise.failure(error)
                        } else {
                            promise.success(response.result.value!)
                        }
                    case .failure(let error):
                        promise.failure(generateError(from: error, with: response))
                    }
            }
            debugPrint(request)
            return promise.future
        } else {
            return promise.future
        }
    }

    /// Method for error handling
    /// - Parameter responseObject: represents responseObject
    static func error<T>(fromResponseObject responseObject: DataResponse<T>) -> NetworkError? {
        if let statusCode = responseObject.response?.statusCode {
            switch statusCode {
            case 200: return nil
            default:
                if let result = responseObject.result.value as? [String: Any], !result.isEmpty {
                    return NetworkError.generic
                } else if let data = responseObject.data {
                    do {
                        let jsonTemp = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary

                        if let errorModel = Mapper<ErrorModel>().map(JSONObject: jsonTemp) {
                            return NetworkError.errorModel(errorModel)
                        }
                        return NetworkError.generic
                    } catch let errorTemp as NSError {
                        return NetworkError.errorString(errorTemp.localizedDescription)
                    }
                }
            }
        }
        return NetworkError.errorString(MessageConstant.genericError)
    }
    
    /// Request failure errors
    /// - Parameters:
    ///   - error: represents error description
    ///   - responseObject: represents responseObject description
    static func generateError<T>(from error: Error, with responseObject: DataResponse<T>) -> NetworkError {
        if  responseObject.response?.statusCode != nil {
            return NetworkManager.error(fromResponseObject: responseObject) ?? .generic
        } else {
            let code = (error as NSError).code
            switch code {
            case NSURLErrorNotConnectedToInternet, NSURLErrorCannotConnectToHost, NSURLErrorCannotFindHost:
                return NetworkError.error(code: 1000, message: MessageConstant.internetNotAvailable)
            default:
                return NetworkError.errorString(MessageConstant.genericError)
            }
        }
    }
}
