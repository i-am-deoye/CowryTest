//
//  Utils.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation

struct Utils {
    static func plistGet<T>(key: String) -> T? {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else { return nil }
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        guard let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: Any] else { return nil }
        return plist[key] as? T
    }
}
