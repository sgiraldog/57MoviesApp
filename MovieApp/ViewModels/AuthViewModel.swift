//
//  AuthViewModel.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 7/05/21.
//

import Foundation
class AuthViewModel: NSObject {
    
    func validateUser(username: String, password: String) -> String? {
        var response: String?
        APIService.shared.mockAuthAPI(username: username, password: password) { (result) in
            if !result.successfull {
                response = result.message
            }
        }
        return response
    }
    
    func saveDataOnKeychain<T>(key: String, data: T) -> Bool{
        return KeychainManager.shared.saveData(key: key, data: data)
    }
    
    func clearSession() -> Bool{
        return KeychainManager.shared.clearUserSession()
    }
}
