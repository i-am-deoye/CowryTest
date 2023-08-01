//
//  LSymbol.swift
//  CowryTest
//
//  Created by ADMIN on 8/1/23.
//

import Foundation
import RealmSwift


class LSymbol: Entity, ToMappable {
    typealias T = SymbolPair
    
    @objc dynamic var currency: String = ""
    @objc dynamic var country: String = ""
    
    override public init() {
        super.init()
    }
    
    public override static func primaryKey() -> String? {
            return "id"
    }
    
    func to() -> SymbolPair {
        return (currency, country)
    }
}
