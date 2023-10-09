//
//  WeatherViewModel.swift
//  DemoApp
//
//  Created by Ravi Vitash on 10/9/23.
//

import Foundation
import Combine
import SwiftUI
 
final class WeatherViewModel: ObservableObject {
    
    // input
    private var city: CityData
    
    // output
    @Published var imageURL = ""
    @Published var temperature = ""
    @Published var hightTemp = ""
    @Published var lowTemp = ""
    @Published var description = ""
    
    private var cancellableSet: Set<AnyCancellable> = []

    private func convertTemp(temp: Double) -> String {
        // we can also utilize extension for this
        return String(temp) + " °F"
    }
    
    init(city: CityData) {
        self.city = city
        let weatherApi = ApiRequest(api: .latLongWeather, params: .list(["lat" : city.lat,
                                                                   "lon" : city.lon,
                                                                   "units": "imperial",
                                                                   "limit": "15"]))
        ConnectionManager.shared.getData(apiRequest: weatherApi, responseType: WeatherModel.self).sink { _ in
        } receiveValue: { [weak self] weatherData in
            self?.imageURL = ApiEndPoint.image.completeURL + weatherData.weather.first!.icon + "@2x.png"
            self?.temperature = self!.convertTemp(temp: weatherData.main.temp)
            self?.hightTemp = self!.convertTemp(temp: weatherData.main.tempMax)
            self?.lowTemp = self!.convertTemp(temp: weatherData.main.tempMin)
            
            if let data =  weatherData.weather.first {
                self?.description = data.description
            }
        }
        .store(in: &cancellableSet)
    }
}
