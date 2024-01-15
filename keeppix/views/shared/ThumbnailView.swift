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
            Image(uiImage: UIImage(data: pix.imageData!)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(pix.pixDescription)
                .frame(maxWidth: .infinity)
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

//#Preview {
//    ThumbnailView()
//}
