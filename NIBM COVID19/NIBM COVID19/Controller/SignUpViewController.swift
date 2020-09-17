//
//  SignUpViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/23/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

  // MARK: - Properties
     
     private let titleLabel: UILabel = {
         let label = UILabel()
         label.text = "Create an account"
         label.font = UIFont(name: "Avenir-Light", size: 36)
         label.textColor = UIColor(white: 1, alpha: 0.8)
         
         return label
     }()
     
     private lazy var emailContainerView: UIView = {
         let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextFiled )
         view.heightAnchor.constraint(equalToConstant: 50).isActive = true
         return view
     }()
     
     private lazy var fullNameContainerView: UIView = {
         let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextFiled )
         view.heightAnchor.constraint(equalToConstant: 50).isActive = true
         return view
     }()
     
     private lazy var passwordContainerView: UIView = {
         let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
         view.heightAnchor.constraint(equalToConstant: 50).isActive = true
         return view
     }()
     
     private lazy var accountTypeContainerView: UIView = {
         let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_account_box_white_2x"), segentedControl: accountTypeSegmentedControl)
         view.heightAnchor.constraint(equalToConstant: 80).isActive = true
         return view
     }()
     
     private let emailTextFiled: UITextField = {
         return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
     }()
     
     private let fullNameTextFiled: UITextField = {
         return UITextField().textField(withPlaceholder: "Full Name", isSecureTextEntry: false)
     }()
     
     private let passwordTextFiled: UITextField = {
         return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
     }()
     
     private let accountTypeSegmentedControl: UISegmentedControl = {
         let sc = UISegmentedControl(items: ["Staff", "Student"])
        sc.backgroundColor = .purple
         sc.tintColor = UIColor(white: 1, alpha: 0.87)
         sc.selectedSegmentIndex = 0
         
         return sc
     }()
     
     private let signUpButton: AuthButtonUIButton = {
         let button = AuthButtonUIButton(type: .system)
         button.setTitle("Sign Up", for: .normal)
         button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
         button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
         
         return button
     }()

     let alreadyHaveAccountButton: AuthButtonUIButton = {
         let button = AuthButtonUIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])

        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))

         button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)

         button.setAttributedTitle(attributedTitle, for: .normal)
         return button
     }()
     
     // MARK: - Lifecycale
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         configureUI()
     }
     
     // MARK: - Helper Function
       
     func configureUI() {
         view.backgroundColor = .white
         
         view.addSubview(titleLabel)
         titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
         titleLabel.centerX(inView: view)
         
         let stack = UIStackView(arrangedSubviews: [emailContainerView, fullNameContainerView, passwordContainerView, accountTypeContainerView,signUpButton])
         stack.axis = .vertical
         stack.distribution = .fillProportionally
         stack.spacing = 24
         
         view.addSubview(stack)
         stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
         
         view.addSubview(alreadyHaveAccountButton)
         alreadyHaveAccountButton.centerX(inView: view)
         alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
 }
    
       // MARK: - Selectors
        
    
        
        @objc func handleSignUp() {
            
            guard let email = emailTextFiled.text else { return }
            guard let password = passwordTextFiled.text else { return }
            guard let fullName = fullNameTextFiled.text else { return }
            let accountType = accountTypeSegmentedControl.selectedSegmentIndex
            
            let values = [
                "email": email,
                "fullName": fullName,
                "accountType": accountType
                ] as [String : Any]
            
            if(email == "" || password == "" || fullName == ""){
                popupAlert()
            }else{
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    print("Faild to register user with error \(error)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                    
                    print("DEBUG: Successfuly Registerd and save data..")
                }
              }
            }
        }
        
        @objc func handleShowLogIn() {
            navigationController?.popViewController(animated: true)
        }
    
      @objc func popupAlert(){
          
          let alert = UIAlertController(title: "Error",
                                      message: "Something you're missing to fill",
                                      preferredStyle: .alert)
          
          alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
              print("Great! Let's Play!")}))
    
          
          self.present(alert, animated: true)
          
      }
    
}
     
