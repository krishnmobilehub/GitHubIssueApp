//
// IssueDetailTableViewCell.swift
// GitHubIssueApp
//

import UIKit
import Kingfisher
import MarkdownKit

class IssueDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentTimeLabel: UILabel!
    @IBOutlet weak var commentDetailTextView: UITextView!

    private let defaultMarkdownParser = MarkdownParser()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }

    func configure(with issue: IssueDetailModel) {
        self.userImageView.downloadImageWithCaching(with: issue.user?.avatarUrl ?? "", placeholderImage: #imageLiteral(resourceName: "placeholder-image"))
        self.userNameLabel.text = issue.user?.login
        
        if let commentTime = issue.updatedAt?.stringToDate() {
            self.commentTimeLabel.text = commentTime.getElapsedInterval()
        } else if let commentTime = issue.createdAt?.stringToDate() {
            self.commentTimeLabel.text = commentTime.getElapsedInterval()
        }

        let attributedString = NSAttributedString(string: issue.body ?? "")
        self.commentDetailTextView.attributedText = defaultMarkdownParser.parse(attributedString)
    }

}
