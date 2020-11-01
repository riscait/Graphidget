import Foundation

/// チャートのモデルクラス
/// `ForEach(_:id:)` で使用するために `Hashable` に適合
public struct ChartModel: Hashable, Codable {
    
    public enum ValueType: String, Codable {
        case currency
        case percentage

        public var suffix: String {
            switch self {
            case .currency:
                return "円"
            case .percentage:
                return "%"
            }
        }
    }

    public struct ChartEntryModel: Hashable, Codable {
        
        public init(
            name: String,
            value: Double
        ) {
            self.name = name
            self.value = value
        }
        

        public let name: String
        public let value: Double
    }

    public init(
        title: String,
        valueType: ChartModel.ValueType,
        entries: [ChartModel.ChartEntryModel],
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self.title = title
        self.valueType = valueType
        self.entries = entries
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    

    public let title: String
    public let valueType: ValueType
    public let entries: [ChartEntryModel]
    public var createdAt: Date?
    public var updatedAt: Date?

    public var toDictionary: [String: Any] {
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

public let chartModelStab = ChartModel(
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
