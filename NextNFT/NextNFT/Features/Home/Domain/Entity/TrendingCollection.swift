//
//  TrendingCollection.swift
//  NextNFT
//

/// A collection in the Trending section, with the NFTs previewed under it.
struct TrendingCollection: Identifiable, Hashable, Sendable {
    let collection: NFTCollection
    let nfts: [NFT]

    var id: String { collection.id }
}
