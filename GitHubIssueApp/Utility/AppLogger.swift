//
// AppLogger.swift
// GitHubIssueApp
//

import Foundation

enum LogEvent: String {
    case error = "[error]"
    case info = "[info]"
    case debug = "[debug]"
    case verbose = "[verbose]"
    case warning = "[warning]"
    case severe = "[severe]"
}

func LogPrint(_ object: Any) {
    // Only allowing in DEBUG mode
    #if DEBUG
    Swift.print(object)
    #endif
}

class AppLog {
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    // MARK: - Loging methods
    class func error( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            LogPrint("\(Date().toString()) \(LogEvent.error.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }

    class func info( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            LogPrint("\(Date().toString()) \(LogEvent.info.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }

    class func debug( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            LogPrint("\(Date().toString()) \(LogEvent.debug.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }

    class func verbose( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            LogPrint("\(Date().toString()) \(LogEvent.verbose.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }

    class func warning( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            LogPrint("\(Date().toString()) \(LogEvent.warning.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }

    class func severe( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            LogPrint("\(Date().toString()) \(LogEvent.severe.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

internal extension Date {
    func toString() -> String {
        return AppLog.dateFormatter.string(from: self as Date)
    }
}
