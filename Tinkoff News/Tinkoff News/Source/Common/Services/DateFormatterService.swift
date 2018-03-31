//
//  DateFormatterService.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 01.04.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation

final class DateFormatterService: NSObject {
    
}

extension DateFormatterService {
    func configureDateString(milliseconds: Int?, with format: String) -> String? {
        guard let milliseconds = milliseconds else { return nil }
        
        let timeInterval = milliseconds / 1000
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        var locale = Locale.current
        
        if let language = Locale.preferredLanguages.first {
            let preferedLocale = Locale(identifier: language)
            locale = preferedLocale
        }
        
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
