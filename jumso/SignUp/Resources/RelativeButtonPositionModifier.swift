import SwiftUI

// MARK: - 버튼 위치 모디파이어
struct FixedButtonPositionModifier: ViewModifier {
    let yPosition: CGFloat
    let keyboardHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight > 0 ? keyboardHeight + 10 : UIScreen.main.bounds.height - yPosition)
            .animation(.easeOut(duration: 0.3), value: keyboardHeight)
    }
}

// MARK: - Extension for ease of use
extension View {
    func fixedButtonPosition(yPosition: CGFloat, keyboardHeight: CGFloat) -> some View {
        self.modifier(FixedButtonPositionModifier(yPosition: yPosition, keyboardHeight: keyboardHeight))
    }
}
