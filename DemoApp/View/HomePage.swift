//
//  HomePage.swift
//  DemoApp
//
//  Created by Ravi Vitash on 10/9/23.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject private var homePageViewModel = HomePageViewModel(text: " ")
    var body: some View {
        NavigationStack{
            VStack {
                SearchBar(text: $homePageViewModel.text)
                List($homePageViewModel.cityList, id: \.self) { $city in
                    NavigationLink(value: city) {
                        HStack {
                            Text(city.name)
                            Text(city.state)
                            Text(city.country)
                        }
                    }
                }
                // adding a very basic navigation here, we can delegate this responsibility to the view model
                // or we can create a complete independent navigation manager, depend on our requirements
                
                .navigationDestination(for: CityData.self) { geoData in
                    WeatherDetail(selectedCity: geoData)
                }
            }
            .padding()
        }
        // we can utilize theme for this
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
