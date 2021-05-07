import UIKit

class PageViewController: UIPageViewController {

    var quiz : Quiz!
    private var controllers: [UIViewController] = []
    var correct = 0
    var total = 0
    var progressView : UIProgressView!
    var progressValue : Float!
    var controllerNum = 0
    
    private var displayedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        total = quiz.questions.count
        progressValue = Float(1)/Float(total)
        var count = 1
        for question in quiz.questions {
            let current = UILabel()
            current.text = "\(count) / \(total) "
            let quizViewController = QuizzViewController(_question: question, _current: current)
            controllers.append(quizViewController)
            count += 1
        }
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .white
        progressView.trackTintColor = .lightGray
        progressView.progress = 0.25
        
        let titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        navigationItem.titleView = titleLabel
        
        view.backgroundColor = .white

        guard let firstVC = controllers.first as? QuizzViewController
            else { return }
        view.backgroundColor = .systemBlue
        //postavljanje boje indikatora stranice
        let pageAppearance = UIPageControl.appearance()
        pageAppearance.currentPageIndicatorTintColor = .white
        pageAppearance.pageIndicatorTintColor = .lightGray
        pageAppearance.backgroundColor = .systemBlue

        firstVC.progress = progressView
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }
    
    func nextPage() {
        controllerNum += 1
        if (controllers.count > controllerNum) {
            guard let nextViewController = controllers[controllerNum] as? QuizzViewController else {return}
            nextViewController.progress = progressView
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
        else {
            let targetController = QuizResultViewController(_correct: correct, _total : total)
            navigationController?.pushViewController(targetController, animated: true)
            return
        }
        
        
    }
}
