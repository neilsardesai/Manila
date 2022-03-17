//
//  Color.swift
//  Manila Finder Extension
//
//  Created by Neil Sardesai on 2/23/22.
//

import Foundation

enum Color: String, CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case gray
    
    var localizedName: String {
        switch self {
        case .red:
            return String(localized: "Red")
        case .orange:
            return String(localized: "Orange")
        case .yellow:
            return String(localized: "Yellow")
        case .green:
            return String(localized: "Green")
        case .blue:
            return String(localized: "Blue")
        case .purple:
            return String(localized: "Purple")
        case .gray:
            return String(localized: "Gray")
        }
    }
    
    var menuImageName: String {
        switch self {
        case .red:
            return "menu red"
        case .orange:
            return "menu orange"
        case .yellow:
            return "menu yellow"
        case .green:
            return "menu green"
        case .blue:
            return "menu blue"
        case .purple:
            return "menu purple"
        case .gray:
            return "menu gray"
        }
    }
}
