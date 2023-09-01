//
//  UsersViewModel.swift
//  CombineWithSwiftUI
//
//  Created by Bhushan Abhyankar on 31/07/2023.
//

import Foundation
import Combine

class UsersViewModel:ObservableObject{
    
    @Published var planet:Planet?
    @Published var result:[Result] = []
    @Published var filteredresult :[Result] = []
    @Published var customError: NetworkError?
    
    private var cancelable = Set<AnyCancellable>()
    
    let networkManager: NetworkableProtocol
    
    init(networkManager: NetworkableProtocol) {
        self.networkManager = networkManager
        //        simpleUseCaseOfCombine()
    }
    
    
    func getPlanetsFromAPI(urlString: String) {
        guard let url = URL(string: urlString) else{
            return
        }
        let request = URLRequest(url: url)
        self.networkManager.getDataFromAPI(urlRequest: request, type: Planet.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Task finished")
                    break
                case .failure(let error):
                    switch error{
                    case is DecodingError:
                        self.customError = NetworkError.parsingError
                    case is URLError:
                        self.customError = NetworkError.inValidURLError
                    case NetworkError.dataNotFoundError:
                        self.customError = NetworkError.dataNotFoundError
                    case NetworkError.responseError:
                        self.customError = NetworkError.responseError
                    default:
                        self.customError = NetworkError.dataNotFoundError
                    }
                    print(self.customError?.localizedDescription as Any)
                }
            } receiveValue: { planet in
                self.planet = planet
                self.result = planet.results
                self.filteredresult = self.result
    
                
            }
            .store(in: &cancelable)
       
    }
    func filterUsersList(searchText:String){
        if searchText.isEmpty{
            self.filteredresult = self.result.sorted(by: { $0.name < $1.name })
        }else{
            let list =  self.result.filter { planet in
                return planet.name.localizedCaseInsensitiveContains(searchText)
            }
            self.filteredresult = list.sorted(by: { $0.name < $1.name })
        }
    }
    
    func cancelAPICall(){
        print("Cancelled the request")
        cancelable.first?.cancel()
    }
}
    
