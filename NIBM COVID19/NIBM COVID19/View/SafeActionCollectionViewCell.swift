//
//  SafeActionCollectionViewCell.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 9/17/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//

import UIKit


protocol SafeActionCollectionViewCellDelegate: class {
    func didChooseAnswer(btnIndex: Int)
}


class SafeActionCollectionViewCell: UICollectionViewCell {
    
    var btn1: UIButton!
    var btn2: UIButton!
  // var btnsArray = [UIButton]()
    
    weak var delegate: SafeActionCollectionViewCellDelegate?
    
    var covidActions: safeAction? {
        didSet {
            guard let unwrappedQue = covidActions else { return }
            imgView.image = UIImage(named: unwrappedQue.imgName)
            lblHeader.text = unwrappedQue.headerText
            lblDes.text = unwrappedQue.description
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
       // btnsArray = [btn1, btn2]
    }

    func setupViews() {
        addSubview(imgView)
        imgView.centerX(inView: self)
        
        addSubview(lblHeader)
        lblHeader.anchor(top: imgView.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingRight: 12,height: 50)
        
        addSubview(lblDes)
        lblDes.anchor(top: lblHeader.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 12,  paddingRight: 12,height: 150)
    }
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblHeader: UILabel = {
        let lbl=UILabel()
        lbl.text="Action header"
        lbl.textColor=UIColor.black
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines=4
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblDes: UILabel = {
          let lbl=UILabel()
          lbl.text="Action description"
          lbl.textColor=UIColor.black
          lbl.textAlignment = .center
          lbl.font = UIFont.systemFont(ofSize: 12)
          lbl.numberOfLines=4
          lbl.translatesAutoresizingMaskIntoConstraints=false
          return lbl
      }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     
}
