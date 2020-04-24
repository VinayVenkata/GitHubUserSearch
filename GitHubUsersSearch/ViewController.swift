//
//  ViewController.swift
//  GitHubUsersSearch
//
//  Created by Vinay Ponnuri on 4/21/20.
//  Copyright © 2020 Vinay Ponnuri. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var accessToken: String?
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var isSearchInProcess: Bool = false
    
    var usersArray = [UsersData]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var usersSearchArray = [SearchUsersList]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var userInfo = UserInfoData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        let userSearchCellNib = UINib(nibName: "UsersSearchTableViewCell", bundle: nil)
        tableView.register(userSearchCellNib, forCellReuseIdentifier: "UsersSearchTableViewCell")
        fetchUserData()
    }
    
    func fetchUserData() {
        NetworkService.getUsers { (_, usersData, error) in
            if error == nil {
                guard let users = usersData else { return }
                self.usersArray = users
            }
        }
    }
    
    func searchUsers(searchText: String) {
        NetworkService.searchUsers(searchText: searchText) { (search, usersData, error) in
            if error == nil {
                guard let users = search else { return }
                self.usersSearchArray = users
            }
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchInProcess ? usersSearchArray.count : usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersSearchTableViewCell", for: indexPath)
        guard let usersSearchTableViewCell = cell as? UsersSearchTableViewCell else {
            return UITableViewCell()
        }
        
        if isSearchInProcess {
            let userinfo = usersSearchArray[indexPath.row]
            usersSearchTableViewCell.configureSearch(users: userinfo)
            usersSearchTableViewCell.userName.text = userinfo.userName
            usersSearchTableViewCell.repoNumber.text = "Repo 2"
        } else {
            let user = usersArray[indexPath.row]
            usersSearchTableViewCell.configureWith(users: user)
            usersSearchTableViewCell.userName.text = user.userName
            usersSearchTableViewCell.repoNumber.text = "Repo 2"
        }
        
        return usersSearchTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentCell = tableView.cellForRow(at: indexPath) as? UsersSearchTableViewCell {
            NetworkService.getUserInfo(url: currentCell.userName.text ?? "") { (userInfo, error) in
                 guard let userInfodata = userInfo else { return }
                self.userInfo = userInfodata
                if error == nil {
                    NetworkService.getUsersRepo(url: currentCell.userName.text ?? "") { (_, userRepoData, error) in
                        if error == nil {
                            guard let usersRepo = userRepoData else { return }
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            if let controller = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
                                controller.userRepoArray = usersRepo
                                controller.userInfo = self.userInfo
                                self.navigationController?.pushViewController(controller, animated: true)
                            }
                        }
                    }
                }
            }
        }

    }
}

extension ViewController: UISearchBarDelegate {
    
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
        isSearchInProcess = false
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       if searchBar.text?.isEmpty ?? false {
            isSearchInProcess = false
            fetchUserData()
        } else {
            isSearchInProcess = true
            searchUsers(searchText: searchText)
        }
    }
    
}
