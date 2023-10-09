//
//  ConnectionManager.swift
//  DemoApp
//
//  Created by Ravi Vitash on 10/9/23.
//

import Foundation
import Combine

// ConnectionManager will handle our api calls
final class  ConnectionManager {
    static let shared = ConnectionManager()
    private var cancellableSet: Set<AnyCancellable> = []
    private let session: URLSession?
    private init() {
        session = URLSession.shared
    }
    
    /// Use this method to fetch data from the network.
    /// - Parameter apiRequest : build api request with s`ApiRequest`
    /// - Parameter responseType: Pass data model type that you expect as a return type from the method.
    /// - Returns `Future<ResponseType, Error>`:  ResponseType is the same you passed when making this call
    ///
    func getData<ResponseType: Decodable>( apiRequest: ApiRequest, responseType: ResponseType.Type) -> Future<ResponseType, Error> {
        return Future<ResponseType, Error> { [weak self] promise in
            URLSession.shared.dataTaskPublisher(for: apiRequest.request)
                .tryMap { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode  else {
                        throw ConnectionError.networkError
                    }
                    if let json = try? JSONSerialization.jsonObject(with: element.data, options: .mutableContainers),
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                        print("Received Json: \(#file) \(#line) :: \n \(String(decoding: jsonData, as: UTF8.self))")
                    } else {
                        print("Error: \(#file) \(#line) :: json data malformed")
                    }
                    return element.data
                    
                }
                .decode(type: ResponseType.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .failure(let error):
                        print("Error: \(#file) \(#line) :: \(error.localizedDescription)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { (data) in
                    promise(Result.success(data))
                })
                .store(in: &self!.cancellableSet)
        }
    }
}
