//
//  GraphidgetApp.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/18.
//

import FirebaseAuth
import FirebaseCore

import SwiftUI

@main
struct GraphidgetApp: App {

    init() {
        FirebaseApp.configure()
        loginIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            ChartListPage()
        }
    }

    func loginIfNeeded() {
        if let user = Auth.auth().currentUser {
            // ログイン済み
            print(user.uid)
            EventSender.loginAnonymous()
        } else {
            // 未ログイン
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    // エラーあり
                    print(error.localizedDescription)
                    return
                }
                guard let result = result else {
                    // 結果なし
                    return
                }
                print(result.user.uid)
                EventSender.setUserID(result.user.uid)
                print(result.additionalUserInfo?.isNewUser == true ? "New user" : "user")
                EventSender.signUpAnonymous()
            }
        }

    }
}
