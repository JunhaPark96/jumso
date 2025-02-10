import SwiftUI

class DeviceSizeManager: ObservableObject {
    static let shared = DeviceSizeManager()

    @Published var screenWidth: CGFloat = UIScreen.main.bounds.width
    @Published var screenHeight: CGFloat = UIScreen.main.bounds.height
    @Published var deviceModel: String = DeviceSizeConstants.getClosestModel() // 현재 기기 모델 감지
    
    private let baseWidth: CGFloat = DeviceSizeConstants.iPhone.iPhone14.width
    private let baseHeight: CGFloat = DeviceSizeConstants.iPhone.iPhone14.height
    
    func widthScale() -> CGFloat {
        return screenWidth / baseWidth
    }

    func heightScale() -> CGFloat {
        return screenHeight / baseHeight
    }

    func scaledFont(size: CGFloat) -> CGFloat {
        return size * widthScale()
    }

    func scaledPadding(_ value: CGFloat) -> CGFloat {
        return value * widthScale()
    }

    func scaledHeight(_ value: CGFloat) -> CGFloat {
        return value * heightScale()
    }
}
