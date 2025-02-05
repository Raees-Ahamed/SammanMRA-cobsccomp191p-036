//
//  HomeViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 8/31/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit
import Firebase
import MapKit


private let reuseIdentifier = "LocationCell"
private let annotationIdentifier = "UserAnnotation"


class HomeViewController: UIViewController {


    //MARK: Properties

    private let userMap = MKMapView()
  
    // private let locationInputUIView = LocationInputView()
     private let locationManager = LocationHandling.shared.locationManager
     private var route: MKRoute?

    
    
    private let topViewContainer: UIView = {
           let containerView = UIView()
           containerView.backgroundColor = .white
           
           let iconImage = UIImageView()
           iconImage.image = UIImage(named: "woman")
           containerView.addSubview(iconImage)
           iconImage.anchor(left: containerView.leftAnchor, width: 150,height: 150 )
        //   iconImage.setDimensions(height: 150, width: 80)
           iconImage.centerY(inView: containerView)
           
           let topText = UILabel()
           topText.text = "All you need is"
           topText.font = UIFont(name: "Avenir-Medium", size: 26)
           containerView.addSubview(topText)
           topText.anchor(top: iconImage.topAnchor, left: iconImage.rightAnchor, paddingLeft: 34)
           
           let subTitle = UILabel()
           subTitle.text = "stay at home"
           subTitle.font = UIFont(name: "Avenir-Black", size: 30)
           containerView.addSubview(subTitle)
           subTitle.anchor(top: topText.bottomAnchor, left: iconImage.rightAnchor, paddingLeft: 34)
           
           let safeActions = UIButton()
           let imgConfig = UIImage.SymbolConfiguration(pointSize: 0, weight: .medium, scale: .small)
           safeActions.setTitle("Safe Actions ", for: .normal)
           safeActions.setTitleColor(.blue, for: .normal)
           safeActions.setImage(UIImage(systemName: "chevron.left", withConfiguration: imgConfig), for: .normal)
           safeActions.tintColor = .darkGray
           safeActions.titleLabel?.font = UIFont.systemFont(ofSize: 14)
           safeActions.semanticContentAttribute = .forceRightToLeft
           safeActions.sizeToFit()
          safeActions.addTarget(self, action: #selector(showSafeActions), for: .touchUpInside)
           containerView.addSubview(safeActions)
           safeActions.anchor(top: subTitle.bottomAnchor, left: iconImage.rightAnchor, paddingTop: 15, paddingLeft: 34)
           
           return containerView
       }()
       
    private let notificTile: UIButton = {
           let tile = UIButton()
           tile.backgroundColor = .white
           tile.layer.cornerRadius = 5
           tile.layer.masksToBounds = true
           
        let title = UILabel()
        title.text = "NIBM is closed until further notice"
        tile.addSubview(title)
        title.anchor(top: tile.topAnchor,  left: title.leftAnchor, right: tile.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingRight: 12)
        
           
           let description = UILabel()
           description.text = "Get quick update about lecture schedule stay tune with LMS"
           description.font = UIFont(name: "Avenir-Medium", size: 12)
           description.textColor = .darkGray
           description.numberOfLines = 2
           tile.addSubview(description)
           description.anchor(top: title.bottomAnchor,  left: tile.rightAnchor, right: tile.leftAnchor, paddingLeft: 12, paddingRight: 12)
           
        
           return tile
       }()
       
       private let caseTile: UIView = {
           let tile = UIView()
           tile.backgroundColor = .white
           
           let title = UILabel()
           title.text = "University Case Update"
           tile.addSubview(title)
           title.anchor(top: tile.topAnchor, left: tile.leftAnchor, paddingTop: 20, paddingLeft: 16)
           
           let moreBtn = UIButton()
           moreBtn.setTitle("See More", for: .normal)
           moreBtn.setTitleColor(.systemBlue, for: .normal)
           moreBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
           tile.addSubview(moreBtn)
           moreBtn.anchor(top: tile.topAnchor, right: tile.rightAnchor, paddingTop: 14, paddingRight: 16)
           
           let timeAgo = UILabel()
           timeAgo.text = "1 minute ago"
           timeAgo.font = UIFont(name: "Avenir-Medium", size: 11)
           timeAgo.textColor = .darkGray
           tile.addSubview(timeAgo)
           timeAgo.anchor(top: title.bottomAnchor, left: tile.leftAnchor, paddingLeft: 16)
           
           let infectedUI = UIView()
           
           let deathsUI = UIView()
           
           let recoveredUI = UIView()
           
           let yellowDot = UIImageView()
           yellowDot.image = UIImage(systemName: "smallcircle.fill.circle")
           yellowDot.tintColor = .systemYellow
           infectedUI.addSubview(yellowDot)
           yellowDot.anchor(top: infectedUI.topAnchor, paddingTop: 18)
           yellowDot.centerX(inView: infectedUI)

           let redDot = UIImageView()
           redDot.image = UIImage(systemName: "smallcircle.fill.circle")
           redDot.tintColor = .systemRed
           deathsUI.addSubview(redDot)
           redDot.anchor(top: deathsUI.topAnchor, paddingTop: 18)
           redDot.centerX(inView: deathsUI)

           let greenDot = UIImageView()
           greenDot.image = UIImage(systemName: "smallcircle.fill.circle")
           greenDot.tintColor = .systemGreen
           recoveredUI.addSubview(greenDot)
           greenDot.anchor(top: recoveredUI.topAnchor, paddingTop: 18)
           greenDot.centerX(inView: recoveredUI)

           let infectedCount = UILabel()
           infectedCount.text = "3"
           infectedCount.font = UIFont(name: "Avenir-Medium", size: 52)
           infectedUI.addSubview(infectedCount)
           infectedCount.anchor(top: yellowDot.bottomAnchor, paddingTop: 12)
           infectedCount.centerX(inView: infectedUI)

           let deathsCount = UILabel()
           deathsCount.text = "0"
           deathsCount.font = UIFont(name: "Avenir-Medium", size: 52)
           deathsUI.addSubview(deathsCount)
           deathsCount.anchor(top: redDot.bottomAnchor, paddingTop: 12)
           deathsCount.centerX(inView: deathsUI)

           let recoveredCount = UILabel()
           recoveredCount.text = "12"
           recoveredCount.font = UIFont(name: "Avenir-Medium", size: 52)
           recoveredUI.addSubview(recoveredCount)
           recoveredCount.anchor(top: greenDot.bottomAnchor, paddingTop: 12)
           recoveredCount.centerX(inView: recoveredUI)
           
           let infectedLbl = UILabel()
           infectedLbl.text = "Infected"
           infectedLbl.font = UIFont(name: "Avenir-Medium", size: 14)
           infectedLbl.textColor = .darkGray
           infectedUI.addSubview(infectedLbl)
           infectedLbl.anchor(top: infectedCount.bottomAnchor)
           infectedLbl.centerX(inView: infectedUI)
           
           let deathsLbl = UILabel()
           deathsLbl.text = "Deaths"
           deathsLbl.font = UIFont(name: "Avenir-Medium", size: 14)
           deathsLbl.textColor = .darkGray
           deathsUI.addSubview(deathsLbl)
           deathsLbl.anchor(top: deathsCount.bottomAnchor)
           deathsLbl.centerX(inView: deathsUI)
           
           let recoveredLbl = UILabel()
           recoveredLbl.text = "Recovered"
           recoveredLbl.font = UIFont(name: "Avenir-Medium", size: 14)
           recoveredLbl.textColor = .darkGray
           recoveredUI.addSubview(recoveredLbl)
           recoveredLbl.anchor(top: recoveredCount.bottomAnchor)
           recoveredLbl.centerX(inView: recoveredUI)
           
           let countStack = UIStackView(arrangedSubviews: [infectedUI, deathsUI, recoveredUI])
           countStack.axis = .horizontal
           countStack.distribution = .fillEqually
           countStack.spacing = 0
           tile.addSubview(countStack)
           countStack.anchor(top: timeAgo.bottomAnchor, left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor)
           
           return tile
       }()
       
       private let mapTile: UIView = {
           let tile = UIView()
           return tile
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configController()
    }

    // MARK: - API
    



    // MARK: - Helper Function
    
    func configController() {
        configureNavigationBar()
        configureUI()
    }

    
    // MARK: - Configuring UI

    func configureUI(){
         configureNavigationBar()
        view.backgroundColor = .systemGray6
               view.addSubview(topViewContainer)
        topViewContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 30 * view.bounds.height/100)
        topViewContainer.anchor(paddingTop: 30)
        
        view.addSubview(notificTile)
        notificTile.anchor(top: topViewContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 80)
        
        view.addSubview(caseTile)
        caseTile.anchor(top: notificTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, height: 25 * view.bounds.height/100)
        
        
        view.addSubview(mapTile)
        mapTile.addSubview(userMap)
        
        userMap.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 220)
                       //userMap.frame = view.frame
                       print(userMap.bounds.height)
                       userMap.showsUserLocation = true
                       userMap.userTrackingMode = .follow
                       userMap.delegate = self
        
