//
//  ViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 09/04/2021.
//

import UIKit

// TODO:
// UIUpdate n'est pas appelé au bon endroit
// UITextInput
// Mettre toutes les correctData de FakeResponseData en une seule et même fonction?

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var cityName: UILabel!
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
    
    var weatherPhotoService = WeatherPhotoServiceUnsplash()
    var openWeatherService = OpenWeatherService()
    
    var resultNewyorkWeather: MainWeatherInfo?
    var resultLyonWeather: MainWeatherInfo?
    var resultCityPhoto: MainWeatherPhotoInfo?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityLocationSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        weatherInfoWhiteBackground.layer.masksToBounds = true
        weatherInfoWhiteBackground.layer.cornerRadius = 15
        weatherInfoWhiteBackground.layer.borderWidth = 3
        weatherInfoWhiteBackground.layer.borderColor = UIColor.quaternaryLabel.cgColor
        weatherIcon.addShadow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
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
    
    func fetchNewyorkWeather() {
        loadingWeatherActIndicator.isHidden = false
        openWeatherService.fetchWeatherData(cityId: WeatherCityID.newyork.cityID) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    self?.resultNewyorkWeather = weatherInfo
                    self?.updateUI(cityResults: self?.resultNewyorkWeather)
                    self?.fetchPhoto(Album.newyork.albumID)
                // fetchPhoto (in collection) "3541178", 2nd parameter is used to update UI from the right json results, depending on the city
                case .failure(let error):
                    print("error: \(error) for New York weather")
                    self?.errorFetchingData()
                }
            }
        }
    }
    
    func fetchLyonWeather() {
        loadingWeatherActIndicator.isHidden = false
        openWeatherService.fetchWeatherData(cityId: WeatherCityID.lyon.cityID) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherInfo):
                    self?.resultLyonWeather = weatherInfo
                    self?.updateUI(cityResults: self?.resultLyonWeather)
                    self?.fetchPhoto(Album.lyon.albumID)
                    
                // fetchPhoto in album, 2nd parameter is used to update UI from the right json results, depending on the city
                case .failure(let error):
                    print("error: \(error) for Lyon weather")
                    self?.errorFetchingData()
                }
            }
        }
    }
    
    func fetchPhoto(_ collectionId: String) {
        weatherPhotoService.fetchWeatherPhotoData(collectionId: collectionId) { [weak self] (result) in
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
    
    func updateImage() {
        guard let photo = resultCityPhoto else { return }
        cityPhoto.loadCityPhoto(photo.urls.regular)
        loadingWeatherActIndicator.isHidden = true
    }
    
    func updateUI(cityResults: MainWeatherInfo?) {
        guard let results = cityResults else { return }
        guard let resultsFirst = results.weather.first else { return } // .first calls the first element (city) in our weather array. Weather array has just one element, Lyon or Newyork.
        cityName.text = results.name
        temperature.text = "\(String(results.main.temp.shortDigitsIn(1)))°C"
        tempFeelsLike.text = "\(String(results.main.feels_like.shortDigitsIn(1)))°C ressentis"
        minimumTemp.text = "temp. mini : \(String(results.main.temp_min.shortDigitsIn(1)))°C"
        maximumTemp.text = "temp. maxi : \(String(results.main.temp_max.shortDigitsIn(1)))°C"
        skyDescription.text = results.weather[0].description.capitalizingFirstLetter()
        weatherIcon.loadIcon(resultsFirst.icon)
    }
}

