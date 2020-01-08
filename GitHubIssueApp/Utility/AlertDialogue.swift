//
// Utility.swift
// GitHubIssueApp
//

import UIKit


func showAlertDialogueWithAction(title:String = "",
                                 withMessage message:String?,
                                 withActions actions: UIAlertAction... , withStyle style:UIAlertController.Style = .alert,
                                 viewController: UIViewController) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    if actions.count == 0 {
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    } else {
        for action in actions {
            alert.addAction(action)
        }
    }
    viewController.present(alert, animated: true, completion: nil)
}

func showAlertDialogue( title: String , message: String, viewController: UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    viewController.present(alert, animated: true, completion: nil)
}
