// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct Renderable<V: View, E: Equatable>: View {

    @Environment(\.displayScale) private var displayScale

    @Binding var trigger: E
    @Binding var renderedData: Data?
    let view: () -> V

    public init(
        updateCounter: Binding<E>,
        renderedData: Binding<Data?>,
        @ViewBuilder _ view: @escaping () -> V
    ) {
        self._trigger = updateCounter
        self._renderedData = renderedData
        self.view = view
    }

    public init(
        trigger: Binding<E>,
        renderedData: Binding<Data?>,
        @ViewBuilder _ view: @escaping () -> V
    ) {
        self._trigger = trigger
        self._renderedData = renderedData
        self.view = view
    }

    public var body: some View {
        view()
            .onChange(of: trigger) {
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
