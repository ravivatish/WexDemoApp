//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Ravi Vitash on 10/9/23.
//

import Foundation
import Combine

struct CityData: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let state: String
    let country: String
    let lat: String
    let lon: String
}

class HomePageViewModel: ObservableObject {
    
    // Input
    @Published var text : String
    
    // Output
    @Published var cityList : [CityData] = []
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(text: String) {
        self.text = text
        $text.sink { text in
            let getCityApi = ApiRequest(api: .getCities, params: .list(["q" : text, "limit": "15"]))
            ConnectionManager.shared.getData(apiRequest: getCityApi, responseType: [GeocoderModel].self).sink { _ in
            } receiveValue: { list in
                self.cityList = []
                for item in list {
                    self.cityList.append(CityData(name: item.name, state: item.state, country: item.country, lat: String(item.lat), lon: String(item.lon)))
                }
            }.store(in: &self.cancellableSet)
        }
        .store(in: &cancellableSet)
    }
}
