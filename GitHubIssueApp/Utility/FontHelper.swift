//
//  FontHelper.swift
//  GitHubIssueApp
//

import Foundation
import UIKit

struct Fonts {
    struct Helvetica {
        static func regular(of size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue", size: size)!
        }
        
        static func bold(of size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue-Bold", size: size)!
        }
    }
}
