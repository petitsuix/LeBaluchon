//
//  ViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 09/04/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var tempFeelsLike: UILabel!
    @IBOutlet weak var minimumTemp: UILabel!
    @IBOutlet weak var maximumTemp: UILabel!
    @IBOutlet weak var skyDescription: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityPhoto: UIImageView!
    
    var unsplashCityPhotoApi = UnsplashApi()
    var openWeatherApi = OpenWeatherApi()
    var resultNewyorkWeather: MainWeatherInfo?
    var resultLyonWeather: MainWeatherInfo?
    var resultCityPhoto: MainWeatherPhotoInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchNewyorkWeather()
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fetchNewyorkWeather()
        } else {
            fetchLyonWeather()
        }
    }
    
    func fetchNewyorkWeather() {
        openWeatherApi.fetchWeatherData(cityId: openWeatherApi.newyorkId) { [weak self] (result) in
            switch result {
            case .success(let weatherInfo):
                self?.resultNewyorkWeather = weatherInfo
                DispatchQueue.main.async { [weak self] in
                    self?.fetchPhoto("3541178", self?.resultNewyorkWeather)
                    // fetchPhoto (in collection) "3541178", 2nd parameter is used to update UI from the right json results, depending on the city
                }
            case .failure(let error):
                print(error)
                self?.errorFetchingData()
            }
        }
    }
    
    func fetchLyonWeather() {
        openWeatherApi.fetchWeatherData(cityId: openWeatherApi.lyonId) { [weak self] (result) in
            switch result {
            case .success(let weatherInfo):
                self?.resultLyonWeather = weatherInfo
                DispatchQueue.main.async { [weak self] in
                    self?.fetchPhoto("426804", self?.resultLyonWeather)
                    // fetchPhoto (in collection) "3541178", 2nd parameter is used to update UI from the right json results, depending on the city
                }
            case .failure(let error):
                print("error: \(error) for Lyon weather")
                self?.errorFetchingData()
            }
        }
    }
    
    func fetchPhoto(_ collectionId: String, _ cityResults: MainWeatherInfo?) {
        unsplashCityPhotoApi.fetchWeatherPhotoData(collectionId: collectionId) { [weak self] (result) in
            switch result {
            case .success(let weatherPhotoInfo):
                self?.resultCityPhoto = weatherPhotoInfo.randomElement()
                DispatchQueue.main.async { [weak self] in
                self?.updateUI(cityResults: cityResults)
                }
            case .failure(let error):
                print("error: \(error) for weather photo")
                self?.errorFetchingData()
            }
        }
    }

    func updateUI(cityResults: MainWeatherInfo?) {
        guard let results = cityResults else { return }
        guard let resultsFirst = results.weather.first else { return }
        guard let photo = resultCityPhoto else { return }
        self.cityName.text = results.name
        self.temperature.text = "\(String(results.main.temp.shortDigitsIn(1)))°C"
        self.tempFeelsLike.text = "\(String(results.main.feels_like.shortDigitsIn(1)))°C ressentis"
        self.minimumTemp.text = "temp. mini : \(String(results.main.temp_min.shortDigitsIn(1)))°C"
        self.maximumTemp.text = "temp. maxi : \(String(results.main.temp_max.shortDigitsIn(1)))°C"
        self.skyDescription.text = results.weather[0].description.capitalizingFirstLetter()
        self.weatherIcon.loadIcon(resultsFirst.icon)
        self.cityPhoto.loadCityPhoto(photo.urls.raw)
    }
}

