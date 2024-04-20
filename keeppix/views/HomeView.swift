//
//  HomeView.swift
//  keeppix
//
//  Created by Peter Wright on 01/01/2024.
//

import SwiftUI
import SwiftData

// Mark: HomeView layout
struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject var state = HomeViewState()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                HStack(alignment: .top, spacing: 30) {
                    Button( "Recent", action: { state.setSortOrder("recent") } ).font(.caption).foregroundColor( state.sortOrder == "recent" ? .accentColor : .secondary)
                    Button( "Frequent", action: {state.setSortOrder("frequent")} ).font(.caption).foregroundColor( state.sortOrder == "frequent" ? .accentColor : .secondary)
                    Button( "Newest", action: { state.setSortOrder("newest")} ).font(.caption).foregroundColor( state.sortOrder == "newest" ? .accentColor : .secondary)
                    Spacer()
                }.padding([.bottom], 10)
                
                if state.heroPix != nil {
                    NavigationLink(destination: PixView(pix: state.heroPix!)) {
                        ThumbnailView(pix: state.heroPix!, captionFont: .body)
                    }
                } else {
                    VStack { Spacer() }
                }
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach (state.previewPixs) { pix in
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
            state.setContext(modelContext)
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
