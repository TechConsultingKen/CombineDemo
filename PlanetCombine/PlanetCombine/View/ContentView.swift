//
//  ContentView.swift
//  PlanetCombine
//
//  Created by Consultant on 8/1/23.
//



import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var usersViewModel = UsersViewModel(networkManager: NetworkManager())
    @State var searchBar = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button("Cancel The API Request") {
                    usersViewModel.cancelAPICall()
                }
                List() {
                    ForEach(usersViewModel.filteredresult) { planet in
                        NavigationLink {
                            DetailsView(planet: planet)
                        } label: {
                            VStack(spacing: 20) {
                                Text(planet.name)
                                Text(planet.population)
                                Text(planet.climate)
                                
                            }
                        }
                        
                    }
                    
                }
                .refreshable {
                    usersViewModel.getPlanetsFromAPI(urlString: APIEndPoint.UsersEndPoint)
                }
                .searchable(text: $searchBar)
            }
            .onChange(of: searchBar, perform: { newValue in
                print(newValue)
                usersViewModel.filterUsersList(searchText: newValue)
            })
            .onAppear() {
                usersViewModel.getPlanetsFromAPI(urlString: APIEndPoint.UsersEndPoint)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

