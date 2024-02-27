//
//  PixView.swift
//  keeppix
//
//  Created by Peter Wright on 25/02/2024.
//

import SwiftUI

struct PixView: View {
    @State private var zoomScale: CGFloat = 1
    @State private var previousZoomScale: CGFloat = 1
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

extension PixView {
    var pixView: some View {
        GeometryReader { proxy in
            ScrollView (
                [.vertical, .horizontal],
                showsIndicators: false){
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture(count: 2, perform: onImageDoubleTapped)
                        .gesture(zoomGesture)
                        .frame(width: proxy.size.width * max(minZoomScale, zoomScale))
                        .frame(maxHeight: .infinity)
                }
        }
    }
}

extension PixView {
    func loadPix() {
        if let imageData = pix.imageData {
            image = Image(uiImage: UIImage(data: imageData)!)
        } else {
            image = Image(systemName: "photo.artframe")
        }
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
