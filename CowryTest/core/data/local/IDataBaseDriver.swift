//
//  IDataBaseDriver.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation

public protocol IDataBaseDriver {
    func save<T>(_ entity: T)
    func fetch<T>(_ type: T.Type) -> [T]
}
