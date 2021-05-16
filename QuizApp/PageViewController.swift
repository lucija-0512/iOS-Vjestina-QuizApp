import UIKit
class PageViewController: UIPageViewController, PageViewDelegate {
    
    var quiz : Quiz!
    var correct = 0
    var total = 0
    var controllerNum = 0
    var colorArray : [UIColor] = [UIColor]()
    var startTime : Double!
    var networkService : NetworkServiceProtocol!
    var router : AppRouterProtocol!
    
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
            sendResult()
            router.goToQuizResultViewController(correct : correct, total : total, quizId: quiz.id)
            return
        }
    }
    
    func sendResult() {
        
        let diff = CFAbsoluteTimeGetCurrent() - startTime
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/result") else { return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "Token") as! String
        let userId = defaults.object(forKey: "UserId") as! Int
        request.setValue(token, forHTTPHeaderField: "Authorization")
        let json: [String: Any] = ["quiz_id": quiz.id,
                                   "user_id": userId,
                                   "time": diff,
                                   "no_of_correct": correct]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        print(json)
        request.httpBody = jsonData
        
        networkService.executeUrlPostRequest(request) { (result: ServerResponse) in
            switch result {
                case .unauthorized:
                    print("401 UNAUTHORIZED")
                case .forbidden:
                    print("403 FORBIDDEN ")
                case .notFound:
                    print("404 NOT FOUND")
                case .badRequest:
                    print("400 BAD REQUEST")
                case .ok:
                    print("200 OK")
            }
        }
    }
}
