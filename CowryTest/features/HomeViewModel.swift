//
//  ConversionViewModel.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation


public protocol HomeViewModel {
    var errorHandler: ((String) -> Void)? { get set }
    var symbols: [SymbolPair] { get }
    
    func getSymbols(completion: @escaping (() -> Void))
    func convert(base: Symbol, against: Symbol)
    func convert(value: Double) -> String
    func getHistroy() -> [Conversion]
}


public final class DefaultHomeViewModel: HomeViewModel {
    private let saveConversionUsecase: SaveConversion
    private let fetchConversionHistoryUsecase: FetchConversionHistory
    private let fetchRateUsecase: FetchRateUsecase
    private let fetchSymbols: FetchSymbolsUsecase
    private var rate: Rate?
    private var _symbols = [SymbolPair]()
    
    public var errorHandler: ((String) -> Void)?
    public var symbols: [SymbolPair] {
        return _symbols
    }
    
    init(saveConversionUsecase: SaveConversion, fetchConversionHistoryUsecase: FetchConversionHistory, fetchRateUsecase: FetchRateUsecase, fetchSymbols: FetchSymbolsUsecase) {
        self.saveConversionUsecase = saveConversionUsecase
        self.fetchRateUsecase = fetchRateUsecase
        self.fetchConversionHistoryUsecase =  fetchConversionHistoryUsecase
        self.fetchSymbols = fetchSymbols
    }
    
    
    public func getSymbols(completion: @escaping (() -> Void)) {
        fetchSymbols.execute { [weak self] pairs in
            self?._symbols = pairs
            completion()
        } failure: { [weak self] message in
            self?.errorHandler?(message)
        }
    }
    
    
    public func convert(base: Symbol, against: Symbol) {
        guard !base.isEmpty &&  !against.isEmpty else { return }
        
        fetchRateUsecase.execute(base: base, against: against) {[weak self] rate in
            self?.rate = rate
        } failure: { [weak self] message in
            self?.errorHandler?(message)
        }

    }
    
    public func getHistroy() -> [Conversion] {
        return fetchConversionHistoryUsecase.execute()
    }
    
    public func convert(value: Double) -> String {
        guard let rate = self.rate else { return "0.00" }
        let result = rate.value * value
        let entity = LConversion()
        entity.base = rate.base
        entity.against = rate.name
        entity.value = rate.value
        return "\(String(format: "%.2f", result))"
    }
}
