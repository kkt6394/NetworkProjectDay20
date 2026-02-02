//
//  NetworkRouter.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 2/2/26.
//

import Foundation
import Alamofire

enum NetworkRouter {
    
    case basic(query: String, page: Int)
    case order(query: String, page: Int, order: String)
    case color(query: String, page: Int, color: String)
    case topic(topicID: String)
    case stat(id: String)
    
    var baseURL: String {
        return "https://api.unsplash.com"
    }
    
    var endpoint: String {
        switch self {
        case .basic, .order, .color:
            return "\(baseURL)/search/photo"
        case .topic(let topicID):
            return  "\(baseURL)/topics/\(topicID)/photos"
        case .stat(let id):
            return "\(baseURL)/photo/\(id)/statistics"
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .basic, .order, .color, .topic:
            return [
                "Accept-Version": "v1"
            ]
        case .stat(let id):
            return [
                "Authorization": APIKey.authorization
            ]

        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .basic, .order, .color:
            return [
                "per_page": 20,
                "client_id": APIKey.key
            ]
        case .topic:
            return [
                "page": 1,
                "client_id": APIKey.key
            ]
        case .stat(let id):
            return [
                "id": id
            ]
        }
    }
}
