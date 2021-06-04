import UIKit
import PureLayout


class LoginViewController: UIViewController {
    
    private var email: UITextField!
    private var password: UITextField!
    private var loginButton : UIButton!
    private var router : AppRouterProtocol!
    private var loginUseCase : LoginUseCaseProtocol!
    private var titleLabel : UILabel!
    
    convenience init(router : AppRouterProtocol, loginUseCase : LoginUseCaseProtocol) {
        self.init()
        self.router = router
        self.loginUseCase = loginUseCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        
        self.navigationController?.navigationBar.barTintColor = .systemBlue
    }
     
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.titleLabel.transform = .identity
                self.titleLabel.alpha = 1
            })
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.email.transform = .identity
                self.email.alpha = 1
            }
        )
        UIView.animate(
            withDuration: 1.5,
            delay: 0.25,
            options: .curveEaseOut,
            animations: {
                self.password.transform = .identity
                self.password.alpha = 1
            }
        )
        UIView.animate(
            withDuration: 1.5,
            delay: 0.5,
            options: .curveEaseOut,
            animations: {
                self.loginButton.transform = .identity
                self.loginButton.alpha = 1
            }
        )
}
    
    private func buildViews() {
        view.backgroundColor = .systemBlue
        titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        titleLabel.transform = titleLabel.transform.scaledBy(x: 0, y: 0)
        titleLabel.alpha = 0
        
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
        email.transform = email.transform.translatedBy(x: -view.frame.width, y: 0)
        email.alpha = 0
        
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
        password.transform = password.transform.translatedBy(x: -view.frame.width, y: 0)
        password.alpha = 0
        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .gray
        loginButton.layer.cornerRadius = 20.0
        loginButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20.0)
        loginButton.addTarget(self, action: #selector(customAction), for: .touchUpInside)
        loginButton.transform = loginButton.transform.translatedBy(x: -view.frame.width, y: 0)
        loginButton.alpha = 0
        
        view.addSubview(titleLabel)
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
        
        loginUseCase.checkLogin(name: name, password: pass, router: router) { session in
            let defaults = UserDefaults.standard
            defaults.set(session.token, forKey: "Token")
            defaults.set(session.userId, forKey: "UserId")
            
            DispatchQueue.main.async {
                self.animateViews()
            }
        }
     }
    
    private func animateViews() {
        let height = view.frame.height
        
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            animations: {
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -height)
            }
        )
        UIView.animate(
            withDuration: 1.5,
            delay: 0.25,
            animations: {
                self.email.transform = self.email.transform.translatedBy(x: 0, y: -height)
            }
        )
        UIView.animate(
            withDuration: 1.5,
            delay: 0.5,
            animations: {
                self.password.transform = self.password.transform.translatedBy(x: 0, y: -height)
            }
        )
        UIView.animate(
            withDuration: 1.5,
            delay: 0.75,
            animations: {
                self.loginButton.transform = self.loginButton.transform.translatedBy(x: 0, y: -height)
            },
            completion: { _ in
                self.router.setTabViewController()
            }
        )
    }
    
    private func addConstraints() {
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 10)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        email.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 80)
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
