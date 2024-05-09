import SwiftUI

struct PokemonDetailView: View {
    let pokemonId: Int
    @State  var showEvolutionView : Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: PokemonViewModel
    
    var drag: some Gesture {
        DragGesture()
            .onEnded { value in
                
                if value.translation.width > 100 && abs(value.translation.height) < 100 {
                    dismiss()
                }
            }
    }
    
    var body: some View {
        GeometryReader { geometry in
        ZStack {
            if let pokemon = viewModel.getPokemonById(pokemonId) {
                pokemon.colorBackground.first
                    .ignoresSafeArea()
                Image("pokemon_background")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: geometry.size.height * 0.25)
                    .foregroundColor(.white.opacity(1))
                    .offset(x: 125, y: -250)
                    
                InfoRectangleView(pokemon: pokemon)
                    .ignoresSafeArea()
                VStack(spacing: geometry.size.height < 800 ? 0 : 30) {
                    Labelpkm(pokemon: pokemon).padding(.top, geometry.size.height < 800 ? -40 : 0 )
                    
                    SpritePkm(pokemon: pokemon, frame: showEvolutionView ? geometry.size.height * 0.23 : geometry.size.height * 0.40, minWidth: 120)
                    
                        PokemonsTypeView(pokemon: pokemon)
                        InformationPokemonLabel(pokemon: pokemon)
                        StatsListView(pokemon: pokemon)
                            .padding(.bottom, showEvolutionView ? 0 : 10)

                    EvolutionView(pokemon: pokemon, showEvolution: $showEvolutionView, viewModel: viewModel)
                 
                    }
                .padding(.bottom, 40)
                .toolbar {
                    CustomToolbar(pokemon: pokemon)
                }
                .navigationBarBackButtonHidden(true)
            } else {
                Text("Pokémon introuvable")
                    .foregroundColor(.white)
            }
        }
        .gesture(drag)
    }
}
}

struct StatsListView: View {
    let pokemon: PokemonEntities
    
    var body: some View {
        VStack {
 
            StatsView(pokemon: pokemon, currentStats: pokemon.stats.hp, nameOfStats: "HP")
            StatsView(pokemon: pokemon, currentStats: pokemon.stats.attack, nameOfStats: "ATK")
            StatsView(pokemon: pokemon, currentStats: pokemon.stats.defense, nameOfStats: "DEF")
            StatsView(pokemon: pokemon, currentStats: pokemon.stats.spttack, nameOfStats: "SATK")
            StatsView(pokemon: pokemon, currentStats: pokemon.stats.spdefense, nameOfStats: "SDEF")
            StatsView(pokemon: pokemon, currentStats: pokemon.stats.speed, nameOfStats: "SPD")
        }

    }
}



//MARK: Custom Toolbar

struct CustomToolbar: ToolbarContent {
    let pokemon: PokemonEntities
    @Environment(\.dismiss) var dismiss
    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button(action: {
                dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    
                }
                .bold()
                .foregroundColor(Color.black)
            }
        }
    }
}



struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PokemonViewModel.mockPokemon()
        
        Group {
            PokemonDetailView(pokemonId: 3, showEvolutionView: viewModel.pokemon[0].haveEvolution)
                .environmentObject(viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
            
            PokemonDetailView(pokemonId: 3, showEvolutionView: viewModel.pokemon[0].haveEvolution)
                .environmentObject(viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")
           
        }
    }
}
