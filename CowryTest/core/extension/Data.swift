//
//  Data.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation
import  SwiftyJSON

extension Data {
    func decode(dataKey: String, keys: [String] = []) -> Response? {
        guard let json = try? SwiftyJSON.JSON(data: self) else { return nil }
        let success = json["success"].boolValue
        let timestamp = json["timestamp"].doubleValue
        let data = json[dataKey].dictionaryValue
        
        var others = [String:Any?]()
        for key in keys {
            others[key] = json[key].rawValue
        }
        return Response.init(success: success, timestamp: timestamp, data: data, others: others)
    }
}
