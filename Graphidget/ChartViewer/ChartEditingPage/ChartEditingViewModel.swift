//
//  ChartEditingViewModel.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/29.
//

import Foundation
import SharedObjects
import FirebaseAuth
import FirebaseFirestore

/// `value` が文字列
struct ChartEntry {
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
    @Published var chartItems = [ChartEntry(), ChartEntry()]

    private let db = Firestore.firestore()
    private let auth = Auth.auth()

    func appendEntryField() {
        guard chartItems.count < 6 else {
            // 個数制限
            return
        }
        // 空のアイテムを追加
        chartItems.append(ChartEntry())
    }

    func delete(at offsets: IndexSet) {
        chartItems.remove(atOffsets: offsets)
    }

    /// チャートデータを保存する
    /// - Parameter completion: 成功またはエラーを返す
    func saveChart(completion: @escaping (Result<Void, DBError>) -> Void) {
        guard let user = auth.currentUser else {
            print("No user")
            completion(.failure(.noUser))
            return
        }

        let chartData = ChartModel(
            title: chartName,
            valueType: chartType,
            entries: chartItems.compactMap { entry in
                if entry.name.isEmpty && entry.value.isEmpty {
                    return nil
                }
                return ChartModel.ChartEntryModel(
                    name: entry.name, value: Double(entry.value) ?? 0
                )
            }
        )

        var dictionary = chartData.toDictionary

        dictionary["createdAt"] = FirebaseFirestore.FieldValue.serverTimestamp()
        dictionary["updatedAt"] = FirebaseFirestore.FieldValue.serverTimestamp()

        db.collection("users").document(user.uid).collection("charts").addDocument(data: dictionary) { error in
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
    case encodeFailed
    case unknown
}
