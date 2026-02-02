//
//  TopicID.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/27/26.
//

import Foundation

enum TopicID: String, CaseIterable {
    case golden = "golden-hour"
    case business = "business-work"
    case architect = "architecture-interior"
    case wallpapers
    case nature
    case renders = "3d-renders"
    case travel
    case texture = "textures-patterns"
    case street = "street-photography"
    case film
    case archival
    case experimental
    case animals
    case fashion = "fashion-beauty"
    case people
    case food = "food-drink"
    
    var topicLabel: String {
        switch self {
        case .golden:
            "골든 아워"
        case .business:
            "비즈니스 및 업무"
        case .architect:
            "건축 및 인테리어"
        case .wallpapers:
            "배경 화면"
        case .nature:
            "자연"
        case .renders:
            "3D 렌더링"
        case .travel:
            "여행하다"
        case .texture:
            "텍스처 및 패턴"
        case .street:
            "거리 사진"
        case .film:
            "필름"
        case .archival:
            "기록의"
        case .experimental:
            "실험적인"
        case .animals:
            "동물"
        case .fashion:
            "패션 및 뷰티"
        case .people:
            "사람"
        case .food:
            "식음료"
        }
    }
}
