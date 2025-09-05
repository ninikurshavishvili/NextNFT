//
//  ContentView.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 13.07.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NFTViewModel()
    
    var body: some View {
        VStack {
            Text("NFTs: \(viewModel.nfts.count)")
                .padding()
            
            NavigationView {
                List(viewModel.nfts) { nft in
                    VStack(alignment: .leading) {
                        Text(nft.collectionName ?? "collection Name")
                            .font(.headline)
                            .foregroundStyle(.red)
                        Text("Creator: \(String(describing: nft.creator))")
                            .font(.subheadline)
                        Text("Price: \(String(describing: nft.price))")
                            .font(.footnote)
                    }
                }
                .navigationTitle("NFTs")
            }

        }
        .onAppear {
            viewModel.fetchNFTs()
        }
    }
}


#Preview {
    ContentView()
}
