//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Jeremy Tygh on 7/20/21.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            PaletteChooser(emojiFontSize: defaultEmojiFontSize)
        }
    }
    
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.overlay(
                    OptionalImage(uiImage: document.backgroundImage)
                        .scaleEffect(zoomScale)
                        .position(convertFromEmojiCoordinates((0,0), in: geometry))
                )
                .gesture(doubleTapToZoom(in: geometry.size))
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) {
                        selectedEmojis.removeAll()
                    }
                }
                
                if document.backgroundImageFetchStatus == .fetching {
                    ProgressView().scaleEffect(2)
                } else {
                    ForEach(document.emojis) { emoji in
                        Text(emoji.text)
//                            .font(.system(size: fontSize(for: emoji)))
//                            .scaleEffect(zoomScale)
                            .font(animatableWithSize: fontSize(for: emoji) * zoomScale(for: emoji))
                            .gesture(dragEmojiGesture(for: emoji))//.simultaneously(with: tapForSelection(emoji: emoji)))
                            .border(selectedEmojis.contains(matching: emoji) ? Color.black : Color.clear)
                            .position(position(for: emoji, in: geometry))
                            .onTapGesture {
                                selectedEmojis.toggleMembership(of: emoji)
                            }
                    }
                }
            }
            .clipped()
            .onDrop(of: [.plainText, .url, .image], isTargeted: nil) { providers, location in
                drop(providers: providers, at: location, in: geometry)
            }
            .gesture(panGesture().simultaneously(with: zoomGesture()) )
            .alert(item: $alertToShow) { alertToShow in
                // return Alert
                alertToShow.alert()
            }
            .onChange(of: document.backgroundImageFetchStatus){ status in
                switch status {
                case .failed(let url):
                    showBackgroundImageFetchFailedAlert(url)
                default:
                    break
                }
            }
            
            //recommended to not put more than one .gesture on any one view
        }
    }
        
    //MARK: - Deletion
    
    private func removeEmoji() {
        for emoji in selectedEmojis {
            if document.emojis.contains(matching: emoji) {
                document.removeEmoji(emoji)
                selectedEmojis.remove(emoji)
            }
        }
    }
    
    @State private var alertToShow: IdentifiableAlert?
    
    private func showBackgroundImageFetchFailedAlert(_ url: URL) {
        alertToShow = IdentifiableAlert(id: "fetch failed: " + url.absoluteString, alert: {
            Alert(
                title: Text("Background Image Fetch"),
                message: Text("Couldn't load image from \(url)."),
                dismissButton: .default(Text("OK"))
            )
        })
    }
    
    // MARK: - Drag and Drop
    
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        var found = providers.loadObjects(ofType: URL.self) { url in
            document.setBackground(.url(url.imageURL))
        }
        
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                if let data = image.jpegData(compressionQuality: 1.0) {
                    document.setBackground(.imageData(data))
                }
            }
        }
        
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                if let emoji = string.first, emoji.isEmoji {
                    document.addEmoji(
                        String(emoji),
                        at: convertToEmojiCoordinates(location, in: geometry),
                        size: defaultEmojiFontSize / zoomScale
                    )
                }
            }
        }
        return found
    }
    
    // MARK: - Position/Sizing Emoji
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
    }
    
    private func convertToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        
        let location = CGPoint (
            x: (location.x - panOffset.width -  center.x) / zoomScale,
            y: (location.y - panOffset.height - center.y) / zoomScale
        )
        return (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x) * zoomScale + panOffset.width,
            y: center.y + CGFloat(location.y) * zoomScale + panOffset.height
        )
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }
    
    // MARK: - Emoji Selection
    
    @State private var selectedEmojis = Set<EmojiArtModel.Emoji>()
    
//    private func tapForSelection(emoji: EmojiArtModel.Emoji) -> some Gesture {
//        TapGesture(count: 1)
//            .onEnded {
//                self.selectedEmojis.toggleMembership(of: emoji)
//            }
//    }
    
    
    // MARK: - Emoji Dragging
    
    //@State private var steadyEmojiDragOffset: CGSize = CGSize.zero
    @GestureState private var gestureDragOffset: CGSize = CGSize.zero
    
//    private var dragOffset: CGSize {
//        (steadyEmojiDragOffset + gestureDragOffset) * zoomScale
//    }
    
    private func dragEmojiGesture(for emoji: EmojiArtModel.Emoji) -> some Gesture {
        
        let isSelected = selectedEmojis.contains(matching: emoji)
        
        return DragGesture()
            .updating($gestureDragOffset) { latestDragGestureValue, gestureDragOffset, _ in
                gestureDragOffset = latestDragGestureValue.translation / zoomScale

//                for emoji in selectedEmojis {
//                        document.moveEmoji(emoji, by: gestureDragOffset)
//                }
                if isSelected {
                    for emoji in selectedEmojis {
                        //withAnimation {
                            document.moveEmoji(emoji, by: gestureDragOffset)
                        //}
                    }
                } else {
                    document.moveEmoji(emoji, by: gestureDragOffset)
                }
    
            }
            .onEnded { finalDragGestureValue in
                let draggedOffset = finalDragGestureValue.translation / zoomScale

                if isSelected {
                    for emoji in selectedEmojis {
                        //withAnimation {
                            document.moveEmoji(emoji, by: draggedOffset)
                        //}
                    }
                } else {
                    document.moveEmoji(emoji, by: draggedOffset)
                }
            }
    }
    
    // MARK: - Panning
    
    @State private var steadyStatePanOffset: CGSize = CGSize.zero
    @GestureState private var gesturePanOffset: CGSize = CGSize.zero
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                gesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                steadyStatePanOffset = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
            }
    }
    
    // MARK: - Zooming
    
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * (selectedEmojis.isEmpty ? gestureZoomScale : 1) //Adjusts zoom scale based on selection of emojis.
    }
    
    private func zoomScale(for emoji: EmojiArtModel.Emoji) -> CGFloat{
        if selectedEmojis.contains(matching: emoji) {
            return steadyStateZoomScale * gestureZoomScale
        } else {
            return zoomScale
        }
    }
    
    private func zoomGesture() -> some  Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { gestureScaleAtEnd in
                if selectedEmojis.isEmpty {
                    steadyStateZoomScale *= gestureScaleAtEnd
                } else {
                    for emoji in selectedEmojis {
                        document.scaleEmoji(emoji, by: gestureScaleAtEnd)
                    }
                }
            }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0, size.width > 0, size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStatePanOffset = .zero
            steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}
