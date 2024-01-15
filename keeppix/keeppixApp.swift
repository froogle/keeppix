//
//  keeppixApp.swift
//  keeppix
//
//  Created by Peter Wright on 31/12/2023.
//

import SwiftUI
import SwiftData

@main
struct keeppixApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Pix.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TabScaffoldView()
        }
        .modelContainer(sharedModelContainer)
    }
}
