//
//  Country.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation

public struct Country {
    let flag : String
    let currency : String
    
    
    static func items() -> [Country] {
        return Statics.read("Countries")
    }
}


extension Country : Decodable {
    enum CountryKeys: String, CodingKey {
      case flag
      case currency
    }
}
