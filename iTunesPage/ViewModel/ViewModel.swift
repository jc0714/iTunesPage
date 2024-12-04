//
//  ViewModel.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/4.
//

import Foundation
import Combine

class ViewModel {
    private let apiManager = APIManager()

    @Published var songs: [MusicTrack] = []
    @Published var albums: [Album] = []
    @Published var errorMessage: String?

    func fetchSongs() {
        apiManager.fetchSongs { [weak self] result in
            switch result {
            case .success(let songs):
                DispatchQueue.main.async {
                    self?.songs = songs
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to fetch songs: \(error.localizedDescription)"
                }
            }
        }
    }

    func fetchAlbums() {
        apiManager.fetchAlbums() { [weak self] result in
            switch result {
            case .success(let albums):
                DispatchQueue.main.async {
                    self?.albums = albums
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to fetch latest songs: \(error.localizedDescription)"
                }
            }
        }
    }
}
