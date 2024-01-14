//
//  EditPix.swift
//  keeppix
//
//  Created by Peter Wright on 03/01/2024.
//

import SwiftUI
import PhotosUI

struct EditPixView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var isPresented: Bool
    
    @State private var isShowingPicker = true
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                
                HStack {
                    Button("Back") { dismiss() }
                    Spacer()
                }
                
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
        }
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        selectedImage = image
                    }
                }
                photosPickerItem = nil
            }
        }
        .onChange(of: isShowingPicker) { _, _ in
            if photosPickerItem == nil {
                isPresented = false
            }
        }
        .photosPicker(isPresented: $isShowingPicker, selection: $photosPickerItem)
        
    }
}

#Preview {
    EditPixView(isPresented: .constant(true))
}
