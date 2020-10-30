//
//  ChartModel.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/23.
//

import Foundation

struct ChartModel: Identifiable {

    let id = UUID()

    let title: String
    let valueType: ValueType
    let entities: [ChartEntityModel]

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

    struct ChartEntityModel: Identifiable {

        let id = UUID()

        let name: String
        let value: Double
    }

    var toDictionary: [String: Any] {
        [
            "title": title,
            "valueType": valueType.rawValue,
            "entities": entities.map {[
                "name": $0.name,
                "value": $0.value,
            ]
            },
        ]
    }
}
