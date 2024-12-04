//
//  SongsTableViewCell.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/3.
//

import Foundation
import UIKit

class SongsTableViewCell: UITableViewCell {
    static let identifier = "SongsTableViewCell"

    private let collectionView: UICollectionView

    var songs: [MusicTrack] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        layout.itemSize = CGSize(width: 300, height: 50)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: SongCollectionViewCell.identifier)

        collectionView.showsHorizontalScrollIndicator = false

        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SongsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(songs.count, 36)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SongCollectionViewCell.identifier, for: indexPath) as! SongCollectionViewCell
        cell.configure(with: songs[indexPath.item], index: indexPath.row)

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

    func updateHeartBtn(at indexPath: IndexPath, songId: Int) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? SongCollectionViewCell else {
            print("Unable to retrieve cell at \(indexPath)")
            return
        }

        let favoritesManager = HeartBtnManager()
        favoritesManager.toggleFavorite(songId: songId)
        let isLiked = favoritesManager.isFavorite(songId: songId)

        let heartImage = isLiked ? "heart.fill" : "heart"
        cell.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)

//        print("下面這行的愛心被按下了")
//        print(indexPath.row)
//        print(songId)
//        print(n as Any)
    }
}
