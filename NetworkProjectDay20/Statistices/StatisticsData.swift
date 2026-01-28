//
//  StatisticsData.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/28/26.
//

import Foundation

struct StatisticsData: Decodable {
    let id: String
    let downloads: Downloads
    let views: Views
}

extension StatisticsData {
    struct Downloads: Decodable {
        let total: Int
        let historical: Historical
    }
    struct Views: Decodable {
        let total: Int
        let historical: Historical
    }
}

extension StatisticsData.Downloads {
    struct Historical: Decodable {
        let values: [Values]
    }
}

extension StatisticsData.Views {
    struct Historical: Decodable {
        let values: [Values]
    }
}

extension StatisticsData.Downloads.Historical {
    struct Values: Decodable {
        let date: String
        let value: Int
    }
}

extension StatisticsData.Views.Historical {
    struct Values: Decodable {
        let date: String
        let value: Int
    }
}
