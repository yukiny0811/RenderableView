//
//  ContentView.swift
//  Demo
//
//  Created by Yuki Kuwashima on 2025/02/14.
//

import SwiftUI
import RenderableView

struct ContentView: View {

    @Environment(\.displayScale) private var displayScale

    @State var imageData: Data?
    @State var updateCounter = 0

    var body: some View {
        Button("update") {
            updateCounter += 1
        }
        Renderable(updateCounter: $updateCounter, renderedData: $imageData) {
            Image("apple")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorEffect(
                    Shader(
                        function: ShaderFunction(
                            library: .bundle(.main),
                            name: "sample"
                        ),
                        arguments: []
                    )
                )
        }
        if let imageData {
            Image(uiImage: UIImage(data: imageData)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    ContentView()
}
