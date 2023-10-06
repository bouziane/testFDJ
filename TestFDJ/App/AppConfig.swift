//
//  AppConfig.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Foundation
final class AppConfig {
    static let shared = AppConfig()
    
    private var config: NSDictionary?
    
    private init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            config = NSDictionary(contentsOfFile: path)
        }
    }
    
    func fetchConfigValue(forKey key: String) -> String? {
        return config?[key] as? String
    }
}
