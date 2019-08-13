//
//  CAGradientLayer+Contacts.swift
//  Contacts
//
//  Created by Burak Akyalcin on 26.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    func makeGradient(topColor: UIColor, bottomColor: UIColor) -> CAGradientLayer {
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x:0.5, y: 1.0)
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        return gradientLayer
    }
}
