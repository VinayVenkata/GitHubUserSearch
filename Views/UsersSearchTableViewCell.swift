//
//  UsersSearchTableViewCell.swift
//  GitHubUsersSearch
//
//  Created by Vinay Ponnuri on 4/21/20.
//  Copyright © 2020 Vinay Ponnuri. All rights reserved.
//

import UIKit
import Kingfisher

class UsersSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: AsyncImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var repoNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(users: UsersData) {
        DispatchQueue.main.async {
            self.userImage.setImageWith(url: users.thumbnail, placeholder: nil, indicatorType: .activity, success: {
            }) { (_) in }
        }
    }
    
    func configureSearch(users: SearchUsersList) {
        DispatchQueue.main.async {
            self.userImage.setImageWith(url: users.thumbnail, placeholder: nil, indicatorType: .activity, success: {
            }) { (_) in }
        }
    }
    
}
