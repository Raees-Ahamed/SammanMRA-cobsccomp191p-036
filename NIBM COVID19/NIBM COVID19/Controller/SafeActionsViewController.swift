//
//  SafeActionsViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 9/2/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit

struct safeAction {
    let imgName: String
    let headerText: String
    let description: String
   
}

class SafeActionsViewController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var myCollectionView: UICollectionView!
    var actionArray = [safeAction]()
    var score: Int = 0
    var currentQuestionNumber = 1
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        self.view.backgroundColor=UIColor.systemGray6
        
        view.addSubview(titleLbl)
        titleLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
              titleLbl.centerX(inView: view)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        myCollectionView=UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(SafeActionCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints=false
        myCollectionView.backgroundColor=UIColor.systemGray6
        myCollectionView.isPagingEnabled = true
        
        self.view.addSubview(myCollectionView)
        
        let que1 = safeAction(imgName: "washing-hands", headerText: "Wash your hands", description: " Washing your hands frequently will destroy the viruses and bacterias!!")
        let que2 = safeAction(imgName: "group", headerText: "Avoid crowd", description: "Please avoid visiting crowded places. Crowded places are the number one Covid 19 hotspots")
        let que3 = safeAction(imgName: "woman", headerText: "Wear facemask", description: "Wearing facemask will save yourself aswell as others from spreading diseases, it will reduces the spread of viruses")
        let que4 = safeAction(imgName: "washHand", headerText: "Use hand sanitizer", description: "Sanitize your hand frequently will kill all the germs in your hands")
        let que5 = safeAction(imgName: "keep-distance", headerText: "Maintain socialdistancing ?", description: "Maintain atleast 1 meter gap inbetween yourself and others when going out and follow covid 19 safe guidlines")
      
        actionArray = [que1, que2, que3,que4,que5]
        
        setupViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SafeActionCollectionViewCell
        cell.covidActions=actionArray[indexPath.row]
        cell.delegate=self
        return cell
    }
    
    
    @objc func navToHome(){
        let navHome = TabBarViewController()
        navHome.hidesBottomBarWhenPushed = true
        navHome.modalPresentationStyle = .fullScreen
        self.present(navHome,animated: true,completion: nil)
    }
    
    @objc func popAlert(){
        let alert = UIAlertController(title: "Safe Actions", message: "No more actions, please go back to Home", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in  self.navToHome()}))
        self.present(alert, animated: true)
    }
    
    @objc func btnPrevNextAction(sender: UIButton) {
        if sender == btnNext && currentQuestionNumber == actionArray.count {
          popAlert()
            return
        }
        
        let collectionBounds = self.myCollectionView.bounds
        var contentOffset: CGFloat = 0
        if sender == btnNext {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x + collectionBounds.size.width))
           currentQuestionNumber += currentQuestionNumber >= actionArray.count ? 0 : 1
        } else {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x - collectionBounds.size.width))
        currentQuestionNumber -= currentQuestionNumber <= 0 ? 0 : 1
        }
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.myCollectionView.contentOffset.y ,width : self.myCollectionView.frame.width,height : self.myCollectionView.frame.height)
        self.myCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    func configureNavigationBar() {
         navigationController?.navigationBar.isHidden = true
     }
    
    func setupViews() {
        
        myCollectionView.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 30)
        
        self.view.addSubview(btnPrev)
        btnPrev.anchor(left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,paddingLeft: 10 ,width: 100, height: 50)
        
        self.view.addSubview(btnNext)
        btnNext.anchor( bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor,paddingRight: 10 ,height: 50)
        

    }
    
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
    
    let btnPrev: UIButton = {
        let btn=UIButton()
        btn.setTitle("PREVIOUS", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.backgroundColor=UIColor.systemGray6
        btn.layer.borderColor = UIColor.systemGray6.cgColor
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnPrevNextAction), for: .touchUpInside)
        return btn
    }()
    
    let btnNext: UIButton = {
        let btn=UIButton()
        btn.setTitle("NEXT", for: .normal)
        
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.backgroundColor=UIColor.systemGray6
        btn.layer.borderColor = UIColor.systemGray6.cgColor
        btn.translatesAutoresizingMaskIntoConstraints=false
        
        btn.addTarget(self, action: #selector(btnPrevNextAction), for: .touchUpInside)
        return btn
    }()
}

extension SafeActionsViewController: SafeActionCollectionViewCellDelegate {
    func didChooseAnswer(btnIndex: Int) {
    }
    
    func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.myCollectionView.center, to: self.myCollectionView)
        let index = myCollectionView!.indexPathForItem(at: center)
        print(index ?? "index not found")
        return index
    }
    
    @objc func handleGoBack() {
       let home = TabBarViewController()
       home.hidesBottomBarWhenPushed = true
       home.modalPresentationStyle = .fullScreen
       self.present(home,animated: true,completion: nil)
        
    }
}

