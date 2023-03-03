//
//  GistiDetailViewController.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 21/12/20.
//

import Foundation
import UIKit

class GistiDetailViewController: LoadableViewController<GistisListView> {

    private enum Dimension {
        static let sectionHeaderHeight: CGFloat = 90
    }

    // MARK: - Properties

    private let viewModel: GistiDetailViewModelProtocol

    // MARK: - Init

    init(viewModel: GistiDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Methods

    private func setup() {
        observeStates()
        setupUI()
    }

    private func observeStates() {
        viewModel.observeStates { [weak self] state in
            guard let _ = self else { return }
            switch state {
            case .default:
                break
            }
        }
    }
}

extension GistiDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(at: section)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = viewModel.section(for: indexPath.section) else { return UICollectionViewCell() }

        switch section {
        case .header:
            let cell: GistDetailTopCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(config: viewModel.topCardConfig() as! GistDetailTopCollectionViewCell.Config)
            return cell

        case .card:
            let cell: GistDetailCardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(config: viewModel.card(row: indexPath.row) as! GistDetailCardCollectionViewCell.Config)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = viewModel.section(for: indexPath.section) else { return }
        if section == .card {
            viewModel.itemTapped(row: indexPath.row)
        }
    }
}

extension GistiDetailViewController: UIHelper {
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#7711DD")
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
        navigationController?.navigationBar.shadowImage = UIImage()
        setupBarBackButton { [weak self] in
            guard let self = self else { return }
            self.viewModel.backTapped()
        }
        setStatusBarStyle(.lightContent)
    }

    func setupCollectionViews() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.collectionView.register(GistDetailTopCollectionViewCell.self)
        contentView.collectionView.register(GistDetailCardCollectionViewCell.self)
    }
}
