//
//  WeatherDetail.swift
//  DemoApp
//
//  Created by Ravi Vitash on 10/9/23.
//

import SwiftUI

struct WeatherDetail: View {
    var selectedCity: CityData
    @ObservedObject private var weatherViewModel: WeatherViewModel
    
    init(selectedCity: CityData) {
        self.selectedCity = selectedCity
        weatherViewModel = WeatherViewModel(city: selectedCity)
    }
    
    var body: some View {
        
        VStack( alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                AsyncImage(url: URL(string: weatherViewModel.imageURL)) { image in
                    image.resizable()
                }
                placeholder: {
                    Image(systemName: "photo")
                }
                .frame(width: 100, height: 100)
                
                Text(weatherViewModel.description)
                    .fixedSize(horizontal: false, vertical: true)
                    .fontWeight(.heavy)
            }
            // We can add localization here for these strings
            temperatureFields(title: "Temperature", value: weatherViewModel.temperature)
            temperatureFields(title: "Today's High:", value: weatherViewModel.hightTemp)
            temperatureFields(title: "Today's Low:", value: weatherViewModel.lowTemp)
        }
        .padding(10)
        .navigationTitle(selectedCity.name + " " + selectedCity.state )
        Spacer()
    }
}

struct temperatureFields: View {
    var title: String
    var value: String
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .fontWeight(.bold)
            Spacer(minLength: 20)
            Text(value)
            Spacer()
        }
        .padding(10)
        .cornerRadius(10)
    }
}

struct WeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetail(selectedCity: CityData(name: "Dallas",
                                             state: "Texas",
                                             country: "USA",
                                             lat: "35.31",
                                             lon: "-81.17"))
    }
}

