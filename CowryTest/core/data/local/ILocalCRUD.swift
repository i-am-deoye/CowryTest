//
//  ILocalCRUD.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation


protocol ILocalCRUD {
    associatedtype T
    
    func save(_ entity: T)
    func fetch() -> [T]
}
