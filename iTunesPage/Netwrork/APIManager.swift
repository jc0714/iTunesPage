//
//  APIManager.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/3.
//

import Foundation

class APIManager {

    private let songURL = "https://itunes.apple.com/search?term=周杰倫&media=music"
    private let albumURL = "https://itunes.apple.com/search?term=周杰倫&entity=album"

    func fetchSongs(completion: @escaping (Result<[Song], Error>) -> Void) {
        guard let url = URL(string: songURL) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let songResponse = try JSONDecoder().decode(SongResponse.self, from: data)
                completion(.success(songResponse.results))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

    func fetchAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        guard let url = URL(string: albumURL) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let albumResponse = try JSONDecoder().decode(AlbumResponse.self, from: data)
                completion(.success(albumResponse.results))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
