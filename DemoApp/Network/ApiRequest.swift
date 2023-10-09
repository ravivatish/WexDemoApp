//
//  ApiRequest.swift
//  DemoApp
//
//  Created by Ravi Vitash on 10/9/23.
//

import Foundation

// This enum will contain all the api endpoints used by ConnectionManager
enum ApiEndPoint: String {
    case getCities = "/geo/1.0/direct"
    case latLongWeather = "/data/2.5/weather"
    case image = "/img/wn/"
    
    private var baseURL : String {
        switch(self) {
        case .image:
            return "https://openweathermap.org"
        case .latLongWeather, .getCities :
            return "https://api.openweathermap.org"
        }
    }
    var completeURL: String {
        baseURL + self.rawValue
    }
}

// We are only using Get calls for this DemoApp, Added this enum if we need to extend
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

// I was thinking of bringing code to fetch images within this structure. But leaving now due to some time constraints.
enum Parameters {
    case iconName(String)
    case list([String: String])
}

// Api request builder
struct ApiRequest{
    private let api: ApiEndPoint
    private let httpMethod: HttpMethod
    private var params: Parameters
    private var completeURL: URL {
        var url = api.completeURL
        switch( params ) {
        case .iconName(let name) :
            url += name
        case .list(let dict):
            if (!dict.isEmpty) {
                url += "?"
                url += convertParams!
            }
        }
        url = url.replacingOccurrences(of:" ", with: "%20")
        return URL(string: url)!
    }
    
    private var convertParams: String? {
        var _convertParams: String = ""
        switch(params) {
        case .list(let dict):
            for (key, value) in dict {
                if (!_convertParams.isEmpty) {
                    _convertParams += "&"
                }
                _convertParams += key
                _convertParams += "="
                _convertParams += value
            }
        case .iconName(_): break
        }
        //Add Api Key
        _convertParams += "&appid=4e9ee6a7ae5b4106e483e61222946c1c"
        return _convertParams
    }
    
    var request: URLRequest {
        var request = URLRequest(url: completeURL)
        request.httpMethod = httpMethod.rawValue
        print("Rest request :\(#file) \(#line) :: \(request)")
        return request
    }
    
    /// Create and initialize APi Request for ConnectionManager
    /// - Parameter api: Define new api endpoint in the enum `ApiEndPoint`
    /// - Parameter httpMethod: default is set to .get, but you can choose from the enum
    /// - Parameter params: This field is use to add parameters to the get call
    init(api: ApiEndPoint, httpMethod: HttpMethod = .get, params: Parameters = .list([:])) {
        self.api = api
        self.httpMethod = httpMethod
        self.params = params
    }
}
