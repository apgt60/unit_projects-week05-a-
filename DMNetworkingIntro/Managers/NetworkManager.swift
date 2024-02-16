//
//  NetworkManager.swift
//  DMNetworkingIntro
//
//  Created by David Ruvinskiy on 4/10/23.
//

import Foundation

protocol NetworkManagerDelegate {
    func usersRetrieved(users: [User])
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://reqres.in/api/"
    
    private init() {}
    
    /*
     2.1 Modify the getUsers function to accept a completion closure. The closure should accept a Result For the success case, the associated value for the result should be an array of User. For the failure case, the associated value should be a DMError.
     2.2 Continue to modify getUsers to use the closure. For all failures, call the completion closure with the correct DMError. For a success, call the completion closure with the array of User.
     */
    func getUsers(_ callback : @escaping ([User]?, DMError?) -> ()) {
        
        let usersURL = "https://reqres.in/api/users?per_page=100"
        
        let url = URL(string: usersURL)
        if(url == nil){
            callback(nil, DMError.invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if(error != nil){
                print("Error not nil: \(error!)")
                callback(nil, DMError.unableToComplete)
                return
            }
            
            if(data == nil){
                print("data is nil")
                callback(nil, DMError.unableToComplete)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedData = try decoder.decode(UserResponse.self, from: data!)
                callback(decodedData.data, nil)
            } catch {
                callback(nil, DMError.invalidResponse)
                print(error)
            }
        }
        
        task.resume()
    }
    
}
