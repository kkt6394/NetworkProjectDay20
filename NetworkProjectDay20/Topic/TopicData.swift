//
//  TopicData.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/27/26.
//

import Foundation

struct TopicData: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let urls: Urls
    let likes: Int
    let user: User
}

extension TopicData {
    struct Urls: Decodable {
        let raw: String
        let small: String
    }
    
    struct User: Decodable {
        let name: String
        let profile_image: ProfileImage
    }
}

extension TopicData.User {
    struct ProfileImage: Decodable {
        let medium: String
    }
}
