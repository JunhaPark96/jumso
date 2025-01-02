import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

    /// The "JumsoColor" asset catalog color resource.
    static let jumso = ColorResource(name: "JumsoColor", bundle: resourceBundle)

    /// The "disabledButtonColor" asset catalog color resource.
    static let disabledButton = ColorResource(name: "disabledButtonColor", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "ic_bookmark_black" asset catalog image resource.
    static let icBookmarkBlack = ImageResource(name: "ic_bookmark_black", bundle: resourceBundle)

    /// The "ic_bookmark_white" asset catalog image resource.
    static let icBookmarkWhite = ImageResource(name: "ic_bookmark_white", bundle: resourceBundle)

    /// The "ic_catstagram_logo" asset catalog image resource.
    static let icCatstagramLogo = ImageResource(name: "ic_catstagram_logo", bundle: resourceBundle)

    /// The "ic_homd_search_light" asset catalog image resource.
    static let icHomdSearchLight = ImageResource(name: "ic_homd_search_light", bundle: resourceBundle)

    /// The "ic_home_comment" asset catalog image resource.
    static let icHomeComment = ImageResource(name: "ic_home_comment", bundle: resourceBundle)

    /// The "ic_home_heart" asset catalog image resource.
    static let icHomeHeart = ImageResource(name: "ic_home_heart", bundle: resourceBundle)

    /// The "ic_home_heart_full" asset catalog image resource.
    static let icHomeHeartFull = ImageResource(name: "ic_home_heart_full", bundle: resourceBundle)

    /// The "ic_home_home_black" asset catalog image resource.
    static let icHomeHomeBlack = ImageResource(name: "ic_home_home_black", bundle: resourceBundle)

    /// The "ic_home_home_white" asset catalog image resource.
    static let icHomeHomeWhite = ImageResource(name: "ic_home_home_white", bundle: resourceBundle)

    /// The "ic_home_more" asset catalog image resource.
    static let icHomeMore = ImageResource(name: "ic_home_more", bundle: resourceBundle)

    /// The "ic_home_reels" asset catalog image resource.
    static let icHomeReels = ImageResource(name: "ic_home_reels", bundle: resourceBundle)

    /// The "ic_home_search_bold" asset catalog image resource.
    static let icHomeSearchBold = ImageResource(name: "ic_home_search_bold", bundle: resourceBundle)

    /// The "ic_home_send" asset catalog image resource.
    static let icHomeSend = ImageResource(name: "ic_home_send", bundle: resourceBundle)

    /// The "ic_home_shop_black" asset catalog image resource.
    static let icHomeShopBlack = ImageResource(name: "ic_home_shop_black", bundle: resourceBundle)

    /// The "ic_home_shop_white" asset catalog image resource.
    static let icHomeShopWhite = ImageResource(name: "ic_home_shop_white", bundle: resourceBundle)

    /// The "ic_home_upload" asset catalog image resource.
    static let icHomeUpload = ImageResource(name: "ic_home_upload", bundle: resourceBundle)

    /// The "ic_login_facebook" asset catalog image resource.
    static let icLoginFacebook = ImageResource(name: "ic_login_facebook", bundle: resourceBundle)

    /// The "ic_login_hidden" asset catalog image resource.
    static let icLoginHidden = ImageResource(name: "ic_login_hidden", bundle: resourceBundle)

    /// The "ic_login_show" asset catalog image resource.
    static let icLoginShow = ImageResource(name: "ic_login_show", bundle: resourceBundle)

    /// The "ic_my_hamburger" asset catalog image resource.
    static let icMyHamburger = ImageResource(name: "ic_my_hamburger", bundle: resourceBundle)

    /// The "ic_my_invite" asset catalog image resource.
    static let icMyInvite = ImageResource(name: "ic_my_invite", bundle: resourceBundle)

    /// The "ic_my_upload" asset catalog image resource.
    static let icMyUpload = ImageResource(name: "ic_my_upload", bundle: resourceBundle)

    /// The "ic_reels_comment" asset catalog image resource.
    static let icReelsComment = ImageResource(name: "ic_reels_comment", bundle: resourceBundle)

    /// The "ic_reels_heart" asset catalog image resource.
    static let icReelsHeart = ImageResource(name: "ic_reels_heart", bundle: resourceBundle)

    /// The "ic_reels_heart_full" asset catalog image resource.
    static let icReelsHeartFull = ImageResource(name: "ic_reels_heart_full", bundle: resourceBundle)

    /// The "ic_reels_more" asset catalog image resource.
    static let icReelsMore = ImageResource(name: "ic_reels_more", bundle: resourceBundle)

    /// The "ic_reels_send" asset catalog image resource.
    static let icReelsSend = ImageResource(name: "ic_reels_send", bundle: resourceBundle)

    /// The "jumso" asset catalog image resource.
    static let jumso = ImageResource(name: "jumso", bundle: resourceBundle)

    /// The "jumso2" asset catalog image resource.
    static let jumso2 = ImageResource(name: "jumso2", bundle: resourceBundle)

    /// The "jumso3" asset catalog image resource.
    static let jumso3 = ImageResource(name: "jumso3", bundle: resourceBundle)

    /// The "jumso4" asset catalog image resource.
    static let jumso4 = ImageResource(name: "jumso4", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "JumsoColor" asset catalog color.
    static var jumso: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .jumso)
#else
        .init()
#endif
    }

    /// The "disabledButtonColor" asset catalog color.
    static var disabledButton: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .disabledButton)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "JumsoColor" asset catalog color.
    static var jumso: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .jumso)
