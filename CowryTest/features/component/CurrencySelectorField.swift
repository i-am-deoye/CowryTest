//
//  CurrencySelectorField.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import UIKit


final class CurrencySelectorField: UIView {
    @IBInspectable var placeholder: String = "" {
        didSet {
            currencyText.placeholder = placeholder
        }
    }
    
    lazy var currencyText: PaddingTextField = {
        let field = PaddingTextField()
        field.textAlignment = .left
        field.placeholder = "EUR"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 15)
        return field
    }()
    
    private lazy var chevronIcon: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = .clear
        
        let img = (UIImage.init(systemName: "chevron.down") ?? UIImage()).withRenderingMode(.alwaysTemplate)
        
        let icon = UIImageView.init(image: img)
        icon.tintColor = .lightGray.withAlphaComponent(0.6)
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(icon)
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: content.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            icon.widthAnchor.constraint(equalToConstant: 20),
            icon.heightAnchor.constraint(equalToConstant: 18)
        ])
        return content
    }()

    private lazy var stack: UIStackView = {
        
        let stack = UIStackView.init(arrangedSubviews: [currencyText, chevronIcon])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        chevronIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        return stack
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.backgroundColor = .lightGray.withAlphaComponent(0.13)
        
        self.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension UITextField {
    
    func loadPickerViewForCustomView(data: [Any], onSelect selectionHandler: @escaping ((_ selectedObject: Any?) -> Void), onDisplay  handlerForCustomView: @escaping ((_ data: Any?, _ view: UIView?) -> UIView)) {
        
        self.inputView = CustomPickerView(data: data, pickerTextField: self, selectionHandler: selectionHandler, handlerForCustomView: handlerForCustomView)
    }
    
    func loadPickerViewString(data: [Any], onSelect selectionHandler: @escaping ((_ selectedObject: Any) -> Void), onDisplay handlerForTitle: @escaping ((_ data: Any) -> String)) {
        let piker = CustomPickerView(data: data, pickerTextField: self, selectionHandler: selectionHandler, handlerForTitle: handlerForTitle)
        self.inputView = piker
    }
}
