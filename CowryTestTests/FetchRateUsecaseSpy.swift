//
//  FetchRateUsecaseSpy.swift
//  CowryTestTests
//
//  Created by ADMIN on 7/14/23.
//

import Foundation
import CowryTest


class FetchRateUsecaseSpy: FetchRateUsecase {
    var isErrorDeleting = false
    
    func execute(base: Symbol, against: Symbol, success: @escaping SuccessCompletion, failure: @escaping FailureCompletion) {
        if isErrorDeleting {
            failure("error")
        } else {
            success(Rate.init(id: nil, base: "EUR", name: "NGN", value: 800))
        }
    }
}
