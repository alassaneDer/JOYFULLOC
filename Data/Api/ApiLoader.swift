//
//  Loader.swift
//  JoieFull
//
//  Created by Alassane Der on 11/02/2025.
//

import Foundation

final class ApiLoader {
    
    private var client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func loadClothes(from request: URLRequest) async throws -> [ClothingItem] {
        let (data, response) = try await client.request(from: request)
        let clothes = try Mapper.map(data, and: response)
        
        return clothes
    }
}
