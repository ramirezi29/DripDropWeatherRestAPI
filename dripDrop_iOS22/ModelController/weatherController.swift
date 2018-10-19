//
//  weatherController.swift
//  dripDrop_iOS22
//
//  Created by Ivan Ramirez on 10/18/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherController {
    
    static let shared = WeatherController()
    
    //NOTE: -
    private init() {}
    
    // NOTE: - Need to be optional bc theres a possibility we wont get back that data
    var arrayOfDailyWeathers: [DailyWeather]?
    var currentWeather: CurrentWeather?
    
    // NOTE: - Needs a location Manger bc we imported 'CoreLocation'
    let locationManger = CLLocationManager()
 
    let baseURL = URL(string: "https://api.darksky.net/forecast/")
    let apiKeyString = "8940fc22c0ed6b892125705b44e40965"
    
    // NOTE: - If it completes currently we have an array of DailyWeather
    func fetchWeeklyWeather(latitude: Double, longitude: Double, completion: @escaping ([DailyWeather]) -> Void) {
        
        // NOTE: - Step 1) Get the right URL
        guard let unwrappedURL = baseURL else { completion([]);  return }
        var url = unwrappedURL.appendingPathComponent(apiKeyString)
        url.appendingPathComponent("\(latitude),\(longitude)")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        // NOTE: - SEE NOTE AT THE END OF THE FILE: *exclude=[blocks] optional
        components?.queryItems = [URLQueryItem(name: "exclude", value: "[currently,hourly,flags]")]
        
        guard let finishedURL = components?.url else { completion([]); return}
        
        // NOTE: - check out URL just in case
        print(finishedURL.absoluteString)
        
        // NOTE: - Step 2) Calling the Data / 2.5) decoding your data
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("\n\n🚀 There was an error with our data in:\(#function); \n\(error); \n\(error.localizedDescription) 🚀\n\n")
                completion([]); return
            }
            // NOTE: - the error response codes will come back if theres an error. might be the same out come as the Wild Card
            print("\(response ?? URLResponse())")
            
            guard let data = data else { print("\n\nError with data\n"); completion([]); return
            }
                
            let decoder = JSONDecoder()
                
                do {
                    //NOTE: - try is optional and its in parentheses
                    let weatherService = try decoder.decode(Weather.self, from: data)
                    let arrayOfDailyWeathers = weatherService.weeklyWeatherData.data
                    self.arrayOfDailyWeathers = arrayOfDailyWeathers
                    self.currentWeather = weatherService.currently
                    completion(arrayOfDailyWeathers)
                    
                } catch {
                    print("\n\n🚀 There was an error with decoding the data in:\(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n"); completion([])
            }
        }.resume()
    }// 👩🏽‍🚒
}//🔥


/*exclude=[blocks] optional
 Exclude some number of data blocks from the API response. This is useful for reducing latency and saving cache space. The value blocks should be a comma-delimeted list (without spaces) of any of the following:
 
 currently
 minutely
 hourly
 daily
 //NOTE: Alerts is to warn people of weather events comig through
 alerts
 flags
 */

//https://darksky.net/dev/docs
//NOTE: - Personal Key
//4e255b621b8dc5821c76ed35f2f6afc2
//https://api.darksky.net/forecast/[key]/[latitude],[longitude]
//https://api.darksky.net/forecast/4e255b621b8dc5821c76ed35f2f6afc2/42.3601,-71.0589
//NOTE: - Class Key
//8940fc22c0ed6b892125705b44e40965
