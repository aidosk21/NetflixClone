//
//  MainViewController.swift
//  Netflix
//
//  Created by Aidos on 12.01.2023.
//

import UIKit

class MainViewController: UITabBarController {
// MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    
}

// MARK: - Private
private extension MainViewController {
    
    func initalize() {
        setViewControllers([generateVC(vc: UINavigationController(rootViewController: HomeViewController()), title: "Home", image: UIImage(systemName: "house")),
                            generateVC(vc: UINavigationController(rootViewController: UpcomingViewController()), title: "Coming", image: UIImage(systemName: "play.circle")),
                            generateVC(vc: UINavigationController(rootViewController: SearchViewController()), title: "Search", image: UIImage(systemName: "magnifyingglass")),
                            generateVC(vc: UINavigationController(rootViewController: DownloadsViewController()), title: "Downloads", image: UIImage(systemName: "arrow.down.circle"))
                           
                           ], animated: true)
        tabBar.tintColor = .label
    }
    
    func generateVC(vc: UIViewController, title: String?, image: UIImage?) -> UIViewController {
        vc.tabBarItem.image = image
        vc.tabBarItem.title = title
        return vc
    }
}
