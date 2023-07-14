//
//  FetchRate.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation


public protocol FetchRateUsecase {
    typealias SuccessCompletion = (Rate) -> Void
    typealias FailureCompletion = (String) -> Void
    
    func execute(base: Symbol, against: Symbol, success: @escaping SuccessCompletion, failure: @escaping FailureCompletion)
}


final class DefaultFetchRateUsecase: FetchRateUsecase {
    private let repository: RateRepository
    
    private var successHandler : SuccessCompletion?
    private var errorHandler: FailureCompletion?
    
    init(repository: RateRepository) {
        self.repository = repository
    }
    
    
    public func execute(base: Symbol, against: Symbol, success: @escaping SuccessCompletion, failure: @escaping FailureCompletion) {
        successHandler = success
        errorHandler = failure
        
        repository.getLatest(base: base, against: against, result: onExecuted)
    }
}


fileprivate extension DefaultFetchRateUsecase {
    func onExecuted(_ result: Result<RRate, ResponseError>) {
            switch result {
            case let .failure(error):
                self.errorHandler?(error.localDescription)
            case let .success(rate):
                self.successHandler?(rate.to())
            }
        }
}
