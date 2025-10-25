//
//  ContentView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 13.07.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CollectionsViewModel()
    
    var body: some View {
        NavigationView {
            HomeView(viewModel: viewModel)
                .navigationBarHidden(true)
        }
    }
}




#Preview {
    ContentView()
}
