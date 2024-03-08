//
//  PixView.swift
//  keeppix
//
//  Created by Peter Wright on 25/02/2024.
//

import SwiftUI

// MARK: PixView layout.
struct PixView: View {
    @Environment(\.modelContext) private var context
    @State private var zoomScale: CGFloat = 1.5
    @State private var previousZoomScale: CGFloat = 1.5
    @State private var image: Image?
    
    private let minZoomScale: CGFloat = 1
    private let maxZoomScale: CGFloat = 5
    let pix: Pix
    
    
    init(pix: Pix) {
        self.pix = pix
    }
    
    var body: some View {
        ZStack {
            if let _ = image {
                pixView
            } else {
                ProgressView()
            }
        }
        .task {
            loadPix()
        }
        .onDisappear {
            image = nil
        }
    }
}

// MARK: Zoomable image view.
extension PixView {
    var pixView: some View {
        ZStack(alignment: .top){
            GeometryReader { proxy in
                ScrollView (
                    [.vertical, .horizontal],
                    showsIndicators: false){
                        image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: proxy.size.width * max(minZoomScale, zoomScale))
                            .frame(maxHeight: .infinity)
                            .onTapGesture(count: 2, perform: onImageDoubleTapped)
                            .gesture(zoomGesture)
                    }
            }
            pixOverlay
        }
    }
}

// MARK: Pix info overlay
extension PixView {
    var pixOverlay: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                Text(pix.pixDescription)
                    .font(.headline)
                    .foregroundColor(.white)
                    .truncationMode(.tail)
                    .lineLimit(1)
                Spacer()
            }
            HStack(alignment: .center, spacing: 0) {
                Text("Viewed \(pix.viewCount) times since \(pix.createdAt.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: .bottom)
        )
        .opacity(0.9)
        .cornerRadius(5)
    }
}


// MARK: Functionality for the PixView
extension PixView {
    func loadPix() {
        if let imageData = pix.imageData {
            image = Image(uiImage: UIImage(data: imageData)!)
        } else {
            image = Image(systemName: "photo.artframe")
        }
        pix.updateViewStats()
        try? context.save()
    }
    
    func onImageDoubleTapped() {
        if zoomScale == 1 {
            withAnimation(.spring()) {
                zoomScale = 5
            }
        } else {
            resetImageState()
        }
    }
    
    func resetImageState() {
        withAnimation(.interactiveSpring()) {
            zoomScale = 1
        }
    }
    
    func onZoomGestureStarted( value: MagnificationGesture.Value) {
        withAnimation(.easeIn(duration: 0.1)) {
            let delta = value / previousZoomScale
            previousZoomScale = value
            let zoomDelta = zoomScale * delta
            var minMaxScale = max(minZoomScale, zoomDelta)
            minMaxScale = min(maxZoomScale, minMaxScale)
            zoomScale = minMaxScale
        }
    }
    
    func onZoomGestureEnded(value: MagnificationGesture.Value) {
        previousZoomScale = 1
        if zoomScale <= 1 {
            resetImageState()
        } else if zoomScale > 5  {
            zoomScale = 5
        }
    }
    
    var zoomGesture: some Gesture {
        MagnificationGesture()
            .onChanged(onZoomGestureStarted)
            .onEnded(onZoomGestureEnded)
    }
    
}



#Preview {
    PixView(pix: Pix(pixDescription: "Test Pix", tags: ["test"]))
}
