//
//  FirebaseService.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 29.08.25.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseInternal

protocol NFTFirebaseServiceProtocol {
    func fetchNFTs(completion: @escaping (Result<[NFT], Error>) -> Void)
}

class NFTFirebaseService: NFTFirebaseServiceProtocol {
    private let ref = Database.database().reference()

    func fetchNFTs(completion: @escaping (Result<[NFT], Error>) -> Void) {
        ref.child("1zNCJlE1bXTEVwU1Xqte8uS3S_J2Lf2R1vZwKkm2f-ts/Sheet1")
            .observeSingleEvent(of: .value) { snapshot in
                print("📦 Raw snapshot:", snapshot.value ?? "nil")

                // 1. Cast as [Any]
                guard let array = snapshot.value as? [Any] else {
                    print("⚠️ Snapshot is not array")
                    completion(.success([]))
                    return
                }

                // 2. Remove nulls + force dictionaries only
                let dicts = array.compactMap { $0 as? [String: Any] }

                do {
                    // 3. Encode to JSON
                    let jsonData = try JSONSerialization.data(withJSONObject: dicts)

                    // 4. Decode into [NFT]
                    let decoded = try JSONDecoder().decode([NFT].self, from: jsonData)

                    print("✅ Decoded NFTs JSON:")
                    let pretty = String(data: try JSONEncoder().encode(decoded), encoding: .utf8) ?? ""
                    print(pretty)

                    completion(.success(decoded))
                } catch {
                    print("❌ Decoding error:", error)
                    completion(.failure(error))
                }
            }
    }
}




