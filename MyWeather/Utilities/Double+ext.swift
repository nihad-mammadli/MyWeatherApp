//
//  KelvinToCelcius.swift
//  MyWeather
//
//  Created by Nebula on 24.02.24.
//

import Foundation

extension Double {
    func convertCelc() -> Double {
        let Kelvin:Double = 273.0
        let kelvinTemp = self
        let celciusTemp = kelvinTemp - Kelvin
        return celciusTemp.rounded()
    }
}
