//
//  ResponseError.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation

public enum ResponseError: Swift.Error {
    case connectivity
    case invalidData
    case otherCause
    
    public var localDescription: String {
        if self == .invalidData { return "invalid data" }
        if self == .connectivity { return "unable to connect to the server" }
        return "something went wrong, please try again later"
    }
}
