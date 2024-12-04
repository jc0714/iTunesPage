//
//  SongListViewController.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/4.
//

import Foundation
import UIKit

import UIKit

class SongsListViewController: UIViewController {

    private var tableView: UITableView!
    var songs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SongListTableViewCell.self, forCellReuseIdentifier: SongListTableViewCell.identifier)

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension SongsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongListTableViewCell.identifier, for: indexPath) as! SongListTableViewCell
        
        cell.configure(with: songs[indexPath.row], index: indexPath.row)

        if let favoriteSongs = UserDefaults.standard.array(forKey: HeartBtnManager.favoritesKey) as? [Int],
           favoriteSongs.contains(songs[indexPath.item].trackId) {
            cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

        cell.heartButtonTappedClosure = { [weak self] in
            Task {
                self?.updateHeartBtn(at: indexPath, songId: self!.songs[indexPath.item].trackId)
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func updateHeartBtn(at indexPath: IndexPath, songId: Int) {

        guard let cell = tableView.cellForRow(at: indexPath) as? SongListTableViewCell else {
            print("Unable to retrieve cell at \(indexPath)")
            return
        }

        let favoritesManager = HeartBtnManager()
        favoritesManager.toggleFavorite(songId: songId)
        let isLiked = favoritesManager.isFavorite(songId: songId)

        let heartImage = isLiked ? "heart.fill" : "heart"
        cell.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }
}
