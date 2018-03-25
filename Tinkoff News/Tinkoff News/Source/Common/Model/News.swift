//
//  News.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 26.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

final class News {
    var title:                  NewsShort?
    var creationDate:           PublicationDate?
    var lastModificationDate:   PublicationDate?
    var content:                String?
    var bankInfoTypeId:         Int?
    var typeId:                 String?
    
    init(title: NewsShort?, creationDate: PublicationDate?, lastModificationDate: PublicationDate?,
         content: String?, bankInfoTypeId: Int?, typeId: String?) {
        self.title                  = title
        self.creationDate           = creationDate
        self.lastModificationDate   = lastModificationDate
        self.content                = content
        self.bankInfoTypeId         = bankInfoTypeId
        self.typeId                 = typeId
    }
}

// MARK: - Decodable methods
extension News: Decodable {
    enum NewsCodingKeys: String, CodingKey {
        case title
        case creationDate
        case lastModificationDate
        case content
        case bankInfoTypeId
        case typeId
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsCodingKeys.self)
        let title                   = try? container.decode(NewsShort.self, forKey: .title)
        let creationDate            = try? container.decode(PublicationDate.self, forKey: .creationDate)
        let lastModificationDate    = try? container.decode(PublicationDate.self, forKey: .lastModificationDate)
        let content                 = try? container.decode(String.self, forKey: .content)
        let bankInfoTypeId          = try? container.decode(Int.self, forKey: .bankInfoTypeId)
        let typeId                  = try? container.decode(String.self, forKey: .typeId)
        
        self.init(title: title, creationDate: creationDate, lastModificationDate: lastModificationDate,
                  content: content, bankInfoTypeId: bankInfoTypeId, typeId: typeId)
    }
}
