//
//  Date+Extension.swift
//  ViewsPracticeApp
//
//  Created by 장예지 on 7/20/24.
//

import Foundation

extension Date {
    func convertDateToString(_ dateStyle: String) -> String? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = dateStyle
        return dateFormat.string(from: self)
    }
}
