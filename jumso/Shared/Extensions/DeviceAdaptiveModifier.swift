import SwiftUI

struct AdaptiveModifier: ViewModifier {
    @EnvironmentObject var deviceSizeManager: DeviceSizeManager

    func body(content: Content) -> some View {
        content
            .padding(deviceSizeManager.scaledPadding(16))
            .font(.system(size: deviceSizeManager.scaledFont(size: 18)))
    }
}

extension View {
    func adaptiveStyle() -> some View {
        self.modifier(AdaptiveModifier())
    }
}
