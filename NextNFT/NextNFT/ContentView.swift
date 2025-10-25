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
            VStack {
                if viewModel.collections.isEmpty {
                    ProgressView("Loading Collections...")
                        .padding()
                } else {
                    List(viewModel.collections) { collection in
                        VStack(alignment: .leading) {
                            Text(collection.name)
                                .font(.headline)
                            Text(collection.description ?? "No description")
                                .font(.subheadline)
                                .lineLimit(2)
                            Text("Category: \(collection.category ?? "N/A")")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Collections")
            .onAppear {
                viewModel.fetchCollections()
            }
        }
    }
}



#Preview {
    ContentView()
}
