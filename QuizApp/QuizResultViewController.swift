//
//  QuizResultViewController.swift
//  QuizApp
//
//  Created by five on 26/04/2021.
//

import UIKit

class QuizResultViewController: UIViewController {

    private var result : UILabel
    private var finishButton : UIButton!
    
    init(_correct : Int, _total : Int) {
        self.result = UILabel()
        self.result.text = "\(_correct) / \(_total) "
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
    }
    
    private func buildViews() {
        view.backgroundColor = .systemBlue
        
        self.result.font = UIFont.boldSystemFont(ofSize: 70.0)
        self.result.textColor = .white
        
        finishButton = UIButton()
        finishButton.setTitle("Finish Quizz", for: .normal)
        finishButton.backgroundColor = .white
        finishButton.layer.cornerRadius = 20.0
        finishButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20.0)
        finishButton.setTitleColor(.systemBlue, for: .normal)
        finishButton.addTarget(self, action: #selector(customAction), for: .touchUpInside)
        
        view.addSubview(result)
        view.addSubview(finishButton)
    }
    
    private func addConstraints() {
        result.autoCenterInSuperview()
        
        finishButton.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        finishButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
        finishButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        finishButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        finishButton.autoSetDimension(.height, toSize: 50)
    }
    
    @objc
    private func customAction() {
        let targetViewController = QuizzesViewController()
        navigationController?.pushViewController(targetViewController, animated: true)
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