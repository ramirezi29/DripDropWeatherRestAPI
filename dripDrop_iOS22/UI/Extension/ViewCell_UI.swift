//
//  ViewCell_UI.swift
//  dripDrop_iOS22
//
//  Created by Ivan Ramirez on 10/18/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

extension WeatherCollectionViewCell {
    
    func updateLabelUI(){
        collectionSummaryLabelUI()
        tempLabelUIUpdate()
        dayOfTheWeekLabelUPdate()
        iconIMageLabelUpdate()
    }
}
extension WeatherCollectionViewCell{
    
    func collectionSummaryLabelUI() {
        collectionSummaryLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        collectionSummaryLabel.textColor = UIColor.white
    }
    
    func tempLabelUIUpdate() {
        
        tempLabel.layer.shadowOffset = CGSize(width: 3, height: 6)
        tempLabel.layer.shadowOpacity = 5.0
    }
    
    func dayOfTheWeekLabelUPdate() {
        
        dayOfTheWeekLabel.layer.shadowOffset = CGSize(width: 3, height: 6)
        dayOfTheWeekLabel.layer.shadowOpacity = 5.0
    }
    
    func iconIMageLabelUpdate() {
        
        iconImageLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        iconImageLabel.layer.shadowRadius = 10.0
        iconImageLabel.layer.shadowOpacity = 0.8
    }
}

