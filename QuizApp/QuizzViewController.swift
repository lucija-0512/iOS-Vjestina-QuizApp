//
//  QuizzViewController.swift
//  QuizApp
//
//  Created by five on 24/04/2021.
//

import UIKit
import PureLayout

class QuizzViewController: UIViewController {

    let quiz : Quiz
    private var questionLabel : UILabel!

    init(_quiz: Quiz) {
        self.quiz = _quiz
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func buildViews() {
        view.backgroundColor = .systemBlue
        
        questionLabel = UILabel()
        questionLabel.text = quiz.questions[0].question
        questionLabel.textColor = .white
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        
        
        view.addSubview(questionLabel)
    }
    
    private func addConstraints() {
        questionLabel.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        questionLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        questionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        questionLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
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
