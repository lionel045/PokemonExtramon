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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PokemonExtramonApp.createViewModel()
        return ContentView().environmentObject(viewModel)
    }
}
