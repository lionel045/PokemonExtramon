//
//  InfoRectangleView.swift
//  PokemonExtramon
//
//  Created by Lion on 28/04/2024.
//

import SwiftUI

// MARK: Rectangle Who Embed Information
struct InfoRectangleView: View {
    let pokemon: PokemonEntities?
    var showEvolutionView : Bool {
        if pokemon?.evolution.next != nil || pokemon?.evolution.pre != nil {
            
            return true
        }
        else {
            return false
        }
    }
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: geometry.size
                        .width, height: geometry.size.height * 0.9)
                    .foregroundColor(Color.white.opacity(0.5))
                    .padding(.top, showEvolutionView ? geometry.size.height * 0.25 : geometry.size.height * 0.50)
              
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
        }
        
    }
}
struct InfoRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        
        let pokemon = PokemonViewModel.mockPokemon().pokemon[0]
        
        return InfoRectangleView(pokemon: pokemon)
    }
}
