//
//  TitlePreviewViewController.swift
//  Netflix
//
//  Created by Aidos on 31.01.2023.
//

import UIKit
import WebKit
import SnapKit

class TitlePreviewViewController: UIViewController {

    
    // MARK: - private properties
    private let webView: WKWebView = WKWebView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Shawshank Redemption"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.text = "The best film i have ever seen sdjkdlasdlaskdjalskdjkalsdjkasldjasldjaksl"
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()

    }
    
    func configure(with viewModel: TitlePreviewVIewModel) {
        titleLabel.text = viewModel.title
        overviewLabel.text = viewModel.titleOverview
        
        guard let url = URL(string: "https://youtube.com/embed/\(viewModel.youTubeView.id.videoId)") else { return }
        webView.load(URLRequest(url: url))
                    
    }
    


}


private extension TitlePreviewViewController {
    func initialize() {
        view.addSubview(downloadButton)
        view.addSubview(overviewLabel)
        view.addSubview(titleLabel)
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).inset(-20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview()
        }
        
        downloadButton.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).inset(-25)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(130)
        }
    }
}
