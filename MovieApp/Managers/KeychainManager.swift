//
//  KeychainManager.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 6/05/21.
//


import Keychain

class KeychainManager {
    static let shared = KeychainManager()
    
    private let keychain = Keychain()
    
    func saveData<T>(key: String, data: T) -> Bool {
        return keychain.save(data, forKey: key)
    }
    
    func getData<T>(key: String) -> T? {
        return keychain.value(forKey: key) as? T
    }
    
    func deleteData(key: String) -> Bool {
        return keychain.remove(forKey: key)
    }
    
    func clearUserSession() -> Bool{
        return keychain.remove(forKey: "isLoggedIn") && keychain.remove(forKey: "username") && keychain.remove(forKey: "password")
    }
}
