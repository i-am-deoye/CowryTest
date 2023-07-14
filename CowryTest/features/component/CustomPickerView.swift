//
//  CustomPickerView.swift
//  CowryTest
//
//  Created by ADMIN on 7/14/23.
//


import UIKit


class CustomPickerView: UIPickerView{
    
    var handlerForCustomView: ((_ data: Any, _ view: UIView?) -> UIView)?
    var handlerForTitle: ((_ data: Any) -> String)?
    var selectionHandler: ((_ selectedObject: Any) -> Void)?
    var data = [Any]()
    
    init(data: [Any], pickerTextField: UITextField, selectionHandler: @escaping ((_ selectedObject: Any) -> Void), handlerForCustomView: @escaping ((_ data: Any, _ view: UIView?) -> UIView)) {
        super.init(frame: CGRect.zero)
        
        self.data = data
        //   self.pickerTextField = pickerTextField
        // self.pickerTextField.delegate = self
        self.handlerForCustomView = handlerForCustomView
        self.selectionHandler = selectionHandler
        
        customize()
    }
    
    init(data: [Any], pickerTextField: UITextField, selectionHandler: @escaping ((_ selectedObject: Any) -> Void), handlerForTitle: @escaping ((_ data: Any) -> String)) {
        super.init(frame: CGRect.zero)
        
        self.data = data
        self.handlerForTitle = handlerForTitle
        self.selectionHandler = selectionHandler
        
        customize()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        customize()
    }
    
    
    func customize() {
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        if handlerForCustomView == nil {
            let record = handlerForTitle!(data[row])
            var label: UILabel
            
            if view == nil {
                label = UILabel()
                label.text = record
                label.textAlignment = .center
            }else {
                label = view as! UILabel
                label.text = record
            }
            
            label.textColor = UIColor.black
            return label
        }
        return handlerForCustomView!(data[row], view)
    }
}

extension CustomPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if data.count > 0 {
            let selct = data[row]
            selectionHandler!(selct)
        }
    }
}



extension CustomPickerView {
    func loadPickerViewForCustomView(data: [Any], onSelect selectionHandler: @escaping ((_ selectedObject: Any?) -> Void), onDisplay  handlerForCustomView: @escaping ((_ data: Any?, _ view: UIView?) -> UIView)) {
        self.data = data
        self.handlerForCustomView = handlerForCustomView
        self.selectionHandler = selectionHandler
        customize()
    }
    
    func loadPickerViewString(data: [Any], onSelect selectionHandler: @escaping ((_ selectedObject: Any) -> Void), onDisplay handlerForTitle: @escaping ((_ data: Any) -> String)) {
        self.data = data
        self.handlerForTitle = handlerForTitle
        self.selectionHandler = selectionHandler
        customize()
    }
}
