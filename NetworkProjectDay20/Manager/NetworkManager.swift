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
    
    func callSearchRequest(query: String, page: Int, completion: @escaping (Result<SearchData, NetworkError>) -> Void) {
        
        let url = "https://api.unsplash.com/search/photos"
        let header: HTTPHeaders = [
            "Accept-Version": "v1"
        ]
        let param: Parameters = [
            "query": query,
            "page": page,
            "per_page": 20,
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
            case .failure:
                let customError = self.handleStatusCode(response: response)
                completion(.failure(customError))
                
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
    
    func callSearchRequestByOrder(query: String, page: Int, order: String, completion: @escaping (Result<SearchData, NetworkError>) -> Void) {
        
        let url = "https://api.unsplash.com/search/photos"
        let header: HTTPHeaders = [
            "Accept-Version": "v1"
        ]
        let param: Parameters = [
            "query": query,
            "page": page,
            "per_page": 20,
            "order_by": order,
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
            case .failure:
                let error = self.handleStatusCode(response: response)
                completion(.failure(error))
            }
        }
    }
    func callSearchRequestByColor(query: String, page: Int, color: String, completion: @escaping (Result<SearchData, NetworkError>) -> Void) {
        let url = "https://api.unsplash.com/search/photos"
        let header: HTTPHeaders = [
            "Accept-Version": "v1"
        ]
        let param: Parameters = [
            "query": query,
            "page": page,
            "per_page": 20,
            "color": color,
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
            case .failure:
                let error = self.handleStatusCode(response: response)
                completion(.failure(error))
            }
        }
    }
    func callTopicRequest(topicID: String, completion: @escaping (Result<[TopicData], NetworkError>) -> Void) {
        
        let url = "https://api.unsplash.com/topics/\(topicID)/photos"
        let header: HTTPHeaders = [
            "Accept-Version": "v1"
        ]
        let param: Parameters = [
            "page": 1,
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
        .responseDecodable(of: [TopicData].self) {
            response in
            switch response.result {
                
            case .success(let value):
                completion(.success(value))
            case .failure:
                let error = self.handleStatusCode(response: response)
                completion(.failure(error))
            }
        }
    }
    
    func callStatisticsRequest(id: String, completion: @escaping (Result<StatisticsData, NetworkError>) -> Void) {
        let url = "https://api.unsplash.com/photos/\(id)/statistics"
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization
        ]
        let param: Parameters = [
            "id": id
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: param,
            encoding: URLEncoding.queryString,
            headers: header
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: StatisticsData.self) { response in
            switch response.result {
                
            case .success(let value):
                completion(.success(value))
            case .failure:
                let error = self.handleStatusCode(response: response)
                completion(.failure(error))
            }
        }
    }
}
