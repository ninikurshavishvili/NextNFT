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
            
            List(viewModel.nfts) { nft in
                VStack(alignment: .leading) {
                    Text(nft.nftName)
                        .font(.headline)
                    Text("Creator: \(nft.creator)")
                        .font(.subheadline)
                    Text("Price: \(nft.price)")
                        .font(.footnote)
                }
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
