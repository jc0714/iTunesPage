//
//  SongCollectionViewCell.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/3.
//

import Foundation
import UIKit

class SongCollectionViewCell: UICollectionViewCell {
    static let identifier = "SongCollectionViewCell"

    var heartButtonTappedClosure: (() -> Void)?

    let songImageView = UIImageView()

    let songTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()

    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [songTitleLabel, artistNameLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()

    let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    @objc func heartButtonTapped() {
        heartButtonTappedClosure?()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(songImageView)
        contentView.addSubview(titleStackView)
        contentView.addSubview(heartButton)

        songImageView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            songImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            songImageView.widthAnchor.constraint(equalToConstant: 50),
            songImageView.heightAnchor.constraint(equalToConstant: 50),

            titleStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
            titleStackView.trailingAnchor.constraint(lessThanOrEqualTo: heartButton.leadingAnchor, constant: -8),

            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            heartButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with track: MusicTrack, index: Int) {
        songTitleLabel.text = "\(index+1). \(track.trackName)"
        artistNameLabel.text = track.artistName
        songImageView.setImage(from: track.artworkUrl100)
    }

    override func prepareForReuse() {
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
