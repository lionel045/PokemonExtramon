import SwiftUI

struct PokemonDetailView: View {
    let pokemonId: Int
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: PokemonViewModel
    
    var drag: some Gesture {
          DragGesture()
              .onEnded { value in
                  // Détection d'un balayage de gauche à droite avec une certaine distance minimale
                  if value.translation.width > 100 && abs(value.translation.height) < 100 {
                      dismiss()
                  }
              }
      }
    
    var body: some View {
        ZStack {
            if let pokemon = viewModel.getPokemonById(pokemonId) {
                pokemon.color // Utilisation de la couleur basée sur le type
                    .ignoresSafeArea()
                Image("pokemon_background")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 300)
                    .foregroundColor(.white.opacity(1))
                    .offset(x: 100, y: -160)
                SubDetailView(pokemon: pokemon)
                VStack(spacing: 30) {
                    Spacer(minLength: 30)
                    Labelpkm(pokemon: pokemon)
                    //                        .padding(.top, 40)
                    ImagePkm(pokemon: pokemon)
                    Spacer(minLength: 390)
                }
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

struct SubDetailView: View {
    let pokemon: PokemonEntities
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: UIScreen.main.bounds.width, height: 450)
            .offset(y: 190)
            .foregroundColor(Color.white.opacity(0.6))
            .ignoresSafeArea(.all)
        
    }
}

struct Labelpkm: View {
    var pokemon: PokemonEntities
    var body: some View {
        VStack {
            Text("#\(pokemon.id)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(pokemon.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct ImagePkm: View {
    var pokemon: PokemonEntities
    var body: some View {
        VStack {
            if let imageURL = URL(string: pokemon.sprite?.regular ?? "") {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                } placeholder: {
                    ProgressView()
                }
            } else {
                ProgressView()
            }
            
        }
        
    }
}

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
                    Text(pokemon.name)
                }
                .bold()
                .foregroundColor(Color.black)
            }
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let bulbizarre = PokemonEntities(id: 1, generation: 1, category: "Graine", name: "Bulbizarre", stats: PokemonStats(hp: 45, attack: 49, defense: 49, spttack: 65, spdefense: 65, speed: 45), type: [TypeEntites(name: "Plante", image: nil)], talentsEntites: [], sprite: SpriteEntites(regular: "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/regular.png", shiny: nil), evolution: EvolutionEntites(pre: nil, next: nil, mega: nil), height: "0.7m", weight: "6.9kg", eggGroups: nil, sexe: nil, catchRate: nil, level100: nil)
        
        let viewModel = PokemonViewModel()
        viewModel.pokemon.append(bulbizarre)
        
        return PokemonDetailView(pokemonId: 1)
            .environmentObject(viewModel)
    }
}
