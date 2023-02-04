//
//  TitleTableViewCell.swift
//  Netflix
//
//  Created by Aidos on 31.01.2023.
//

import UIKit
import SDWebImage

class TitleTableViewCell: UITableViewCell {
    
    
    // MARK: - static
    static let identifier = "TitleTableViewCell"
    
    
    // MARK: - private properties
    private let titlePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       initialize()
        
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - public
    
    func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        titlePosterImageView.sd_setImage(with: url)
        titleLabel.text = model.titleName
    }
    
    
    
    private func initialize() {
        contentView.addSubview(titlePosterImageView)
        titlePosterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(contentView.snp.top).inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(100)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titlePosterImageView.snp.trailing).inset(-20)
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(60)
            
        }
        
        contentView.addSubview(playTitleButton)
        playTitleButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    

}



    

