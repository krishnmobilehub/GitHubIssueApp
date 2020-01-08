//
// IssueTableViewCell.swift
// GitHubIssueApp
//

import UIKit

let titleLimit = 140

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var assignLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var editTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.numberLabel.textColor = Colors.textBlue
        self.titleLabel.textColor = Colors.textBlue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with issue: IssueList) {
        
        self.numberLabel.text = "#" + String(issue.number)
        if issue.pullRequest == nil && (issue.assignees?.count ?? 0) > 0 {
            self.typeLabel.text = "issue".capitalized
            self.assignLabel.text = issue.assignees?[0].login
        } else {
            self.typeLabel.text = "pull".capitalized
            self.assignLabel.text = "unassigned".capitalized
        }
        
        let issueTitle: String = issue.title ?? ""
        
        if issueTitle.count >= titleLimit {
            self.titleLabel.text = String(issueTitle.prefix(titleLimit)) + "..."
        } else {
            self.titleLabel.text = issueTitle
        }
        
        self.stateLabel.text = issue.state
        self.commentLabel.text = String(issue.comments)
        
        if let editComment = issue.updatedAt?.stringToDate() {
            self.editTimeLabel.text = editComment.getElapsedInterval()
        } else if let editComment = issue.createdAt?.stringToDate() {
            self.editTimeLabel.text = editComment.getElapsedInterval()
        }
    }
}
