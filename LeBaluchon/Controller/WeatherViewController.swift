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
    var resultWeather: MainWeatherInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        openWeatherApi.start { (decodedData, error) in
            print(error ?? "")
            self.resultWeather = decodedData
            self.updateUI()
        }
    }
    func updateUI() {
        guard let new = resultWeather else { return }
        guard let first = new.weather.first else { return }
        DispatchQueue.main.async { [self] in
            self.cityName.text = new.name
            self.temperature.text = String(new.main.temp)
            self.tempFeelsLike.text = String(new.main.feels_like)
            self.minimumTemp.text = String(new.main.temp_min)
            self.maximumTemp.text = String(new.main.temp_max)
            self.skyDescription.text = new.weather[0].description
            self.weatherIcon.loadIcon(first.icon)
        }
    }
}

