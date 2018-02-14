//
//  ViewController.swift
//  DraftBoard-Weather
//
//  Created by Konrad Wright on 2/13/18.
//  Copyright © 2018 Konrad Wright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var screen0: UIView!
    @IBOutlet weak var glow1: UIImageView!
    @IBOutlet weak var glow2: UIImageView!
    @IBOutlet weak var circleBtn: UIButton!
    let myGroup = DispatchGroup()
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.glow1.alpha = 0.0
        self.glow2.alpha = 0.0
        self.circleBtn.alpha = 0.0
        self.cityLbl.alpha = 0.0
        self.weatherLbl.alpha = 0.0
        self.glow1.isHidden = false
        self.glow2.isHidden = false
        self.circleBtn.isHidden = false
        self.cityLbl.isHidden = false
        self.weatherLbl.isHidden = false
        
        //Load in Weather API
        let weather = WeatherGetter()
        weather.getWeather(city:"Paso%20Robles")
        
        //Once loaded in, animate glow and button into view
        while weather.weatherIsReady == false {
            myGroup.enter()
            if (weather.weatherIsReady == true) {
                myGroup.leave()
                cityLbl.text = "Paso Robles"
                weatherLbl.text = weather.weatherConditions
                UIView.animate(withDuration: 1.5, animations: {
                    self.glow1.alpha = 1.0
                    self.glow2.alpha = 1.0
                    self.circleBtn.alpha = 1.0
                    self.cityLbl.alpha = 1.0
                    self.weatherLbl.alpha = 1.0
                })
            }
        }
    }

    //Button function to go to next screen
    @IBAction func circleBtnPressed(_ sender: Any) {
        UIView.animate(withDuration: 1.5, animations: {
            self.screen0.alpha = 0.0
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
