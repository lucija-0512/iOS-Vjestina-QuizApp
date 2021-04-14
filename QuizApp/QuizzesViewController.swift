import UIKit
import PureLayout

class TableHeader : UITableViewHeaderFooterView {
    static let identifier = "TableHeader"
    
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
        //label.autoCenterInSuperview()
    }
    
}
class QuizzesViewController: UIViewController {

    private var titleLabel : UILabel!
    private var showButton : UIButton!
    private var tableView : UITableView!
    private var fact : UILabel!
    private var nbaQuestion : UILabel!
    
    private var quizzes = [Quiz]()
    let cellIdentifier = "cellId"
    var quizzesGroupedByCategory = [(String,Array<Quiz>)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
    }
    
    private func buildViews() {
        view.backgroundColor = .systemBlue
        
        titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        
        showButton = UIButton()
        showButton.setTitle("Get Quizz", for: .normal)
        showButton.backgroundColor = .white
        showButton.layer.cornerRadius = 20.0
        showButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20.0)
        showButton.setTitleColor(.systemBlue, for: .normal)
        showButton.addTarget(self, action: #selector(customAction), for: .touchUpInside)
        
        fact = UILabel()
        fact.textColor = .white
        fact.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        nbaQuestion = UILabel()
        nbaQuestion.textColor = .white
        nbaQuestion.font = UIFont.systemFont(ofSize: 20.0)
        nbaQuestion.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        nbaQuestion.numberOfLines = 0
        
        
        tableView = UITableView()
        tableView.isHidden = true
        tableView.rowHeight = 150
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.isUserInteractionEnabled = true
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(titleLabel)
        view.addSubview(showButton)
        view.addSubview(tableView)
        view.addSubview(fact)
        view.addSubview(nbaQuestion)
        view.bringSubviewToFront(tableView)
    }
    
    @objc
    func customAction() {
        
        tableView.isHidden = false
        quizzes = DataService().fetchQuizes()
        self.quizzesGroupedByCategory = groupByCategory(quizzesList: quizzes)
        tableView.reloadData()
        
        var count = quizzes.map{$0.questions}.flatMap{$0}.filter{$0.question.contains("NBA")}.count
        
        fact.text = "Fun Fact"
        nbaQuestion.text = "There are \(count) questions that contain the word \"NBA\""
        
     }
    
    private func addConstraints() {
        titleLabel.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        
        showButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        showButton.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 30)
        showButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 50)
        showButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 50)
        showButton.autoSetDimension(.height, toSize: 50)
        
        fact.autoPinEdge(.top, to: .bottom, of: showButton, withOffset: 30)
        fact.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        fact.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        
        nbaQuestion.autoPinEdge(.top, to: .bottom, of: fact, withOffset: 10)
        nbaQuestion.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        nbaQuestion.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        
        tableView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        tableView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        tableView.autoPinEdge(.top, to: .bottom, of: nbaQuestion, withOffset: 30)
        //tableView.autoSetDimensions(to: CGSize(width: view.bounds.width, height: view.bounds.height))
        tableView.autoSetDimension(.height, toSize: view.bounds.height)
    }
    
    private func groupByCategory(quizzesList: [Quiz]) -> [(String,Array<Quiz>)] {
        var quizzesGroupedByCategory = Dictionary<String, Array<Quiz>>()
        

        // Looping the Array of transactions
        for quiz in quizzesList {


          // Verifying if the array is nil for the current date used as a
          // key in the dictionary, if so the array is initialized only once
            if quizzesGroupedByCategory[quiz.category.rawValue] == nil {
            quizzesGroupedByCategory[quiz.category.rawValue] = Array<Quiz>()
          }

          // Adding the transaction in the dictionary to the key that is the date
            quizzesGroupedByCategory[quiz.category.rawValue]?.append(quiz)
        }

        // Sorting the dictionary to descending order and the result will be
        // an array of tuples with key(String) and value(Array<Transaction>)
        return quizzesGroupedByCategory.sorted { $0.0 > $1.0 }
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
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TableHeader
        if section == 0 {
            header.label.text = QuizCategory.sport.rawValue
        }
        else {
            header.label.text = QuizCategory.science.rawValue
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
}
