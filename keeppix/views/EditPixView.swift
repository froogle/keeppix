//
//  EditPix.swift
//  keeppix
//
//  Created by Peter Wright on 03/01/2024.
//

import SwiftUI

struct EditPixView: View {
    @State private var isShowingPixSource = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                isShowingPixSource = true
            }
            .confirmationDialog("Where should we get your new Pix from?", isPresented: $isShowingPixSource, titleVisibility: .visible){
                Button("Use your phone's gallery") {}
                Button("Use your phone's camera") {}
            }
    }
    
    
}

#Preview {
    EditPixView()
}
