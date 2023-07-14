//
//  ViewModelState.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation

public enum ViewModelState<R> {
    case loading
    case result(payload: R)
    case failure(error : String)
}
