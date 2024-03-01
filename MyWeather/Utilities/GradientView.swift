//
//  GradientLayer.swift
//  MyWeather
//
//  Created by Nebula on 24.02.24.
//

import UIKit


extension Home {
    
    func setGradient(topColor: UIColor , bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
        
}
