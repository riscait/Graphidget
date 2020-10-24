//
//  IntentHandler.swift
//  GraphidgetIntent
//
//  Created by 村松龍之介 on 2020/10/24.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    
    func provideParameterOptionsCollection(
        for intent: ConfigurationIntent,
        with completion: @escaping (INObjectCollection<WidgetCharts>?, Error?) -> Void
    ) {
        // データの生成処理
        let charts = [WidgetCharts]()
        
        completion(INObjectCollection(items: charts), nil)
    }
    
    // Widgetを初めて表示して、まだ動的リストから選択していない時の表示を設定
    func defaultParameter(for intent: ConfigurationIntent) -> WidgetCharts? {
        WidgetCharts(
            identifier: "0",
            // 簡潔に記述する表示文字列
            display: "表示文字列",
            // 二次情報を追加する文字列
            subtitle: "",
            // 画像
            image: INImage(named: "star")
        )
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
