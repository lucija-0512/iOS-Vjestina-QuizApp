
import UIKit
import Foundation

class SearchQuizViewController: UIViewController{

    private var tableView : UITableView!
    private var quizzesUseCase : QuizzesUseCaseProtocol!
    private var router : AppRouterProtocol!
    private var searchBar : UISearchBar!
    var quizzesGroupedByCategory = [(QuizCategory,Array<Quiz>)]()
    let cellIdentifier = "searchCellId"
    let headerIdentifier = "headerId"
    
    convenience init(router : AppRouterProtocol, quizzesUseCase : QuizzesUseCaseProtocol) {
        self.init()
        self.router = router
        self.quizzesUseCase = quizzesUseCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    func buildViews() {
        view.backgroundColor = .systemBlue
        
        tableView = UITableView()
        tableView.rowHeight = 150
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.isUserInteractionEnabled = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        view.addSubview(tableView)
        
        searchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: 50, height: 50))
        searchBar.delegate = self
        searchBar.placeholder = "Search Quizzes"
        searchBar.showsSearchResultsButton = true
        searchBar.backgroundColor = .clear
        
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchBar
        
        addConstraints()
        
    }

    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        tableView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        tableView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 30)
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

extension SearchQuizViewController: UITableViewDataSource, UITableViewDelegate {

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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! TableHeader
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

extension SearchQuizViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let quizzes = quizzesUseCase.filterQuizzes(name: searchBar.text)
        quizzesGroupedByCategory = groupByCategory(quizzesList: quizzes)
        print("hello")
        tableView.reloadData()
        }

}

