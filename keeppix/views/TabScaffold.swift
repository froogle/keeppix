//
//  TabScaffold.swift
//  keeppix
//
//  Created by Peter Wright on 01/01/2024.
//

import SwiftUI

struct TabScaffold: View {
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
                HomeView()
                    .tabItem {
                        Label("Add", systemImage: "plus.circle.fill")
                    }
                    .confirmationDialog("Where should we get your new Pix from?", isPresented: $showCameraSource){
                        Button("Use your phone's gallery") {}
                        Button("Use your phone's camera") {}
                    }
            }
        }.searchable(text: $searchText, prompt: "Search for...")
    }
}

#Preview {
    TabScaffold()
}
