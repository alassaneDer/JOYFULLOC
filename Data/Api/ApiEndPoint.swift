//
//  ApiEndPoint.swift
//  JoyFullOC
//
//  Created by Alassane Der on 17/03/2025.
//

import Foundation


enum EndPoint {
    static func request() -> URLRequest {
        let baseUrl = URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json")!
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        
        return request
    }
}
