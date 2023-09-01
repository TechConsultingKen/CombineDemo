//
//  DetailsView.swift
//  PlanetCombine
//
//  Created by Consultant on 8/1/23.
//

import SwiftUI

struct DetailsView: View {
    
    var planet: Result
    
        var body: some View {
            
                VStack{
                    Group{
                        Text(planet.name)
                        Text(planet.rotationPeriod)
                        Text(planet.orbitalPeriod)
                        Text(planet.diameter)
                        Text(planet.climate)
                        Text(planet.gravity)
                    }
                    
                    Group{
                        Text(planet.terrain)
                        Text(planet.surfaceWater)
                        Text(planet.population)
                        Text(planet.created)
                        Text(planet.edited)
                        Text(planet.url)
                    }
                
                }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(planet: Result(name: "", rotationPeriod: "", orbitalPeriod: "", diameter: "", climate: "", gravity: "", terrain: "", surfaceWater: "", population: "", residents: ["",""], films: ["",""], created: "", edited: "", url: ""))
    }
}
