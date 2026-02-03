//
//  SearchError.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 2/3/26.
//

import Foundation

enum SearchError: Error, LocalizedError {
    case empty
    case tooShort
    case tooLong
    
    var errorDescription: String {
        switch self {
        case .empty:
            "검색어를 입력하세요"
        case .tooShort:
            "검색어를 두 글자 이상 입력하세요"
        case .tooLong:
            "검색어를 15글자 이내로 입력하세요"
        }
    }
}
