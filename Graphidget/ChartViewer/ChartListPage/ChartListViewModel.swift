//
//  ChartListViewModel.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/28.
//

import Foundation
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

        db.collection("users").document(user.uid).collection("charts").addSnapshotListener { [self] querySnapshot, _ in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            charts = documents.compactMap { document in
                let data = document.data()

                guard let title = data["title"] as? String,
                      let valueTypeRawValue = data["valueType"] as? String,
                      let valueType = ChartModel.ValueType(rawValue: valueTypeRawValue),
                      let entitiesData = data["entities"] as? [[String: Any]] else {
                    return nil
                }

                let entities = entitiesData.compactMap { entity -> ChartModel.ChartEntityModel? in
                    guard let name = entity["name"] as? String,
                          let value = entity["value"] as? Double else {
                        return nil
                    }
                    return ChartModel.ChartEntityModel(name: name, value: value)
                }

                let chart = ChartModel(
                    title: title,
                    valueType: valueType,
                    entities: entities
                )
                return chart
            }
        }
    }
}
