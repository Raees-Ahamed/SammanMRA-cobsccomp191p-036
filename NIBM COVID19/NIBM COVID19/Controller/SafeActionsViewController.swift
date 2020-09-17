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
      //  self.title="Safe Actions"
        configureNavigationBar()
        self.view.backgroundColor=UIColor.systemGray6
        
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
        
        let que1 = safeAction(imgName: "handwash", headerText: "Wash your hands", description: " Washing your hands frequently will destroy the viruses and bacterias!!")
        let que2 = safeAction(imgName: "nocrowd", headerText: "Avoid crowd", description: "Please avoid visiting crowded places. Crowded places are the number one Covid 19 hotspots")
        let que3 = safeAction(imgName: "patient", headerText: "Wear facemask", description: "Wearing facemask will save yourself aswell as others from spreading diseases, it will reduces the spread of viruses")
        let que4 = safeAction(imgName: "handsanitizer", headerText: "Use hand sanitizer", description: "Sanitize your hand frequently will kill all the germs in your hands")
        let que5 = safeAction(imgName: "socialdistancing", headerText: "Maintain socialdistancing ?", description: "Maintain atleast 1 meter gap inbetween yourself and others when going out and follow covid 19 safe guidlines")
      
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //   setQuestionNumber()
    }
    
//    func setQuestionNumber() {
//        let x = myCollectionView.contentOffset.x
//        let w = myCollectionView.bounds.size.width
//        let currentPage = Int(ceil(x/w))
//        if currentPage < questionsArray.count {
//          //  lblQueNumber.text = "Question: \(currentPage+1) / \(questionsArray.count)"
//          //  currentQuestionNumber = currentPage + 1
//        }
//    }
    @objc func navToHome(){
        let vc = TabBarViewController()
                   self.navigationController?.pushViewController(vc, animated: true)
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
      // lblQueNumber.text = "Question: \(currentQuestionNumber) / \(questionsArray.count)"
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.myCollectionView.contentOffset.y ,width : self.myCollectionView.frame.width,height : self.myCollectionView.frame.height)
        self.myCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    func configureNavigationBar() {
         navigationController?.navigationBar.isHidden = true
    //  navigationController?.navigationBar.barStyle = .default
      
     }
    
    func setupViews() {
//        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive=true
//        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
//        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
//        myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive=true
        
        myCollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        self.view.addSubview(btnPrev)
//        btnPrev.heightAnchor.constraint(equalToConstant: 50).isActive=true
      
//        btnPrev.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
//        btnPrev.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive=true
        
       // btnPrev.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 20,paddingBottom: 40, height: 50,width: 100)
        // btnPrev.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive=true
        btnPrev.anchor(left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor,paddingLeft: 10 ,width: 100, height: 50)
        
        self.view.addSubview(btnNext)
//        btnNext.heightAnchor.constraint(equalTo: btnPrev.heightAnchor).isActive=true
      
//        btnNext.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
//        btnNext.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive=true
       // btnNext.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 40,paddingRight: 20,  height: 50,width: 100)
      //   btnNext.widthAnchor.constraint(equalTo: btnPrev.widthAnchor).isActive=true
        
//        self.view.addSubview(lblQueNumber)
//        lblQueNumber.heightAnchor.constraint(equalToConstant: 20).isActive=true
//        lblQueNumber.widthAnchor.constraint(equalToConstant: 150).isActive=true
//        lblQueNumber.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive=true
//        lblQueNumber.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive=true
//        lblQueNumber.text = "Question: \(1) / \(questionsArray.count)"
        btnNext.anchor( bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor,paddingRight: 10 ,height: 50)
        

    }
    
    let btnPrev: UIButton = {
        let btn=UIButton()
        btn.setTitle("PREVIOUS", for: .normal)
       // btn.setTitleColor(UIColor.white, for: .normal)
       // btn.backgroundColor=UIColor.orange
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
    
//    let lblQueNumber: UILabel = {
//        let lbl=UILabel()
//        lbl.text="0 / 0"
//        lbl.textColor=UIColor.gray
//        lbl.textAlignment = .left
//        lbl.font = UIFont.systemFont(ofSize: 16)
//        lbl.translatesAutoresizingMaskIntoConstraints=false
//        return lbl
//    }()
    
//    let lblScore: UILabel = {
//        let lbl=UILabel()
//        lbl.text="0 / 0"
//        lbl.textColor=UIColor.gray
//        lbl.textAlignment = .right
//        lbl.font = UIFont.systemFont(ofSize: 16)
//        lbl.translatesAutoresizingMaskIntoConstraints=false
//        return lbl
//    }()
}

extension SafeActionsViewController: SafeActionCollectionViewCellDelegate {
    func didChooseAnswer(btnIndex: Int) {
//        let centerIndex = getCenterIndex()
//        guard let index = centerIndex else { return }
//        questionsArray[index.item].isAnswered=true
//        if questionsArray[index.item].correctAns != btnIndex {
//            questionsArray[index.item].wrongAns = btnIndex
//            score -= 1
//        } else {
//            score += 1
//        }
//        lblScore.text = "Score: \(score) / \(questionsArray.count)"
//        myCollectionView.reloadItems(at: [index])
    }
    
    func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.myCollectionView.center, to: self.myCollectionView)
        let index = myCollectionView!.indexPathForItem(at: center)
        print(index ?? "index not found")
        return index
    }
}

