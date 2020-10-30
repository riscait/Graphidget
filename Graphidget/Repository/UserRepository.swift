//
//  UserRepository.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/28.
//

import Foundation
import FirebaseFirestore

class UserRepository {

    private let db = Firestore.firestore()

    func create(uid: String) {
        db.collection("users").document(uid).setData([
            "createdAt": FirebaseFirestore.FieldValue.serverTimestamp(),
        ])
    }
}
