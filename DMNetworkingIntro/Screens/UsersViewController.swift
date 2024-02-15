//
//  UsersViewController.swift
//  DMNetworkingIntro
//
//  Created by David Ruvinskiy on 4/10/23.
//

import UIKit

/**
 1. Create the user interface. See the provided screenshot for how the UI should look.
 2. Follow the instructions in the `User` file.
 3. Follow the instructions in the `NetworkManager` file.
 */
class UsersViewController: UIViewController, NetworkManagerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var networkManager = NetworkManager.shared
    
    /**
     4. Create a variable called `users` and set it to an empty array of `User` objects.
     */
    var users = [User]()
    
    /**
     5. Connect the UITableView to the code. Create a function called `configureTableView` that configures the table view. You may find the `Constants` file helpful. Make sure to call the function in the appropriate spot.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        getUsers()
        configureViewController()
    }
    
    /**
     6.1 Set the `NetworkManager`'s delegate property to the `UsersViewController`. Have the `UsersViewController` conform to the `NetworkManagerDelegate` protocol. Call the `NetworkManager`'s `getUsers` function. In the `usersRetrieved` function, assign the `users` property to the array we got back from the API and call `reloadData` on the table view.
     */
    func getUsers() {
        networkManager.getUsers()
        //tableView.reloadData()
        
    }
    
    func usersRetrieved(users: [User]) {
        print("Got \(users.count) users back to UsersViewController")
        self.users = users
        for user in self.users {
            print(user.email)
        }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
    
}

extension UsersViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("table size is \(users.count)")
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! CustomUserCell
        //cell.set(expense: expenses[indexPath.row])
        cell.userNameLabel.text = user.firstName
        cell.userEmailLabel.text = user.email
        //cell.textLabel?.text = users[indexPath.row].firstName
        return cell
    }
    
    func configureViewController() {
        self.tableView.delegate = self
        tableView.dataSource = self
        //register custom Nib for table view
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
         return 50 // custom height
    }
    
}
