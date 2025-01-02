import SwiftUI

// MARK: - 버튼 위치 모디파이어
struct RelativeButtonPositionModifier: ViewModifier {
    let relativeHeight: CGFloat // 화면 높이에 대한 비율 (0.0 ~ 1.0)
    let keyboardHeight: CGFloat
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let calculatedPosition = screenHeight * relativeHeight
            let safeBottomPadding = keyboardHeight > 0 ? keyboardHeight + 10 : 0
            
            content
                .padding(.bottom, max(safeBottomPadding, screenHeight - calculatedPosition))
                .animation(.easeOut(duration: 0.3), value: keyboardHeight)
        }
    }
}

extension View {
    func relativeButtonPosition(relativeHeight: CGFloat, keyboardHeight: CGFloat) -> some View {
        self.modifier(RelativeButtonPositionModifier(relativeHeight: relativeHeight, keyboardHeight: keyboardHeight))
    }
}
