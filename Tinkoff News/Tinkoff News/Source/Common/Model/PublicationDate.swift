//
//  PublicationDate.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 26.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

final class PublicationDate {
    var milliseconds:    Int?
    
    init(milliseconds: Int?) {
        self.milliseconds = milliseconds
    }
}

// MARK: - Decodable methods
extension PublicationDate: Decodable {
    enum PublicationDateCodingKeys: String, CodingKey {
        case milliseconds
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PublicationDateCodingKeys.self)
        let milliseconds = try? container.decode(Int.self, forKey: .milliseconds)
        
        self.init(milliseconds: milliseconds)
    }
}
