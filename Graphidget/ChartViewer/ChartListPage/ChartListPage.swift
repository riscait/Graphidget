//
//  ChartListPage.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/18.
//

import SwiftUI

struct ChartListPage: View {
    let graphList = [
        ChartModel(
            title: "タイトル",
            valueType: .percentage,
            entities: [
                .init(
                    name: "",
                    value: 20
                ),
            ]
        ),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: GridItem(), count: 2),
                alignment: .center/*@END_MENU_TOKEN@*/,
                spacing: 8/*@END_MENU_TOKEN@*/,
                pinnedViews: [.sectionHeaders, .sectionFooters]/*@END_MENU_TOKEN@*/
            ) {
                Section(header: Text("グラフ一覧"), footer: Text("Footer")) {
                    ForEach(0..<graphList.count) { index in
                        ThumbnailChartView(title: graphList[index].title)
                    }
                }
            }/*@END_MENU_TOKEN@*/
            .padding()
        }
    }
}

struct GraphListPage_Previews: PreviewProvider {
    static var previews: some View {
        ChartListPage()
    }
}
