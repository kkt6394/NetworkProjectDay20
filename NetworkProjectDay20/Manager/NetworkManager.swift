//
//  NetworkManager.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        parameter: Parameters,
        header: HTTPHeaders,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        AF.request(
            url,
            method: method,
            parameters: parameter,
            headers: header
        )
        .responseDecodable(of: T.self) { response in
            switch response.result {
                
            case .success(let value):
                completion(.success(value))
            case .failure:
                let error = self.handleStatusCode(response: response)
                completion(.failure(error))
            }
        }
    }
    
    func handleStatusCode<T>(response: DataResponse<T, AFError>) -> NetworkError {
        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 400:
                return .badRequest
            case 401:
                return .unauthorized
            case 403:
                return .forbidden
            case 404:
                return .notFound
            case 500, 503:
                return .somethingWrong
            default:
                return .somethingWrong
            }
        }
        return .somethingWrong
    }
    
    func callRequest<T: Decodable>(
        api: NetworkRouter,
        type: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        request(
            url: api.endpoint,
            method: api.method,
            parameter: api.parameter,
            header: api.header,
            completion: completion
        )
        
        
    }
}
