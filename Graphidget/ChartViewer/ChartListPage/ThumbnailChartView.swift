//
//  ThumbnailChartView.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/22.
//

import SwiftUI

struct ThumbnailChartView: View {
    /// グラフのタイトル
    let chart: ChartModel

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CircularChartView(chartData: chart,
                              entryLabelEnabled: false,
                              centerTextEnabled: false,
                              legendEnabled: false)
                .frame(height: 140)
            Text(chart.title)
                .padding(.bottom, 8)
        }
        .background(Color.black.opacity(0.05))
        .cornerRadius(16)
    }
}

struct ThumbnailChartView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailChartView(
            chart: ChartModel(
                title: "",
                valueType: .currency,
                entries: [ChartModel.ChartEntryModel(name: "", value: 100)]
            )
        )
    }
}
