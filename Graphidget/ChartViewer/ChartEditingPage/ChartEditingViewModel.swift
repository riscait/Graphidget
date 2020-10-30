//
//  ChartEditingViewModel.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/29.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

/// `value` が文字列
struct ChartItem {
    var name: String
    var value: String

    init() {
        name = ""
        value = ""
    }
}

class ChartEditingViewModel: ObservableObject {

    @Published var chartType = ChartModel.ValueType.currency
    @Published var chartName = ""
    /// チャートの項目、初期値で空の項目を2つ用意
    @Published var chartItems = [ChartItem(), ChartItem()]

    private let db = Firestore.firestore()
    private let auth = Auth.auth()

    func appendEntryField() {
        guard chartItems.count < 6 else {
            // 個数制限
            return
        }
        // 空のアイテムを追加
        chartItems.append(ChartItem())
    }

    func delete(at offsets: IndexSet) {
        chartItems.remove(atOffsets: offsets)
    }

    func wtite(completion: @escaping (Result<Void, DBError>) -> Void) {
        guard let user = auth.currentUser else {
            print("No user")
            completion(.failure(.noUser))
            return
        }

        let chartData = ChartModel(
            title: chartName,
            valueType: chartType,
            entries: chartItems.map { ChartModel.ChartEntryModel(name: $0.name, value: Double($0.value) ?? 0) }
        )

        db.collection("users").document(user.uid).collection("charts").addDocument(data: chartData.toDictionary) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.unknown))
                return
            }
            completion(.success(()))
        }
    }
}

enum DBError: Error {
    case noUser
    case unknown
}
