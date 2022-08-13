//
//  Settings.swift
//  
//
//  Created by p-x9 on 2022/08/13.
//  
//

import UIKit
import HeadlineNewsWindowC

struct Settings: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case isTweakEnabled
        
        case rssURLsRaw = "rssURLs"
        
        case fontSize
        case textColorCode = "textColor"
        case backgroundColorCode = "backgroundColor"
        case textSpeed
    }
    
    
    var isTweakEnabled = true
    var rssURLsRaw = ""
    var fontSize: CGFloat = 20
    var textColorCode = "#FFFFFF"
    var backgroundColorCode = "#000000"
    var textSpeed: CGFloat = 1
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        isTweakEnabled = try container.decodeIfPresent(Bool.self, forKey: .isTweakEnabled) ?? true
        
        rssURLsRaw = try container.decodeIfPresent(String.self, forKey: .rssURLsRaw) ?? ""
        
        fontSize = try container.decodeIfPresent(CGFloat.self, forKey: .fontSize) ?? 20
        
        textColorCode = try container.decodeIfPresent(String.self, forKey: .textColorCode) ?? "#FFFFFF"
        backgroundColorCode = try container.decodeIfPresent(String.self, forKey: .backgroundColorCode) ?? "#000000"
        
        textSpeed = try container.decodeIfPresent(CGFloat.self, forKey: .textSpeed) ?? 1
    }
}

extension Settings {
    var rssURLsString: [String] {
        self.rssURLsRaw.components(separatedBy: .newlines)
    }
    
    var rssURLs: [URL] {
        self.rssURLsString.compactMap {
            URL(string: $0)
        }
    }
    
    var textColor: UIColor {
        SparkColourPickerUtils.colour(with: self.textColorCode, withFallbackColour: .white)
    }
    
    var backgroundColor: UIColor {
        SparkColourPickerUtils.colour(with: self.backgroundColorCode, withFallbackColour: .black)
    }
}
