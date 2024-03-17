//
//  ContentView.swift
//  PokemonExtramon
//
//  Created by Lion on 07/03/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: PokemonViewModel
    var body: some View {
        
        PokemonListView()
      
    }
}

#Preview {
    let viewModel = PokemonViewModel()
    return ContentView()
         .environmentObject(viewModel)
 }
