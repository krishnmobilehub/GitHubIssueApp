//
// ProgressHud.swift
// GitHubIssueApp
//

import Foundation
import MBProgressHUD

func showProgressHud(progressText:String) {
    DispatchQueue.main.async {
        if let window = UIApplication.shared.keyWindow {
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.label.text = progressText
            hud.label.numberOfLines = 0
        }
    }
}

func hideProgressHud() {
    DispatchQueue.main.async {
        if let window = UIApplication.shared.keyWindow {
            MBProgressHUD.hide(for: window, animated: true)
        }
    }
}
