//
//  Model.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/2.
//

import Foundation

struct MusicResponse: Codable {
    let results: [MusicTrack]
}

struct MusicTrack: Codable {
    let trackId: Int
    let artworkUrl100: String
    let trackName: String
    let artistName: String
}

struct AlbumResponse: Codable {
    let results: [Album]
}

struct Album: Codable {
    let collectionId: Int
    let collectionName: String
    let artworkUrl100: String
    let artistName: String
}

