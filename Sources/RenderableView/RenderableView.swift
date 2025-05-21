// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct Renderable<V: View>: View {

    @Environment(\.displayScale) private var displayScale

    @Binding var updateCounter: Int
    @Binding var renderedData: Data?
    let view: () -> V

    public init(
        updateCounter: Binding<Int>,
        renderedData: Binding<Data?>,
        @ViewBuilder _ view: @escaping () -> V
    ) {
        self._updateCounter = updateCounter
        self._renderedData = renderedData
        self.view = view
    }

    public var body: some View {
        view()
            .onChange(of: updateCounter) {
                renderedData = render()
            }
    }

    @MainActor
    func render() -> Data? {
        let renderer = ImageRenderer(
            content: view()
        )
        renderer.scale = displayScale
        return renderer.uiImage?.pngData()
    }
}
