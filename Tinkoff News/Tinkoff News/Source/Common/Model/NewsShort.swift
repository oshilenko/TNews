//
//  NewsShort.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 26.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

final class NewsShort {
    var id:                 String?
    var name:               String?
    var text:               String?
    var publicationDate:    PublicationDate?
    var bankInfoTypeId:     Int?
    
    init(id: String?, name: String?, text: String?, publicationDate: PublicationDate?, bankInfoTypeId: Int?) {
        self.id              = id
        self.name            = name
        self.text            = text
        self.publicationDate = publicationDate
        self.bankInfoTypeId  = bankInfoTypeId
    }
}

// MARK: - Decodable methods
extension NewsShort: Decodable {
    enum NewsShortCodingKeys: String, CodingKey {
        case id
        case name
        case text
        case publicationDate
        case bankInfoTypeId
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsShortCodingKeys.self)
        let id              = try? container.decode(String.self, forKey: .id)
        let name            = try? container.decode(String.self, forKey: .name)
        let text            = try? container.decode(String.self, forKey: .text)
        let publicationDate = try? container.decode(PublicationDate.self, forKey: .publicationDate)
        let bankInfoTypeId  = try? container.decode(Int.self, forKey: .bankInfoTypeId)
        
        self.init(id: id, name: name, text: text, publicationDate: publicationDate, bankInfoTypeId: bankInfoTypeId)
    }
}

