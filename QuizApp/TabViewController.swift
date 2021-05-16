import UIKit

class TabViewController: UITabBarController {
    private var router : AppRouterProtocol!
    private var networkService : NetworkServiceProtocol!
    
    convenience init(router : AppRouterProtocol, networkService : NetworkServiceProtocol) {
        self.init()
        self.router = router
        self.networkService = networkService
        setUpViews()
    }
    
     func setUpViews() {
        super.viewDidLoad()

        let quizzesVC = QuizzesViewController(router: router, networkService: networkService)
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
