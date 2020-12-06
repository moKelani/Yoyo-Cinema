//
//  GlobalVariables.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/6/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

struct GlobalVariables {
    
    static var FavoriteList: [Movie] {

        get {
            
            if let favoriteList = UserDefaults.standard.data(forKey: UserDefaultsKey.favoriteList.rawValue),
                let favoriteMovies = try? JSONDecoder().decode([Movie].self, from: favoriteList) {
                return favoriteMovies
            }
            
            return []
        }
        
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: UserDefaultsKey.favoriteList.rawValue)
            }
        }
    }
    
    static var baseURL: String?
}

