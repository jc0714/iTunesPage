//
//  SongModel.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/2.
//

import Foundation

struct SongResponse: Codable {
    let results: [Song]
}

struct Song: Codable {
    let trackId: Int
    let artworkUrl100: String
    let trackName: String
    let artistName: String
}
