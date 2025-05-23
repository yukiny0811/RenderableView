
# RenderableView

## Usage

```swift
import SwiftUI
import RenderableView

struct ContentView: View {

    @State var imageData: Data?
    @State var updateCounter = 0

    var body: some View {
        Button("update") {
            updateCounter += 1
        }
        Renderable(trigger: $updateCounter) {
            Image("apple")
                .resizable()
                .aspectRatio(contentMode: .fit)
        } onTrigger: { data in
            self.imageData = data
        }
        if let imageData {
            Image(uiImage: UIImage(data: imageData)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
```
