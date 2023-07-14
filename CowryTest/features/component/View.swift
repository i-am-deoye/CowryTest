//
//  View.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import UIKit

@IBDesignable
final class View: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
