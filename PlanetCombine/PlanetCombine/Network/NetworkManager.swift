//  NetworkManager.swift
//  MyFirstUIkitApp
//
//  Created by Bhushan Abhyankar on 07/07/2023.
//

import Foundation
import Combine

class NetworkManager: NetworkableProtocol{
    // trymap - to map data
    //.decode - for parsing
    //recive - this is for reciving actual output
    //.sink - for geting completing either data ot failure
    //.store - to clear out memory refrences, to deiniatilize an refrence or to cancel any task
    //merge - to mix and merge multiple streams
    //debounce - debounce- to delay responses
    
    func getDataFromAPI<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ (data: Data, response: URLResponse) in
                guard let httpResponse  = response as? HTTPURLResponse, 200...209 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            })
            .decode(type: type.self, decoder: JSONDecoder()) //- parsing
            .eraseToAnyPublisher()
    }

//
//    func getDataFromAPI<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
//
//        return URLSession.shared.dataTaskPublisher(for: urlRequest)
////            .delay(for: .seconds(5.0), scheduler: DispatchQueue.main)
//            .map{$0.data} // this was for raw data
//            .decode(type: type.self, decoder: JSONDecoder()) //- parsing
//            .eraseToAnyPublisher()
//    }
//
    
    

    
}
