//
//  ContentView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 13.07.25.
//

import SwiftUI

@available(iOS 26.0, *)
struct ContentView: View {
    @StateObject private var viewModel = CollectionNFTsViewModel()
    
    var body: some View {
        NavigationView {
            MainTabView()
        }
    }
}




#Preview {
    if #available(iOS 26.0, *) {
        ContentView()
    } else {
        // Fallback on earlier versions
    }
}
