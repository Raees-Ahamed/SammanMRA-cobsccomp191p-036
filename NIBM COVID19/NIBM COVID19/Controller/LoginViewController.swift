//
//  LoginViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/23/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

     // MARK: - Properties
     private let titleLabel: UILabel = {
     
         let label = UILabel()
         label.text = "NIBM-COVID-19"
         label.font = UIFont(name: "Avenir-Light", size: 36)
         label.textColor = UIColor(white: 1, alpha: 0.8)
         
         return label
         
     }()
     
     private lazy var emailContainerView: UIView = {
         
         let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextFiled)
         view.heightAnchor.constraint(equalToConstant: 50).isActive = true
         return view
         
     }()
     
     private lazy var passwordContainerView: UIView = {
         
         let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
         view.heightAnchor.constraint(equalToConstant: 50).isActive = true
         return view
         
     }()
     
     
     private let emailTextFiled: UITextField = {
         
         return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
         
     }()
     
     private let passwordTextFiled: UITextField = {
         
         return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
         
     }()
     
     
       private let loginButton: AuthButtonUIButton = {
           let button = AuthButtonUIButton(type: .system)
           button.setTitle("Log In", for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
           button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
           return button
         
     }()

     let dontHaveAccountButton: UIButton = {
         
         let button = UIButton(type: .system)
         
         let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         
         attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
         
         
         button.setAttributedTitle(attributedTitle, for: .normal)
         button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
     
         return button
         
     }()
     
     // MARK: - Lifecycle

     override func viewDidLoad() {
         
         super.viewDidLoad()
         
         confugerNaviagationBar()
         
         view.backgroundColor = .backgroundColor
     
         view.addSubview(titleLabel)
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
         
     
     
         let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
         stack.axis = .vertical
         stack.distribution = .fillEqually
         stack.spacing = 16
         
         
         
         view.addSubview(stack)
         
         stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
         
     
         view.addSubview(dontHaveAccountButton)
         dontHaveAccountButton.centerX(inView: view)
         dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
         
     }

     // MARK: - Helper Functions
     func confugerNaviagationBar() {
         
         navigationController?.navigationBar.isHidden = true
         navigationController?.navigationBar.barStyle = .black
         
     }
    
    @objc func handleSignIn() {
        
         /*
         guard let email = emailTextFiled.text else { return }
         guard let password = passwordTextFiled.text else { return }
         
         Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
             if let error = error {
                 print("DEBUG: Faild to log user with error \(error.localizedDescription)")
                 return
             }
             
             print("Login Successful")
            
             let keyWindow = UIApplication.shared.connectedScenes
                 .filter({$0.activationState == .foregroundActive})
                 .map({$0 as? UIWindowScene})
                 .compactMap({$0})
                 .first?.windows
                 .filter({$0.isKeyWindow}).first
             
             guard let controller = keyWindow?.rootViewController as? HomeViewController else { return }
             controller.configureUi()
             
             self.dismiss(animated: true, completion: nil)
         }*/
        let name = emailTextFiled.text
        let password = passwordTextFiled.text
        if(name == "" || password == ""){
            popupAlert()
        }else{
            let tabBarViewController = TabBarViewController()
            navigationController?.pushViewController(tabBarViewController, animated: true)
        }
     }
    
    @objc func popupAlert(){
        
        let alert = UIAlertController(title: "Error",
                                    message: "Something you're missing to fill",
                                    preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("Great! Let's Play!")}))
  
        
        self.present(alert, animated: true)
        
    }
     
     // MARK: Functions
     @objc func handleShowSignUp() {
    
         let signUpViewController = SignUpViewController()
         navigationController?.pushViewController(signUpViewController, animated: true)
         
     }

}
