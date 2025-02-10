import SwiftUI

struct DeviceSizeConstants {
    struct iPhone {
        static let se1 = CGSize(width: 320, height: 568)    // iPhone SE (1st Gen)
        static let iPhone6 = CGSize(width: 375, height: 667)
        static let iPhone6Plus = CGSize(width: 414, height: 736)
        static let iPhone6s = CGSize(width: 375, height: 667)
        static let iPhone6sPlus = CGSize(width: 414, height: 736)
        static let iPhone7 = CGSize(width: 375, height: 667)
        static let iPhone7Plus = CGSize(width: 414, height: 736)
        static let iPhone8 = CGSize(width: 375, height: 667)
        static let iPhone8Plus = CGSize(width: 414, height: 736)
        static let iPhoneX = CGSize(width: 375, height: 812)
        static let iPhoneXR = CGSize(width: 414, height: 896)
        static let iPhoneXS = CGSize(width: 375, height: 812)
        static let iPhoneXSMax = CGSize(width: 414, height: 896)
        static let iPhoneSE2 = CGSize(width: 375, height: 667)  // iPhone SE (2nd Gen)
        static let iPhone11 = CGSize(width: 414, height: 896)
        static let iPhone11Pro = CGSize(width: 375, height: 812)
        static let iPhone11ProMax = CGSize(width: 414, height: 896)
        static let iPhone12 = CGSize(width: 390, height: 844)
        static let iPhone12Mini = CGSize(width: 360, height: 780)
        static let iPhone12Pro = CGSize(width: 390, height: 844)
        static let iPhone12ProMax = CGSize(width: 428, height: 926)
        static let iPhoneSE3 = CGSize(width: 375, height: 667)  // iPhone SE (3rd Gen)
        static let iPhone13 = CGSize(width: 390, height: 844)
        static let iPhone13Mini = CGSize(width: 375, height: 812)
        static let iPhone13Pro = CGSize(width: 390, height: 844)
        static let iPhone13ProMax = CGSize(width: 428, height: 926)
        static let iPhone14 = CGSize(width: 390, height: 844)
        static let iPhone14Plus = CGSize(width: 428, height: 926)
        static let iPhone14Pro = CGSize(width: 393, height: 852)
        static let iPhone14ProMax = CGSize(width: 430, height: 932)
        static let iPhone15 = CGSize(width: 393, height: 852)
        static let iPhone15Plus = CGSize(width: 430, height: 932)
        static let iPhone15Pro = CGSize(width: 393, height: 852)
        static let iPhone15ProMax = CGSize(width: 430, height: 932)
        static let iPhone16 = CGSize(width: 393, height: 852)
        static let iPhone16Plus = CGSize(width: 430, height: 932)
        static let iPhone16Pro = CGSize(width: 405, height: 883)
        static let iPhone16ProMax = CGSize(width: 448, height: 976)
    }
    
    static func getScreenSize() -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    static func getClosestModel() -> String {
        let currentSize = getScreenSize()
        let devices: [String: CGSize] = [
            "iPhone SE (1st Gen)": iPhone.se1,
            "iPhone 6": iPhone.iPhone6,
            "iPhone 6 Plus": iPhone.iPhone6Plus,
            "iPhone 6s": iPhone.iPhone6s,
            "iPhone 6s Plus": iPhone.iPhone6sPlus,
            "iPhone 7": iPhone.iPhone7,
            "iPhone 7 Plus": iPhone.iPhone7Plus,
            "iPhone 8": iPhone.iPhone8,
            "iPhone 8 Plus": iPhone.iPhone8Plus,
            "iPhone X": iPhone.iPhoneX,
            "iPhone XR": iPhone.iPhoneXR,
            "iPhone XS": iPhone.iPhoneXS,
            "iPhone XS Max": iPhone.iPhoneXSMax,
            "iPhone SE (2nd Gen)": iPhone.iPhoneSE2,
            "iPhone 11": iPhone.iPhone11,
            "iPhone 11 Pro": iPhone.iPhone11Pro,
            "iPhone 11 Pro Max": iPhone.iPhone11ProMax,
            "iPhone 12": iPhone.iPhone12,
            "iPhone 12 Mini": iPhone.iPhone12Mini,
            "iPhone 12 Pro": iPhone.iPhone12Pro,
            "iPhone 12 Pro Max": iPhone.iPhone12ProMax,
            "iPhone SE (3rd Gen)": iPhone.iPhoneSE3,
            "iPhone 13": iPhone.iPhone13,
            "iPhone 13 Mini": iPhone.iPhone13Mini,
            "iPhone 13 Pro": iPhone.iPhone13Pro,
            "iPhone 13 Pro Max": iPhone.iPhone13ProMax,
            "iPhone 14": iPhone.iPhone14,
            "iPhone 14 Plus": iPhone.iPhone14Plus,
            "iPhone 14 Pro": iPhone.iPhone14Pro,
            "iPhone 14 Pro Max": iPhone.iPhone14ProMax,
            "iPhone 15": iPhone.iPhone15,
            "iPhone 15 Plus": iPhone.iPhone15Plus,
            "iPhone 15 Pro": iPhone.iPhone15Pro,
            "iPhone 15 Pro Max": iPhone.iPhone15ProMax,
            "iPhone 16": iPhone.iPhone16,
            "iPhone 16 Plus": iPhone.iPhone16Plus,
            "iPhone 16 Pro": iPhone.iPhone16Pro,
            "iPhone 16 Pro Max": iPhone.iPhone16ProMax
        ]
        
        return devices.min(by: { abs($0.value.width - currentSize.width) < abs($1.value.width - currentSize.width) })?.key ?? "Unknown"
    }
}
