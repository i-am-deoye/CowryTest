//
//  HTTPClient.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation


protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    
    func get(from url: URL, completion: @escaping (Result) -> Void )
}
