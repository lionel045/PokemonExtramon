import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject var viewModel: PokemonViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 1)

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.searchPokemon) { pokemon in
                            PokemonRowSubview(pokemon: pokemon)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .background(Color.black)
            
            .onAppear{
                viewModel.fetchPokemonUseCase()
            }
        }
    }
}

struct PokemonImageRow: View {
    var pokemon: PokemonEntities
    var height: CGFloat?
    var width: CGFloat?
    var body: some View {
        LazyVStack {
            if let imageURLString = pokemon.sprite?.regular, let imageURL = URL(string: imageURLString) {
            CacheAsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: width, height: height)
                                     .cornerRadius(8)
                            case .failure:
                                Image("pokeball")  .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        ProgressView()
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
