//
//  CircularChartView.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/21.
//

import Charts
import SwiftUI

struct CircularChartView: UIViewRepresentable {
    typealias UIViewType = PieChartView

    let chartData: ChartModel
    let entryLabelColor = UIColor.white
    let entryLabelEnabled: Bool
    let centerTextEnabled: Bool
    let legendEnabled: Bool

    func makeUIView(context: Context) -> UIViewType {
        let chart = PieChartView()

        //        chart.centerText = "Asset\nAllocation"
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        chart.centerAttributedText = .init(
            string: chartData.title,
            attributes: [
                .paragraphStyle: paragraph,
                .font: UIFont.boldSystemFont(ofSize: 20),
            ]
        )
        chart.drawCenterTextEnabled = centerTextEnabled

        // entry label styling
        chart.entryLabelFont = .boldSystemFont(ofSize: 13)
        chart.entryLabelColor = entryLabelColor
        chart.drawEntryLabelsEnabled = entryLabelEnabled

        // no data label styling
        chart.noDataFont = .italicSystemFont(ofSize: 15)

        // legend styling
        let legend = chart.legend
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .top
        //        legend.orientation = .vertical
        legend.xEntrySpace = 7
        legend.yEntrySpace = 0
        legend.yOffset = 0
        legend.enabled = legendEnabled

        //        chart.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        //        chart.backgroundColor = .lightGray
        return chart
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

        let entries = chartData.entries
            // 金額の大きい順に並び替える
            .sorted { $0.value > $1.value }
            .map { entry in
                PieChartDataEntry(value: entry.value, label: entry.name)
            }

        let dataSet = PieChartDataSet(entries: entries, label: chartData.title)
        // ColorSet: vordiplom, joyful, colorful, liberty, pastel, material
        dataSet.colors = ChartColorTemplates.colorful()
        dataSet.xValuePosition = .insideSlice
        dataSet.sliceSpace = 0
        dataSet.drawValuesEnabled = entryLabelEnabled
        // distance to outside
        //        dataSet.xValuePosition = .outsideSlice
        //        dataSet.yValuePosition = .outsideSlice
        //        dataSet.valueLinePart1OffsetPercentage = 0.2
        //        dataSet.valueLinePart1Length = 0
        //        dataSet.valueLinePart2Length = 0.2

        let data = PieChartData(dataSet: dataSet)

        // value label styling
        let formatter = NumberFormatter()
        switch chartData.valueType {
        case .currency:
            formatter.numberStyle = .currency
            formatter.usesSignificantDigits = true
        case .percentage:
            formatter.numberStyle = .percent
            formatter.maximumFractionDigits = 1
            formatter.multiplier = 1
        }
        //        formatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        data.setValueFont(.boldSystemFont(ofSize: 16))
        data.setValueTextColor(entryLabelColor)

        uiView.data = data
    }
}

struct CircularChartView_Previews: PreviewProvider {
    static var previews: some View {
        CircularChartView(
            chartData: ChartModel(
                title: "Asset Allocation",
                valueType: .currency,
                entries: [
                    ChartModel.ChartEntryModel(name: "国内株式", value: 1000000000),
                    ChartModel.ChartEntryModel(name: "米国株式", value: 2000000000),
                    ChartModel.ChartEntryModel(name: "債権", value: 3000000000),
                    ChartModel.ChartEntryModel(name: "預金", value: 4000000000),
                    ChartModel.ChartEntryModel(name: "小規模企業共済", value: 5000000000),
                ]
            ),
            entryLabelEnabled: true,
            centerTextEnabled: true,
            legendEnabled: true
        )
    }
}
