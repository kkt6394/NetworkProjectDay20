//
//  NetworkError.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/31/26.
//

import UIKit

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case somethingWrong
    
    var description: String {
        switch self {
        case .badRequest:
            "The request was unacceptable, often due to missing a required parameter"
        case .unauthorized:
            "Invalid Access Token"
        case .forbidden:
            "Missing permissions to perform request"
        case .notFound:
            "The requested resource doesn’t exist"
        case .somethingWrong:
            "Something went wrong on our end"
        }
    }
}

