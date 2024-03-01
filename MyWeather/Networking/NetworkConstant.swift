//
//  NetworkConstant.swift
//  MyWeather
//
//  Created by Nebula on 18.02.24.
//

import Foundation

class NetworkConstant {
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init() {
        // Singletone
    }
    
    public var apiKey: String {
        get {
            return "4045400b596a25cd2716909d3c37f27e"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.openweathermap.org/data/2.5/weather?"
        }
    }
}
