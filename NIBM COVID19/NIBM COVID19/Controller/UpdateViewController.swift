//
//  UpdateViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/31/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
    private let titleLabel: UILabel = {
    
        let label = UILabel()
        label.text = "Update"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        
        return label
        
    }()

      private let loginButton: AuthButtonUIButton = {
          let button = AuthButtonUIButton(type: .system)
          button.setTitle("create a survey >", for: .normal)
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
          button.addTarget(self, action: #selector(navigateToSurvey), for: .touchUpInside)
          return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    
    
    func configureUI(){
        
        view.addSubview(titleLabel)
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [loginButton])
                 stack.axis = .vertical
                 stack.distribution = .fillEqually
                 stack.spacing = 16
                 
                 view.addSubview(stack)
                 
                 stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
                 
    }
    
    @objc func navigateToSurvey(){
                 let signUpViewController = SurveyViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
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
