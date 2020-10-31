//
//  ChartDetailPage.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/23.
//

import SwiftUI

struct ChartDetailPage: View {

    let chart: ChartModel

    var body: some View {
        VStack {
            DetailChartView(chart: chart)
            Text("Created at: \(chart.createdAt?.longStyleString ?? "")")
                .padding()
            Text("Updated at: \(chart.updatedAt?.longStyleString ?? "")")
            Spacer()
        }
        .navigationTitle(chart.title)
    }
}

struct ChartDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        ChartDetailPage(chart: chartModelStab)
    }
}
