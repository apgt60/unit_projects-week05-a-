//
//  UsersViewController.swift
//  DMNetworkingIntro
//
//  Created by David Ruvinskiy on 4/10/23.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var networkManager = NetworkManager.shared
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getUsers()
        
    }
    
    /*
    3.1 Modify the UsersViewController to use the completion closure instead of the NetworkManagerDelegate.
     */
    func getUsers() {
        networkManager.getUsers({(newUsers: [User]?, error: DMError?) -> () in
            if let error {
                DispatchQueue.main.async {
                    self.presentError(error)
                }
            }
        
            if let newUsers {
                print("UsersViewController received \(newUsers.count) users")
                self.users = newUsers
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    /*
    3.2 Add a function called presentAlert to the UsersViewController that accepts a DMError and presents a UIAlertController with that error. Call presentError if there's a failure.
    */
     func presentError(_ error : DMError){
        print(error.rawValue)
        let alert = UIAlertController(title: "Network Error", message: error.rawValue, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
        
}

extension UsersViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! CustomUserCell
        cell.userNameLabel.text = user.firstName
        cell.userEmailLabel.text = user.email
        return cell
    }
    
    func configureViewController() {
        self.tableView.delegate = self
        tableView.dataSource = self
        //register custom Nib for table view
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
}
