//
//  FetchConversionHistory.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation


protocol FetchConversionHistory {
    func execute() -> [Conversion]
}


final class DefaultFetchConversionHistory: FetchConversionHistory {
    private let repository: RateRepository
    
    
    init(repository: RateRepository) {
        self.repository = repository
    }
    
    func execute() -> [Conversion] {
        return repository.getHistory().map { $0.to() }
    }
}
