//
//  AlamofireHTTPClient.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation
import Alamofire


final class AlamofireHTTPClient : HTTPClient {
    
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        Logger.log(.i, messages: url.absoluteString)
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default).response { response in
            switch response.result {
            case let .success(data):
                Logger.log(.i, messages: String.init(data: data!, encoding: .utf8) ?? "")
                
                completion(.success((data!, response.response!)))
            case let .failure(afError):
                completion(.failure(afError.underlyingError!))
            }
        }
    }
}
