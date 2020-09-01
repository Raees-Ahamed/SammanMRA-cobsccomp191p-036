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
        view.backgroundColor = .purple
        
        tabBar()
        // Do any additional setup after loading the view.
    }
    
    func tabBar() {
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem.title = "HOME"
        
        
        let updatedViewController = UpdateViewController()
        updatedViewController.tabBarItem.title = "UPDATE"
        
        let settingsViewCOntroller = SettingsViewController()
        settingsViewCOntroller.tabBarItem.title = "SETTINGS"
        
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
