//
//  ThumbnailView.swift
//  keeppix
//
//  Created by Peter Wright on 02/01/2024.
//

import SwiftUI

struct ThumbnailView: View {
    @State var pix: Pix
    
    var body: some View {
        ZStack( alignment: .top) {
            if let imageData = pix.imageData {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            Text(pix.pixDescription)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
                .font(.caption2)
                .foregroundColor(.white)
                .truncationMode(.tail)
                .lineLimit(1)
                .padding(5)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(5)
                .opacity(0.95)
            
        }.padding(0)
    }
}

//#Preview {
//    ThumbnailView()
//}
