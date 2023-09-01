//
//  NetworkError.swift
//  CombinewithSwiftUI
//
//  Created by Consultant on 7/31/23.
//

import Foundation

enum NetworkError:Error{
    case inValidURLError
    case dataNotFoundError
    case parsingError
    case responseError
}


extension NetworkError:LocalizedError, Equatable{
    var errorDescription: String?{
        switch self {
            
        case .inValidURLError:
            return NSLocalizedString("API Endpoint", comment: "")
        case .dataNotFoundError:
            return NSLocalizedString("API failed to give us a response", comment: "")
        case .parsingError:
            return NSLocalizedString("We failed to parse the recieved response", comment: "")
        case .responseError:
            return NSLocalizedString("Got invalid status code", comment: "")
        }
    }
}

