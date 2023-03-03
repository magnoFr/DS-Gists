//
//  GenericListViewController.swift
//  GistisProject
//
//  Created by Magno Augusto Ferreira Ruivo on 24/12/20.
//

import Foundation
import UIKit

class GenericListViewController: LoadableViewController<GistisListView> {

    private enum Dimension {
        static let sectionHeaderHeight: CGFloat = 90
    }

    // MARK: - Properties

    private let viewModel: GenericListViewModelProtocol

    // MARK: - Init

    init(viewModel: GenericListViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getList()
    }

    // MARK: - Methods

    private func setup() {
        observeStates()
        setupUI()
        viewModel.getList()
    }

    private func observeStates() {
        viewModel.observeStates { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                self.contentView.collectionView.reloadData()
            case .failure:
                // Any error implementation
                return
            case .default:
                break
            }
        }
    }
}

extension GenericListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            let cell: GenericListTopCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(config: viewModel.topCardConfig() as! GenericListTopCollectionViewCell.Config)
            cell.delegate = self
            return cell

        case .card:
            let cell: GenericListCardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(config: viewModel.card(row: indexPath.row) as! GenericListCardCollectionViewCell.Config)
            cell.delegate = self
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.getListByPage(index: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = viewModel.section(for: indexPath.section) else { return }
        if section == .card {
            viewModel.itemTapped(row: indexPath.row)
        }
    }
}

extension GenericListViewController: GenericListTopCollectionViewCellDelegate {
    func favoriteTapped() {
        viewModel.favoriteTapped()
    }
}

extension GenericListViewController: GenericListCardCollectionViewCellDelegate {
    func favoriteIconTapped(view: GenericListCardCollectionViewCell) {
        guard let index = contentView.collectionView.indexPath(for: view) else { return }
        viewModel.favoriteIconTapped(index: index.row)
    }
}

extension GenericListViewController: UIHelper {
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#7711DD")
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
        navigationController?.navigationBar.shadowImage = UIImage()
        setupBarBackButton(completion: nil)
        setStatusBarStyle(.lightContent)
    }

    func setupCollectionViews() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.collectionView.register(GenericListTopCollectionViewCell.self)
        contentView.collectionView.register(GenericListCardCollectionViewCell.self)
    }
}
