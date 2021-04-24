import UIKit
import PureLayout


class LoginViewController: UIViewController {
    
    private var titleLabel : UILabel!
    private var email: UITextField!
    private var password: UITextField!
    private var loginButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
        navigationItem.title = "Login"
    }
    
    private func buildViews() {
        view.backgroundColor = .systemBlue
        
        titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        
        
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
        let message = DataService().login(email: name, password: pass)
        if case LoginStatus.success = message  {
            let vc = QuizzesViewController()
            //self.navigationController?.pushViewController(vc, animated: true)
            let customViewControllersArray : [UIViewController] = [vc]
            self.navigationController?.setViewControllers(customViewControllersArray, animated: true)
            //UIApplication.shared.windows.first?.rootViewController = vc
            //UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        print(message)
     }
    
    private func addConstraints() {
        
        titleLabel.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 50)
        
        email.autoSetDimensions(to: CGSize(width: 300, height: 50))
        email.autoCenterInSuperview()
        
        password.autoPinEdge(.top, to: .bottom, of: email, withOffset: 10)
        password.autoAlignAxis(.vertical, toSameAxisOf: email)
        password.autoMatch(.width, to: .width, of: email)
        password.autoMatch(.height, to: .height, of: email)
        
        loginButton.autoPinEdge(.top, to: .bottom, of: password, withOffset: 30)
        loginButton.autoAlignAxis(.vertical, toSameAxisOf: password)
        loginButton.autoMatch(.width, to: .width, of: password)
        loginButton.autoMatch(.height, to: .height, of: password)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
