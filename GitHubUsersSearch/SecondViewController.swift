//
//  SecondViewController.swift
//  GitHubUsersSearch
//
//  Created by Vinay Ponnuri on 4/22/20.
//  Copyright © 2020 Vinay Ponnuri. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var avatarImage: AsyncImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    var userInfo: UserInfoData = UserInfoData()
    var userRepoArray: [UsersRepoData] = [UsersRepoData]()
    
    var userData = [UsersRepoData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        definesPresentationContext = true
        let usersSearchDetailCellNib = UINib(nibName: "UsersSearchDetailTableViewCell", bundle: nil)
        tableView.register(usersSearchDetailCellNib, forCellReuseIdentifier: "UsersSearchDetailTableViewCell")
        loadUI()
    }
    
    func loadUI() {
        self.bioLabel.text = ""
        self.userNameLabel.text = userInfo.name
        self.emailLabel.text = userInfo.email?.isEmpty ?? false ? "null" : userInfo.email
        self.locationLabel.text = userInfo.location
        self.joinDateLabel.text = userInfo.created_at
        if let followers = userInfo.followers, let following = userInfo.following {
            self.followersLabel.text = String("\(followers) Followers")
            self.followingLabel.text = String("\(following) Following")
        }
        self.avatarImage.setImageWith(url: userInfo.thumbnail, placeholder: nil, indicatorType: .activity, completion: nil)
        
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRepoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "UsersSearchDetailTableViewCell", for: indexPath)
        guard let usersSearchDetailTableViewCell = cell as? UsersSearchDetailTableViewCell else {
            return UITableViewCell()
        }
        let userRepo = userRepoArray[indexPath.row]
        userData.append(userRepo)
        usersSearchDetailTableViewCell.repoName.text = userRepo.repoName
        if let forks = userRepo.forks, let watchers = userRepo.watchers {
            usersSearchDetailTableViewCell.forks.text = String("\(forks) Forks")
            usersSearchDetailTableViewCell.watchers.text = String("\(watchers) Stars")
        }
        
        return usersSearchDetailTableViewCell
    }
}

extension SecondViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Do some search stuff
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
    }
}
