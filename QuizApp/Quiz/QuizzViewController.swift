

import UIKit
import PureLayout

class QuizzViewController: UIViewController {

    private var currentPage : UILabel!
    private var currentQuestion : Question
    private var questionLabel : UILabel!
    private var answer1: UIButton!
    private var answer2: UIButton!
    private var answer3: UIButton!
    private var answer4: UIButton!
    private var buttonArray: [UIButton]!
    var stackView : UIStackView!
    var delegate : PageViewDelegate?
    var total : Int
    var colorArray : [UIColor]

    init(question: Question, current : UILabel, delegate : PageViewDelegate, total : Int, array : [UIColor]) {
        self.currentPage = current
        self.currentQuestion = question;
        self.delegate = delegate
        self.total = total
        colorArray = array
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    private func buildViews() {
        view.backgroundColor = .systemBlue
        stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        for i in 0...total-1 {
            let currentProgress = UIProgressView(progressViewStyle: .default)
            currentProgress.trackTintColor = colorArray[i]
            stackView.addArrangedSubview(currentProgress)
        }
        
        buttonArray = [UIButton]()
        
        currentPage.textColor = .white
        currentPage.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        questionLabel = UILabel()
        questionLabel.text = currentQuestion.question
        questionLabel.textColor = .white
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        answer1 = UIButton()
        answer1.tag = 0
        answer1.setTitle(currentQuestion.answers[0], for: .normal)
        answer1.backgroundColor = UIColor(red: 0.49, green: 0.78, blue: 0.94, alpha: 1.00)
        answer1.setTitleColor(.white, for: .normal)
        answer1.layer.cornerRadius = 20.0
        answer1.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        buttonArray.append(answer1)
        
        answer2 = UIButton()
        answer2.tag = 1
        answer2.setTitle(currentQuestion.answers[1], for: .normal)
        answer2.backgroundColor = UIColor(red: 0.49, green: 0.78, blue: 0.94, alpha: 1.00)
        answer2.setTitleColor(.white, for: .normal)
        answer2.layer.cornerRadius = 20.0
        answer2.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        buttonArray.append(answer2)
        
        answer3 = UIButton()
        answer3.tag = 2
        answer3.setTitle(currentQuestion.answers[2], for: .normal)
        answer3.backgroundColor = UIColor(red: 0.49, green: 0.78, blue: 0.94, alpha: 1.00)
        answer3.setTitleColor(.white, for: .normal)
        answer3.layer.cornerRadius = 20.0
        answer3.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        buttonArray.append(answer3)
        
        answer4 = UIButton()
        answer4.tag = 3
        answer4.setTitle(currentQuestion.answers[3], for: .normal)
        answer4.backgroundColor = UIColor(red: 0.49, green: 0.78, blue: 0.94, alpha: 1.00)
        answer4.setTitleColor(.white, for: .normal)
        answer4.layer.cornerRadius = 20.0
        answer4.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        buttonArray.append(answer4)
        
        view.addSubview(stackView)
        view.addSubview(currentPage)
        view.addSubview(questionLabel)
        view.addSubview(answer1)
        view.addSubview(answer2)
        view.addSubview(answer3)
        view.addSubview(answer4)
    }
    
    private func addConstraints() {
        currentPage.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        currentPage.autoPinEdge(toSuperviewSafeArea: .top, withInset: 40)
        currentPage.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        currentPage.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        stackView.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        stackView.autoPinEdge(.top, to: .bottom, of: currentPage, withOffset: 30)
        stackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        stackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        questionLabel.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        questionLabel.autoPinEdge(.top, to: .bottom, of: currentPage, withOffset: 60)
        questionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        questionLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)        
        
        answer1.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer1.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer1.autoPinEdge(.top, to: .bottom, of: questionLabel, withOffset: 30)
        answer1.autoSetDimension(.height, toSize: 50)

        answer2.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer2.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer2.autoPinEdge(.top, to: .bottom, of: answer1, withOffset: 10)
        answer2.autoMatch(.width, to: .width, of: answer1)
        answer2.autoMatch(.height, to: .height, of: answer1)

        answer3.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer3.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer3.autoPinEdge(.top, to: .bottom, of: answer2, withOffset: 10)
        answer3.autoMatch(.width, to: .width, of: answer2)
        answer3.autoMatch(.height, to: .height, of: answer2)

        answer4.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        answer4.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        answer4.autoPinEdge(.top, to: .bottom, of: answer3, withOffset: 10)
        answer4.autoMatch(.width, to: .width, of: answer3)
        answer4.autoMatch(.height, to: .height, of: answer3)
    }
    
    @objc
    func buttonClicked(sender:UIButton)
    {
        let greenColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1.00)
        let redColor = UIColor(red: 0.80, green: 0.29, blue: 0.21, alpha: 1.00)
        if sender.tag == currentQuestion.correctAnswer {
            sender.backgroundColor = greenColor
            delegate?.goToNextQuestion(_correct: 1)
        }
        else {
            buttonArray[currentQuestion.correctAnswer].backgroundColor = greenColor
            sender.backgroundColor = redColor
            delegate?.goToNextQuestion(_correct: 0)
        }
    }
}
