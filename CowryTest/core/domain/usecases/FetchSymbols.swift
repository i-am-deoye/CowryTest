//
//  FetchSymbols.swift
//  CowryTest
//
//  Created by ADMIN on 8/1/23.
//

import Foundation


public protocol FetchSymbolsUsecase {
    typealias SuccessCompletion = ([SymbolPair]) -> Void
    typealias FailureCompletion = (String) -> Void
    
    func execute(success: @escaping SuccessCompletion, failure: @escaping FailureCompletion)
}


final class DefaultFetchSymbolsUsecase: FetchSymbolsUsecase {
    private let repository: RateRepository
    
    private var successHandler : SuccessCompletion?
    private var errorHandler: FailureCompletion?
    
    init(repository: RateRepository) {
        self.repository = repository
    }
    
    func execute(success: @escaping SuccessCompletion, failure: @escaping FailureCompletion) {
        successHandler = success
        errorHandler = failure
        
        let entities = repository.getLocalSymbols()
        if !entities.isEmpty {
            let symbolPairs = entities.compactMap({ $0.to() })
            self.successHandler?(symbolPairs)
        } else {
            repository.getSymbols(result: onExecuted)
        }
    }
    
}


fileprivate extension DefaultFetchSymbolsUsecase {
    func onExecuted(_ result: Result<RSymbols, ResponseError>) {
            switch result {
            case let .failure(error):
                self.errorHandler?(error.localDescription)
            case let .success(symbols):
                let symbols = symbols.to().symbols
                
                symbols.forEach({ symbol in
                    let entity = LSymbol()
                    entity.id = symbol.symbol
                    entity.currency = symbol.symbol
                    entity.country = symbol.country
                    self.repository.save(entity)
                })
                
                self.successHandler?(symbols)
            }
        }
}
