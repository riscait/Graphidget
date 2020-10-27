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

    static func setUserID(_ id: String) {
        Analytics.setUserID(id)
    }

    static func setUserPropertys() {
        Analytics.setUserProperty("value", forName: "name")
    }

    static func signUpAnonymous() {
        Analytics.logEvent(AnalyticsEventSignUp, parameters: [AnalyticsParameterSignUpMethod: "Anonymous"])
    }

    static func loginAnonymous() {
        Analytics.logEvent(AnalyticsEventLogin, parameters: [AnalyticsParameterMethod: "Anonymous"])
    }

    static func beginTutorial() {
        Analytics.logEvent(AnalyticsEventTutorialBegin, parameters: nil)
    }

    static func completeTutorial() {
        Analytics.logEvent(AnalyticsEventTutorialComplete, parameters: nil)
    }
}
