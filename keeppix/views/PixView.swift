//
//  PixView.swift
//  keeppix
//
//  Created by Peter Wright on 25/02/2024.
//

import SwiftUI

struct PixView: View {
    
    let pix: Pix
    
    init(pix: Pix) {
        self.pix = pix
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PixView(pix: Pix(pixDescription: "Test Pix", tags: ["test"]))
}
