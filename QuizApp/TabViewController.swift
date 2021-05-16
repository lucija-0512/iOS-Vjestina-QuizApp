import UIKit

class TabViewController: UITabBarController {
    private var router : AppRouterProtocol!
    private var quizzesUseCase : QuizzesUseCaseProtocol!
    
    convenience init(router : AppRouterProtocol, quizzesUseCase : QuizzesUseCaseProtocol) {
        self.init()
        self.router = router
        self.quizzesUseCase = quizzesUseCase
        setUpViews()
    }
    
     func setUpViews() {
        super.viewDidLoad()

        let quizzesVC = QuizzesViewController(router: router, quizzesUseCase: quizzesUseCase)
        quizzesVC.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "Dashboard.png"), selectedImage: UIImage(named: "Quizzes.png"))
        
        let settingsVC = SettingsViewController(router: router)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "Settings.png"), selectedImage: UIImage(named: "Settings.png"))
        
        self.viewControllers = [quizzesVC, settingsVC]
        
        let titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        navigationItem.titleView = titleLabel
    }
    
}
