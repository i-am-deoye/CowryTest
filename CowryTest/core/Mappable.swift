//
//  RemoteMapper.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation


protocol InitMappable {
    init(json: JSON)
}


protocol ToMappable {
    associatedtype T
    
    func to() -> T
}
