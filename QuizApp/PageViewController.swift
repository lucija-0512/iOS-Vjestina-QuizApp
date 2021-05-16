import UIKit
class PageViewController: UIPageViewController, PageViewDelegate {
    
    var quiz : Quiz!
    var correct = 0
    var total = 0
    var controllerNum = 0
    var colorArray : [UIColor] = [UIColor]()
    var startTime : Double!
    var router : AppRouterProtocol!
    var pageUseCase : PageUseCaseProtocol!
    
    private var displayedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        total = quiz.questions.count
        colorArray.append(.white)
        for _ in 1...(total-1) {
            colorArray.append(.gray)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        navigationItem.titleView = titleLabel
        
        view.backgroundColor = .systemBlue
        let firstVC = getQuizViewController()
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func getQuizViewController() -> QuizzViewController {
        let current = UILabel()
        current.text = "\(controllerNum + 1) / \(total) "
        let quizViewController = QuizzViewController(_question: quiz.questions[controllerNum], _current: current, _delegate: self, _total: total, _array: colorArray)
        return quizViewController
    }
    
    func goToNextQuestion(_correct : Int) {
        let lastProgress = UIProgressView(progressViewStyle: .default)
        correct += _correct
        if(_correct == 1) {
            lastProgress.trackTintColor = .green
            colorArray[controllerNum] = .green
        }
        else {
            lastProgress.trackTintColor = .red
            colorArray[controllerNum] = .red
        }
        controllerNum += 1
        if (total > controllerNum) {
            colorArray[controllerNum] = .white
            let nextViewController = getQuizViewController()
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
        else {
            pageUseCase.sendResult(startTime: startTime, quizId: quiz.id, correct: correct)
            router.goToQuizResultViewController(correct : correct, total : total, quizId: quiz.id)
            return
        }
    }
}
