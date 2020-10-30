//
//  ChartListPage.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/18.
//

import SwiftUI

struct ChartListPage: View {

    @State private var isPresented = false
    @ObservedObject var viewModel = ChartListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(), count: 2),
                    alignment: .center,
                    spacing: 8,
                    pinnedViews: [.sectionHeaders, .sectionFooters]
                ) {
                    ForEach(viewModel.charts) { chart in
                        ThumbnailChartView(chart: chart)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Charts")
            .navigationBarItems(
                trailing: plusButton
            )
            .onAppear {
                viewModel.fetchData()
            }
        }
    }

    private var plusButton: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            Image(systemName: "plus.circle.fill")
                .imageScale(.large)
                .frame(width: 44, height: 44, alignment: .center)
        })
        .fullScreenCover(isPresented: $isPresented) {
            ChartEditingPage()
        }
    }
}

struct GraphListPage_Previews: PreviewProvider {
    static var viewModel: ChartListViewModel {
        let viewModel = ChartListViewModel()
        viewModel.charts = [ChartModel(
            title: "タイトル",
            valueType: .percentage,
            entries: [
                .init(
                    name: "",
                    value: 20
                ),
            ]
        ), ]
        return viewModel
    }

    static var previews: some View {
        ChartListPage(viewModel: viewModel)
    }
}
