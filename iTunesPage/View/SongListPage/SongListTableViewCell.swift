//
//  SongListTableViewCell.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/4.
//

import Foundation
import UIKit

class SongListTableViewCell: UITableViewCell {
    static let identifier = "SongTableViewCell"

    var heartButtonTappedClosure: (() -> Void)?

    let songNumberLabel = UILabel()
    let songImageView = UIImageView()
    let songTitleLabel = UILabel()
    let artistNameLabel = UILabel()
    
    let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(songNumberLabel)
        contentView.addSubview(songImageView)
        contentView.addSubview(songTitleLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(heartButton)

        songNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        songImageView.translatesAutoresizingMaskIntoConstraints = false
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false

        songNumberLabel.font = .systemFont(ofSize: 20)
        songNumberLabel.textAlignment = .center

        songTitleLabel.font = .systemFont(ofSize: 14)
        songTitleLabel.textAlignment = .left
        songTitleLabel.numberOfLines = 2

        artistNameLabel.textColor = .darkGray
        artistNameLabel.numberOfLines = 1
        artistNameLabel.font = .systemFont(ofSize: 14)

        NSLayoutConstraint.activate([
            songNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            songNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            songNumberLabel.widthAnchor.constraint(equalToConstant: 30),

            songImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            songImageView.leadingAnchor.constraint(equalTo: songNumberLabel.trailingAnchor, constant: 8),
            songImageView.widthAnchor.constraint(equalToConstant: 60),
            songImageView.heightAnchor.constraint(equalToConstant: 60),

            songTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            songTitleLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
            songTitleLabel.widthAnchor.constraint(equalToConstant: 220),

            artistNameLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 4),
            artistNameLabel.leadingAnchor.constraint(equalTo: songTitleLabel.leadingAnchor),
            artistNameLabel.trailingAnchor.constraint(equalTo: songTitleLabel.trailingAnchor),

            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            heartButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        heartButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func heartButtonTapped() {
        heartButtonTappedClosure?()
    }

    func configure(with track: MusicTrack, index: Int) {
        songNumberLabel.text = "\(index + 1)"
        songTitleLabel.text = track.trackName
        artistNameLabel.text = track.artistName
        songImageView.setImage(from: track.artworkUrl100)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        songTitleLabel.text = nil
        artistNameLabel.text = nil
        songImageView.image = nil
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
