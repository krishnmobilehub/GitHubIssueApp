//
//  CustomeNavigation.swift
//  GitHubIssueApp
//


import UIKit

class CustomeNavigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationBar.barTintColor = Colors.white
        self.navigationBar.isTranslucent = false
        self.setNavigationBarHidden(false, animated: false)
        let textAttributes = [NSAttributedString.Key.font: Fonts.Helvetica.bold(of: 18),
                              NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationBar.titleTextAttributes = textAttributes
    }

}
