//
//  Quiz_MasterApp.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI

@main
@MainActor
struct Quiz_MasterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(appContainer)
        }
    }
}
