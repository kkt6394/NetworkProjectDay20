//
//  NetworkManager.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func callRequest(completion: @escaping (Result<SearchData, AFError>) -> Void) {
        
        let url = "https://api.unsplash.com/search/photos"
        let header: HTTPHeaders = [
            "Accept-Version": "v1"
        ]
        let param: Parameters = [
            "query": "query",
            "page": 1,
            "per_page": 20,
            "order_by": "latest",
            "color": "yellow",
            "client_id": APIKey.key
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: param,
            encoding: URLEncoding.queryString,
            headers: header
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: SearchData.self) {
            response in
            switch response.result {
                
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
