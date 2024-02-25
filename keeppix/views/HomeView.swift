//
//  HomeView.swift
//  keeppix
//
//  Created by Peter Wright on 01/01/2024.
//

import SwiftUI
import SwiftData


struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var pixs = [Pix]()
    @State private var previewPixs = ArraySlice<Pix>()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                HStack(alignment: .top, spacing: 30) {
                    Button( "Recent", action: {} ).font(.caption)
                    Button( "Frequent", action: {} ).font(.caption)
                    Button( "Newest", action: {} ).font(.caption)
                    Spacer()
                }.padding([.bottom], 10)
                
                
                // TODO: If we don't have any pixs, don't do this...
                if let pix = pixs.first {
                    NavigationLink(destination: PixView(pix: pix)) {
                        ThumbnailView(pix: pix, captionFont: .body)
                    }
                    
                }
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach (previewPixs) { pix in
                        NavigationLink( destination: PixView(pix: pix)) {
                            ThumbnailView(pix: pix, showCaption: false)
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding( .all )
        }
        .onAppear {
            loadPixs()
        }
    }
    
    private func loadPixs() {
        var fetchDescriptor = FetchDescriptor<Pix>( )
        fetchDescriptor.fetchLimit = 7
        do {
            pixs = try modelContext.fetch(fetchDescriptor)
            previewPixs = pixs.dropFirst(1)
        } catch {
            pixs = []
        }
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Pix.self, configurations: config)
    
    for i in 1..<10 {
        let pix = Pix(pixDescription: "Test Pix \(i)", tags: ["test"])
        container.mainContext.insert(pix)
    }
    return HomeView().modelContainer(container)
}
