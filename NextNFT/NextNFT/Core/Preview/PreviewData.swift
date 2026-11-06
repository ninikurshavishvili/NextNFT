//
//  PreviewData.swift
//  NextNFT
//

#if DEBUG
extension NFTCollection {
    /// Sample collections for SwiftUI previews (images from picsum.photos).
    static let previewSamples: [NFTCollection] = [
        NFTCollection(
            collection: "impostors-genesis",
            name: "Impostors Genesis",
            description: "A collection of genesis impostors",
            imageURL: "https://picsum.photos/400",
            bannerImageURL: nil,
            owner: nil,
            category: "art",
            openseaURL: nil,
            totalSupply: 10000,
            createdDate: nil
        ),
        NFTCollection(
            collection: "boredapeyachtclub",
            name: "Bored Ape Yacht Club",
            description: "10,000 unique Bored Ape NFTs",
            imageURL: "https://picsum.photos/401",
            bannerImageURL: nil,
            owner: nil,
            category: "pfp",
            openseaURL: nil,
            totalSupply: 10000,
            createdDate: nil
        ),
        NFTCollection(
            collection: "cryptopunks",
            name: "CryptoPunks",
            description: "10,000 unique collectible characters",
            imageURL: "https://picsum.photos/402",
            bannerImageURL: nil,
            owner: nil,
            category: "pfp",
            openseaURL: nil,
            totalSupply: 10000,
            createdDate: nil
        ),
        NFTCollection(
            collection: "doodles-official",
            name: "Doodles",
            description: "A community-driven collectibles project",
            imageURL: "https://picsum.photos/403",
            bannerImageURL: nil,
            owner: nil,
            category: "art",
            openseaURL: nil,
            totalSupply: 10000,
            createdDate: nil
        ),
        NFTCollection(
            collection: "clonex",
            name: "CLONE X - X TAKASHI MURAKAMI",
            description: "20,000 next-gen Avatars",
            imageURL: "https://picsum.photos/404",
            bannerImageURL: nil,
            owner: nil,
            category: "pfp",
            openseaURL: nil,
            totalSupply: 20000,
            createdDate: nil
        )
    ]
}
#endif
