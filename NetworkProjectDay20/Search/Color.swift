//
//  Color.swift
//  NetworkProjectDay20
//
//  Created by 김기태 on 1/26/26.
//

import UIKit

enum Color: String, CaseIterable {
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
    
    var colorCode: String {
        switch self {
        case .black_and_white:
            return "#D3D3D3"
        case .black:
            return "#000000"
        case .white:
            return "#FFFFFF"
        case .yellow:
            return "#FFEF62"
        case .orange:
            return "#FFA500"
        case .red:
            return "#F04452"
        case .purple:
            return "#9636E1"
        case .magenta:
            return "#FF00FF"
        case .green:
            return "#02B946"
        case .teal:
            return "#008080"
        case .blue:
            return "#3C59FF"
        }
    }
    var hexColor: UIColor {
        UIColor(hex: self.colorCode) ?? .clear
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        guard hexString.count == 6 else { return nil }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0x0000FF) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
        
    }
    
}
