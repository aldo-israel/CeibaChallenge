//
//  CeibaChallengeApp.swift
//  CeibaChallenge
//
//  Created by Aldo Israel Navarro on 4/23/22.
//

import SwiftUI

@main
struct CeibaChallengeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
