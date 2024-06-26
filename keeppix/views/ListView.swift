//
//  ListView.swift
//  keeppix
//
//  Created by Peter Wright on 02/01/2024.
//

import SwiftUI
import SwiftData

// MARK: ListView layout.
struct ListView: View {
    @Query() var pixs: [Pix]
    @State private var sortOrder = "recent"
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top, spacing: 30) {
                Button( "Recent", action: {sortOrder = "recent"} ).font(.caption).foregroundColor( sortOrder == "recent" ? .accentColor : .secondary)
                Button( "Frequent", action: {sortOrder = "frequent"} ).font(.caption).foregroundColor( sortOrder == "frequent" ? .accentColor : .secondary)
                Button( "Newest", action: {sortOrder = "newest"} ).font(.caption).foregroundColor( sortOrder == "newest" ? .accentColor : .secondary)
                Spacer()
            }.padding([.bottom], 10)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(pixs) { pix in
                        NavigationLink( destination: PixView(pix: pix)) {
                            ThumbnailView(pix: pix)
                        }
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding( .all )
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Pix.self, configurations: config)

    for i in 1..<10 {
        let pix = Pix(pixDescription: "Test Pix \(i)", tags: ["test"])
        container.mainContext.insert(pix)
    }

    return ListView()
        .modelContainer(container)
}
