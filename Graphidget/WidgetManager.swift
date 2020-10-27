//
//  WidgetManager.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/26.
//

import WidgetKit

/// アプリ側からWidgetを操作する
/// MEMO: Widget側に移した方が良いかも？
struct WidgetManager {
    private init() {}

    /// Widget Targetと共有するUserDefaults
    static let userDefaults = UserDefaults(suiteName: "group.jp.altive.Graphidget")

    /// Widget target と共有するデータを保存する
    /// - Parameter dataString: 保存する文字列
    static func save(dataString: String) {
        userDefaults?.set(dataString, forKey: "key")
    }

    /// Widgetをリロードさせる
    static func reloadWidget() {
        WidgetCenter.shared.reloadAllTimelines()
    }
}
