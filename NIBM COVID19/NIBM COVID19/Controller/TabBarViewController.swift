//
//  TabBarViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/31/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {

    let tab = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureNavigationBar()
        tabBar()
        // Do any additional setup after loading the view.
    }
    
    func tabBar() {
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem.title = "HOME"
        homeViewController.tabBarItem.image = UIImage(named: "home")
        
            

        let updatedViewController = UpdateViewController()
        updatedViewController.tabBarItem.title = "UPDATE"
        updatedViewController.tabBarItem.image = UIImage(named: "plus")
        
        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem.title = "SETTINGS"
        settingsViewController.tabBarItem.image = UIImage(named: "Settings")
        
        tab.viewControllers = [homeViewController,updatedViewController,settingsViewController]
        self.view.addSubview(tab.view)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
       }

}
