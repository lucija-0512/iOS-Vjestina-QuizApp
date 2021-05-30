
import UIKit

class SearchBarView: UIView {
    var searchBar : UITextField!
    var searchButton : UIButton!
    
    init(){

            super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            viewDidLoad()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            viewDidLoad()
        }
    
    func viewDidLoad(){
        buildViews()
        addConstraints()
    }
    
    private func buildViews() {
        backgroundColor = .systemBlue
        
        searchBar = UITextField()
        searchBar.backgroundColor = UIColor(red: 0.49, green: 0.78, blue: 0.94, alpha : 1.00)
        searchBar.textColor = .white
        searchBar.placeholder = "Search Quizzes"
        searchBar.layer.cornerRadius = 20.0
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor.white.cgColor
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        searchBar.leftView = leftView
        searchBar.leftViewMode = .always
        searchBar.font = UIFont.systemFont(ofSize: 17.0)
        
        searchButton = UIButton()
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = .clear
        searchButton.layer.cornerRadius = 20.0
        searchButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 17.0)
        searchButton.sizeToFit()
        //searchButton.addTarget(self, action: #selector(searchQuizzes), for: .touchUpInside)
        
        addSubview(searchBar)
        addSubview(searchButton)
    }
    
    
    
    private func addConstraints() {
        searchBar.autoPinEdge(toSuperviewSafeArea: .top)
        searchBar.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 5)
        searchBar.autoSetDimension(.height, toSize: 50)
        
        searchButton.autoPinEdge(.leading, to: .trailing, of: searchBar, withOffset: 10)
        searchButton.autoPinEdge(toSuperviewSafeArea: .top)
        searchButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 5)
        searchButton.autoSetDimension(.height, toSize: 50)
        searchButton.autoSetDimension(.width, toSize: 80)
        
    }

}
