import UIKit
import PureLayout

class LeaderboardViewController: UIViewController {
    private var tableView : UITableView!
    private var dismissButton : UIButton!
    private var titleLabel : UILabel!
    private var result : [LeaderboardResult]!
    
    let cellIdentifier = "cellIdentifier"
    convenience init(result : [LeaderboardResult]) {
        self.init()
        self.result = result
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
    }
    
    func buildViews() {
        view.backgroundColor = .systemBlue
        
        let titleLabel = UILabel()
        titleLabel.text = "Leaderboard"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35.0)
        navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(customAction(_:)))
        navigationItem.rightBarButtonItem = rightItem
        
        tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(CustomLeaderboardTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.isUserInteractionEnabled = true
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
    }
    
    func addConstraints() {
        tableView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 40)
        tableView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 10)
        tableView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    @objc
    func customAction(_ sender : UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
     }


}

extension LeaderboardViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomLeaderboardTableViewCell
        let getResult = result[indexPath.row]
        
        cell.player.text = "\(indexPath.row+1). " + getResult.username
        var current = 0.0
        if(getResult.score != nil) {
            current = Double(getResult.score!)!
        }
        cell.points.text = String(format: "%.3f", current)
        cell.backgroundColor = .systemBlue
        return cell
    }
      
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
