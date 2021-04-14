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
    
    var openWeatherApi = APIMeteo()
    var resultNewyorkWeather: MainWeatherInfo?
    var resultLyonWeather: MainWeatherInfo?
    
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
        openWeatherApi.start(cityId: openWeatherApi.newyorkId) { [weak self] (decodedData, error) in
            print(error ?? "")
            self?.resultNewyorkWeather = decodedData
            DispatchQueue.main.async {
                self?.updateUINewyork()
            }
        }
    }
    
    func fetchLyonWeather() {
        openWeatherApi.start(cityId: self.openWeatherApi.lyonId) { [weak self] (decodedData, error) in
            print(error ?? "")
            self?.resultLyonWeather = decodedData
            DispatchQueue.main.async {
                self?.updateUILyon()
            }
        }
    }
    
    func updateUILyon() {
        guard let lyon = resultLyonWeather else { return }
        guard let lyonFirst = lyon.weather.first else { return }
        self.cityName.text = lyon.name
        self.temperature.text = "\(String(lyon.main.temp.shortDigitsIn(1)))°C"
        self.tempFeelsLike.text = "\(String(lyon.main.feels_like.shortDigitsIn(1)))°C ressentis"
        self.minimumTemp.text = "Temp mini : \(String(lyon.main.temp_min.shortDigitsIn(1)))°C"
        self.maximumTemp.text = "Temp maxi : \(String(lyon.main.temp_max.shortDigitsIn(1)))°C"
        self.skyDescription.text = lyon.weather[0].description
        self.weatherIcon.loadIcon(lyonFirst.icon)
    }
    func updateUINewyork() {
        guard let ny = resultNewyorkWeather else { return }
        guard let nyFirst = ny.weather.first else { return }
        self.cityName.text = ny.name
        self.temperature.text = "\(String(ny.main.temp.shortDigitsIn(1)))°C"
        self.tempFeelsLike.text = "\(String(ny.main.feels_like.shortDigitsIn(1)))°C ressentis"
        self.minimumTemp.text = "Temp mini : \(String(ny.main.temp_min.shortDigitsIn(1)))°C"
        self.maximumTemp.text = "Temp maxi : \(String(ny.main.temp_max.shortDigitsIn(1)))°C"
        self.skyDescription.text = ny.weather[0].description
        self.weatherIcon.loadIcon(nyFirst.icon)
    }
}

