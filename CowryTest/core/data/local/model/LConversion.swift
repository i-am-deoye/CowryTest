//
//  LRate.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation
import RealmSwift


class LConversion: Entity, ToMappable {
    typealias T = Conversion
    
    @objc dynamic var base: String = ""
    @objc dynamic var against: String = ""
    @objc dynamic var value: Double = 0.00
    
    override public init() {
        super.init()
    }
    
    public override static func primaryKey() -> String? {
            return "id"
    }
    
    func to() -> Conversion {
        return Conversion(id: id, base: base, against: against, value: value)
    }
}
