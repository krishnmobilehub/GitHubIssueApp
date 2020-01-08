//
// String+Extension.swift
// GitHubIssueApp
//

import Foundation

extension String {
    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:self)
        
        return date
    }
    
    func stringToDate(with formatter: String) -> Date?  {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formatter
        let date = dateFormatter.date(from:self)
        
        return date
    }
}
