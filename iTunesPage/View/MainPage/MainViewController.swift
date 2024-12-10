//
//  MainViewController.swift
//  iTunesPage
//
//  Created by J oyce on 2024/12/2.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    private let tableView = UITableView()
    private var viewModel = MainPageViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        setupTableView()
        viewModel.fetchSongs()
        viewModel.fetchAlbums()

        let backButton = UIBarButtonItem(title: "音樂", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    private func bindViewModel() {
        viewModel.$songs
            .receive(on: DispatchQueue.main)
            .sink { [weak self] songs in
                guard let self = self else { return }
                if let indexPath = self.indexPathForSection(0) {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
            .store(in: &cancellables)

        viewModel.$albums
            .receive(on: DispatchQueue.main)
            .sink { [weak self] albums in
                guard let self = self else { return }
                if let indexPath = self.indexPathForSection(1) {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 }
            .sink { [weak self] errorMessage in
                self?.showErrorAlert(message: errorMessage)
            }
            .store(in: &cancellables)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false

        tableView.register(SongsTableViewCell.self, forCellReuseIdentifier: SongsTableViewCell.identifier)
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.identifier)
        // 
//        tableView.register(TableViewHeader, forCellReuseIdentifier: "TableViewHeader")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "網路連線異常", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func indexPathForSection(_ section: Int) -> IndexPath? {
        return IndexPath(row: 0, section: section)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        // enum
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SongsTableViewCell.identifier, for: indexPath) as! SongsTableViewCell
            cell.songs = viewModel.songs
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as! AlbumTableViewCell
            cell.album = viewModel.albums
            return cell
        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = "🎵🎵🎵🎵🎵"
            return cell
        }
    }
}

// case eterable 解析錯誤也好用
enum section {
    case songs
    case album
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = section == 0 ? "Songs" : "Albums"
        // 可註冊
        return TableViewHeader(title: title, buttonTitle: "See More>", section: section, target: self, action: #selector(didTapSeeMore(_:)))
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    // 移到 header
    @objc private func didTapSeeMore(_ sender: UIButton) {
        if sender.tag == 0 {
            let songsListVC = SongsListViewController()
            songsListVC.songs = viewModel.songs
            navigationController?.pushViewController(songsListVC, animated: true)
        }
    }
}
