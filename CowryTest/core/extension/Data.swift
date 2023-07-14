//
//  Data.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation
import  SwiftyJSON

extension Data {
    func decode() -> Response? {
        guard let json = try? SwiftyJSON.JSON(data: self) else { return nil }
        let success = json["success"].boolValue
        let timestamp = json["timestamp"].doubleValue
        let rates = json["rates"].dictionaryValue
        let base = json["base"].stringValue
        return Response.init(success: success, timestamp: timestamp, base: base, rates: rates)
    }
}
