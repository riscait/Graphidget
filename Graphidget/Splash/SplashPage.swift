//
//  SplashPage.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/28.
//

import SwiftUI
import FirebaseAuth

struct SplashPage: View {

    @State var canTransition = false

    var body: some View {
        ZStack {
            if canTransition {
                ChartListPage()
            } else {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }.onAppear {
            loginIfNeeded {
                canTransition = true
            }
        }
    }

    func loginIfNeeded(completion: @escaping () -> Void) {
        if let user = Auth.auth().currentUser {
            // ログイン済み
            EventSender.loginAnonymous(uid: user.uid)
            completion()
            return
        }
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
            EventSender.setUserID(result.user.uid)

            if result.additionalUserInfo?.isNewUser == true {
                UserRepository().create(uid: result.user.uid)
            }
            EventSender.signUpAnonymous()
            completion()
        }
    }
}

struct SplashPage_Previews: PreviewProvider {
    static var previews: some View {
        SplashPage()
    }
}
