//
//  MapFullViewController.swift
//  NIBM COVID19
//
//  Created by Raees Samman on 9/18/20.
//  Copyright © 2020 Raees Samman. All rights reserved.
//


import UIKit
import MapKit

class MapFullViewController: UIViewController {

    var window: UIWindow?
    var mapView: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        
       // self.mapView = MKMapView(frame: CGRectMake(0, 20, (self.window?.frame.width)!, 300))
        self.view.addSubview(self.mapView!)
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

}
