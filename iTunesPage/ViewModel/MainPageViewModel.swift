//
//  MainPageViewModel.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/4.
//

import Foundation
// 這裡其實不需要 import Combine

class MainPageViewModel {
    private let apiManager = APIManager()

    @Published var songs: [Song] = []
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
