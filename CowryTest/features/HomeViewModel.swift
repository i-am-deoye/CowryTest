//
//  ConversionViewModel.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//

import Foundation


public protocol HomeViewModel {
    var errorHandler: ((String) -> Void)? { get set }
    
    func getCountry(filter: [String]) -> [Country]
    func convert(base: Symbol, against: Symbol)
    func convert(value: Double) -> String
    func getHistroy() -> [Conversion]
}


public final class DefaultHomeViewModel: HomeViewModel {
    private let saveConversionUsecase: SaveConversion
    private let fetchConversionHistoryUsecase: FetchConversionHistory
    private let fetchRateUsecase: FetchRateUsecase
    private var rate: Rate?
    
    public var errorHandler: ((String) -> Void)?
    
    init(saveConversionUsecase: SaveConversion, fetchConversionHistoryUsecase: FetchConversionHistory, fetchRateUsecase: FetchRateUsecase) {
        self.saveConversionUsecase = saveConversionUsecase
        self.fetchRateUsecase = fetchRateUsecase
        self.fetchConversionHistoryUsecase =  fetchConversionHistoryUsecase
    }
    
    
    
    public func getCountry(filter: [String]) -> [Country] {
        return Country.items().filter({ !filter.contains($0.currency) })
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
