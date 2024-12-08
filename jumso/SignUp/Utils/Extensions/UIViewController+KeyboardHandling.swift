import UIKit

extension UIViewController {
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
