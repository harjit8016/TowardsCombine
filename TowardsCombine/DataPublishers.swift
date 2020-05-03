//
//  DataPublishers.swift
//  TowardsCombine
//
//  Created by Harjit Singh on 01/05/20.
//  Copyright © 2020 Harjit Singh. All rights reserved.
//

enum APIError: Error {
    case invalidBody
    case invalidEndpoint
    case invalidURL
    case emptyData
    case invalidJSON
    case invalidResponse
    case statusCode(Int)
}

import Foundation
import Combine

class ApiPublishers {
    
    static func api(url:String) throws -> URLSession.DataTaskPublisher {
        
        guard let url = URL(string: url ) else {
            throw APIError.invalidEndpoint
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: .infinity)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        return session.dataTaskPublisher(for: request)
        
    }
}




