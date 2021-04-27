//
//  TabViewController.swift
//  QuizApp
//
//  Created by five on 27/04/2021.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let quizzesVC = QuizzesViewController()
        quizzesVC.tabBarItem = UITabBarItem(title: "Quizzes", image: .add, selectedImage: .add)
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: .add, selectedImage: .add)
        
        self.viewControllers = [quizzesVC, settingsVC]
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
