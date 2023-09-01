//
//  FakeNetworkManager.swift
//  PlanetCombineTests
//
//  Created by Consultant on 8/1/23.
//

import Foundation
import Combine
@testable import PlanetCombine

class FakeNetworkManager:NetworkableProtocol{
    func getDataFromAPI<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        let bundle = Bundle(for: FakeNetworkManager.self)
        let urlString = urlRequest.url?.absoluteString
        guard let url = bundle.url(forResource: urlString, withExtension: "json") else{
            return Fail(error: NetworkError.inValidURLError).eraseToAnyPublisher()
        }
        do{
            let data = try Data(contentsOf: url)
            let userList = try JSONDecoder().decode(type.self, from: data)
            return Just(userList)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }catch{
            print(error.localizedDescription)
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
