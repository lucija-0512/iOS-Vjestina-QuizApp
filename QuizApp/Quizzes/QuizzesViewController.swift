import UIKit
import PureLayout

class TableHeader : UITableViewHeaderFooterView {
    
     var label : UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
    }
    
}
class QuizzesViewController: UIViewController {

    private var showButton : UIButton!
    private var tableView : UITableView!
    private var fact : UILabel!
    private var nbaQuestion : UILabel!
    private var quizzesUseCase : QuizzesUseCaseProtocol!
    
    private var quizzes = [Quiz]()
    let cellIdentifier = "cellId"
    var quizzesGroupedByCategory = [(QuizCategory,Array<Quiz>)]()
    private var router : AppRouterProtocol!
    
    convenience init(router : AppRouterProtocol, quizzesUseCase : QuizzesUseCaseProtocol) {
        self.init()
        self.router = router
        self.quizzesUseCase = quizzesUseCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        
        self.navigationController?.navigationBar.barTintColor = .systemBlue
    }
    
    private func buildViews() {
        view.backgroundColor = .systemBlue
        
        showButton = UIButton()
        showButton.setTitle("Get Quizz", for: .normal)
        showButton.backgroundColor = .white
        showButton.layer.cornerRadius = 20.0
        showButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20.0)
        showButton.setTitleColor(.systemBlue, for: .normal)
        showButton.addTarget(self, action: #selector(customAction), for: .touchUpInside)
        
        fact = UILabel()
        fact.textColor = .white
        fact.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        nbaQuestion = UILabel()
        nbaQuestion.textColor = .white
        nbaQuestion.font = UIFont.systemFont(ofSize: 18.0)
        nbaQuestion.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        nbaQuestion.numberOfLines = 0
        
        
        tableView = UITableView()
        tableView.isHidden = true
        tableView.rowHeight = 150
        tableView.backgroundColor = .clear
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.isUserInteractionEnabled = true
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(showButton)
        view.addSubview(tableView)
        view.addSubview(fact)
        view.addSubview(nbaQuestion)
        view.bringSubviewToFront(tableView)
    }
    
    @objc
    func customAction() {
        tableView.isHidden = false
        quizzesUseCase.fetchQuizzes()  {[weak self] quizzes in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.quizzes = quizzes.quizzes
                self.quizzesGroupedByCategory = self.groupByCategory(quizzesList: self.quizzes)
                self.tableView.reloadData()
            
                let count = self.quizzes.map{$0.questions}.flatMap{$0}.filter{$0.question.contains("NBA")}.count
            
                self.fact.text = "Fun Fact"
                self.nbaQuestion.text = "There are \(count) questions that contain the word \"NBA\""
            }
        }
     }
    
    
    private func addConstraints() {
        
        showButton.autoPinEdge(toSuperviewSafeArea: .top, withInset: 30)
        showButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        showButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 50)
        showButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 50)
        showButton.autoSetDimension(.height, toSize: 50)
        
        fact.autoPinEdge(.top, to: .bottom, of: showButton, withOffset: 20)
        fact.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        fact.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        
        nbaQuestion.autoPinEdge(.top, to: .bottom, of: fact, withOffset: 10)
        nbaQuestion.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        nbaQuestion.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        
        tableView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        tableView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        tableView.autoPinEdge(.top, to: .bottom, of: nbaQuestion, withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func groupByCategory(quizzesList: [Quiz]) -> [(QuizCategory,Array<Quiz>)] {
        var quizzesGroupedByCategory = Dictionary<QuizCategory, Array<Quiz>>()
        for quiz in quizzesList {
            if quizzesGroupedByCategory[quiz.category] == nil {
            quizzesGroupedByCategory[quiz.category] = Array<Quiz>()
          }
            quizzesGroupedByCategory[quiz.category]?.append(quiz)
        }
        return quizzesGroupedByCategory.compactMap{$0}
      }


}
extension QuizzesViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizzesGroupedByCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzesGroupedByCategory[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
        let quiz = quizzesGroupedByCategory[indexPath.section].1[indexPath.row]
        let url = URL(string: quiz.imageUrl)
        let data = try? Data(contentsOf: url!)
        cell.imgQuiz.image = UIImage(data: data!)
        cell.titleQuiz.text = quiz.title
        cell.descriptionQuiz.text = quiz.description
        cell.levelQuiz.text = "Level \(quiz.level)"
        cell.backgroundColor = UIColor(red: 0.49, green: 0.78, blue: 0.94, alpha: 1.00)
        return cell
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TableHeader
        header.label.text = quizzesGroupedByCategory[section].0.rawValue
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fetchedQuiz = quizzesGroupedByCategory[indexPath.section].1[indexPath.row]
        router.goToQuizViewController(quiz: fetchedQuiz)
    }
    
   
}