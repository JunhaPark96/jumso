//
//  LoginViewController.swift
//  jumso
//
//  Created by junha on 9/22/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    var email = String()
    var password = String()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
//        print("이메일 텍스트필드 호출")
        let text = sender.text ?? ""
        self.email = text
        print(text)
    }
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.password = text
        print(text)
    }
    // Touch Up Inside: tap
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 네비게이션 컨트롤러가 있는지 확인
            if let navigationController = self.navigationController {
                print("Navigation controller exists")
                let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
                let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
                navigationController.pushViewController(registerViewController, animated: true)
            } else {
                print("Navigation controller is nil")
            }
        // 화면 전환
        // 1. 스토리보드 생성
//        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
//        
//        // 2. 뷰 컨트롤러 생성
//        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
//        
//        // 3. 화면전환 메소드로 화면 전환
////        self.present(registerViewController, animated: true, completion: nil)
//        // container view controller
//        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    
}
