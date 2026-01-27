//
//  SearchData.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import Foundation

struct SearchData: Decodable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

extension SearchData {
    struct Result: Decodable {
        let id: String
        let created_at: String
        let width: Int
        let height: Int
        let urls: Urls
        let likes: Int
        let user: User
    }
}

extension SearchData.Result {
    struct Urls: Decodable {
        let raw: String
        let small: String
    }
    
    struct User: Decodable {
        let name: String
        let profile_image: Profile
    }
}

extension SearchData.Result.User {
    struct Profile: Decodable {
        let medium: String
    }
}
