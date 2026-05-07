//
//  Week_11_MADApp.swift
//  Week_11_MAD
//
//  Created by Felicia Sword on 07/05/26.
//

// Week_11_MADApp.swift
import SwiftUI
import SwiftData

@main
struct Week_11_MADApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: Company.self, Project.self, Employee.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            CompanyListView()
                .environmentObject(CompanyViewModel(context: container.mainContext))
        }
        .modelContainer(container)
    }
}
