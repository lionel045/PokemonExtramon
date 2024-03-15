//
//  PokemonExtramonApp.swift
//  PokemonExtramon
//
//  Created by Lion on 07/03/2024.
//

import SwiftUI

@available(iOS 14.0, *)
@main
struct PokemonExtramonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PokemonViewModel())
        }
    }
}
