//
//  RateRepository.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation

protocol RateRepository: IRemoteRepository {
    typealias ResultCompletion = (Result<RRate, ResponseError>) -> Void
    
    func getLatest(base: Symbol, against: Symbol, result completion: @escaping ResultCompletion)
    func getHistory() -> [LConversion]
    func save(_ entity: LConversion)
}


final class DefaultRateRepository: RateRepository,
                                    ILocalRepository{
    var client: HTTPClient
    var local: IDataBaseDriver
    
    private var resultCompletion: ResultCompletion?
    
    init(client: HTTPClient, local: IDataBaseDriver) {
        self.client = client
        self.local = local
    }
    
    func getLatest(base: Symbol, against: Symbol, result completion: @escaping ResultCompletion) {
        resultCompletion = completion
        
        guard let url = EndPoints.latest.absoluteString
            .param(key: "{base}", with: base)
            .param(key: "{symbols}", with: against)
            .url else {
                completion(.failure(.otherCause))
                return
            }
        
        client.get(from: url, completion: {[weak self] result in
            guard let self = self else { return }
            self.onLatest(result)
        })
    }
    
    func getHistory() -> [LConversion] {
        return local.fetch(LConversion.self)
    }
    
    func save(_ entity: LConversion) {
        local.save(entity)
    }
}


fileprivate extension DefaultRateRepository {
    func onLatest(_ result: HTTPClient.Result) {
        self.onResponse(result) {[weak self] data in
            guard let self = self else { return }
            guard let response = data.decode() else {
                self.resultCompletion?(.failure(.otherCause))
                return
            }
            var rate = RRate.init(json: response.rates)
            rate.base = response.base
            self.resultCompletion?(.success(rate))
        } resultError: {[weak self] error in
            guard let self = self else { return }
            self.resultCompletion?(.failure(error))
        }

    }
}
