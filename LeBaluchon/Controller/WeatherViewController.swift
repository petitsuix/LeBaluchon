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
    
    @IBOutlet weak var localCityName: UILabel!
    @IBOutlet weak var localWeatherIcon: UIImageView!
    @IBOutlet weak var localSkyDescription: UILabel!
    @IBOutlet weak var localTemperature: UILabel!
    @IBOutlet weak var localTempFeelsLike: UILabel!
    @IBOutlet weak var localMinimumTemp: UILabel!
    @IBOutlet weak var localMaximumTemp: UILabel!
    
    var openWeatherApi = APIMeteo()
    var resultNewyorkWeather: MainWeatherInfo?
    var resultLyonWeather: MainWeatherInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        openWeatherApi.start(cityId: openWeatherApi.newyorkId) { (decodedData, error) in
            print(error ?? "")
            self.resultNewyorkWeather = decodedData
            self.updateUINewyork()
            
            self.openWeatherApi.start(cityId: self.openWeatherApi.lyonId) { (decodedData, error) in
                print(error ?? "")
                self.resultLyonWeather = decodedData
                self.updateUILyon()
            }
        }
    }
    
    func updateUILyon() {
        guard let lyon = resultLyonWeather else { return }
        guard let lyonFirst = lyon.weather.first else { return }
        DispatchQueue.main.async { [self] in
            self.localCityName.text = lyon.name
            self.localTemperature.text = String(lyon.main.temp)
            self.localTempFeelsLike.text = String(lyon.main.feels_like)
            self.localMinimumTemp.text = String(lyon.main.temp_min)
            self.localMaximumTemp.text = String(lyon.main.temp_max)
            self.localSkyDescription.text = lyon.weather[0].description
            self.localWeatherIcon.loadIcon(lyonFirst.icon)
        }
    }
    func updateUINewyork() {
        guard let ny = resultNewyorkWeather else { return }
        guard let nyFirst = ny.weather.first else { return }
        DispatchQueue.main.async { [self] in
            self.cityName.text = ny.name
            self.temperature.text = String(ny.main.temp)
            self.tempFeelsLike.text = String(ny.main.feels_like)
            self.minimumTemp.text = String(ny.main.temp_min)
            self.maximumTemp.text = String(ny.main.temp_max)
            self.skyDescription.text = ny.weather[0].description
            self.weatherIcon.loadIcon(nyFirst.icon)
        }
    }
}

