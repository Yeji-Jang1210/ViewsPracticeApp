//
//  String+Extension.swift
//  ViewsPracticeApp
//
//  Created by 장예지 on 7/20/24.
//

import Foundation

extension String {
    func convertStringToDate(_ dateFormatStyle: String) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.dateFormat = dateFormatStyle
        
        return dateFormat.date(from: self)
    }
}

