//
//  ChartModel.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/23.
//

import Foundation
import FirebaseFirestore

/// チャートのモデルクラス
/// `ForEach(_:id:)` で使用するために `Hashable` に適合
struct ChartModel: Hashable {

    let title: String
    let valueType: ValueType
    let entries: [ChartEntryModel]
    var createdAt: Date?
    var updatedAt: Date?

    enum ValueType: String {
        case currency
        case percentage

        var suffix: String {
            switch self {
            case .currency:
                return "円"
            case .percentage:
                return "%"
            }
        }
    }

    struct ChartEntryModel: Hashable {

        let name: String
        let value: Double
    }

    var toDictionary: [String: Any] {
        [
            "title": title,
            "valueType": valueType.rawValue,
            "entries": entries.map {[
                "name": $0.name,
                "value": $0.value,
            ]
            },
        ]
    }
}

// Stab data

let chartModelStab = ChartModel(
    title: "Asset Allocation",
    valueType: .currency,
    entries: [
        ChartModel.ChartEntryModel(name: "Stock", value: 40),
        ChartModel.ChartEntryModel(name: "Bond", value: 40),
        ChartModel.ChartEntryModel(name: "cash", value: 20),
    ],
    createdAt: Date(),
    updatedAt: Date()
)
