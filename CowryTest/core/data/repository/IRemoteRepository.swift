//
//  IRemoteRepository.swift
//  CowryTest
//
//  Created by ADMIN on 7/13/23.
//

import Foundation


protocol IRemoteRepository {
    var client: HTTPClient { get }
}


extension IRemoteRepository {
    func onResponse(_ result: HTTPClient.Result,
                      resultData: @escaping (Data) -> Void,
                      resultError: @escaping (ResponseError) -> Void) {
        switch result {
        case let .success(tupleResult as SuccessResponse):
            if !tupleResult.response.statusCode.STATUS_CODE_OK {
                resultError(.invalidData)
            } else {
                resultData(tupleResult.data)
            }
        case .failure(_):
            resultError(.connectivity)
        }
    }
}
