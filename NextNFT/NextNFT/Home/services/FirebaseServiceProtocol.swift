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

final class NFTFirebaseService: NFTFirebaseServiceProtocol {
    private let ref = Database.database().reference()
    
    func fetchNFTs(completion: @escaping (Result<[NFT], Error>) -> Void) {
        ref.child("1zNCJlE1bXTEVwU1Xqte8uS3S_J2Lf2R1vZwKkm2f-ts/Sheet1")
            .observeSingleEvent(of: .value) { snapshot in
                
                print("📦 Snapshot value:", snapshot.value ?? "nil")
                
                guard let value = snapshot.value as? [String: Any] else {
                    completion(.success([]))
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let decoded = try JSONDecoder().decode([String: NFT].self, from: jsonData)
                    
                    let nftArray = Array(decoded.values).sorted { $0.id < $1.id }
                    completion(.success(nftArray))
                    
                } catch {
                    completion(.failure(error))
                }
            }
    }

}
