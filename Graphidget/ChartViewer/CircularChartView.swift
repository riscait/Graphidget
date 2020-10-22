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

    let centerLabel: String
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
            string: centerLabel,
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

        fetchData { result in
            switch result {
            case .success(let data):
                uiView.data = data

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchData(completion: @escaping (Result<ChartData, Error>) -> Void) {
        let entries = [
            PieChartDataEntry(value: 20, label: "国内株式"),
            PieChartDataEntry(value: 20, label: "米国株式"),
            PieChartDataEntry(value: 20, label: "債権"),
            PieChartDataEntry(value: 20, label: "預金"),
            PieChartDataEntry(value: 20, label: "小規模企業共済"),
        ]

        let dataSet = PieChartDataSet(entries: entries, label: "Asset Allocation")
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
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1
        //        formatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        data.setValueFont(.boldSystemFont(ofSize: 16))
        data.setValueTextColor(entryLabelColor)

        completion(.success(data))
    }
}

struct CircularChartView_Previews: PreviewProvider {
    static var previews: some View {
        CircularChartView(
            centerLabel: "Asset\nAllocation",
            entryLabelEnabled: true,
            centerTextEnabled: true,
            legendEnabled: true
        )
    }
}
