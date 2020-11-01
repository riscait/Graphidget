//
//  ChartListViewModel.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/28.
//

import Foundation
import SharedObjects
import FirebaseAuth
import FirebaseFirestore

class ChartListViewModel: ObservableObject {

    @Published var charts = [ChartModel]()

    private let db = Firestore.firestore()
    private let auth = Auth.auth()

    func fetchData() {
        guard let user = auth.currentUser else {
            print("No user")
            return
        }

        db.collection("users").document(user.uid).collection("charts").addSnapshotListener { [self] querySnapshot, error  in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            charts = documents.compactMap(createChart)
        }
    }

    private func createChart(document: QueryDocumentSnapshot) -> ChartModel? {

        let dictionary = document.data()

        guard let title = dictionary["title"] as? String,
              let valueTypeRawValue = dictionary["valueType"] as? String,
              let valueType = ChartModel.ValueType(rawValue: valueTypeRawValue),
              let entriesData = dictionary["entries"] as? [[String: Any]],
              let createdAt = dictionary["createdAt"] as? Timestamp,
              let updatedAt = dictionary["updatedAt"] as? Timestamp else {
            return nil
        }

        let entries = entriesData.compactMap { entry -> ChartModel.ChartEntryModel? in
            guard let name = entry["name"] as? String,
                  let value = entry["value"] as? Double else {
                return nil
            }
            return ChartModel.ChartEntryModel(name: name, value: value)
        }

        let chart = ChartModel(
            title: title,
            valueType: valueType,
            entries: entries,
            // Firestoreから受け取ったTimestampをDateとして利用
            createdAt: createdAt.dateValue(),
            updatedAt: updatedAt.dateValue()
        )
        return chart
    }
}
