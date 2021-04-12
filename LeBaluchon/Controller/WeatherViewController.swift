//
//  ViewController.swift
//  LeBaluchon
//
//  Created by Richardier on 09/04/2021.
//

import UIKit

class WeatherViewController: UIViewController {

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
        
        func updateUI() {
            guard let new = MainWeatherInfo else { return }
            print(new)
        }
    }


}

