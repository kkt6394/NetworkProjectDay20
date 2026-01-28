//
//  MainTabBarController.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/28/26.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    func configureTabBar() {
        let searchVC = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let topicVC = TopicViewController()
        let topicNav = UINavigationController(rootViewController: topicVC)
        topicNav.tabBarItem = UITabBarItem(title: "토픽", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 1)
        
        setViewControllers([searchNav, topicNav], animated: true)
    }

}
