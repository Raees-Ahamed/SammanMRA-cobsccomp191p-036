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
        
        tabBar()
        // Do any additional setup after loading the view.
    }
    
    func tabBar() {
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem.title = "HOME"
        homeViewController.tabBarItem.image = UIImage(named: "Home")
        
            

        let updatedViewController = UpdateViewController()
        updatedViewController.tabBarItem.title = "UPDATE"
        updatedViewController.tabBarItem.image = UIImage(named: "plus")
        
        let settingsViewCOntroller = SettingsViewController()
        settingsViewCOntroller.tabBarItem.title = "SETTINGS"
        settingsViewCOntroller.tabBarItem.image = UIImage(named: "Settings")
        
        tab.viewControllers = [homeViewController,updatedViewController,settingsViewCOntroller]
        self.view.addSubview(tab.view)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
