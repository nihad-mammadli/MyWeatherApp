//
//  HomeViewModel.swift
//  MyWeather
//
//  Created by Nebula on 18.02.24.
//

import UIKit

protocol HomeViewModelInterface {
    var view: HomeInterface? { get set }
    
    func viewDidLoad()
    func viewDidAppear()
    
}

enum weatherDescription: String {
    case scattered_clouds = "scattered clouds"
    case overcast_clouds = "overcast clouds"
    case light_snow = "light snow"
    case broken_clouds = "broken clouds"
    case light_rain = "light rain"
    case clear_sky = "clear sky"
}

final class HomeViewModel {
   
    //Mark: For setGradient Function Parameters
    var topColor: UIColor = .white
    var bottomColor: UIColor = .systemBlue
    //---------------------------------------
    
    weak var view : HomeInterface?
    var weatherInfo : [weatherModel] = []
}

extension HomeViewModel: HomeViewModelInterface {
    func getData() {
        let latitude = LocationManager.shared.userLocation?.coordinate.latitude
        let longitude = LocationManager.shared.userLocation?.coordinate.longitude
        
        APICaller.getWeather(latitude: Double(latitude ?? 0.0), longitude: Double(longitude ?? 0.0)) { result in
            switch result {
                case .success(let data):
                self.weatherInfo = [data]
                print(self.weatherInfo.first!)
                DispatchQueue.main.async { [self] in
                    self.view?.loadLabels(model: weatherInfo.first!)
                    self.configureWeatherImage(description: weatherInfo.first?.weather.first?.description ?? "")
                    print(weatherInfo.first?.weather.first?.description ?? "")
                }
                case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchCityLocation(cityName: String) {
        LocationManager.shared.getSearchedLocation(forPlaceCalled: cityName) { location in
            guard let location = location else { return }
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            APICaller.getWeather(latitude: Double(latitude), longitude: Double(longitude)) { result in
                switch result {
                    case .success(let data):
                    self.weatherInfo = [data]
                    print(self.weatherInfo.first!)
                    DispatchQueue.main.async { [self] in
                        self.view?.loadLabels(model: weatherInfo.first!)
                        self.configureWeatherImage(description: weatherInfo.first?.weather.first?.description ?? "")
                    }
                    case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getUserLocation() {
        LocationManager.shared.requestLocation()
        }
    
    func viewDidLoad() {
        getUserLocation()
        view?.setupUI()
    }
 
    func viewDidAppear() {
        getData()
        view?.setGradient(topColor: topColor, bottomColor: bottomColor)
    }
    
    func configureWeatherImage(description: String) {
        
        let weatherDesc = weatherDescription(rawValue: description)
        
        switch weatherDesc {
        case .clear_sky :
            view?.loadWeatherImage(imageName: "sun.max.fill")
        case .broken_clouds :
            view?.loadWeatherImage(imageName: "smoke.fill")
        case .light_rain :
            view?.loadWeatherImage(imageName: "cloud.rain.fill")
        case .light_snow :
            view?.loadWeatherImage(imageName: "cloud.snow.fill")
        case .overcast_clouds :
            view?.loadWeatherImage(imageName: "cloud.fill")
        case .scattered_clouds :
            view?.loadWeatherImage(imageName: "cloud.sun.fill")
        default:
            view?.loadWeatherImage(imageName: "cloud.fill")
            break
        }
    }
}
