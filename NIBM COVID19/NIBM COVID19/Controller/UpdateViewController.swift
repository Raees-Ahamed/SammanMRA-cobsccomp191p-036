//
//  UpdateViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/31/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//
import UIKit
import Firebase
import LocalAuthentication

class UpdateViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = .black
        return label
    }()
    
    // Notifications tile
    
    private let notificationsTile: UIButton = {
        let tileView = UIButton()
        tileView.backgroundColor = .white
        tileView.layer.cornerRadius = 5
        tileView.layer.masksToBounds = true
        tileView.addTarget(self, action: #selector(showNotifications), for: .touchUpInside)
        return tileView
    }()
    
    private let notificationsTileLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Notifications"
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = UIColor.black
        //label.backgroundColor = .red
        return label
    }()
    
    private let notificationsTileButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: boldConfig), for: .normal)
        return button
    }()
    
    // New survey tile
    
    private let surveyTileUIView: UIView = {
        let tileView = UIView()
        tileView.backgroundColor = .white
        tileView.layer.cornerRadius = 5
        tileView.layer.masksToBounds = true
        return tileView
    }()
    
    private let temperatureSubmitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .black
        button.setDimensions(height: 50, width: 80)
        button.setTitle("Submit temperature", for: .normal)
        button.addTarget(self, action: #selector(updateTemperature), for: .touchUpInside)
        return button
    }()
    
    let temperatureTextfield : UITextField = {
        let textField = UITextField()
        textField.placeholder = "ENTER TEMPERATURE"
        textField.textColor = .black
        textField.setDimensions(height: 50, width: 80)
        
        return textField
    }()
    

    
    private let surveyTile: UIButton = {
        let tileBtn = UIButton()
        tileBtn.backgroundColor = .white
        tileBtn.layer.cornerRadius = 5
        tileBtn.layer.masksToBounds = true
        tileBtn.addTarget(self, action: #selector(showSurvey), for: .touchUpInside)
        return tileBtn
    }()
    
    private let surveyTileLabel: UILabel = {
        let label = UILabel()
        label.text = "New Survey"
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = UIColor.black
        //label.backgroundColor = .red
        return label
    }()
    
    private let surveyTileButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: boldConfig), for: .normal)
        //button.backgroundColor = .green
        button.addTarget(self, action: #selector(showSurvey), for: .touchUpInside)
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
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Go Back"
        label.font = UIFont(name: "Avenir-Light", size: 26)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        checkUserLoggedIn()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    
        func configureUI() {
            configNavBar()
            view.backgroundColor = .systemGray6
            
            view.addSubview(titleLbl)
            titleLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
                  titleLbl.centerX(inView: view)
            
            view.addSubview(backButton)
            backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
            
            view.addSubview(titleLabel)
            titleLabel.anchor(top: backButton.bottomAnchor, paddingTop: 20)
            titleLabel.centerX(inView: view)
            
            view.addSubview(notificationsTile)
            notificationsTile.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
            
            view.addSubview(notificationsTileLabel)
            notificationsTileLabel.anchor(top: notificationsTile.topAnchor, left: notificationsTile.leftAnchor, paddingLeft: 25)
            notificationsTileLabel.centerY(inView: notificationsTile)
            
            view.addSubview(notificationsTileButton)
            notificationsTileButton.anchor(top: notificationsTile.topAnchor, right: notificationsTile.rightAnchor, width: 60)
            notificationsTileButton.centerY(inView: notificationsTile)
            
            // survey tile
            
            view.addSubview(surveyTile)
            surveyTile.anchor(top: notificationsTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)

            view.addSubview(surveyTileLabel)
            surveyTileLabel.anchor(top: surveyTile.topAnchor, left: surveyTile.leftAnchor, paddingLeft: 25)
            surveyTileLabel.centerY(inView: surveyTile)

            view.addSubview(surveyTileButton)
            surveyTileButton.anchor(top: surveyTile.topAnchor, right: surveyTile.rightAnchor, width: 60)
            surveyTileButton.centerY(inView: surveyTile)
            
            view.addSubview(temperatureTextfield)
            temperatureTextfield.anchor(top: surveyTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
            temperatureTextfield.centerX(inView: view)
            
            view.addSubview(temperatureSubmitButton)
            temperatureSubmitButton.anchor(top: temperatureTextfield.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
            temperatureSubmitButton.centerX(inView: view)
        }
        
        func configNavBar() {
            //navigationController?.navigationBar.barTintColor = .lightGray
            navigationController?.navigationBar.isHidden = true
            navigationController?.navigationBar.barStyle = .default
        }
        

        @objc func showNotifications() {
            let login = LoginViewController()
            login.hidesBottomBarWhenPushed = true
            login.modalPresentationStyle = .fullScreen
            self.present(login,animated: true,completion: nil)

        }
        
        @objc func showSurvey() {
            let survey = SurveyViewController()
            survey.hidesBottomBarWhenPushed = true
            survey.modalPresentationStyle = .fullScreen
            self.present(survey,animated: true,completion: nil)
            
    }
    
    @objc func updateTemperature(){
    
        let temperature = temperatureTextfield.text
        
        if(temperature == ""){
            popupAlert()
        }
        else{
            succesAlert()
        }
     
    }
    @objc func popupAlert(){
        
        let alert = UIAlertController(title: "Error",
                                    message: "Something you're missing to fill",
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            print("Great! Let's Play!")}))
        self.present(alert, animated: true)
        
    }

    @objc func succesAlert(){
           
           let alert = UIAlertController(title: "Success",
                                       message: "Temperature Updated",
                                       preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
               print("Great! Let's Play!")}))
           self.present(alert, animated: true)
           
       }
    
    @objc func handleGoBack() {
       let Home = TabBarViewController()
       Home.hidesBottomBarWhenPushed = true
       Home.modalPresentationStyle = .fullScreen
       self.present(Home,animated: true,completion: nil)
        
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
}
