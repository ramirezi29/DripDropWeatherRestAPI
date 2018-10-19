//
//  ViewControllerUI.swift
//  dripDrop_iOS22
//
//  Created by Ivan Ramirez on 10/18/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

extension weatherViewController {
    
    func updateUI() {
        updateBackgroundUI()
        CityLabelUPdateUI()
    }
}
extension weatherViewController {
    
    
    func updateBackgroundUI() {
        
        let backgroundImage = UIImageView(frame: view.frame)
        backgroundImage.image = UIImage(named: "mountainSunShade")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        backgroundImage.clipsToBounds = true
    }
    
    func CityLabelUPdateUI() {
        cityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        //    cityLabel
    }
}

/*
 let blueImage = UIImage(named: "blueWall")
 let imageView = UIImageView(image: blueImage)
 tableView.backgroundView = imageView
 imageView.contentMode = .scaleAspectFill
 
 //        let blurEffect = UIBlurEffect(style: .light)
 //        let blurView = UIVisualEffectView(effect: blurEffect)
 //        blurView.frame = imageView.bounds
 //        imageView.addSubview(blurView)
 //        imageView.clipsToBounds = true
 */
