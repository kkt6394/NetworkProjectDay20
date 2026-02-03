//
//  ProfileError.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 2/3/26.
//

import Foundation

enum ProfileError: Error/*, LocalizedError*/ {
    // LocalizedError 채택하면 errorDescription이 nil로 나옴
    case empty
    case isNotNumber
    case outOfRange
    
    var errorDescription: String {
        switch self {
        case .empty:
            "입력칸이 비어있습니다."
        case .isNotNumber:
            "숫자가 아닙니다."
        case .outOfRange:
            "범위를 벗어났습니다."
        }
    }
}
