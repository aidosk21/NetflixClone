//
//  UpcomingViewController.swift
//  Netflix
//
//  Created by Aidos on 12.01.2023.
//

import UIKit
import SnapKit

class UpcomingViewController: UIViewController {
    
    
    
    // MARK: - private properties
    
    private var titles = [Title]()
    
    private let upcomingTable: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()

    

    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()


    }
    

 

}

// MARK: - private methods
private extension UpcomingViewController {
    func initialize() {
        fetchUpcomingMovies()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        navigationController?.navigationBar.tintColor = .white
    }
    
    func fetchUpcomingMovies() {
        APICaller.shared.getUpcomingMovies { [weak self ] result in
            switch result {
            case .success(let title):
                self?.titles = title
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "Unknown", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getMovie(with: titleName) { result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async { [weak self] in
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewVIewModel(title: titleName, youTubeView: videoElement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
     
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
  
    
    
}