        mapTile.anchor(top: caseTile.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
      // setMap()
    }

//
//    func setMap(){
//
//       mapTile.addSubview(userMap)
//               userMap.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 220)
//               //mapView.frame = view.frame
//               print(userMap.bounds.height)
//               userMap.showsUserLocation = true
//               userMap.userTrackingMode = .follow
//               userMap.delegate = self
//    }

    // MARK: - Navigation

    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
       }


   

     // MARK: - Selectors
        
        @objc func showSafeActions() {
            let safeActions = SafeActionsViewController()
            safeActions.hidesBottomBarWhenPushed = true
            safeActions.modalPresentationStyle = .fullScreen
            self.present(safeActions,animated: true,completion: nil)
        }


    func signOut() {
                  do {
                      try Auth.auth().signOut()
                  } catch {
                      print("DEBUG: sign out error")
                  }
              }
    }


// MARK: - MKMapViewDelegate

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? UserAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            view.image = UIImage(systemName: "mappin.circle.fill")
            view.image?.withTintColor(.red)
            //view.tintColor = .red
            return view
        }
        return nil
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let route = self.route {
            let polyline = route.polyline
            let lineRenderer = MKPolylineRenderer(overlay: polyline)
            lineRenderer.strokeColor = .mainBlueTint
            lineRenderer.lineWidth = 4
            return lineRenderer
        }
        return MKOverlayRenderer()
    }
}

// MARK: - LocationServices

extension HomeViewController {
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse:
            locationManager?.requestAlwaysAuthorization()
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        default:
            break
        }
    }
}



