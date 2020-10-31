//
//  EventSender.swift
//  Graphidget
//
//  Created by 村松龍之介 on 2020/10/26.
//

import Foundation
import FirebaseAnalytics

/// https://support.google.com/analytics/answer/9267735
enum EventSender {

    /// イベントを送信すると同時にプリントする
    /// - Parameters:
    ///   - name: イベント名
    ///   - parameters: Optionalなイベントパラメーター
    private static func sendLogEvent(_ name: String, parameters: [String: Any]) {
        Analytics.logEvent(name, parameters: parameters)
        print("logEvent(\(name):parameters:\(parameters))")
    }

    static func setUserID(_ id: String) {
        Analytics.setUserID(id)
        print("setUserID(\(id)")
    }

    static func setUserPropertys(_ value: String, forName: String) {
        Analytics.setUserProperty("value", forName: "name")
        print("setUserProperty(\(value):forName:\(forName))")
    }

    static func signUpAnonymous() {
        sendLogEvent(AnalyticsEventSignUp, parameters: [AnalyticsParameterSignUpMethod: "Anonymous"])
    }

    static func loginAnonymous(uid: String) {
        sendLogEvent(AnalyticsEventLogin, parameters: [AnalyticsParameterMethod: "Anonymous"])
        print("uid: \(uid)")
    }

    static func beginTutorial() {
        sendLogEvent(AnalyticsEventTutorialBegin, parameters: [:])
    }

    static func completeTutorial() {
        sendLogEvent(AnalyticsEventTutorialComplete, parameters: [:])
    }
}
