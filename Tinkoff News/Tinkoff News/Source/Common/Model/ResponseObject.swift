//
//  Response.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 25.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

final class ResponseObject {
    var payload:        Any?
    var resultCode:     String?
    var errorMessage:   String?
    var plainMessage:   String?
    var trackingId:     String?
    
    init(resultCode: String?, payload: Any?, errorMessage: String?,
         plainMessage: String?, trackingId: String?) {
        self.payload        = payload
        self.resultCode     = resultCode
        self.errorMessage   = errorMessage
        self.plainMessage   = plainMessage
        self.trackingId     = trackingId
    }
}

extension ResponseObject: Decodable {
    enum ResponseCodingKeys: String, CodingKey {
        case resultCode
        case payload
        case errorMessage
        case plainMessage
        case trackingId
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        let payload        = try? container.decode(String.self, forKey: .payload)
        let resultCode     = try? container.decode(String.self, forKey: .resultCode)
        let errorMessage   = try? container.decode(String.self, forKey: .errorMessage)
        let plainMessage   = try? container.decode(String.self, forKey: .plainMessage)
        let trackingId     = try? container.decode(String.self, forKey: .trackingId)
        
        self.init(resultCode: resultCode, payload: payload,
                  errorMessage: errorMessage, plainMessage: plainMessage, trackingId: trackingId)
    }
}
