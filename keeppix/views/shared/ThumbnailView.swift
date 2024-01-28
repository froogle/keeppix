//
//  ThumbnailView.swift
//  keeppix
//
//  Created by Peter Wright on 02/01/2024.
//

import SwiftUI

struct ThumbnailView: View {
    @State var pix: Pix
    @State var captionFont: Font = .caption2
    @State var showCaption = true
    
    var body: some View {
        ZStack( alignment: .top) {
            if let imageData = pix.imageData {
                Color.clear
                    .aspectRatio(1, contentMode: .fit)
                    .background(Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        )
                    .clipped()
                    .cornerRadius(10.0)
            } else {
                Color.clear
                    .aspectRatio(1, contentMode: .fit)
                    .background(Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(contentMode: .fill))
                    .clipped()
                    .cornerRadius(10.0)
            }
            
            if (showCaption) {
                HStack(alignment: .top, spacing: 0) {
                    Text(pix.pixDescription)
                        .font(captionFont)
                        .foregroundColor(.white)
                        .truncationMode(.tail)
                        .lineLimit(1)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(7)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: .bottom)
                )
                .opacity(0.9)
                .cornerRadius(5)
            }
            
            
        }.padding(0)
    }
}

//#Preview {
//    ThumbnailView()
//}
