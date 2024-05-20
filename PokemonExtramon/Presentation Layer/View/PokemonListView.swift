import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject var viewModel: PokemonViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 1)
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                SearchBar(text: $viewModel.searchText)
                    .padding()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.searchPokemon) { pokemon in
                            PokemonRowSubview(pokemon: pokemon)
                        }
                    }
                    .listStyle(.plain)
                }
                .refreshable {
                    viewModel.fetchPokemonUseCase()
                }
            }
            .scrollDismissesKeyboard(.immediately) //
            .background(Color.black)
            .onAppear {
                viewModel.fetchPokemonUseCase()
            }
        }
    }
}
struct PokemonRowSubview: View {
   let pokemon: PokemonEntities
    @EnvironmentObject var viewModel: PokemonViewModel
    
    var body: some View {
        NavigationLink(destination: PokemonDetailView(pokemonId: pokemon.id, showEvolutionView: pokemon.haveEvolution).environmentObject(viewModel)) {
            PokeCard(pokemon: pokemon)
        }
        .listRowBackground(Color.yellow.opacity(0.4))
        .listRowSeparator(.hidden)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let mock = PokemonViewModel.mockPokemon()
    return PokemonListView().environmentObject(mock)
}