#else
        .init()
#endif
    }

    /// The "disabledButtonColor" asset catalog color.
    static var disabledButton: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .disabledButton)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// The "JumsoColor" asset catalog color.
    static var jumso: SwiftUI.Color { .init(.jumso) }

    /// The "disabledButtonColor" asset catalog color.
    static var disabledButton: SwiftUI.Color { .init(.disabledButton) }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "JumsoColor" asset catalog color.
    static var jumso: SwiftUI.Color { .init(.jumso) }

    /// The "disabledButtonColor" asset catalog color.
    static var disabledButton: SwiftUI.Color { .init(.disabledButton) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "ic_bookmark_black" asset catalog image.
    static var icBookmarkBlack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBookmarkBlack)
#else
        .init()
#endif
    }

    /// The "ic_bookmark_white" asset catalog image.
    static var icBookmarkWhite: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icBookmarkWhite)
#else
        .init()
#endif
    }

    /// The "ic_catstagram_logo" asset catalog image.
    static var icCatstagramLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icCatstagramLogo)
#else
        .init()
#endif
    }

    /// The "ic_homd_search_light" asset catalog image.
    static var icHomdSearchLight: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomdSearchLight)
#else
        .init()
#endif
    }

    /// The "ic_home_comment" asset catalog image.
    static var icHomeComment: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeComment)
#else
        .init()
#endif
    }

    /// The "ic_home_heart" asset catalog image.
    static var icHomeHeart: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeHeart)
#else
        .init()
#endif
    }

    /// The "ic_home_heart_full" asset catalog image.
    static var icHomeHeartFull: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeHeartFull)
#else
        .init()
#endif
    }

    /// The "ic_home_home_black" asset catalog image.
    static var icHomeHomeBlack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeHomeBlack)
#else
        .init()
#endif
    }

    /// The "ic_home_home_white" asset catalog image.
    static var icHomeHomeWhite: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeHomeWhite)
#else
        .init()
#endif
    }

    /// The "ic_home_more" asset catalog image.
    static var icHomeMore: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeMore)
#else
        .init()
#endif
    }

    /// The "ic_home_reels" asset catalog image.
    static var icHomeReels: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeReels)
#else
        .init()
#endif
    }

    /// The "ic_home_search_bold" asset catalog image.
    static var icHomeSearchBold: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeSearchBold)
#else
        .init()
#endif
    }

    /// The "ic_home_send" asset catalog image.
    static var icHomeSend: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeSend)
#else
        .init()
#endif
    }

    /// The "ic_home_shop_black" asset catalog image.
    static var icHomeShopBlack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeShopBlack)
#else
        .init()
#endif
    }

    /// The "ic_home_shop_white" asset catalog image.
    static var icHomeShopWhite: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeShopWhite)
#else
        .init()
#endif
    }

    /// The "ic_home_upload" asset catalog image.
    static var icHomeUpload: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icHomeUpload)
#else
        .init()
#endif
    }

    /// The "ic_login_facebook" asset catalog image.
    static var icLoginFacebook: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icLoginFacebook)
#else
        .init()
#endif
    }

    /// The "ic_login_hidden" asset catalog image.
    static var icLoginHidden: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icLoginHidden)
#else
        .init()
#endif
    }

    /// The "ic_login_show" asset catalog image.
    static var icLoginShow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icLoginShow)
#else
        .init()
#endif
    }

    /// The "ic_my_hamburger" asset catalog image.
    static var icMyHamburger: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icMyHamburger)
#else
        .init()
#endif
    }

    /// The "ic_my_invite" asset catalog image.
    static var icMyInvite: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icMyInvite)
#else
        .init()
#endif
    }

    /// The "ic_my_upload" asset catalog image.
    static var icMyUpload: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icMyUpload)
#else
        .init()
#endif
    }

    /// The "ic_reels_comment" asset catalog image.
    static var icReelsComment: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icReelsComment)
#else
        .init()
#endif
    }

    /// The "ic_reels_heart" asset catalog image.
    static var icReelsHeart: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icReelsHeart)
#else
        .init()
#endif
    }

    /// The "ic_reels_heart_full" asset catalog image.
    static var icReelsHeartFull: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icReelsHeartFull)
#else
        .init()
#endif
    }

    /// The "ic_reels_more" asset catalog image.
    static var icReelsMore: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icReelsMore)
#else
        .init()
#endif
    }

    /// The "ic_reels_send" asset catalog image.
    static var icReelsSend: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icReelsSend)
