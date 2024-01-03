//
//  ThumbnailView.swift
//  keeppix
//
//  Created by Peter Wright on 02/01/2024.
//

import SwiftUI

struct ThumbnailView: View {
    var body: some View {
        ZStack( alignment: .top) {
            Image(systemName: "photo.artframe")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.caption2)
                .foregroundColor(.white)
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(2)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: .bottom)
                )
                .opacity(0.95)
        }.padding(0)
    }
}

#Preview {
    ThumbnailView()
}
