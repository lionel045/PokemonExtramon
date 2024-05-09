//
//  InformationPokemonLabel.swift
//  PokemonExtramon
//
//  Created by Lion on 30/04/2024.
//

import SwiftUI

//MARK: Some information For pokemon
struct InformationPokemonLabel: View {
    var pokemon : PokemonEntities
    
    var body: some View {
        
        VStack {
            Text("Informations Pokemon")
                .font(.title)
                .foregroundColor(pokemon.colorBackground.first)
                .padding(.bottom , 10)
            
            HStack {
                
                //MARK: Weight
                
                Image(systemName:"scalemass")
                    .padding(.bottom, 50)
                
                VStack(alignment: .center) {
                    Text(pokemon.weight ?? "")
                        .font(.title3)
                        .font(.system(size: 18, design: .rounded))
                        .padding(.bottom, 30)
                    
                    Text("Poids")
                        .foregroundColor(Color(.systemGray))
                        .font(.caption)
                }
                
                Divider()
                    .frame(width: 2, height: 80)
                    .background(Color.black)
                
                // MARK: Height
                
                Image(systemName: "ruler")
                    .rotationEffect(Angle(degrees: 90))
                    .font(.system(size: 20))
                    .offset(x: 10)
                
                    .padding(.bottom, 50)
                
                VStack(alignment: .center,spacing: 37){
                    Text(pokemon.height ?? "")
                        .font(.system(size: 18, design: .rounded))
                    
                    Text("Taille")
                        .foregroundColor(Color(.systemGray))
                        .font(.caption)
                        .frame(alignment: .center)
                        .padding(.trailing)
                    
                }
                .padding(.trailing, 20)
                
                Divider()
                    .frame(width: 2, height: 80)
                    .background(Color.black)
                    .padding(.trailing,10)
                
                // MARK: Talent
                
                VStack(alignment : .center, spacing: 37) {
                    Text(pokemon.talentsEntites.first?.name ?? "")
                        .font(.system(size: 18, design: .rounded))

                    Text("Talent")
                        .foregroundColor(Color(.systemGray))
                        .font(.caption)
                }
            }
            .padding(.trailing, 30)
        }
    }
}


struct InformationPokemonLabel_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = PokemonViewModel.mockPokemon().pokemon[0]
        InformationPokemonLabel(pokemon: pokemon)
    }
}
