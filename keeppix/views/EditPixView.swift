//
//  EditPix.swift
//  keeppix
//
//  Created by Peter Wright on 03/01/2024.
//

import SwiftUI
import PhotosUI
import TagField


// MARK: EditPixView layout
struct EditPixView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @Binding var isPresented: Bool
    
    @State private var isShowingPicker = true
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?

    @State private var pix = Pix(pixDescription: "", tags: [])
    
    @State private var tags: [String] = []
    var body: some View {
        VStack {
            
            HStack {
                Button("Cancel") { dismiss() }
                Spacer()
                Button("Done") {
                    context.insert( pix )
                    dismiss()
                }
            }
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
            } else
            {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
            }
            
            Form {
                Section {
                    Text("Created: 01/01/2021").font(.caption).foregroundColor(.accentColor)
                    TextField("Description", text: $pix.pixDescription)
                    TagField( tags: $pix.tags, placeholder: "Add some tags...")
                        .styled(.Modern)
                }
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                await choosePhoto()
            }
        }
        .onChange(of: isShowingPicker) { _, _ in
            togglePhotosPicker()
        }
        .photosPicker(isPresented: $isShowingPicker, selection: $photosPickerItem)
        
    }
}

// MARK: EditPixView functionality
extension EditPixView {
    func togglePhotosPicker() {
        if photosPickerItem == nil {
            isPresented = false
        }
    }
    
    func choosePhoto() async {
        if let photosPickerItem,
           let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
            if let image = UIImage(data: data) {
                pix.imageData = data
                selectedImage = image
            }
        }
        photosPickerItem = nil
    }
}

#Preview {
    EditPixView(isPresented: .constant(true))
}