#else
        .init()
#endif
    }

    /// The "jumso" asset catalog image.
    static var jumso: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .jumso)
#else
        .init()
#endif
    }

    /// The "jumso2" asset catalog image.
    static var jumso2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .jumso2)
#else
        .init()
#endif
    }

    /// The "jumso3" asset catalog image.
    static var jumso3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .jumso3)
#else
        .init()
#endif
    }

    /// The "jumso4" asset catalog image.
    static var jumso4: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .jumso4)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "ic_bookmark_black" asset catalog image.
    static var icBookmarkBlack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBookmarkBlack)
#else
        .init()
#endif
    }

    /// The "ic_bookmark_white" asset catalog image.
    static var icBookmarkWhite: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icBookmarkWhite)
#else
        .init()
#endif
    }

    /// The "ic_catstagram_logo" asset catalog image.
    static var icCatstagramLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icCatstagramLogo)
#else
        .init()
#endif
    }

    /// The "ic_homd_search_light" asset catalog image.
    static var icHomdSearchLight: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomdSearchLight)
#else
        .init()
#endif
    }

    /// The "ic_home_comment" asset catalog image.
    static var icHomeComment: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeComment)
#else
        .init()
#endif
    }

    /// The "ic_home_heart" asset catalog image.
    static var icHomeHeart: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeHeart)
#else
        .init()
#endif
    }

    /// The "ic_home_heart_full" asset catalog image.
    static var icHomeHeartFull: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeHeartFull)
#else
        .init()
#endif
    }

    /// The "ic_home_home_black" asset catalog image.
    static var icHomeHomeBlack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeHomeBlack)
#else
        .init()
#endif
    }

    /// The "ic_home_home_white" asset catalog image.
    static var icHomeHomeWhite: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeHomeWhite)
#else
        .init()
#endif
    }

    /// The "ic_home_more" asset catalog image.
    static var icHomeMore: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeMore)
#else
        .init()
#endif
    }

    /// The "ic_home_reels" asset catalog image.
    static var icHomeReels: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeReels)
#else
        .init()
#endif
    }

    /// The "ic_home_search_bold" asset catalog image.
    static var icHomeSearchBold: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeSearchBold)
#else
        .init()
#endif
    }

    /// The "ic_home_send" asset catalog image.
    static var icHomeSend: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeSend)
#else
        .init()
#endif
    }

    /// The "ic_home_shop_black" asset catalog image.
    static var icHomeShopBlack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeShopBlack)
#else
        .init()
#endif
    }

    /// The "ic_home_shop_white" asset catalog image.
    static var icHomeShopWhite: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeShopWhite)
#else
        .init()
#endif
    }

    /// The "ic_home_upload" asset catalog image.
    static var icHomeUpload: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icHomeUpload)
#else
        .init()
#endif
    }

    /// The "ic_login_facebook" asset catalog image.
    static var icLoginFacebook: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icLoginFacebook)
#else
        .init()
#endif
    }

    /// The "ic_login_hidden" asset catalog image.
    static var icLoginHidden: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icLoginHidden)
#else
        .init()
#endif
    }

    /// The "ic_login_show" asset catalog image.
    static var icLoginShow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icLoginShow)
#else
        .init()
#endif
    }

    /// The "ic_my_hamburger" asset catalog image.
    static var icMyHamburger: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icMyHamburger)
#else
        .init()
#endif
    }

    /// The "ic_my_invite" asset catalog image.
    static var icMyInvite: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icMyInvite)
#else
        .init()
#endif
    }

    /// The "ic_my_upload" asset catalog image.
    static var icMyUpload: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icMyUpload)
#else
        .init()
#endif
    }

    /// The "ic_reels_comment" asset catalog image.
    static var icReelsComment: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icReelsComment)
#else
        .init()
#endif
    }

    /// The "ic_reels_heart" asset catalog image.
    static var icReelsHeart: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icReelsHeart)
#else
        .init()
#endif
    }

    /// The "ic_reels_heart_full" asset catalog image.
    static var icReelsHeartFull: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icReelsHeartFull)
#else
        .init()
#endif
    }

    /// The "ic_reels_more" asset catalog image.
    static var icReelsMore: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icReelsMore)
#else
        .init()
#endif
    }

    /// The "ic_reels_send" asset catalog image.
    static var icReelsSend: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icReelsSend)
#else
        .init()
#endif
    }

    /// The "jumso" asset catalog image.
    static var jumso: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .jumso)
#else
        .init()
#endif
    }

    /// The "jumso2" asset catalog image.
    static var jumso2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .jumso2)
#else
        .init()
#endif
    }

    /// The "jumso3" asset catalog image.
    static var jumso3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .jumso3)
#else
        .init()
#endif
    }

    /// The "jumso4" asset catalog image.
    static var jumso4: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .jumso4)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Hashable {

    /// An asset catalog color resource name.
    fileprivate let name: String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Hashable {

    /// An asset catalog image resource name.
    fileprivate let name: String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif