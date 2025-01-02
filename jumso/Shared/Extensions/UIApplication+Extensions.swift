import UIKit

extension UIApplication {
    func switchToLogin() {
        guard let scene = connectedScenes.first as? UIWindowScene,
              let sceneDelegate = scene.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.switchToLogin()
    }
}
