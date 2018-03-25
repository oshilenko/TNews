//
//  Response.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 25.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

final class ResponseObjects<T: Decodable> {
    var payload:        [T]?
    var resultCode:     String?
    var errorMessage:   String?
    var plainMessage:   String?
    var trackingId:     String?
    
    init(resultCode: String?, payload: [T]?, errorMessage: String?,
         plainMessage: String?, trackingId: String?) {
        self.payload        = payload
        self.resultCode     = resultCode
        self.errorMessage   = errorMessage
        self.plainMessage   = plainMessage
        self.trackingId     = trackingId
    }
}

// MARK: - Decodable methods
extension ResponseObjects: Decodable {
    enum ResponseCodingKeys: String, CodingKey {
        case resultCode
        case payload
        case errorMessage
        case plainMessage
        case trackingId
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        let payload        = try? container.decode([T].self, forKey: .payload)
        let resultCode     = try? container.decode(String.self, forKey: .resultCode)
        let errorMessage   = try? container.decode(String.self, forKey: .errorMessage)
        let plainMessage   = try? container.decode(String.self, forKey: .plainMessage)
        let trackingId     = try? container.decode(String.self, forKey: .trackingId)
        
        self.init(resultCode: resultCode, payload: payload,
                  errorMessage: errorMessage, plainMessage: plainMessage, trackingId: trackingId)
    }
}
