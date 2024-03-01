//
//  Home.swift
//  MyWeather
//
//  Created by Nebula on 18.02.24.
//

import UIKit

protocol HomeInterface: AnyObject {
    func setupUI()
    func setGradient(topColor: UIColor, bottomColor: UIColor)
    func loadLabels(model : weatherModel)
    func loadWeatherImage(imageName : String) 
}

final class Home: UIViewController {
    
    lazy var viewModel = HomeViewModel()

    //UI Components
    private let SearchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search..."
        return sc
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        stack.isOpaque = true
        stack.layer.cornerRadius = 15
        return stack
    }()
    
    private let weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        return iv
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let windSpeed: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let Humidity: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    //viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        navigationItem.searchController = SearchController
        configureSearchController()
        viewModel.viewDidLoad()
    }
    
    //viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidAppear()
    }

}

extension Home: HomeInterface {
    func setupUI() {
        if UIDevice.current.orientation.isPortrait {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
        
        navigationItem.title = "MyWeather"
        self.view?.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ])
        
        stackView.addArrangedSubview(cityName)
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(windSpeed)
        stackView.addArrangedSubview(Humidity)
    }
    
    func loadLabels(model: weatherModel) {
        self.cityName.text = "\(model.name)"
        self.tempLabel.text = "\(model.main.temp.convertCelc()) C°"
        self.windSpeed.text = "Wind Speed: \(model.wind.speed) m/s"
        self.Humidity.text = "Humidity: \(model.main.humidity)%"
    }
    
    func loadWeatherImage(imageName:String) {
        weatherImage.image = UIImage(systemName: imageName)
    }
}

extension Home: UISearchResultsUpdating, UISearchBarDelegate {
    func configureSearchController() {
        SearchController.searchResultsUpdater = self
        SearchController.searchBar.delegate = self
    }
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCityLocation(cityName: SearchController.searchBar.text ?? "")
        SearchController.searchBar.text = nil
        view.endEditing(true)
    }
}
