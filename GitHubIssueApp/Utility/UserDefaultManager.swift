//
// UserDefaultManager.swift
// GitHubIssueApp
//

import Foundation
let KEYDate = "kDate"

class SharedPreferences: NSObject {
    class func setCurrentDate(date: String) {
        UserDefaults.standard.set(date, forKey: KEYDate)
        UserDefaults.standard.synchronize()
    }
    
    class func getDate() -> String? {
        return UserDefaults.standard.string(forKey: KEYDate)
    }
}
