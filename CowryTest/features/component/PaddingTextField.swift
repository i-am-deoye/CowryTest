//
//  PaddingTextField.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import UIKit


class PaddingTextField: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 8,
        bottom: 10,
        right: 8
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
