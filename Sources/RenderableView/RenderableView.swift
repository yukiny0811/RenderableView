// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct Renderable<V: View, E: Equatable>: View {

    @Environment(\.displayScale) private var displayScale

    @Binding var trigger: E
    let view: () -> V
    let onTrigger: (Data?) -> Void

    public init(
        trigger: Binding<E>,
        @ViewBuilder _ view: @escaping () -> V,
        onTrigger: @escaping (Data?) -> Void
    ) {
        self._trigger = trigger
        self.view = view
        self.onTrigger = onTrigger
    }

    public var body: some View {
        view()
            .onChange(of: trigger) {
                Task {
                    await onTrigger(render())
                }
            }
    }

    @MainActor
    func render() async -> Data? {
        let renderer = ImageRenderer(
            content: view()
        )
        renderer.scale = displayScale
        return renderer.uiImage?.pngData()
    }
}
