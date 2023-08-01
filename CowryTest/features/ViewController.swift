//
//  ViewController.swift
//  CowryTest
//
//  Created by ADMIN on 7/12/23.
//

import UIKit
import FlagKit


class ViewController: UIViewController {
    @IBOutlet private weak var firstAmountInputField: AmountInputField!
    @IBOutlet private weak var secondAmountInputField: AmountInputField!
    
    @IBOutlet private weak var firstCurrencyField: CurrencySelectorField!
    @IBOutlet private weak var secondCurrencyField: CurrencySelectorField!
    
    @IBOutlet private weak var errorLabel: UILabel!
    
    
    
    private var viewmodel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    
    @IBAction private func convert(sender: UIButton) {
        errorLabel.text = ""
        guard let value = Double.init(firstAmountInputField.text ?? "0.00") else { return }
        guard let result = viewmodel?.convert(value: value) else { return }
        secondAmountInputField.set(result)
    }
    
    private func selectorFirst() {
        setSelector(selector: firstCurrencyField, filter: []) { symbol in
            self.firstAmountInputField.currencyLabel.text = symbol
            self.firstAmountInputField.symbol = symbol
            self.viewmodel?.convert(base: symbol, against: self.secondAmountInputField.symbol ?? "")
        }
    }

    private func selectorSecond() {
        setSelector(selector: secondCurrencyField, filter: []) { symbol in
            self.secondAmountInputField.currencyLabel.text = symbol
            self.secondAmountInputField.symbol = symbol
            self.viewmodel?.convert(base: self.firstAmountInputField.symbol ?? "", against: symbol)
        }
    }
    
    
    private func setSelector(selector: CurrencySelectorField, filter: [Symbol], handler:  @escaping (Symbol) -> Void) {
        selector.currencyText.loadPickerViewForCustomView(data: viewmodel?.symbols ?? []) { selectedObject in
            guard let item = selectedObject as? Country else { return }

            var countryCode = item.symbol
            countryCode.removeLast()
            
            let flag = Flag(countryCode: countryCode)
            selector.currencyText.text = item.symbol
            
            let image = UIImageView.init(image: flag?.originalImage)
            image.frame = .init(x: 4, y: 0, width: 20, height: 20)
            selector.currencyText.leftView = image
            selector.currencyText.leftViewMode = .always
            handler(item.symbol)
        } onDisplay: { (data, view) -> UIView in
            guard let country = data as? Country else { return UIView() }
            
            var countryCode = country.symbol
            countryCode.removeLast()
            
            let flag = Flag(countryCode: countryCode)
            
            let itemView = UIView()
            itemView.tag = country.symbol.hashValue
            
            let icon = UIImageView()
            icon.image = flag?.originalImage
            icon.translatesAutoresizingMaskIntoConstraints = false
            itemView.addSubview(icon)
            
            icon.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16).isActive = true
            icon.centerYAnchor.constraint(equalTo: itemView.centerYAnchor).isActive = true
            icon.heightAnchor.constraint(equalToConstant: 15).isActive = true
            icon.widthAnchor.constraint(equalToConstant: 15).isActive = true
            
            let title = UILabel()
            title.textColor = UIColor.black
            title.text = country.symbol
            title.translatesAutoresizingMaskIntoConstraints = false
            itemView.addSubview(title)
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16).isActive = true
            title.centerYAnchor.constraint(equalTo: itemView.centerYAnchor).isActive = true
            title.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -16).isActive = true
            
            return itemView
        }
    }
    
    
    private func setup() {
        let repository = DefaultRateRepository(client: AlamofireHTTPClient(), local: RealmDriver.instance)
        let save = DefaultSaveConversion.init(repository: repository)
        let fetchConversion = DefaultFetchConversionHistory(repository: repository)
        let fetchRate = DefaultFetchRateUsecase(repository: repository)
        let fetchSymbols = DefaultFetchSymbolsUsecase.init(repository: repository)
        
        viewmodel = DefaultHomeViewModel.init(saveConversionUsecase: save,
                                              fetchConversionHistoryUsecase: fetchConversion,
                                              fetchRateUsecase: fetchRate,
                                              fetchSymbols: fetchSymbols)
        
        viewmodel?.errorHandler = { self.errorLabel.text = $0 }
        viewmodel?.getSymbols(completion: {[weak self] in
            self?.selectorFirst()
            self?.selectorSecond()
        })
    }
}

