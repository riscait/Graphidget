//
//  Date+String.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/31.
//

import Foundation

extension Date {

    var longStyleString: String {
        DateFormatter.longDateFormatter.string(from: self)
    }
}
