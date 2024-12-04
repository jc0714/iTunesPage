//
//  AlbumModel.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/4.
//

import Foundation

struct AlbumResponse: Codable {
    let results: [Album]
}

struct Album: Codable {
    let collectionId: Int
    let collectionName: String
    let artworkUrl100: String
    let artistName: String
}
