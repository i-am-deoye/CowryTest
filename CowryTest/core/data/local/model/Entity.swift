//
//  Entity.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation
import RealmSwift


public class Entity : Object, Persistable {
    @objc dynamic var id: String = ""
}
