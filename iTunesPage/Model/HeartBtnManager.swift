//
//  HeartBtnManager.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/3.
//

import Foundation

class HeartBtnManager {

    private let favoritesKey = "favoriteSongs"

    func getFavoriteSongs() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }

    func isFavorite(songId: Int) -> Bool {
        return getFavoriteSongs().contains(songId)
    }

    func toggleFavorite(songId: Int) {
        var favorites = getFavoriteSongs()
        if let index = favorites.firstIndex(of: songId) {
            favorites.remove(at: index)
        } else {
            favorites.append(songId)
        }
        UserDefaults.standard.set(favorites, forKey: favoritesKey)

        print(favorites)
    }
}
