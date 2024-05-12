import SwiftUI

@main
struct PokemonExtramonApp: App {
    var viewModel: PokemonViewModel

    init() {
        viewModel = PokemonExtramonApp.createViewModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

extension PokemonExtramonApp {
    //MARK: dependency injection static func
    static func createViewModel() -> PokemonViewModel {
        let dataSource = PokemonDataSourceImpl()
        let repo = PokemonRepoImpl(dataSource: dataSource)
        let useCase = FetchPokemonUseCaseImpl(repo: repo)
        return PokemonViewModel(pokemonUseCase: useCase)
    }
}
