//
//  HeaderUIView.swift
//  Netflix
//
//  Created by Aidos on 12.01.2023.
//

import UIKit
import SnapKit
import SDWebImage

class HeaderUIView: UIView {
    
    // MARK: - private props
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "avengers")
        return imageView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initalize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        
        imageView.sd_setImage(with: url)
    }
    
 

}

// MARK: - private methods

extension HeaderUIView {
    func initalize() {
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addGradient()
        
        addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(70)
            make.bottom.equalTo(-50)
            make.width.equalTo(120)
        }
        
        addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.trailing.equalTo(-70)
            make.bottom.equalTo(-50)
            make.width.equalTo(120)
        }
        
    }
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
}
