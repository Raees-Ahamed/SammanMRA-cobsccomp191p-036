//
//  LoginView.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/22/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "NIBM-Covid"
        label.font = UIFont(name:"Avenir-Light", size: 36)
        
        return label
    }()
    
    private var userNameText : UIView = {
       let text = UITextView()
        text.text = "Hello"
        text.font = UIFont(name:"Avenir-Light", size: 36)
        
        return text
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        
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
