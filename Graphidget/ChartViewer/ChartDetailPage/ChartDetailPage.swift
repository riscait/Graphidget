//
//  ChartDetailPage.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/23.
//

import SwiftUI
import SharedObjects

struct ChartDetailPage: View {

    let chart: ChartModel

    var body: some View {
        VStack {
            DetailChartView(chart: chart)
            Text("ChartDetailPage.createdAt \(chart.createdAt?.longStyleString ?? "")")
                .padding()
            Text("ChartDetailPage.updatedAt \(chart.updatedAt?.longStyleString ?? "")")
            Spacer()
        }
        .navigationTitle(chart.title)
    }
}

struct ChartDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChartDetailPage(chart: chartModelStab)
                .environment(\.colorScheme, .light)
                .environment(\.locale, .init(identifier: "en"))
            ChartDetailPage(chart: chartModelStab)
                .environment(\.colorScheme, .dark)
                .environment(\.locale, .init(identifier: "ja"))
        }
    }
}
