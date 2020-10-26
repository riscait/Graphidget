//
//  GraphidgetWidget.swift
//  GraphidgetWidget
//
//  Created by 村松龍之介 on 2020/10/18.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    // 初回表示に呼ばれるが、呼ばれないこともあるようだ
    func placeholder(in context: Context) -> SimpleEntry {
        // Widgetのサイズ
        print(context.displaySize)
        return SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    // Widgetの追加時に呼ばれる
    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (SimpleEntry) -> ()
    ) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    // 1. Widgetをホーム画面に表示する時 2. ユーザー入力(configuration)を受け付けた後 に呼ばれる
    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// 更新のタイミングでWidgetに渡すデータの定義
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

// Widgetに表示するView
struct GraphidgetWidgetEntryView : View {
    var entry: Provider.Entry

    // アプリ側で保存したUserDefaultsを使う
//    let ud = UserDefaults(suiteName: "group.jp.altive.Graphidget")
    
    var body: some View {
        VStack {
            // configuration.parameter = ユーザーが選択した項目情報
            if let parameter = entry.configuration.parameter {
                Text(parameter.identifier ?? "none")
                Text(parameter.displayString)
            } else {
                Text(entry.date, style: .date)
            }
        }
    }
}

// エントリーポイント
@main
struct GraphidgetWidget: Widget {
    let kind: String = "GraphidgetWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            GraphidgetWidgetEntryView(entry: entry)
        }
        // Widget名
        .configurationDisplayName("Chart")
        // Widgetの説明
        .description("This is an chart.")
        // Widgetのサイズを指定
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// プレビューに定義
struct GraphidgetWidget_Previews: PreviewProvider {
    static var previews: some View {
        GraphidgetWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        GraphidgetWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
