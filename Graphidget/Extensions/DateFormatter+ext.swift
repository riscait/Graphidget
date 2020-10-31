//
//  DateFormatter+ext.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/31.
//

import Foundation

extension DateFormatter {
    /// 時間情報のない長い日付フォーマット
    /// e.g. "en_US": June 24, 2014, "ja_JP": 2017年8月13日
    static let longDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .none
        return df
    }()

    /// ミリ秒付きのiso8601フォーマット e.g. 2019-08-22T09:30:15.000+0900
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    /// 日付8桁・時間6桁のフォーマット e.g. 20190822093015
    static let yyyyMMddHHmmss: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
