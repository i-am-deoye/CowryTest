//
//  RateRepository.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation

protocol RateRepository: IRemoteRepository {
    typealias RateResultCompletion = (Result<RRate, ResponseError>) -> Void
    typealias SymbolsResultCompletion = (Result<RSymbols, ResponseError>) -> Void
    
    func getLatest(base: Symbol, against: Symbol, result completion: @escaping RateResultCompletion)
    func getHistory() -> [LConversion]
    func save<T: Entity>(_ entity: T)
    func getSymbols(result completion: @escaping SymbolsResultCompletion)
    func getLocalSymbols() -> [LSymbol]
}


final class DefaultRateRepository: RateRepository,
                                    ILocalRepository{
    var client: HTTPClient
    var local: IDataBaseDriver
    
    private var rateResultCompletion: RateResultCompletion?
    private var symbolsResultCompletion: SymbolsResultCompletion?
    
    init(client: HTTPClient, local: IDataBaseDriver) {
        self.client = client
        self.local = local
    }
    
    func getLatest(base: Symbol, against: Symbol, result completion: @escaping RateResultCompletion) {
        rateResultCompletion = completion
        
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
    
    func getLocalSymbols() -> [LSymbol] {
        return local.fetch(LSymbol.self)
    }
    
    func getSymbols(result completion: @escaping SymbolsResultCompletion) {
        symbolsResultCompletion = completion
        
        guard let url = EndPoints.symbols.absoluteString
            .url else {
                completion(.failure(.otherCause))
                return
            }
        
        client.get(from: url, completion: {[weak self] result in
            guard let self = self else { return }
            self.onFetchedSymbols(result)
        })
    }
    
    func getHistory() -> [LConversion] {
        return local.fetch(LConversion.self)
    }
    
    func save<T>(_ entity: T) where T : Entity {
        local.save(entity)
    }
}


fileprivate extension DefaultRateRepository {
    
    func onFetchedSymbols(_ result: HTTPClient.Result) {
        self.onResponse(result) {[weak self] data in
            guard let self = self else { return }
            guard let response = data.decode(dataKey: "symbols") else {
                self.symbolsResultCompletion?(.failure(.otherCause))
                return
            }
            var symbols = RSymbols.init(json: response.data)
            self.symbolsResultCompletion?(.success(symbols))
        } resultError: {[weak self] error in
            guard let self = self else { return }
            self.symbolsResultCompletion?(.failure(error))
        }
    }
    
    
    func onLatest(_ result: HTTPClient.Result) {
        let baseKey = "base"
        
        self.onResponse(result) {[weak self] data in
            guard let self = self else { return }
            guard let response = data.decode(dataKey: "rates", keys: [baseKey]) else {
                self.rateResultCompletion?(.failure(.otherCause))
                return
            }
            var rate = RRate.init(json: response.data)
            rate.base = response.others[baseKey] as? String  ?? ""
            self.rateResultCompletion?(.success(rate))
        } resultError: {[weak self] error in
            guard let self = self else { return }
            self.rateResultCompletion?(.failure(error))
        }

    }
}
