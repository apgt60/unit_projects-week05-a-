//
//  NetworkManager.swift
//  DMNetworkingIntro
//
//  Created by David Ruvinskiy on 4/10/23.
//

import Foundation

/**
 3.1 Create a protocol called `NetworkManagerDelegate` that contains a function called `usersRetrieved`.. This function should accept an array of `User` and should not return anything.
 */
protocol NetworkManagerDelegate {
    func usersRetrieved(users: [User])
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://reqres.in/api/"
    
    private init() {}
    
    /**
     3.2 Create a variable called `delegate` of type optional `NetworkManagerDelegate`. We will be using the delegate to pass the `Users` to the `UsersViewController` once they come back from the API.
     */
    var delegate: NetworkManagerDelegate?
    
    /**
     3.3 Makes a request to the API and decode the JSON that comes back into a `UserResponse` object.
     3.4 Call the `delegate`'s `usersRetrieved` function, passing the `data` array from the decoded `UserResponse`.
     
     This is a tricky function, so some starter code has been provided.
     */
    func getUsers() {
        
        // 3.3 Append the "/users" endpoint to the base URL and store the result in a variable. You should end up with this String: "https://reqres.in/api/users".
        let usersURL = "https://reqres.in/api/users?per_page=100"
        
        // 3.3 Create a `URL` object from the String. If the `URL` is nil, break out of the function.
        let url = URL(string: usersURL)
        if(url == nil){
            return
        }
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            // 3.3 If the error is not nil, break out of the function.
            if(error != nil){
                print(error!)
                return
            }
            
            // 3.3 Unwrap the data. If it is nil, break out of the function.
            if(data == nil){
                print("data is nil")
                return
            }
            
//            print("sleeping")
//            sleep(1)
//            print("getting users from server")
            
//            let dataString = String(data: data!, encoding: .utf8)
//            print(dataString!)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                // 3.3 Use the provided `decoder` to decode the data into a `UserResponse` object.
                let decodedData = try decoder.decode(UserResponse.self, from: data!)
                //print("Received \(decodedData.total) users from API")
                
                // 3.4 Call the `delegate`'s `usersRetrieved` function, passing the `data` array from the decoded `UserResponse`.
                self.delegate?.usersRetrieved(users: decodedData.data)
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
}
