//
//  LoginViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/23/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class LoginViewController: UIViewController {

     // MARK: - Properties
     private let titleLabel: UILabel = {
     
         let label = UILabel()
         label.text = "LogIn"
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
         configureUI()
         view.backgroundColor = .white

         
     }

     // MARK: - Helper Functions
    
    func configureUI(){
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
    
     func confugerNaviagationBar() {
         navigationController?.navigationBar.isHidden = true
         navigationController?.navigationBar.barStyle = .black
     }
    
    @objc func handleSignIn() {
        guard let email = emailTextFiled.text else { return }
        guard let password = passwordTextFiled.text else { return }

        if(email == "" || password == ""){
            popupAlert()
        }else{
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    print("DEBUG: Faild to log user with error \(error.localizedDescription)")
                    return
                }
                
                    
                let context = LAContext()
                var error: NSError?

                if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                    let reason = "Identify yourself!"

                    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                        [weak self] success, authenticationError in

                        DispatchQueue.main.async {
                            if success {
                                let ac = UIAlertController(title: "Authentication success", message: "Well Done", preferredStyle: .alert)
                                ac.addAction(UIAlertAction(title: "Happy", style: .default))
                                self?.present(ac, animated: true)
                            } else {
                                let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                                ac.addAction(UIAlertAction(title: "OK", style: .default))
                                self?.present(ac, animated: true)
                            }
                        }
                    }
                } else {
                    let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
                
            }
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
    
     @objc func handleShowSignUp() {
         let signup = SignUpViewController()
         signup.hidesBottomBarWhenPushed = true
         signup.modalPresentationStyle = .fullScreen
         self.present(signup,animated: true,completion: nil)
     }

}
