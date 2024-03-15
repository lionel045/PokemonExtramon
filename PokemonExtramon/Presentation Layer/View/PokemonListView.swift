import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject var viewModel: PokemonViewModel
    var body: some View {
        NavigationStack {
            List(viewModel.searchPokemon) { pokemon in
                PokemonRowSubview(pokemon: pokemon)
            }
            .listRowSeparatorTint(.yellow.opacity(0.5))
            .background(Color.yellow.opacity(0.4))
            .listStyle(.plain)
            .listRowSpacing(12)
            
        }
        .searchable(text: $viewModel.searchText, prompt: "Pokemon")
        
    }
    
}

struct PokemonImageRow: View {
    var pokemon: PokemonEntities // Correctly expecting a PokemonEntity
    var body: some View {
        HStack {
            if let imageURL = URL(string: pokemon.sprite?.regular ?? "") {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
            } else {
                ProgressView()
            }
            Text(pokemon.name)
        }
    }
}

struct PokemonRowSubview: View {
   let pokemon: PokemonEntities
    @EnvironmentObject var viewModel: PokemonViewModel
    
    var body: some View {
        NavigationLink(destination: PokemonDetailView(pokemonId: pokemon.id).environmentObject(viewModel)) {
            PokemonImageRow(pokemon: pokemon)
        }
        .navigationBarBackButtonHidden()

        .listRowBackground(Color.yellow.opacity(0.2)) // Définit l'arrière-plan pour chaque ligne
    }
}













#Preview {
    let testPokemon: [PokemonEntities] = [
        PokemonEntities(id: 1, generation: 1, category: "Graine", name: "Bulbizarre", stats: PokemonStats(hp: 45, attack: 49, defense: 49, spttack: 65, spdefense: 65, speed: 45), type: [TypeEntites(name: "Plante", image: nil)], talentsEntites: [], sprite: SpriteEntites(regular: "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/regular.png", shiny: nil), evolution: EvolutionEntites(pre: nil, next: nil, mega: nil), height: "0.7m", weight: "6.9kg", eggGroups: nil, sexe: nil, catchRate: nil, level100: nil),
        PokemonEntities(id: 2, generation: 1, category: "Graine", name: "Herbizarre", stats: PokemonStats(hp: 60, attack: 62, defense: 63, spttack: 80, spdefense: 80, speed: 60), type: [TypeEntites(name: "Plante", image: nil)], talentsEntites: [], sprite: SpriteEntites(regular: "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/2/regular.png", shiny: nil), evolution: EvolutionEntites(pre: nil, next: nil, mega: nil), height: "1.0m", weight: "13.0kg", eggGroups: nil, sexe: nil, catchRate: nil, level100: nil),
        PokemonEntities(id: 3, generation: 1, category: "Graine", name: "Florizarre", stats: PokemonStats(hp: 80, attack: 82, defense: 83, spttack: 100, spdefense: 100, speed: 80), type: [TypeEntites(name: "Plante", image: nil)], talentsEntites: [], sprite: SpriteEntites(regular: "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/3/regular.png", shiny: nil), evolution: EvolutionEntites(pre: nil, next: nil, mega: nil), height: "2.0m", weight: "100.0kg", eggGroups: nil, sexe: nil, catchRate: nil, level100: nil)
    ]
    let viewModel = PokemonViewModel(testData: testPokemon)
    return PokemonListView().environmentObject(viewModel)
}

