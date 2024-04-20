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
    @Published var heroPix: Pix?
    @Published var previewPixs = ArraySlice<Pix>()
    @Published var sortOrder = "recent"
    
    private var modelContext: ModelContext?
    
    init() {

    }
    
    func setSortOrder(_ order: String) {
        sortOrder = order
        loadPixs()
        assignThumbnailPixs()
    }
    
    func setContext(_ context: ModelContext) {
        modelContext = context
        loadPixs()
        assignThumbnailPixs()
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
    
    func assignThumbnailPixs() {
        if !pixs.isEmpty {
            heroPix = pixs.removeFirst()
            previewPixs = pixs.prefix(6)
        } else {
            heroPix = nil
            previewPixs = []
        }
        
    }
}
