import Foundation
import UIKit

protocol AppRouterProtocol {
    func setStartScreen(in window : UIWindow?)
    func setTabViewController()
    func goToLoginViewController()
    func goToRoot()
    func goToQuizViewController(quiz : Quiz)
    func goToQuizResultViewController(result : QuizResult)
    func presentLeaderboardViewController(board : [LeaderboardResult])
}

class AppRouter : AppRouterProtocol {
   
    private let navigationController : UINavigationController!
    private var networkService : NetworkServiceProtocol = NetworkService()
    private var pageUseCase: PageUseCaseProtocol
    private var quizResultUseCase: QuizResultUseCaseProtocol
    private var loginUseCase : LoginUseCaseProtocol
    private var quizzesUseCase : QuizzesUseCaseProtocol
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        pageUseCase = PageUseCase(networkService: networkService)
        quizResultUseCase = QuizResultUseCase(networkService: networkService)
        loginUseCase = LoginUseCase(networkService: networkService)
        quizzesUseCase = QuizzesUseCase(networkService: networkService)
    }
    
    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router: self, loginUseCase: loginUseCase)
        navigationController.pushViewController(vc, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setTabViewController() {
        let vc = TabViewController(router: self, quizzesUseCase: quizzesUseCase)
        let customViewControllersArray : [UIViewController] = [vc]
        self.navigationController?.setViewControllers(customViewControllersArray, animated: true)
    }
    
    func goToLoginViewController() {
        let vc = LoginViewController(router: self, loginUseCase: loginUseCase)
        let customViewControllersArray : [UIViewController] = [vc]
        self.navigationController?.setViewControllers(customViewControllersArray, animated: true)
    }
    
    func goToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
  
    func goToQuizViewController(quiz : Quiz) {
        let pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.quiz = quiz
        pageViewController.router = self
        pageViewController.pageUseCase = pageUseCase
        navigationController?.pushViewController(pageViewController, animated: true)
    }
    
    func goToQuizResultViewController(result : QuizResult) {
        let targetController = QuizResultViewController(correct: result.correct, total : result.total, router: self, quizId: result.quizId, quizResultUseCase: quizResultUseCase)
        navigationController?.pushViewController(targetController, animated: true)
    }
    
    func presentLeaderboardViewController(board : [LeaderboardResult]) {
        let leaderboardController = LeaderboardViewController(result: board)
        let newController = UINavigationController(rootViewController: leaderboardController)
        newController.modalPresentationStyle = .overFullScreen
        navigationController?.present(newController, animated: true, completion: nil)
    }
}
