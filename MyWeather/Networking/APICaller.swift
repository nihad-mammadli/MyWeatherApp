//
//  APICaller.swift
//  MyWeather
//
//  Created by Nebula on 18.02.24.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case parsingError
}

public class APICaller {
    
    static func getWeather (latitude: Double, longitude: Double,
        completionHandler: @escaping (_ result: Result<weatherModel,NetworkError>) -> Void ) {
            let urlString = NetworkConstant.shared.serverAddress + "lat=\(latitude)&lon=\(longitude)&appid=" + NetworkConstant.shared.apiKey
            
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(.urlError))
                return
            }
            
            URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
                
                if
                   let data = dataResponse,
                   let resultData = try? JSONDecoder().decode(weatherModel.self, from: data) {
                    completionHandler(.success(resultData))
                } else {
                    completionHandler(.failure(.parsingError))
                }
                
            }.resume()
        }

}


