//
//  ThumbnailChartView.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/22.
//

import SwiftUI

struct ThumbnailChartView: View {
    /// グラフのタイトル
    let title: String

    var body: some View {
        VStack(alignment: .center/*@END_MENU_TOKEN@*/,
               spacing: 0/*@END_MENU_TOKEN@*/) {
            CircularChartView(centerLabel: title,
                              entryLabelEnabled: false,
                              centerTextEnabled: false,
                              legendEnabled: false)
                .frame(height: 140)
            Text(title)
                .padding(.bottom, 8)
        }
        .background(Color.black.opacity(0.05))
        .cornerRadius(16)
    }
}

struct ThumbnailChartView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailChartView(title: "Graph Title")
    }
}
