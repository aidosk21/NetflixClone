//
//  TitleCollectionViewCell.swift
//  Netflix
//
//  Created by Aidos on 29.01.2023.
//

import UIKit
import SnapKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - static
    static let identifier = "TitleCollectionViewCell"
    
   
    
    
    // MARK: - private properties
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - public
    func configure(with url: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(url)") else { return }
        posterImage.sd_setImage(with: url)

        
    }
    
}

// MARK: - private methods
private extension TitleCollectionViewCell {
    func initialize() {
        
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


