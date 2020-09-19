//
//  SettingsViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/31/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class SettingsViewController: UIViewController {

    var safeArea: UILayoutGuide!
       
       private let titleLbl: UILabel = {
           let label = UILabel()
           label.text = "Settings"
           label.font = UIFont(name: "Avenir-Light", size: 25)
           label.textColor = .black
           return label
       }()
       
       private let profileTile: UIButton = {
           let tile = UIButton()
           tile.backgroundColor = .white
            tile.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
           
           let title = UILabel()
           title.text = "Profile"
           title.textColor = .black
           tile.addSubview(title)
           title.anchor(top: tile.topAnchor, left: tile.leftAnchor, bottom: tile.bottomAnchor, paddingLeft: 20)
           title.centerY(inView: tile)
           
           let arrow = UIImageView()
           arrow.image = UIImage(systemName: "chevron.right")
           arrow.tintColor = .black
           arrow.layer.masksToBounds = true
           tile.addSubview(arrow)
           arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 24)
           arrow.centerY(inView: tile)
           
           let separatorView = UIView()
           separatorView.backgroundColor = .lightGray
           tile.addSubview(separatorView)
           separatorView.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
           
           return tile
       }()
       
       private let contactTile: UIButton = {
           let tile = UIButton()
           tile.backgroundColor = .white
           
           let title = UILabel()
           title.text = "Contact Us / About Us"
           title.textColor = .black
           tile.addSubview(title)
           //title.backgroundColor = .green
           title.anchor(top: tile.topAnchor, left: tile.leftAnchor, bottom: tile.bottomAnchor, paddingLeft: 20)
           title.centerY(inView: tile)
           
           let arrow = UIImageView()
           arrow.image = UIImage(systemName: "chevron.right")
           //arrow.backgroundColor = .green
           arrow.tintColor = .black
           arrow.layer.masksToBounds = true
           tile.addSubview(arrow)
           arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 24)
           arrow.centerY(inView: tile)
           
           let separatorView = UIView()
           separatorView.backgroundColor = .lightGray
           tile.addSubview(separatorView)
           separatorView.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
           
           tile.addTarget(self, action: #selector(showContactUs), for: .touchUpInside)
           
           return tile
       }()
       
       private let shareTile: UIButton = {
           let tile = UIButton()
           tile.backgroundColor = .white
           
           let title = UILabel()
           title.text = "Share with friend"
           title.textColor = .systemBlue
           tile.addSubview(title)
           title.anchor(top: tile.topAnchor, left: tile.leftAnchor, bottom: tile.bottomAnchor, paddingLeft: 14)
           title.centerY(inView: tile)
           
           let arrow = UIImageView()
           arrow.image = UIImage(systemName: "chevron.right")
           arrow.layer.masksToBounds = true
           tile.addSubview(arrow)
           arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 24)
           arrow.centerY(inView: tile)
                   
           tile.addTarget(self, action: #selector(showShareWithFriend), for: .touchUpInside)
           
           return tile
       }()
       
       private let blankView: UIView = {
           let blank = UIView()
           blank.backgroundColor = .white
           
           let separatorView = UIView()
           separatorView.backgroundColor = .lightGray
           blank.addSubview(separatorView)
           separatorView.anchor(left: blank.leftAnchor, bottom: blank.bottomAnchor, right: blank.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
           
           return blank
       }()
       
       private let logoutButton: UIButton = {
           let button = UIButton()
           button.backgroundColor = .white
           button.setTitle("LOGOUT", for: .normal)
           button.setTitleColor(.black, for: .normal)
           button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
           //button.addTextSpacing(2)
           button.addTarget(self, action: #selector(Logout), for: .touchUpInside)
           return button
       }()

    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()
    
    private let backLbl: UILabel = {
        let label = UILabel()
        label.text = "Go Back"
        label.font = UIFont(name: "Avenir-Light", size: 26)
        label.textColor = .black
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .black
           safeArea = view.layoutMarginsGuide
        
          checkUserLoggedIn()
          configureUI()
        tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configureUI(){
        configNavBar()
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(backLbl)
        backLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
              backLbl.centerX(inView: view)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
        
        view.addSubview(titleLbl)
        titleLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 70)
        titleLbl.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [profileTile, contactTile, shareTile])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 0
        
        view.addSubview(stack)
        stack.anchor( top: titleLbl.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor,paddingTop: 30, width: 100, height: 210)
        stack.centerY(inView: view)
        view.addSubview(logoutButton)
        
        logoutButton.anchor(left: view.leftAnchor, bottom: safeArea.bottomAnchor, right: view.rightAnchor, height: 60)
        
        view.addSubview(blankView)
        blankView.anchor(top: stack.bottomAnchor, left: view.leftAnchor, bottom: logoutButton.topAnchor, right: view.rightAnchor)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    
    @objc func showProfile(){
        let profile = ProfileViewController()
        profile.hidesBottomBarWhenPushed = true
        profile.modalPresentationStyle = .fullScreen
        self.present(profile,animated: true,completion: nil)
    }
    
    @objc func handleGoBack() {
       let Home = TabBarViewController()
       Home.hidesBottomBarWhenPushed = true
       Home.modalPresentationStyle = .fullScreen
       self.present(Home,animated: true,completion: nil)
    }
    
    @objc func showContactUs(){
        let contact = ContactUsViewController()
          contact.hidesBottomBarWhenPushed = true
          contact.modalPresentationStyle = .fullScreen
          self.present(contact,animated: true,completion: nil)
    }
    
    @objc func showShareWithFriend(){
        let contact = ContactUsViewController()
        contact.hidesBottomBarWhenPushed = true
        contact.modalPresentationStyle = .fullScreen
        self.present(contact,animated: true,completion: nil)
    }
    
    func checkUserLoggedIn(){
        if(Auth.auth().currentUser?.uid == nil){
            DispatchQueue.main.async {
                let login = LoginViewController()
                login.hidesBottomBarWhenPushed = true
                login.modalPresentationStyle = .fullScreen
                self.present(login,animated: true,completion: nil)
            }
        }else{
            print("user already logged in")
        }
    }
    
    @objc func Logout(){
        do{
            try Auth.auth().signOut()
            print("logged out")
            
            let login = LoginViewController()
            login.hidesBottomBarWhenPushed = true
            login.modalPresentationStyle = .fullScreen
            self.present(login,animated: true,completion: nil)
        }
        catch{
            print("signout error")
        }
    }
}
