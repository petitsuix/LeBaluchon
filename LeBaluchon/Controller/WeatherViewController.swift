//
//  ViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 09/04/2021.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var tempFeelsLike: UILabel!
    @IBOutlet weak var minimumTemp: UILabel!
    @IBOutlet weak var maximumTemp: UILabel!
    @IBOutlet weak var skyDescription: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityPhoto: UIImageView!
    @IBOutlet weak var weatherInfoWhiteBackground: UIView!
    @IBOutlet weak var cityLocationSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loadingWeatherActIndicator: UIActivityIndicatorView!
    @IBOutlet weak var weatherInfoStackView: UIStackView!
    
    private var resultNewyorkWeather: MainWeatherInfo?
    private var resultLyonWeather: MainWeatherInfo?
    private var resultCityPhoto: MainWeatherPhotoInfo?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityLocationSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal) // Changing segmented control's text color
        weatherInfoWhiteBackground.layer.masksToBounds = true
        weatherInfoWhiteBackground.layer.cornerRadius = 15
        weatherInfoWhiteBackground.layer.borderWidth = 3
        weatherInfoWhiteBackground.layer.borderColor = UIColor.quaternaryLabel.cgColor
        weatherIcon.addShadow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // ⬇︎ Ensures that a new request is done everytime the user switches from one view to another, so the data is kept up to date without having to launch the app again
        if cityLocationSegmentedControl.selectedSegmentIndex == 0 {
            fetchNewyorkWeather()
        } else {
            fetchLyonWeather()
        }
    }
    
    // MARK: - Methods
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fetchNewyorkWeather()
        } else {
            fetchLyonWeather()
        }
    }
    
    private func fetchNewyorkWeather() {
        loadingWeatherActIndicator.isHidden = false
        OpenWeatherService.shared.fetchWeatherData(cityId: WeatherCityID.newyork.cityID) { [weak self] (result) in // Calling request method. Weak self is to avoid any retain cycle that could provoke memory leaks and crashes (deinit could never be called, memory would never be freed)
            DispatchQueue.main.async { // Switching work item to asynchronous so it runs elsewhere while code is still being executed
                switch result {
                case .success(let weatherInfo):
                    self?.resultNewyorkWeather = weatherInfo
                    self?.updateUI(cityResults: self?.resultNewyorkWeather)
                    self?.fetchPhoto(Album.newyork.albumID)
                case .failure(let error):
                    print("error: \(error) for New York weather")
                    self?.errorFetchingData()
                }
            }
        }
    }
    
    private func fetchLyonWeather() {
        loadingWeatherActIndicator.isHidden = false
        OpenWeatherService.shared.fetchWeatherData(cityId: WeatherCityID.lyon.cityID) { [weak self] (result) in //
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    self?.resultLyonWeather = weatherInfo
                    self?.updateUI(cityResults: self?.resultLyonWeather)
                    self?.fetchPhoto(Album.lyon.albumID)
                case .failure(let error):
                    print("error: \(error) for Lyon weather")
                    self?.errorFetchingData()
                }
            }
        }
    }
    
    private func fetchPhoto(_ collectionId: String) {
        WeatherPhotoServiceUnsplash.shared.fetchWeatherPhotoData(collectionId: collectionId) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherPhotoInfo): // enum with associated value
                    self?.resultCityPhoto = weatherPhotoInfo.randomElement() // random photo in album
                    self?.updateImage()
                case .failure(let error):
                    print("error: \(error) for weather photo")
                    self?.errorFetchingData()
                }
            }
        }
    }
    
    private func updateImage() {
        guard let photo = resultCityPhoto else { return }
        cityPhoto.loadCityPhoto(photo.urls.regular)
        loadingWeatherActIndicator.isHidden = true
    }
    
    private func updateUI(cityResults: MainWeatherInfo?) {
        guard let results = cityResults else { return }
        guard let resultsFirst = results.weather.first else { return } // .first calls the first element (city) in our weather array. Weather array has just one element, Lyon or Newyork.
        temperature.text = "\(String(results.main.temp.shortDigitsIn(1)))°C"
        tempFeelsLike.text = "\(String(results.main.feels_like.shortDigitsIn(1)))°C ressentis"
        minimumTemp.text = "Temp. mini : \(String(results.main.temp_min.shortDigitsIn(1)))°C"
        maximumTemp.text = "Temp. maxi : \(String(results.main.temp_max.shortDigitsIn(1)))°C"
        skyDescription.text = results.weather[0].description.capitalizingFirstLetter()
        weatherIcon.loadIcon(resultsFirst.icon)
    }
}

