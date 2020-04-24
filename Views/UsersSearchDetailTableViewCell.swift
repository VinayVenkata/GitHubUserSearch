//
//  UsersSearchDetailTableViewCell.swift
//  GitHubUsersSearch
//
//  Created by Vinay Ponnuri on 4/22/20.
//  Copyright © 2020 Vinay Ponnuri. All rights reserved.
//

import UIKit

class UsersSearchDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var watchers: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
