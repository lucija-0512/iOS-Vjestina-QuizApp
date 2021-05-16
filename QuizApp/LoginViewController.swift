import UIKit
import PureLayout


class LoginViewController: UIViewController {
    
    private var email: UITextField!
    private var password: UITextField!
    private var loginButton : UIButton!
    private var router : AppRouterProtocol!
    private var networkService : NetworkServiceProtocol!
    
    convenience init(router : AppRouterProtocol, networkService : NetworkServiceProtocol) {
        self.init()
        self.router = router
        self.networkService = networkService
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        let titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.barTintColor = .systemBlue
    }
    
    private func buildViews() {
        view.backgroundColor = .systemBlue
        
        email = UITextField()
        email.backgroundColor = .lightGray
        email.textColor = .white
        email.placeholder = "Email"
        email.layer.cornerRadius = 20.0
        email.layer.borderWidth = 1.0
        email.layer.borderColor = UIColor.white.cgColor
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        email.leftView = leftView
        email.leftViewMode = .always
        email.font = UIFont.systemFont(ofSize: 20.0)
        
        password = UITextField()
        password.backgroundColor = .lightGray
        password.textColor = .white
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.layer.cornerRadius = 20.0
        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor.white.cgColor
        let leftView2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        password.leftView = leftView2
        password.leftViewMode = .always
        password.font = UIFont.systemFont(ofSize: 20.0)
        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .gray
        loginButton.layer.cornerRadius = 20.0
        loginButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20.0)
        loginButton.addTarget(self, action: #selector(customAction), for: .touchUpInside)
        
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(loginButton)
    }
    @objc
    func customAction() {
        guard let name = email.text else { return }
        guard let pass = password.text else { return }
        print(name)
        print(pass)
        
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/session?username=\(name)&password=\(pass)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(request) { (result: Result<Session, RequestError>) in
            switch result {
                case .failure(let error):
                    print(error)
                    //handleRequestError(error: error)
                case .success(let value):
                    print(value)
                    let defaults = UserDefaults.standard
                    defaults.set(value.token, forKey: "Token")
                    defaults.set(value.userId, forKey: "UserId")
                    DispatchQueue.main.async {
                        self.router.setTabViewController()
                    }
            }
        }
     }
    private func handleRequestError(error : Error) {
        
    }
    
    
    private func addConstraints() {
        
        email.autoPinEdge(toSuperviewSafeArea: .top, withInset: 100)
        email.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        email.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 30)
        email.autoSetDimension(.height, toSize: 50)
        
        password.autoPinEdge(.top, to: .bottom, of: email, withOffset: 10)
        password.autoAlignAxis(.vertical, toSameAxisOf: email)
        password.autoMatch(.height, to: .height, of: email)
        password.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        password.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 30)
        
        loginButton.autoPinEdge(.top, to: .bottom, of: password, withOffset: 30)
        loginButton.autoAlignAxis(.vertical, toSameAxisOf: password)
        loginButton.autoMatch(.height, to: .height, of: password)
        loginButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 30)
        loginButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 30)
    }
    
}
