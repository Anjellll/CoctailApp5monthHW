//
//  UserDefaultManager.swift
//  5.3.CoctailAppHW
//
//  Created by anjella on 24/2/23.
//

import Foundation

class UserDefaultManager {
    enum Storage: String {
        case favoriteColor
        case fdasfa
    }
    
    static let shared = UserDefaultManager()
    
    private init() { }
    
    func save(_ model: String, for key: Storage) {
        UserDefaults.standard.set(model, forKey: key.rawValue)
    }
    
    func remove(with key: Storage) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func string(for key: Storage) -> String {
        UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
}
