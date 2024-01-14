//
//  TabScaffold.swift
//  keeppix
//
//  Created by Peter Wright on 01/01/2024.
//

import SwiftUI

struct TabScaffoldView: View {
    @State var searchText = ""
    @State var showAddPixView = false;
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                ListView()
                    .tabItem {
                        Label("List", systemImage: "photo")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddPixView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search for...")
        .fullScreenCover(isPresented: $showAddPixView) {
            EditPixView(isPresented: $showAddPixView)
        }
    }
}

#Preview {
    TabScaffoldView()
}
