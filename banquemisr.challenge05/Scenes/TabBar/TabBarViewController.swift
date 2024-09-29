//
//  TabBarViewController.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create instances of your view controllers
        let nowPlayingVC = UINavigationController(rootViewController: NowPlayingViewController(type: .nowPlaying))
        let upcomingVC = UINavigationController(rootViewController: NowPlayingViewController(type: .upcoming))
        let popularVC = UINavigationController(rootViewController: NowPlayingViewController(type: .popular))

        // Set the titles and tab bar images
        nowPlayingVC.tabBarItem = UITabBarItem(title: "Now Playing", image: UIImage(named: "nowPlaying"), tag: 0)
        popularVC.tabBarItem = UITabBarItem(title: "Popular", image: UIImage(named: "popular"), tag: 1)
        upcomingVC.tabBarItem = UITabBarItem(title: "Upcoming", image: UIImage(named: "movieCamera"), tag: 2)

        // Assign the view controllers to the tab bar
        viewControllers = [nowPlayingVC, upcomingVC, popularVC]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        simpleAnnimationWhenSelectItem(item)
    }
    
    func simpleAnnimationWhenSelectItem(_ item: UITabBarItem){
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
}

