import UIKit

class PageViewController: UIPageViewController {

    var quiz : Quiz!
    private var controllers: [UIViewController] = []
    var correct = 0
    var total = 0
    var progressView : UIProgressView!
    var progressValue : Float!
    
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

        dataSource = self

        firstVC.progress = progressView
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }
    
    func nextPage() {
        goToNextPage(_correct: correct, _total: total, _progress : progressView)
    }
}

extension PageViewController: UIPageViewControllerDataSource {

    // Index trenutno aktivne stranice
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        displayedIndex
    }

    // Broj stranica
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        controllers.count
    }

    // Navigacija u nazad
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let controllerIndex = controllers.firstIndex(of: viewController),
            controllerIndex - 1 >= 0,
            controllerIndex - 1 < controllers.count
        else {
            return nil
        }

        displayedIndex = controllerIndex - 1
        return controllers[displayedIndex]
    }

    //Navigacija u naprijed
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let controllerIndex = controllers.firstIndex(of: viewController),
            controllerIndex + 1 < controllers.count
        else {
            return nil
        }

        displayedIndex = controllerIndex + 1
        return controllers[displayedIndex]
    }
    
    
    
}

extension UIPageViewController {

    func goToNextPage(animated: Bool = true, _correct : Int, _total: Int, _progress : UIProgressView ){
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) as? QuizzViewController
        else {
            let targetController = QuizResultViewController(_correct: _correct, _total : _total)
            navigationController?.pushViewController(targetController, animated: true)
            return
        }
        nextViewController.progress = _progress
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
    }

//    func goToPreviousPage(animated: Bool = true) {
//        guard let currentViewController = self.viewControllers?.first else { return }
//        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
//        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
//    }

}

