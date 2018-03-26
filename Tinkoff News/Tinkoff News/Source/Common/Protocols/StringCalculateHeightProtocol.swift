//
//  StringCalculateHeightProtocol.swift
//  Tinkoff News
//
//  Created by Ольга Шиленко on 26.03.2018.
//  Copyright © 2018 Ольга Шиленко. All rights reserved.
//

import Foundation
import UIKit

protocol StringCalculateHeightProtocol {
    var font: UIFont { get }
    var width: CGFloat { get }
    var size: CGSize { get }
}

public enum StringItemType {
    case feedItemTitle(text: String)
}

// MARK: - StringCalculateHeightProtocol methods
extension StringItemType: StringCalculateHeightProtocol {
    var font: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 17)!
    }
    
    var width: CGFloat {
        return UIScreen.main.bounds.size.width - 32
    }
    
    var size: CGSize {
        switch self {
        case .feedItemTitle(let text):
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let attrStr = NSAttributedString(string: text,
                                             attributes: [NSAttributedStringKey.font: font,
                                                          NSAttributedStringKey.paragraphStyle: paragraphStyle])
            
            let textSize = attrStr
                .boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                              options: [.usesLineFragmentOrigin, .usesFontLeading],
                              context: nil).size
            
            return textSize
        }
    }
    
    
}

