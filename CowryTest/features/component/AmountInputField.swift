//
//  AmountInputField.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import UIKit

final class AmountInputField: UIView {
    var symbol: Symbol?
    
    var text: String? {
        return amountTextField.text
    }
    
    private lazy var amountTextField: PaddingTextField = {
        let field = PaddingTextField()
        field.textAlignment = .left
        field.placeholder = "0.00"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 15)
        return field
    }()
    
    lazy var currencyLabel: PaddingLabel = {
        let field = PaddingLabel()
        field.text = "EUR"
        field.textAlignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        field.textColor = .lightGray.withAlphaComponent(0.6)
        field.paddingRight = 8
        return field
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [amountTextField, currencyLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        currencyLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        return stack
    }()
    
    
    func set(_ value: String) {
        amountTextField.text = value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.backgroundColor = .lightGray.withAlphaComponent(0.13)
        
        self.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
