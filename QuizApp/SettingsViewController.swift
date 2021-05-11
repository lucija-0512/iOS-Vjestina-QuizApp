import UIKit

class SettingsViewController: UIViewController {

    private var username : UILabel!
    private var name : UILabel!
    private var logOut: UIButton!
    private var router : AppRouterProtocol!
    
    convenience init(router : AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        addConstraints()
        self.navigationController?.navigationBar.barTintColor = .systemBlue
    }
    

    private func buildViews() {
        view.backgroundColor = .systemBlue
        
        username = UILabel()
        username.text = "USERNAME"
        username.textColor = .white
        
        name = UILabel()
        name.text = "Lucija Omrčen"
        name.textColor = .white
        name.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        logOut = UIButton()
        logOut.setTitle("Log Out", for: .normal)
        logOut.backgroundColor = .white
        logOut.setTitleColor(.red, for: .normal)
        logOut.layer.cornerRadius = 20.0
        logOut.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20.0)
        logOut.addTarget(self, action: #selector(customAction), for: .touchUpInside)
        
        view.addSubview(username)
        view.addSubview(name)
        view.addSubview(logOut)
    }
    
    private func addConstraints() {
        username.autoPinEdge(toSuperviewSafeArea: .top, withInset: 50)
        username.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        
        name.autoPinEdge(.top, to: .bottom, of: username, withOffset: 20)
        name.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        
        logOut.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        logOut.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 30)
        logOut.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        logOut.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        logOut.autoSetDimension(.height, toSize: 50)
    }
    
    @objc
    private func customAction() {
        router.goToLoginViewController()
    }

}
