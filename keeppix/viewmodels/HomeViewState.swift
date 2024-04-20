//
//  HomeViewState.swift
//  keeppix
//
//  Created by Peter Wright on 20/04/2024.
//
import SwiftUI
import SwiftData

@MainActor final class HomeViewState : ObservableObject {
    @Published var pixs = [Pix]()
    @Published var sortOrder = "recent"
    
    private var modelContext: ModelContext?
    
    init() {

    }
    
    func setSortOrder(_ order: String) {
        sortOrder = order
        loadPixs()
    }
    
    func setContext(_ context: ModelContext) {
        modelContext = context
        loadPixs()
    }
    
    func loadPixs() {
        var fetchDescriptor = FetchDescriptor<Pix>()
        
        switch(sortOrder) {
            case "recent":
                fetchDescriptor.sortBy = [SortDescriptor(\.updatedAt, order: .reverse)]
            case "newest":
                fetchDescriptor.sortBy = [SortDescriptor(\.createdAt, order: .reverse)]
            default:
                fetchDescriptor.sortBy = [SortDescriptor(\.viewCount, order: .reverse)]
        }

        fetchDescriptor.fetchLimit = 7
        if let context = modelContext {
            do {
                pixs = try context.fetch(fetchDescriptor)
            } catch {
                pixs = []
            }
        }
    }
    

}
