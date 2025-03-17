//
//  ApiHTTPClient.swift
//  JoyFullOC
//
//  Created by Alassane Der on 17/03/2025.
//

import Foundation

protocol HTTPClient {
    func request(from request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
