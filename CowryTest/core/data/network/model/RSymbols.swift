//
//  RSymbols.swift
//  CowryTest
//
//  Created by ADMIN on 8/1/23.
//

import Foundation
import SwiftyJSON

typealias RSymbolPair = (symbol: Symbol, country: String)

struct RSymbols: InitMappable, ToMappable {
    typealias T = Symbols
    var symbols: [RSymbolPair]
    
    init(json: JSON) {
        self.symbols = [RSymbolPair]()
        
        for key in json.keys {
            let value = (json[key] as? SwiftyJSON.JSON)?.stringValue ?? ""
            self.symbols.append((key, value))
        }
    }
    
    
    func to() -> Symbols {
        return Symbols.init(symbols: symbols)
    }
}
