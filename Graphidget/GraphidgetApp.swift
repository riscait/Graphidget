//
//  GraphidgetApp.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/18.
//

import SwiftUI

import FirebaseCore

@main
struct GraphidgetApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SplashPage()
        }
    }
}
