//import UIKit
//
//struct SignUpAppearance {
//    
//    // ProgressBar 스타일 설정
//    static func styleProgressBar(_ progressBar: UIProgressView) {
//        progressBar.trackTintColor = UIColor.white
//        progressBar.progressTintColor = UIColor.jumso
//        progressBar.layer.borderColor = UIColor.disabledButton.cgColor
//        progressBar.layer.shadowColor = UIColor.gray.cgColor
//        progressBar.layer.shadowOpacity = 0.9
//        progressBar.layer.shadowOffset = CGSize(width: 2, height: 2)
//    }
//    
//    // 이메일 도메인 UI 설정
//    static func configureEmailDomainUI(controller: EmailAuthenticationViewController, emailDomains: [String]?) {
//        
//        
//        guard let emailDomains = emailDomains else {
//            return
//        }
//        
//        // 도메인 하나면 라벨, 두개 이상이면 드롭다운 버튼
//        if emailDomains.count == 1 {
//            controller.EmailDomainLabel.isHidden = false
//            controller.EmailDomainButton.isHidden = true
//            controller.EmailDomainLabel.text = emailDomains.first
//            controller.selectedEmailDomain = emailDomains.first
//        } else {
//            controller.EmailDomainLabel.isHidden = true
//            controller.EmailDomainButton.isHidden = false
//            controller.EmailDomainButton.setTitle(emailDomains.first, for: .normal)
//            
//            let firstDomain = emailDomains.first ?? "Select Domain"
//            setButtonWithTextAndImage(controller: controller, title: firstDomain, image: UIImage(systemName: "chevron.down"))
//            controller.selectedEmailDomain = emailDomains.first
//            
//            var actions: [UIAction] = []
//            for domain in emailDomains {
//                let action = UIAction(title: domain, handler: { [weak controller] _ in
//                    guard let controller = controller else { return }
//                    controller.EmailDomainButton.setTitle(domain, for: .normal)
//                    setButtonWithTextAndImage(controller: controller, title: domain, image: UIImage(systemName: "chevron.down"))
//                    controller.selectedEmailDomain = domain
//                })
//                actions.append(action)
//            }
//            controller.EmailDomainButton.menu = UIMenu(title: "Select Email Domain", options: .displayInline, children: actions)
//            controller.EmailDomainButton.showsMenuAsPrimaryAction = true // 버튼 클릭 시 바로 메뉴가 보이게 설정
//        }
//    }
//    
//    static func setButtonWithTextAndImage(controller: EmailAuthenticationViewController, title: String, image: UIImage?) {
//            var config = UIButton.Configuration.plain()
//            config.title = title
//            if let image = image {
//                let resizedImage = image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .regular))
//                config.image = resizedImage.withRenderingMode(.alwaysTemplate)
//            }
//            config.imagePadding = 20
//            config.baseBackgroundColor = .black
//            config.imagePlacement = .trailing
//            controller.EmailDomainButton.configuration = config
//            controller.EmailDomainButton.tintColor = .black
//        }
//}
