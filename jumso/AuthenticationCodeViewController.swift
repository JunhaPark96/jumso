//
//  AuthenticationCodeViewController.swift
//  jumso
//
//  Created by junha on 9/29/24.
//

import UIKit

class AuthenticationCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func emailAuthorizedDidTap(_ sender: UIButton) {
        
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        // 2. 뷰 컨트롤러 생성
        let signUpPasswordViewController = storyboard.instantiateViewController(withIdentifier: "SignUpPasswordVC") as! SignUpPasswordViewController
        
        // 3. 화면전환 메소드로 화면 전환
//        self.present(registerViewController, animated: true, completion: nil)
        // container view controller
        self.navigationController?.pushViewController(signUpPasswordViewController, animated: true)
    }
    
}
