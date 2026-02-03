//
//  NetworkRouter.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 2/2/26.
//

import Foundation
import Alamofire

// Request
protocol Router {
    var baseURL: String { get }
    var endpoint: String { get }
    var header: HTTPHeaders { get }
    var method: HTTPMethod { get }
    var parameter: Parameters { get }
    
}


// Unsplash API Request
enum NetworkRouter: Router {
    
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
            return "\(baseURL)/search/photos"
        case .topic(let topicID):
            return  "\(baseURL)/topics/\(topicID)/photos"
        case .stat(let id):
            return "\(baseURL)/photos/\(id)/statistics"
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
        case .basic(let query, let page):
            return [
                "query": query,
                "page": page,
                "per_page": 20,
                "client_id": APIKey.key
            ]
        case .order(let query, let page, let order):
            return [
                "query": query,
                "page": page,
                "order_by": order,
                "per_page": 20,
                "client_id": APIKey.key
            ]
        case .color(let query, let page, let color):
            return [
                "query": query,
                "page": page,
                "color": color,
                "per_page": 20,
                "client_id": APIKey.key
            ]

        case .topic(let topicID):
            return [
                "id_or_slug": topicID,
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
