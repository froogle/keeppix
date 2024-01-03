//
//  TabScaffold.swift
//  keeppix
//
//  Created by Peter Wright on 01/01/2024.
//

import SwiftUI

struct TabScaffoldView: View {
    @State var searchText = ""
    @State var showCameraSource = false;
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
                EditPixView()
                    .tabItem {
                        Label("Add", systemImage: "plus.circle.fill")
                    }
            }
        }.searchable(text: $searchText, prompt: "Search for...")
    }
}

#Preview {
    TabScaffoldView()
}
