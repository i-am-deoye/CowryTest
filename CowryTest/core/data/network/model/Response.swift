//
//  Response.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation


struct Response {
    let success: Bool
    let timestamp: Double
    let data: JSON
    let others: [String: Any?]
}
