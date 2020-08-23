//
//  LoginView.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/22/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    
    //Mark :- Properties
    
    
    
    
   private lazy var emailContainerView: UIView = {
        let view = UIView()
        
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
        
        view.addSubview(emailTextFiled)
        emailTextFiled.centerY(inView: view)
        emailTextFiled.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        view.addSubview(separatorView)
        separatorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }()
    
    private lazy var passwordContainerField : UIView = {
       
        let view = UIView()
        
        let imageView = UIImageView()
               //imageView.image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        imageView.alpha = 0.87
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
               
        
        view.addSubview(passwordTextField)
        passwordTextField.centerY(inView: view)
        passwordTextField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        view.addSubview(separatorView)
        separatorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
        
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NTAXI"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        
        return label
    }()
    
    private var emailTextFiled: UITextField = {
        var tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        return tf
    }()
    
    private var passwordTextField: UITextField = {
        var tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.isSecureTextEntry = true
        tf.keyboardAppearance = .dark
        tf.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        return tf
    }()
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .red
       button.setTitle("Login", for: .normal)
        button.addTarget(self,action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var submitButtonContainer : UIView = {
       let view = UIView()
        
//        let imageView = UIImageView()
//                      //imageView.image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
//               imageView.alpha = 0.87
//               view.addSubview(imageView)
//               imageView.centerY(inView: view)
//               imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
        
        view.addSubview(loginButton)
        loginButton.centerY(inView: view)
        loginButton.anchor(left: view.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        
        return view
    }()
    
    
    
    
    
    //Mark :- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = .red
        
        
        view.addSubview(titleLabel)
             titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
             titleLabel.centerX(inView: view)
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16, height: 50)
        
        view.addSubview(passwordContainerField)
        passwordContainerField.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16, height: 50)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: passwordContainerField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16, height: 50)
        
        }
    
    @objc func buttonClicked(){
        
        let email = emailTextFiled.text!
        let password = passwordTextField.text!
        
        print("username  :",String(email))
        print("password  :",String(password))

    }

     
}


