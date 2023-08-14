//
//  PageIntro.swift
//  simplrdating
//
//  Created by Brandon Ramírez Casazza on 09/08/23.
//

import SwiftUI

/// Page Intro Model
struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var title: String
    var subTitle: String
    var displaysAction: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "Page 1", title: "Welcome to\nSIMPLR!", subTitle: "Rediscover the essence of dating."),
    .init(introAssetImage: "Page 2", title: "Simplifying\nConnections", subTitle: "Dating made easy, just like it used to be."),
    .init(introAssetImage: "Page 3", title: "Let's\nGet Started!", subTitle: "To register for an account, kindly Sign Up.", displaysAction: true),
]
