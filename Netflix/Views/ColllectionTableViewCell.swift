//
//  ColllectionTableViewCell.swift
//  Netflix
//
//  Created by Aidos on 12.01.2023.
//

import UIKit
import SnapKit

protocol ColllectionTableViewCellDelegate: AnyObject {
    func colllectionTableViewCellDidTapCell(_ cell: ColllectionTableViewCell, model: TitlePreviewVIewModel)
}

class ColllectionTableViewCell: UITableViewCell {
    // MARK: static
  static let identifier = "ColllectionTableViewCell"
    
    var delegate: ColllectionTableViewCellDelegate?
    
    // MARK: - private
    
    private var titles = [Title]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - public
    func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    
    

}

// MARK: - private methods

private extension ColllectionTableViewCell {
    func initialize() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - ColllectionTableViewCell, UICollectionViewDataSource

extension ColllectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getMovie(with: titleName + "trailer") { result in
            switch result {
            case .success(let videoElement):
                let title = self.titles[indexPath.row]
                guard let titleOverview = title.overview else { return }
                let viewModel = TitlePreviewVIewModel(title: titleName, youTubeView: videoElement, titleOverview: titleOverview)
                self.delegate?.colllectionTableViewCellDidTapCell(self, model: viewModel)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    
    
    
}
