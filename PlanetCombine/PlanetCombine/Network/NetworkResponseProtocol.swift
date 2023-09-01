//
//  NetworkResponseProtocol.swift
//  CombinewithSwiftUI
//
//  Created by Consultant on 7/31/23.
//

import Foundation
import Combine

protocol NetworkableProtocol{
    func getDataFromAPI<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T: Decodable
    
    
}
