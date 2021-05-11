import UIKit
class PageViewController: UIPageViewController, PageViewDelegate {
    
    var quiz : Quiz!
    private var controllers: [UIViewController] = []
    var correct = 0
    var total = 0
    var stackView : UIStackView!
    var controllerNum = 0
    
    private var displayedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        total = quiz.questions.count
        var count = 1
        for question in quiz.questions {
            let current = UILabel()
            current.text = "\(count) / \(total) "
            let quizViewController = QuizzViewController(_question: question, _current: current, _delegate: self)
            controllers.append(quizViewController)
            count += 1
        }
        stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        for _ in 1...quiz.questions.count {
            stackView.addArrangedSubview(UIProgressView(progressViewStyle: .default))
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        navigationItem.titleView = titleLabel
        
        view.backgroundColor = .white

        guard let firstVC = controllers.first as? QuizzViewController
            else { return }
        view.backgroundColor = .systemBlue

        let pView = UIProgressView(progressViewStyle: .default)
        pView.trackTintColor = .white
        
        stackView.replaceView(atIndex: 0, withView: pView)
        firstVC.stackView = stackView
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }
    func goToNextQuestion(_color : UIColor) {
        let lastProgress = UIProgressView(progressViewStyle: .default)
        lastProgress.trackTintColor = _color
        stackView.replaceView(atIndex: controllerNum, withView: lastProgress)
        controllerNum += 1
        if (controllers.count > controllerNum) {
            guard let nextViewController = controllers[controllerNum] as? QuizzViewController else {return}
            let currentProgress = UIProgressView(progressViewStyle: .default)
            currentProgress.trackTintColor = .white
            stackView.replaceView(atIndex: controllerNum, withView: currentProgress)
            nextViewController.stackView = stackView
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
        else {
            let targetController = QuizResultViewController(_correct: correct, _total : total)
            navigationController?.pushViewController(targetController, animated: true)
            return
        }
    }
    
}
extension UIStackView {
    func replaceView(atIndex index: Int, withView view: UIView) {
        let viewToRemove = arrangedSubviews[index]
        removeArrangedSubview(viewToRemove)
        insertArrangedSubview(view, at: index)
    }
}
