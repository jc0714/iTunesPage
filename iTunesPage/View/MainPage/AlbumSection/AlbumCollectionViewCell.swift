//
//  AlbumCollectionViewCell.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/3.
//

import Foundation
import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumCollectionViewCell"

    let albumImageView = UIImageView()
    let albumNameLabel = UILabel()
    let artistNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(albumImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)

        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false

        albumNameLabel.numberOfLines = 2
        albumNameLabel.font = .systemFont(ofSize: 14)
        albumNameLabel.textAlignment = .left

        artistNameLabel.textColor = .darkGray
        artistNameLabel.numberOfLines = 1
        artistNameLabel.font = .systemFont(ofSize: 14)

        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            albumImageView.widthAnchor.constraint(equalToConstant: 100),
            albumImageView.heightAnchor.constraint(equalToConstant: 100),

            albumNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 8),
            albumNameLabel.leadingAnchor.constraint(equalTo: albumImageView.leadingAnchor),
            albumNameLabel.widthAnchor.constraint(lessThanOrEqualTo: albumImageView.widthAnchor),

            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 2),
            artistNameLabel.leadingAnchor.constraint(equalTo: albumNameLabel.leadingAnchor),
            artistNameLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with track: Album, index: Int) {
        albumNameLabel.text = "\(index+1). \(track.collectionName)"
        artistNameLabel.text = track.artistName
        albumImageView.setImage(from: track.artworkUrl100)
    }
}
