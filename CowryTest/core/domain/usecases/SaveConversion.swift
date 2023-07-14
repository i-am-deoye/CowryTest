//
//  SaveConversion.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation

protocol SaveConversion {
    func execute(value: Conversion)
}


final class DefaultSaveConversion: SaveConversion {
    private let repository: RateRepository
    
    
    init(repository: RateRepository) {
        self.repository = repository
    }
    
    func execute(value: Conversion) {
        
        let entity = LConversion()
        entity.base = value.base
        entity.against = value.against
        entity.id = UUID().uuidString
        
        repository.save(entity)
    }
}
