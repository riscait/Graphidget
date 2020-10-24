//
//  ChartModel.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/23.
//

import Foundation

struct ChartModel {
    let title: String
    let valueType: ValueType
    let entities: [ChartEntityModel]

    enum ValueType {
        case money
        case percentage
    }

    struct ChartEntityModel {
        let name: String
        let value: Double
    }
}
