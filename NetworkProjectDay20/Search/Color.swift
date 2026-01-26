//
//  Color.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import Foundation

enum Color: Int, CaseIterable {
    case black_and_white
    case black
    case white
    case yellow
    case orange
    case red
    case purple
    case magenta
    case green
    case teal
    case blue
    
    var colorName: String {
        switch self {
        case .black_and_white:
            "흑백"
        case .black:
            "블랙"
        case .white:
            "화이트"
        case .yellow:
            "옐로우"
        case .orange:
            "오렌지"
        case .red:
            "레드"
        case .purple:
            "퍼플"
        case .magenta:
            "마젠타"
        case .green:
            "그린"
        case .teal:
            "틸"
        case .blue:
            "블루"
        }
    }
}
