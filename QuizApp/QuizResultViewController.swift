import UIKit

class QuizResultViewController: UIViewController {

    private var result : UILabel
    private var finishButton : UIButton!
    private var leaderboardButton : UIButton!
    private var router : AppRouterProtocol!
    private var quizId : Int
    private var quizResultUseCase : QuizResultUseCaseProtocol!
    
    init(correct : Int, total : Int, router : AppRouterProtocol, quizId : Int, quizResultUseCase : QuizResultUseCaseProtocol) {
        self.result = UILabel()
        self.result.text = "\(correct) / \(total) "
        self.router = router
        self.quizId = quizId
        self.quizResultUseCase = quizResultUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func buildViews() {
        view.backgroundColor = .systemBlue
        
        self.result.font = UIFont.boldSystemFont(ofSize: 80.0)
        self.result.textColor = .white
        
        finishButton = UIButton()
        finishButton.setTitle("Finish Quizz", for: .normal)
        finishButton.backgroundColor = .white
        finishButton.layer.cornerRadius = 20.0
        finishButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20.0)
        finishButton.setTitleColor(.systemBlue, for: .normal)
        finishButton.addTarget(self, action: #selector(customAction), for: .touchUpInside)
        
        leaderboardButton = UIButton()
        leaderboardButton.setTitle("See Leaderboard", for: .normal)
        leaderboardButton.backgroundColor = .white
        leaderboardButton.layer.cornerRadius = 20.0
        leaderboardButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20.0)
        leaderboardButton.setTitleColor(.systemBlue, for: .normal)
        leaderboardButton.addTarget(self, action: #selector(showLeaderboard), for: .touchUpInside)
        
        view.addSubview(result)
        view.addSubview(finishButton)
        view.addSubview(leaderboardButton)
    }
    
    private func addConstraints() {
        result.autoCenterInSuperview()
        
        leaderboardButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        leaderboardButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        leaderboardButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        leaderboardButton.autoSetDimension(.height, toSize: 50)
        
        finishButton.autoPinEdge(.top, to: .bottom, of: leaderboardButton, withOffset: 20)
        finishButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        finishButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
        finishButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        finishButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        finishButton.autoSetDimension(.height, toSize: 50)
    }
    
    @objc
    private func customAction() {
        self.navigationController?.isNavigationBarHidden = false
        router.goToRoot()
    }
    
    @objc
    private func showLeaderboard() {
        quizResultUseCase.getLeaderboard(quizId: quizId, router: router)
    }
}
