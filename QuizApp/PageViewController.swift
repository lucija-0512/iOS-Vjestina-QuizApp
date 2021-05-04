//
//  PageViewController.swift
//  QuizApp
//
//  Created by five on 30/04/2021.
//

import UIKit

class PageViewController: UIPageViewController {

    var quiz : Quiz!
    private var controllers: [UIViewController] = []
    
    private var displayedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for question in quiz.questions {
            let quizViewController = QuizzViewController(_question: question)
            controllers.append(quizViewController)
        }
        
        view.backgroundColor = .white

        guard let firstVC = controllers.first else { return }
        
        view.backgroundColor = .systemBlue
        //postavljanje boje indikatora stranice
        let pageAppearance = UIPageControl.appearance()
        pageAppearance.currentPageIndicatorTintColor = .white
        pageAppearance.pageIndicatorTintColor = .lightGray
        pageAppearance.backgroundColor = .systemBlue

        dataSource = self

        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }
    
    
    

}
extension PageViewController: UIPageViewControllerDataSource {

    // Index trenutno aktivne stranice
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        displayedIndex
    }

    // Broj stranica
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        controllers.count
    }

    // Navigacija u nazad
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let controllerIndex = controllers.firstIndex(of: viewController),
            controllerIndex - 1 >= 0,
            controllerIndex - 1 < controllers.count
        else {
            return nil
        }

        displayedIndex = controllerIndex - 1
        return controllers[displayedIndex]
    }

    //Navigacija u naprijed
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let controllerIndex = controllers.firstIndex(of: viewController),
            controllerIndex + 1 < controllers.count
        else {
            return nil
        }

        displayedIndex = controllerIndex + 1
        return controllers[displayedIndex]
    }
    
    
}

extension UIPageViewController {

    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
    }

    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
    }

}

